package www.ksee.kr.web;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import www.ksee.kr.service.ChatbotService;
import www.ksee.kr.vo.ChatMessage;
import www.ksee.kr.vo.UserVO;

/**
 * 챗봇 프록시 컨트롤러.
 *
 * <p>브라우저의 채팅 요청을 받아 서버에서 OpenRouter 를 호출하고, 응답을 SSE 로 스트리밍한다.
 * API 키는 서버에만 존재하므로 브라우저에 노출되지 않는다.
 *
 * <p>보안:
 * <ul>
 *   <li>이 엔드포인트는 비로그인 방문자도 사용할 수 있다(권한 검사 없음).</li>
 *   <li>비로그인 사용자에게는 IP 기준 분당 요청 수 제한을 적용한다.</li>
 *   <li>관리자 여부는 서버측 {@code request.isUserInRole} 로만 판단하며, 클라이언트 값은 신뢰하지 않는다.</li>
 * </ul>
 */
@RequestMapping("/chatbot")
@Controller
public class ChatbotController {

	private static final Logger logger = LoggerFactory.getLogger(ChatbotController.class);

	/** 사용자 입력 1건의 최대 길이 (남용 방지). */
	private static final int MAX_MESSAGE_LENGTH = 4000;

	@Autowired
	private ChatbotService chatbotService;

	@Autowired
	private www.ksee.kr.service.UserService userService;

	@Value("${chatbot.ratelimit.per.minute:15}")
	private int rateLimitPerMinute;

	/** IP 별 분당 요청 카운터. value = {분단위 타임스탬프, 카운트}. */
	private static final Map<String, long[]> IP_WINDOWS = new ConcurrentHashMap<>();

	/**
	 * 위젯 초기화용 상태.
	 * enabled: API 키가 설정되어 챗봇을 쓸 수 있는지 / admin: 관리자 로그인 여부.
	 */
	@ResponseBody
	@RequestMapping(value = "/status", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
	public String status(HttpServletRequest request) {
		JSONObject json = new JSONObject();
		json.put("enabled", chatbotService.isConfigured());
		json.put("admin", isAdmin(request));
		json.put("login", isLoggedIn(request));
		return json.toString();
	}

	/**
	 * 스트리밍 대화 엔드포인트.
	 * 요청 본문(JSON): { "message": "...", "history": [ {"role":"user|assistant","content":"..."}, ... ] }
	 * 응답: text/event-stream (data: "<토큰 JSON 문자열>")
	 */
	@RequestMapping(value = "/stream", method = RequestMethod.POST)
	public void stream(HttpServletRequest request, HttpServletResponse response) throws IOException {

		final boolean admin = isAdmin(request);
		// 본문은 request.getReader() 로 읽는다. CharacterEncodingFilter(forceEncoding=UTF-8)
		// 덕분에 UTF-8 로 디코딩되어 한글이 깨지지 않는다.
		final String body = readBody(request);

		// --- 스트림 시작 전 검증 (여기서만 상태코드를 바꿀 수 있다) ---
		if (!chatbotService.isConfigured()) {
			writeJsonError(response, 503, "챗봇이 아직 설정되지 않았습니다. 관리자에게 문의해 주세요.");
			return;
		}

		String message = null;
		List<ChatMessage> history = new ArrayList<>();
		try {
			JSONObject req = new JSONObject(body == null ? "{}" : body);
			message = req.optString("message", "").trim();
			JSONArray arr = req.optJSONArray("history");
			if (arr != null) {
				for (int i = 0; i < arr.length(); i++) {
					JSONObject m = arr.optJSONObject(i);
					if (m == null) {
						continue;
					}
					String role = m.optString("role", "");
					String content = m.optString("content", "");
					if (!content.isEmpty() && ("user".equals(role) || "assistant".equals(role))) {
						history.add(new ChatMessage(role, content));
					}
				}
			}
		} catch (Exception e) {
			writeJsonError(response, 400, "요청 형식이 올바르지 않습니다.");
			return;
		}

		if (message == null || message.isEmpty()) {
			writeJsonError(response, 400, "메시지를 입력해 주세요.");
			return;
		}
		if (message.length() > MAX_MESSAGE_LENGTH) {
			writeJsonError(response, 400, "메시지가 너무 깁니다.");
			return;
		}

		// 비로그인 사용자에게만 IP 기준 요청 제한 적용
		if (!isLoggedIn(request) && !allowRequest(getClientIp(request))) {
			writeJsonError(response, 429, "요청이 많습니다. 잠시 후 다시 시도해 주세요.");
			return;
		}

		// --- SSE 스트리밍 시작 ---
		response.setContentType("text/event-stream;charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Connection", "keep-alive");
		response.setHeader("X-Accel-Buffering", "no"); // nginx 프록시 버퍼링 비활성화

		final PrintWriter writer = response.getWriter();
		try {
			if (admin) {
				// 관리자: 도구 호출(agentic) 루프로 처리한 뒤 최종 답변을 스트림처럼 전송
				int adminUserId = getAdminUserId(request);
				String finalText = chatbotService.chatWithTools(history, message, adminUserId);
				emitAsStream(writer, finalText);
			} else {
				// 일반 방문자: 토큰 단위 실시간 스트리밍
				chatbotService.streamChat(history, message, false, token -> {
					writer.write("data: " + JSONObject.quote(token) + "\n\n");
					writer.flush();
				});
			}
			writer.write("event: done\ndata: {}\n\n");
			writer.flush();
		} catch (IOException e) {
			logger.warn("Chatbot stream failed", e);
			writer.write("event: error\n");
			writer.write("data: " + JSONObject.quote("답변 생성 중 오류가 발생했습니다.") + "\n\n");
			writer.flush();
		}
	}

	/** 완성된 텍스트를 SSE data 이벤트로 잘게 나눠 보내 스트리밍 느낌을 준다. */
	private void emitAsStream(PrintWriter writer, String text) {
		if (text == null || text.isEmpty()) {
			text = "(응답이 없습니다.)";
		}
		final int chunk = 60;
		for (int i = 0; i < text.length(); i += chunk) {
			String part = text.substring(i, Math.min(text.length(), i + chunk));
			writer.write("data: " + JSONObject.quote(part) + "\n\n");
			writer.flush();
		}
	}

	/** 현재 로그인한 관리자의 user id. 실패 시 0. */
	private int getAdminUserId(HttpServletRequest request) {
		String login = request.getRemoteUser();
		if (login == null || login.isEmpty()) {
			return 0;
		}
		UserVO param = new UserVO();
		param.setLogin(login);
		UserVO user = userService.selectOne(param);
		return user != null ? user.getId() : 0;
	}

	// ------------------------------------------------------------------
	// helpers
	// ------------------------------------------------------------------

	private boolean isAdmin(HttpServletRequest request) {
		return request.isUserInRole(UserVO.ADMIN);
	}

	private boolean isLoggedIn(HttpServletRequest request) {
		for (int i = 1; i < UserVO.ROLES.length; i++) {
			if (request.isUserInRole(UserVO.ROLES[i])) {
				return true;
			}
		}
		return false;
	}

	/**
	 * IP 기준 분당 요청 제한. 허용되면 true.
	 */
	private boolean allowRequest(String ip) {
		final int limit = rateLimitPerMinute;
		if (limit <= 0) {
			return true;
		}
		if (ip == null) {
			ip = "unknown";
		}
		final long nowMinute = System.currentTimeMillis() / 60_000L;
		final boolean[] allowed = { true };
		IP_WINDOWS.compute(ip, (k, v) -> {
			if (v == null || v[0] != nowMinute) {
				return new long[] { nowMinute, 1 };
			}
			if (v[1] >= limit) {
				allowed[0] = false;
				return v;
			}
			v[1]++;
			return v;
		});
		// 메모리 폭주 방지용 러프 정리
		if (IP_WINDOWS.size() > 10_000) {
			IP_WINDOWS.entrySet().removeIf(e -> e.getValue()[0] != nowMinute);
		}
		return allowed[0];
	}

	/** 요청 본문 전체를 UTF-8 문자열로 읽는다. */
	private String readBody(HttpServletRequest request) throws IOException {
		StringBuilder sb = new StringBuilder();
		try (java.io.BufferedReader reader = request.getReader()) {
			char[] buf = new char[1024];
			int n;
			while ((n = reader.read(buf)) != -1) {
				sb.append(buf, 0, n);
			}
		}
		return sb.toString();
	}

	private String getClientIp(HttpServletRequest request) {
		String xForwardedFor = request.getHeader("X-Forwarded-For");
		if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
			return xForwardedFor.split(",")[0].trim();
		}
		String xRealIp = request.getHeader("X-Real-IP");
		if (xRealIp != null && !xRealIp.isEmpty()) {
			return xRealIp;
		}
		return request.getRemoteAddr();
	}

	private void writeJsonError(HttpServletResponse response, int status, String message) throws IOException {
		response.setStatus(status);
		response.setContentType("application/json; charset=UTF-8");
		JSONObject json = new JSONObject();
		json.put("error", message);
		response.getWriter().write(json.toString());
		response.getWriter().flush();
	}
}
