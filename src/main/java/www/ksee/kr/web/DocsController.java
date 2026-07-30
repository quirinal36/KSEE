package www.ksee.kr.web;

import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.util.StreamUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * 프로젝트 기능 문서를 공개 웹 페이지로 제공한다.
 * 원본 Markdown은 프로젝트 루트 docs/에 있고 Maven이 classpath:docs/로 패키징한다.
 */
@Controller
@RequestMapping("/docs")
public class DocsController {

	private static final Map<String, String> DOCUMENTS;
	static {
		Map<String, String> documents = new LinkedHashMap<String, String>();
		documents.put("overview", "README.md");
		documents.put("architecture", "01-architecture.md");
		documents.put("public-content", "02-public-content.md");
		documents.put("member", "03-member.md");
		documents.put("symposium-application", "04-symposium-application.md");
		documents.put("board-comment", "05-board-comment.md");
		documents.put("file-image", "06-file-image.md");
		documents.put("admin", "07-admin.md");
		documents.put("route-catalog", "08-route-catalog.md");
		documents.put("chatbot", "09-chatbot.md");
		DOCUMENTS = Collections.unmodifiableMap(documents);
	}

	@RequestMapping(value = {"", "/", "/{document}"}, method = RequestMethod.GET)
	public ModelAndView view(ModelAndView mv,
			@PathVariable(value = "document", required = false) String document,
			HttpServletResponse response) {
		String documentKey = document == null || document.length() == 0 ? "overview" : document;
		if (!DOCUMENTS.containsKey(documentKey)) {
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			mv.setViewName("/error/404");
			return mv;
		}

		mv.addObject("title", "기능 문서");
		mv.addObject("documentKey", documentKey);
		mv.addObject("documents", DOCUMENTS);
		mv.setViewName("/docs/index");
		return mv;
	}

	@ResponseBody
	@RequestMapping(value = "/content/{document}", method = RequestMethod.GET,
			produces = "text/markdown; charset=UTF-8")
	public String content(@PathVariable("document") String document,
			HttpServletResponse response) throws IOException {
		String filename = DOCUMENTS.get(document);
		if (filename == null) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return "";
		}

		ClassPathResource resource = new ClassPathResource("docs/" + filename);
		if (!resource.exists()) {
			response.sendError(HttpServletResponse.SC_NOT_FOUND);
			return "";
		}

		InputStream input = resource.getInputStream();
		try {
			return StreamUtils.copyToString(input, StandardCharsets.UTF_8);
		} finally {
			input.close();
		}
	}
}
