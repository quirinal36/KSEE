package www.ksee.kr.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.Semaphore;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import www.ksee.kr.service.DocsRagService;
import www.ksee.kr.service.DocsRagService.SearchResult;
import www.ksee.kr.service.OpenRouterService;
import www.ksee.kr.service.OpenRouterService.ChatTurn;
import www.ksee.kr.service.OpenRouterService.OpenRouterException;

/** 공개 문서 RAG 챗봇 API. */
@Controller
@RequestMapping("/docs/chat")
public class DocsChatController {

	private static final int MAX_QUESTION_LENGTH = 800;
	private static final int MAX_HISTORY_LENGTH = 6;
	private static final int MAX_TURN_LENGTH = 1200;
	private static final int REQUESTS_PER_MINUTE = 10;
	private static final long WINDOW_MILLIS = 60L * 1000L;

	@Autowired
	private DocsRagService ragService;

	@Autowired
	private OpenRouterService openRouterService;

	private final ConcurrentHashMap<String, RateWindow> rateWindows =
			new ConcurrentHashMap<String, RateWindow>();
	private final Semaphore outboundPermits = new Semaphore(4);

	@ResponseBody
	@RequestMapping(method = RequestMethod.POST, produces = "application/json; charset=UTF-8")
	public Map<String, Object> chat(
			@RequestParam(value = "question", required = false) String question,
			@RequestParam(value = "history", required = false) String historyJson,
			HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> result = new LinkedHashMap<String, Object>();
		String normalizedQuestion = question == null ? "" : question.trim();
		response.setHeader("Cache-Control", "no-store");

		if (normalizedQuestion.length() == 0 || normalizedQuestion.length() > MAX_QUESTION_LENGTH) {
			response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			result.put("result", 0);
			result.put("message", "질문은 1자 이상 800자 이하로 입력해 주세요.");
			return result;
		}
		if (!allowRequest(request.getRemoteAddr())) {
			response.setStatus(429);
			result.put("result", 0);
			result.put("message", "요청이 많습니다. 잠시 후 다시 시도해 주세요.");
			return result;
		}
		if (!openRouterService.isConfigured()) {
			response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
			result.put("result", 0);
			result.put("message", "챗봇 API 키가 아직 설정되지 않았습니다.");
			return result;
		}
		if (!outboundPermits.tryAcquire()) {
			response.setStatus(HttpServletResponse.SC_SERVICE_UNAVAILABLE);
			result.put("result", 0);
			result.put("message", "챗봇이 다른 질문을 처리 중입니다. 잠시 후 다시 시도해 주세요.");
			return result;
		}

		try {
			SearchResult searchResult = ragService.search(normalizedQuestion);
			List<ChatTurn> history = parseHistory(historyJson);
			String answer = openRouterService.answer(normalizedQuestion, history, searchResult.getContext());
			result.put("result", 1);
			result.put("answer", answer);
			result.put("sources", searchResult.getSources());
		} catch (OpenRouterException e) {
			response.setStatus(e.getStatus() == 429 ? 429 : HttpServletResponse.SC_BAD_GATEWAY);
			result.put("result", 0);
			result.put("message", e.getMessage());
		} catch (IOException e) {
			response.setStatus(HttpServletResponse.SC_BAD_GATEWAY);
			result.put("result", 0);
			result.put("message", "AI 서비스에 연결하지 못했습니다. 잠시 후 다시 시도해 주세요.");
		} catch (RuntimeException e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			result.put("result", 0);
			result.put("message", "답변을 처리하지 못했습니다.");
		} finally {
			outboundPermits.release();
		}
		return result;
	}

	private List<ChatTurn> parseHistory(String historyJson) {
		List<ChatTurn> history = new ArrayList<ChatTurn>();
		if (historyJson == null || historyJson.trim().length() == 0) {
			return history;
		}
		try {
			JSONArray input = new JSONArray(historyJson);
			int start = Math.max(0, input.length() - MAX_HISTORY_LENGTH);
			for (int i = start; i < input.length(); i++) {
				JSONObject item = input.optJSONObject(i);
				if (item == null) {
					continue;
				}
				String role = item.optString("role", "");
				String content = item.optString("content", "").trim();
				if (("user".equals(role) || "assistant".equals(role)) && content.length() > 0) {
					if (content.length() > MAX_TURN_LENGTH) {
						content = content.substring(0, MAX_TURN_LENGTH);
					}
					history.add(new ChatTurn(role, content));
				}
			}
		} catch (Exception ignored) {
			// 손상된 브라우저 기록은 무시하고 현재 질문만 처리한다.
		}
		return history;
	}

	private boolean allowRequest(String clientAddress) {
		long now = System.currentTimeMillis();
		String key = clientAddress == null ? "unknown" : clientAddress;
		RateWindow window = rateWindows.get(key);
		if (window == null) {
			RateWindow newWindow = new RateWindow(now);
			RateWindow existing = rateWindows.putIfAbsent(key, newWindow);
			window = existing == null ? newWindow : existing;
		}
		synchronized (window) {
			if (now - window.startedAt >= WINDOW_MILLIS) {
				window.startedAt = now;
				window.count = 0;
			}
			if (window.count >= REQUESTS_PER_MINUTE) {
				return false;
			}
			window.count++;
		}
		if (rateWindows.size() > 2000) {
			cleanupWindows(now);
		}
		return true;
	}

	private void cleanupWindows(long now) {
		for (Map.Entry<String, RateWindow> entry : rateWindows.entrySet()) {
			if (now - entry.getValue().startedAt > WINDOW_MILLIS * 2) {
				rateWindows.remove(entry.getKey(), entry.getValue());
			}
		}
	}

	private static class RateWindow {
		private long startedAt;
		private int count;

		private RateWindow(long startedAt) {
			this.startedAt = startedAt;
		}
	}
}
