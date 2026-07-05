package www.ksee.kr.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.function.Consumer;

import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import www.ksee.kr.vo.ChatMessage;

/**
 * OpenRouter(OpenAI 호환) Chat Completions 를 호출하는 챗봇 서비스.
 *
 * <p>API 키는 서버에만 보관하며, 브라우저에는 절대 노출하지 않는다.
 * (브라우저 → ChatbotController → OpenRouter 프록시 구조)
 *
 * <p>Phase 1: 스트리밍 대화만 제공한다. (도구/함수호출은 Phase 2)
 */
@Service
public class ChatbotService {

	private static final Logger logger = LoggerFactory.getLogger(ChatbotService.class);

	/** 환경변수 OPENROUTER_API_KEY 를 우선 사용하고, 없으면 chatbot.properties 값을 사용한다. */
	@Value("${OPENROUTER_API_KEY:${openrouter.api.key:}}")
	private String apiKey;

	@Value("${openrouter.api.url:https://openrouter.ai/api/v1/chat/completions}")
	private String apiUrl;

	@Value("${openrouter.model:google/gemini-2.0-flash-001}")
	private String model;

	@Value("${openrouter.referer:https://www.ksee.kr}")
	private String referer;

	@Value("${openrouter.title:KSEE Chatbot}")
	private String appTitle;

	@Value("${openrouter.max.tokens:1024}")
	private int maxTokens;

	/** 최근 대화 히스토리 중 서버가 실제로 모델에 전달할 최대 메시지 수 (프롬프트 폭주 방지). */
	private static final int MAX_HISTORY_MESSAGES = 20;

	/** 도구 호출(agentic) 루프의 최대 반복 횟수 (무한루프 방지). */
	private static final int MAX_TOOL_STEPS = 6;

	@Autowired
	private ChatbotToolService toolService;

	/**
	 * API 키가 설정되어 있는지 여부.
	 */
	public boolean isConfigured() {
		return apiKey != null && !apiKey.trim().isEmpty();
	}

	/**
	 * KSEE 안내 도우미 시스템 프롬프트.
	 *
	 * @param isAdmin 관리자 로그인 여부
	 */
	private String buildSystemPrompt(boolean isAdmin) {
		StringBuilder sb = new StringBuilder();
		sb.append("당신은 '한국효소공학연구회(KSEE, Korean Society for Enzyme Engineering)' 공식 웹사이트의 안내 도우미입니다.\n");
		sb.append("- 한국효소공학연구회는 효소공학 분야의 학술 교류를 위한 학회입니다.\n");
		sb.append("- 웹사이트는 학회 소개, 공지사항/회원동정/자유게시판 등 게시판, 국내 및 한중일 국제 심포지엄 안내, 심포지엄 참가 접수, 회원 가입/로그인 기능을 제공합니다.\n");
		sb.append("역할:\n");
		sb.append("- 방문자가 학회, 심포지엄 일정, 참가 접수 방법, 게시판 이용, 회원 가입 등을 이해하도록 친절하고 간결하게 안내합니다.\n");
		sb.append("- 사용자가 사용하는 언어(한국어 기본, 요청 시 영어)로 답변합니다.\n");
		sb.append("- 확실하지 않은 구체적 사실(정확한 날짜, 장소, 금액 등)은 지어내지 말고, 해당 안내 페이지를 확인하도록 권합니다.\n");
		if (isAdmin) {
			sb.append("- 현재 관리자로 로그인되어 있습니다. 게시판 작성/수정/삭제 등 관리 기능은 다음 단계에서 제공될 예정이며, 지금은 안내만 가능합니다.\n");
		} else {
			sb.append("- 로그인하지 않은 방문자에게도 도움을 줍니다. 개인정보나 로그인이 필요한 작업은 안내만 합니다.\n");
		}
		return sb.toString();
	}

	/**
	 * OpenRouter 에 스트리밍 요청을 보내고, 응답 토큰을 받을 때마다 {@code onToken} 콜백을 호출한다.
	 *
	 * @param history     이전 대화 히스토리 (role: user/assistant)
	 * @param userMessage 이번 사용자 입력
	 * @param isAdmin     관리자 로그인 여부 (시스템 프롬프트 구성용)
	 * @param onToken     응답 조각(delta)이 도착할 때마다 호출되는 콜백
	 * @throws IOException 네트워크/HTTP 오류
	 */
	public void streamChat(List<ChatMessage> history, String userMessage,
			boolean isAdmin, Consumer<String> onToken) throws IOException {

		if (!isConfigured()) {
			throw new IOException("OpenRouter API key is not configured");
		}

		JSONObject requestBody = buildRequestBody(history, userMessage, isAdmin);

		RequestConfig requestConfig = RequestConfig.custom()
				.setConnectTimeout(10_000)
				.setSocketTimeout(120_000)
				.build();

		try (CloseableHttpClient httpClient = HttpClients.custom()
				.setDefaultRequestConfig(requestConfig)
				.build()) {

			HttpPost post = new HttpPost(apiUrl);
			post.setHeader("Authorization", "Bearer " + apiKey);
			post.setHeader("Content-Type", "application/json");
			// OpenRouter 식별 헤더 (선택)
			post.setHeader("HTTP-Referer", referer);
			post.setHeader("X-Title", appTitle);
			post.setEntity(new StringEntity(requestBody.toString(), StandardCharsets.UTF_8));

			try (CloseableHttpResponse response = httpClient.execute(post)) {
				int status = response.getStatusLine().getStatusCode();
				HttpEntity entity = response.getEntity();

				if (status < 200 || status >= 300) {
					String err = entity != null
							? new String(readAll(entity.getContent()), StandardCharsets.UTF_8)
							: "";
					logger.warn("OpenRouter error status={} body={}", status, err);
					throw new IOException("OpenRouter returned status " + status);
				}

				parseStream(entity.getContent(), onToken);
			}
		}
	}

	/**
	 * OpenRouter 요청 본문(JSON)을 구성한다.
	 */
	private JSONObject buildRequestBody(List<ChatMessage> history, String userMessage, boolean isAdmin) {
		JSONArray messages = new JSONArray();

		// 1) system
		messages.put(new JSONObject()
				.put("role", "system")
				.put("content", buildSystemPrompt(isAdmin)));

		// 2) history (최근 MAX_HISTORY_MESSAGES 개만)
		List<ChatMessage> trimmed = trimHistory(history);
		for (ChatMessage m : trimmed) {
			if (m == null || m.getRole() == null || m.getContent() == null) {
				continue;
			}
			String role = m.getRole();
			if (!"user".equals(role) && !"assistant".equals(role)) {
				continue; // system 은 서버가 통제한다
			}
			messages.put(new JSONObject()
					.put("role", role)
					.put("content", m.getContent()));
		}

		// 3) 이번 사용자 입력
		messages.put(new JSONObject()
				.put("role", "user")
				.put("content", userMessage));

		JSONObject body = new JSONObject();
		body.put("model", model);
		body.put("stream", true);
		body.put("max_tokens", maxTokens);
		body.put("messages", messages);
		return body;
	}

	private List<ChatMessage> trimHistory(List<ChatMessage> history) {
		if (history == null || history.isEmpty()) {
			return new ArrayList<>();
		}
		int size = history.size();
		if (size <= MAX_HISTORY_MESSAGES) {
			return history;
		}
		return history.subList(size - MAX_HISTORY_MESSAGES, size);
	}

	/**
	 * OpenRouter SSE 스트림을 파싱하여 content delta 를 콜백으로 전달한다.
	 *
	 * <p>스트림 형식(줄 단위):
	 * <pre>
	 *   data: {"choices":[{"delta":{"content":"안"}}]}
	 *   data: {"choices":[{"delta":{"content":"녕"}}]}
	 *   data: [DONE]
	 * </pre>
	 * ':' 로 시작하는 줄은 keep-alive 주석이므로 무시한다.
	 */
	private void parseStream(InputStream in, Consumer<String> onToken) throws IOException {
		try (BufferedReader reader = new BufferedReader(
				new InputStreamReader(in, StandardCharsets.UTF_8))) {
			String line;
			while ((line = reader.readLine()) != null) {
				line = line.trim();
				if (line.isEmpty() || line.startsWith(":")) {
					continue; // 빈 줄 / keep-alive 주석
				}
				if (!line.startsWith("data:")) {
					continue;
				}
				String payload = line.substring("data:".length()).trim();
				if (payload.isEmpty()) {
					continue;
				}
				if ("[DONE]".equals(payload)) {
					break;
				}
				String content = extractDeltaContent(payload);
				if (content != null && !content.isEmpty()) {
					onToken.accept(content);
				}
			}
		}
	}

	/**
	 * 한 개의 data 페이로드(JSON)에서 choices[0].delta.content 를 추출한다.
	 * 파싱 실패 시 null 반환(해당 조각만 건너뜀).
	 */
	private String extractDeltaContent(String payload) {
		try {
			JSONObject json = new JSONObject(payload);
			JSONArray choices = json.optJSONArray("choices");
			if (choices == null || choices.length() == 0) {
				return null;
			}
			JSONObject choice = choices.getJSONObject(0);
			JSONObject delta = choice.optJSONObject("delta");
			if (delta == null) {
				return null;
			}
			return delta.optString("content", null);
		} catch (Exception e) {
			logger.debug("Skip unparseable stream chunk: {}", payload);
			return null;
		}
	}

	// ==================================================================
	// Phase 2: 관리자 도구 호출 (function calling) — 비스트리밍 agentic 루프
	// ==================================================================

	/**
	 * 관리자용 도구 호출 대화. 모델이 도구를 요청하면 서버가 실행하고 결과를 되먹여,
	 * 모델이 최종 자연어 답변을 낼 때까지 반복한다. 최종 답변 문자열을 반환한다.
	 *
	 * @param history     이전 대화 히스토리
	 * @param userMessage 이번 사용자 입력
	 * @param adminUserId 작성자 기록용 관리자 user id
	 */
	public String chatWithTools(List<ChatMessage> history, String userMessage, int adminUserId)
			throws IOException {
		if (!isConfigured()) {
			throw new IOException("OpenRouter API key is not configured");
		}

		JSONArray messages = new JSONArray();
		messages.put(new JSONObject()
				.put("role", "system")
				.put("content", buildAdminToolSystemPrompt()));

		for (ChatMessage m : trimHistory(history)) {
			if (m == null || m.getRole() == null || m.getContent() == null) {
				continue;
			}
			if (!"user".equals(m.getRole()) && !"assistant".equals(m.getRole())) {
				continue;
			}
			messages.put(new JSONObject().put("role", m.getRole()).put("content", m.getContent()));
		}
		messages.put(new JSONObject().put("role", "user").put("content", userMessage));

		JSONArray tools = toolService.getToolDefinitions();

		for (int step = 0; step < MAX_TOOL_STEPS; step++) {
			JSONObject assistantMsg = callOnce(messages, tools);
			JSONArray toolCalls = assistantMsg.optJSONArray("tool_calls");

			if (toolCalls != null && toolCalls.length() > 0) {
				// 모델이 도구 실행을 요청함 → assistant 메시지를 그대로 대화에 추가
				messages.put(assistantMsg);

				for (int i = 0; i < toolCalls.length(); i++) {
					JSONObject tc = toolCalls.optJSONObject(i);
					if (tc == null) {
						continue;
					}
					String callId = tc.optString("id", "call_" + i);
					JSONObject function = tc.optJSONObject("function");
					String toolName = function != null ? function.optString("name", "") : "";

					JSONObject argsObj = new JSONObject();
					if (function != null) {
						String argStr = function.optString("arguments", "{}");
						try {
							argsObj = new JSONObject(argStr == null || argStr.trim().isEmpty() ? "{}" : argStr);
						} catch (Exception e) {
							logger.debug("Bad tool arguments: {}", argStr);
						}
					}

					// 서버측에서 관리자 권한을 재확인하며 실행 (callerIsAdmin=true 는 컨트롤러가 이미 검증)
					JSONObject result = toolService.execute(toolName, argsObj, true, adminUserId);

					messages.put(new JSONObject()
							.put("role", "tool")
							.put("tool_call_id", callId)
							.put("name", toolName)
							.put("content", result.toString()));
				}
				continue; // 결과를 반영해 다시 모델 호출
			}

			// 도구 요청이 없으면 최종 답변
			return assistantMsg.optString("content", "");
		}

		return "요청을 처리하는 데 단계가 너무 많이 필요합니다. 좀 더 구체적으로 말씀해 주세요.";
	}

	/**
	 * 관리자 도구 호출용 시스템 프롬프트.
	 */
	private String buildAdminToolSystemPrompt() {
		StringBuilder sb = new StringBuilder();
		sb.append("당신은 '한국효소공학연구회(KSEE)' 웹사이트의 관리자 어시스턴트입니다. 현재 관리자로 로그인한 사용자를 돕습니다.\n");
		sb.append("제공된 도구를 사용해 게시판 작업을 대신 수행할 수 있습니다:\n");
		sb.append("- list_posts: 게시판 글 목록 조회\n");
		sb.append("- get_post: 게시글 상세 조회\n");
		sb.append("- create_post: 새 게시글 작성\n");
		sb.append("- update_post: 게시글 수정(제공한 항목만)\n");
		sb.append("- delete_post: 게시글 삭제\n");
		sb.append("게시판 종류: notice(공지사항), news(관련소식), member(회원동정), speaker(연사제안), free(자유게시판).\n");
		sb.append("규칙:\n");
		sb.append("- 한국어로 간결하고 명확하게 답합니다.\n");
		sb.append("- 수정/삭제하려면 대상 게시글 id 가 필요합니다. id 를 모르면 먼저 list_posts 로 찾습니다.\n");
		sb.append("- 삭제(delete_post)는 되돌릴 수 없습니다. 반드시 사용자에게 어떤 글을 지울지 알리고 명시적 동의를 받은 뒤에만 confirm=true 로 실행합니다. 동의 전에는 실행하지 않습니다.\n");
		sb.append("- 작성/수정/삭제를 실행한 뒤에는 결과(제목, 게시판, 가능하면 링크 경로)를 사용자에게 알려줍니다.\n");
		sb.append("- 도구 결과가 실패(success=false)이면 지어내지 말고 실패 사실과 이유를 그대로 전달합니다.\n");
		return sb.toString();
	}

	/**
	 * 도구를 포함한 비스트리밍 단일 호출. choices[0].message 를 반환한다.
	 */
	private JSONObject callOnce(JSONArray messages, JSONArray tools) throws IOException {
		JSONObject body = new JSONObject();
		body.put("model", model);
		body.put("stream", false);
		body.put("max_tokens", maxTokens);
		body.put("messages", messages);
		if (tools != null && tools.length() > 0) {
			body.put("tools", tools);
			body.put("tool_choice", "auto");
		}

		RequestConfig requestConfig = RequestConfig.custom()
				.setConnectTimeout(10_000)
				.setSocketTimeout(120_000)
				.build();

		try (CloseableHttpClient httpClient = HttpClients.custom()
				.setDefaultRequestConfig(requestConfig)
				.build()) {

			HttpPost post = new HttpPost(apiUrl);
			post.setHeader("Authorization", "Bearer " + apiKey);
			post.setHeader("Content-Type", "application/json");
			post.setHeader("HTTP-Referer", referer);
			post.setHeader("X-Title", appTitle);
			post.setEntity(new StringEntity(body.toString(), StandardCharsets.UTF_8));

			try (CloseableHttpResponse response = httpClient.execute(post)) {
				int status = response.getStatusLine().getStatusCode();
				HttpEntity entity = response.getEntity();
				String responseString = entity != null
						? new String(readAll(entity.getContent()), StandardCharsets.UTF_8)
						: "";

				if (status < 200 || status >= 300) {
					logger.warn("OpenRouter (tools) error status={} body={}", status, responseString);
					throw new IOException("OpenRouter returned status " + status);
				}

				JSONObject json = new JSONObject(responseString);
				JSONArray choices = json.optJSONArray("choices");
				if (choices == null || choices.length() == 0) {
					throw new IOException("OpenRouter returned no choices");
				}
				JSONObject message = choices.getJSONObject(0).optJSONObject("message");
				if (message == null) {
					throw new IOException("OpenRouter returned no message");
				}
				return message;
			}
		}
	}

	private byte[] readAll(InputStream in) throws IOException {
		java.io.ByteArrayOutputStream out = new java.io.ByteArrayOutputStream();
		byte[] buf = new byte[4096];
		int n;
		while ((n = in.read(buf)) != -1) {
			out.write(buf, 0, n);
		}
		return out.toByteArray();
	}
}
