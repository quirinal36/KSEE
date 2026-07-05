package www.ksee.kr.service;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import www.ksee.kr.dao.ChatbotBoardDAO;
import www.ksee.kr.vo.Board;

/**
 * 챗봇(관리자)이 사용할 수 있는 도구(function calling) 정의 및 실행.
 *
 * <p><b>보안:</b> 모든 변경성 도구는 실행 직전 {@code callerIsAdmin} 를 다시 확인한다.
 * LLM 이나 클라이언트가 무엇을 요청하든, 서버가 관리자 여부를 재검증하지 않으면 실행되지 않는다.
 *
 * <p>Phase 2 범위: 게시판(공지사항/관련소식/회원동정/연사제안/자유게시판) 목록·조회·작성·수정·삭제.
 */
@Service
public class ChatbotToolService {

	private static final Logger logger = LoggerFactory.getLogger(ChatbotToolService.class);

	@Autowired
	private BoardService boardService;

	@Autowired
	private ChatbotBoardDAO chatbotBoardDAO;

	/** 게시글 조회/목록 시 모델에 넘길 본문 최대 길이 (토큰 절약). */
	private static final int CONTENT_PREVIEW_LEN = 1500;
	private static final int LIST_PAGE_SIZE = 10;

	// 게시판 이름/타입 매핑
	private static final Map<String, Integer> NAME_TO_TYPE = new LinkedHashMap<>();
	private static final Map<Integer, String> TYPE_TO_NAME = new LinkedHashMap<>();
	private static final Map<Integer, String> TYPE_TO_TITLE = new LinkedHashMap<>();
	static {
		NAME_TO_TYPE.put("notice", Board.TYPE_NOTICE);
		NAME_TO_TYPE.put("news", Board.TYPE_NEWS);
		NAME_TO_TYPE.put("member", Board.TYPE_MEMBER);
		NAME_TO_TYPE.put("speaker", Board.TYPE_SPEAKER);
		NAME_TO_TYPE.put("free", Board.TYPE_FREE);

		TYPE_TO_NAME.put(Board.TYPE_NOTICE, "notice");
		TYPE_TO_NAME.put(Board.TYPE_NEWS, "news");
		TYPE_TO_NAME.put(Board.TYPE_MEMBER, "member");
		TYPE_TO_NAME.put(Board.TYPE_SPEAKER, "speaker");
		TYPE_TO_NAME.put(Board.TYPE_FREE, "free");

		TYPE_TO_TITLE.put(Board.TYPE_NOTICE, "공지사항");
		TYPE_TO_TITLE.put(Board.TYPE_NEWS, "관련소식");
		TYPE_TO_TITLE.put(Board.TYPE_MEMBER, "회원동정");
		TYPE_TO_TITLE.put(Board.TYPE_SPEAKER, "연사제안");
		TYPE_TO_TITLE.put(Board.TYPE_FREE, "자유게시판");
	}

	/**
	 * OpenRouter(OpenAI 호환) 도구 스키마 목록.
	 */
	public JSONArray getToolDefinitions() {
		JSONArray tools = new JSONArray();
		String boardEnumDesc = "게시판 종류: notice(공지사항), news(관련소식), member(회원동정), speaker(연사제안), free(자유게시판)";

		// list_posts
		tools.put(fn("list_posts", "특정 게시판의 최근 글 목록을 조회한다.",
				new JSONObject()
						.put("type", "object")
						.put("properties", new JSONObject()
								.put("boardType", strEnum(boardEnumDesc))
								.put("page", new JSONObject().put("type", "integer")
										.put("description", "페이지 번호(1부터). 기본 1")))
						.put("required", new JSONArray().put("boardType"))));

		// get_post
		tools.put(fn("get_post", "게시글 id 로 한 건의 상세 내용을 조회한다.",
				new JSONObject()
						.put("type", "object")
						.put("properties", new JSONObject()
								.put("id", new JSONObject().put("type", "integer")
										.put("description", "게시글 id")))
						.put("required", new JSONArray().put("id"))));

		// create_post
		tools.put(fn("create_post", "새 게시글을 작성한다.",
				new JSONObject()
						.put("type", "object")
						.put("properties", new JSONObject()
								.put("boardType", strEnum(boardEnumDesc))
								.put("title", str("게시글 제목(한국어)"))
								.put("content", str("게시글 본문. HTML 허용."))
								.put("title_en", str("영문 제목(선택)")))
						.put("required", new JSONArray().put("boardType").put("title").put("content"))));

		// update_post
		tools.put(fn("update_post", "기존 게시글의 제목/본문을 수정한다. 제공된 항목만 변경된다.",
				new JSONObject()
						.put("type", "object")
						.put("properties", new JSONObject()
								.put("id", new JSONObject().put("type", "integer").put("description", "게시글 id"))
								.put("title", str("새 제목(선택)"))
								.put("content", str("새 본문(선택). HTML 허용."))
								.put("title_en", str("새 영문 제목(선택)")))
						.put("required", new JSONArray().put("id"))));

		// delete_post
		tools.put(fn("delete_post", "게시글을 삭제한다. 되돌릴 수 없으므로 반드시 사용자에게 먼저 확인받고, "
				+ "사용자가 동의한 경우에만 confirm=true 로 호출한다.",
				new JSONObject()
						.put("type", "object")
						.put("properties", new JSONObject()
								.put("id", new JSONObject().put("type", "integer").put("description", "게시글 id"))
								.put("confirm", new JSONObject().put("type", "boolean")
										.put("description", "사용자가 삭제에 명시적으로 동의했으면 true")))
						.put("required", new JSONArray().put("id").put("confirm"))));

		return tools;
	}

	/**
	 * 도구 실행. 변경성 작업은 관리자 권한을 서버측에서 재확인한다.
	 *
	 * @param name         도구 이름
	 * @param args         도구 인자
	 * @param callerIsAdmin 호출자가 서버 기준 관리자인지 (신뢰 가능한 값)
	 * @param adminUserId  작성자 기록용 관리자 user id
	 * @return 실행 결과 JSON (모델에 tool 메시지로 전달됨)
	 */
	public JSONObject execute(String name, JSONObject args, boolean callerIsAdmin, int adminUserId) {
		if (!callerIsAdmin) {
			return err("이 작업은 관리자만 수행할 수 있습니다.");
		}
		if (name == null) {
			return err("도구 이름이 없습니다.");
		}
		try {
			switch (name) {
				case "list_posts":
					return listPosts(args);
				case "get_post":
					return getPost(args);
				case "create_post":
					return createPost(args, adminUserId);
				case "update_post":
					return updatePost(args);
				case "delete_post":
					return deletePost(args);
				default:
					return err("알 수 없는 도구입니다: " + name);
			}
		} catch (Exception e) {
			logger.warn("Tool execution failed: " + name + " args=" + args, e);
			return err("도구 실행 중 오류가 발생했습니다: " + e.getMessage());
		}
	}

	// ------------------------------------------------------------------
	// 도구 구현
	// ------------------------------------------------------------------

	private JSONObject listPosts(JSONObject args) {
		Integer type = resolveType(args.opt("boardType"));
		if (type == null) {
			return err("게시판 종류(boardType)가 올바르지 않습니다.");
		}
		int page = args.optInt("page", 1);
		if (page < 1) {
			page = 1;
		}

		Board q = new Board();
		q.setBoardType(type);
		q.setLanguage("ko");
		q.setQuery("");
		q.setPageSize(LIST_PAGE_SIZE);
		q.setFrom((page - 1) * LIST_PAGE_SIZE);

		int total = boardService.count(q);
		List<Board> list = boardService.select(q);

		JSONArray posts = new JSONArray();
		if (list != null) {
			for (Board b : list) {
				posts.put(new JSONObject()
						.put("id", b.getId())
						.put("title", nz(b.getTitle()))
						.put("writer", nz(b.getWriterName())));
			}
		}
		return new JSONObject()
				.put("success", true)
				.put("boardType", TYPE_TO_NAME.get(type))
				.put("boardTitle", TYPE_TO_TITLE.get(type))
				.put("page", page)
				.put("totalCount", total)
				.put("posts", posts);
	}

	private JSONObject getPost(JSONObject args) {
		int id = args.optInt("id", 0);
		if (id <= 0) {
			return err("게시글 id 가 올바르지 않습니다.");
		}
		Board b = boardService.selectOne(Board.newInstance(id));
		if (b == null) {
			return err("해당 게시글을 찾을 수 없습니다. id=" + id);
		}
		String content = nz(b.getContent());
		boolean truncated = false;
		if (content.length() > CONTENT_PREVIEW_LEN) {
			content = content.substring(0, CONTENT_PREVIEW_LEN);
			truncated = true;
		}
		Integer type = b.getBoardType();
		return new JSONObject()
				.put("success", true)
				.put("id", b.getId())
				.put("boardType", TYPE_TO_NAME.getOrDefault(type, String.valueOf(type)))
				.put("title", nz(b.getTitle()))
				.put("title_en", nz(b.getTitle_en()))
				.put("writer", nz(b.getWriterName()))
				.put("content", content)
				.put("contentTruncated", truncated);
	}

	private JSONObject createPost(JSONObject args, int adminUserId) {
		Integer type = resolveType(args.opt("boardType"));
		if (type == null) {
			return err("게시판 종류(boardType)가 올바르지 않습니다.");
		}
		String title = args.optString("title", "").trim();
		String content = args.optString("content", "");
		if (title.isEmpty()) {
			return err("제목(title)이 필요합니다.");
		}
		if (content.trim().isEmpty()) {
			return err("본문(content)이 필요합니다.");
		}

		Board b = new Board();
		b.setBoardType(type);
		b.setTitle(title);
		b.setContent(content);
		b.setWriter(adminUserId);
		if (args.has("title_en")) {
			b.setTitle_en(args.optString("title_en", null));
		}

		int r = chatbotBoardDAO.insertPost(b);
		if (r > 0 && b.getId() > 0) {
			logger.info("Chatbot admin created post id={} type={}", b.getId(), type);
			return new JSONObject()
					.put("success", true)
					.put("id", b.getId())
					.put("boardType", TYPE_TO_NAME.get(type))
					.put("url", "/group/" + TYPE_TO_NAME.get(type) + "/view/" + b.getId());
		}
		return err("게시글 작성에 실패했습니다.");
	}

	private JSONObject updatePost(JSONObject args) {
		int id = args.optInt("id", 0);
		if (id <= 0) {
			return err("게시글 id 가 올바르지 않습니다.");
		}
		Board existing = boardService.selectOne(Board.newInstance(id));
		if (existing == null) {
			return err("해당 게시글을 찾을 수 없습니다. id=" + id);
		}

		Board b = new Board();
		b.setId(id);
		boolean any = false;
		if (args.has("title")) {
			b.setTitle(args.optString("title", null));
			any = true;
		}
		if (args.has("content")) {
			b.setContent(args.optString("content", null));
			any = true;
		}
		if (args.has("title_en")) {
			b.setTitle_en(args.optString("title_en", null));
			any = true;
		}
		if (!any) {
			return err("수정할 항목(title/content/title_en)이 없습니다.");
		}

		int r = chatbotBoardDAO.updatePost(b);
		if (r > 0) {
			logger.info("Chatbot admin updated post id={}", id);
			Integer type = existing.getBoardType();
			String tname = TYPE_TO_NAME.getOrDefault(type, String.valueOf(type));
			return new JSONObject()
					.put("success", true)
					.put("id", id)
					.put("url", "/group/" + tname + "/view/" + id);
		}
		return err("게시글 수정에 실패했습니다.");
	}

	private JSONObject deletePost(JSONObject args) {
		int id = args.optInt("id", 0);
		if (id <= 0) {
			return err("게시글 id 가 올바르지 않습니다.");
		}
		boolean confirm = args.optBoolean("confirm", false);
		if (!confirm) {
			return new JSONObject()
					.put("success", false)
					.put("needConfirm", true)
					.put("message", "삭제는 되돌릴 수 없습니다. 사용자에게 삭제 여부를 확인한 뒤 confirm=true 로 다시 호출하세요.");
		}
		Board existing = boardService.selectOne(Board.newInstance(id));
		if (existing == null) {
			return err("해당 게시글을 찾을 수 없습니다. id=" + id);
		}
		int r = chatbotBoardDAO.deletePost(Board.newInstance(id));
		if (r > 0) {
			logger.info("Chatbot admin deleted post id={}", id);
			return new JSONObject()
					.put("success", true)
					.put("id", id)
					.put("deletedTitle", nz(existing.getTitle()));
		}
		return err("게시글 삭제에 실패했습니다.");
	}

	// ------------------------------------------------------------------
	// helpers
	// ------------------------------------------------------------------

	/** boardType 인자(문자 이름 또는 정수)를 내부 타입 정수로 변환. 실패 시 null. */
	private Integer resolveType(Object raw) {
		if (raw == null) {
			return null;
		}
		if (raw instanceof Number) {
			int v = ((Number) raw).intValue();
			return TYPE_TO_NAME.containsKey(v) ? v : null;
		}
		String s = String.valueOf(raw).trim();
		if (s.isEmpty()) {
			return null;
		}
		Integer byName = NAME_TO_TYPE.get(s.toLowerCase());
		if (byName != null) {
			return byName;
		}
		// 한글 게시판명 매칭
		for (Map.Entry<Integer, String> e : TYPE_TO_TITLE.entrySet()) {
			if (e.getValue().equals(s)) {
				return e.getKey();
			}
		}
		// 숫자 문자열
		try {
			int v = Integer.parseInt(s);
			return TYPE_TO_NAME.containsKey(v) ? v : null;
		} catch (NumberFormatException ignore) {
			return null;
		}
	}

	private JSONObject err(String message) {
		return new JSONObject().put("success", false).put("error", message);
	}

	private String nz(String s) {
		return s == null ? "" : s;
	}

	private JSONObject fn(String name, String description, JSONObject parameters) {
		return new JSONObject()
				.put("type", "function")
				.put("function", new JSONObject()
						.put("name", name)
						.put("description", description)
						.put("parameters", parameters));
	}

	private JSONObject str(String description) {
		return new JSONObject().put("type", "string").put("description", description);
	}

	private JSONObject strEnum(String description) {
		return new JSONObject()
				.put("type", "string")
				.put("description", description)
				.put("enum", new JSONArray().put("notice").put("news").put("member").put("speaker").put("free"));
	}
}
