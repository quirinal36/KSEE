package www.ksee.kr.web;

import java.util.LinkedHashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomNumberEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.PageContentService;
import www.ksee.kr.vo.PageContent;

/**
 * 소개 페이지(인사말/임원진/정관/연혁) 내용을 관리자 페이지에서
 * 에디터 또는 파일 업로드로 편집하기 위한 컨트롤러.
 */
@RequestMapping("/admin/page")
@Controller
public class AdminPageController extends KseeController {

	@Autowired
	private PageContentService pageContentService;

	/** 빈 문자열로 넘어오는 숫자 파라미터(fileId)를 null 로 바인딩 */
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		binder.registerCustomEditor(Integer.class, new CustomNumberEditor(Integer.class, true));
	}

	/** 편집 대상 페이지 key -> 표시 제목 (순서 유지) */
	public static final Map<String, String> PAGES = new LinkedHashMap<String, String>();
	static {
		PAGES.put("greet", "인사말");
		PAGES.put("member", "임원진");
		PAGES.put("term", "정관");
		PAGES.put("history", "연혁");
	}

	/**
	 * 페이지 관리 목록
	 */
	@RequestMapping(value = "/")
	public ModelAndView getList(ModelAndView mv) {
		mv.addObject("title", "페이지 관리");
		mv.addObject("menu", 4);
		mv.addObject("pages", PAGES);

		Map<String, PageContent> contents = new LinkedHashMap<String, PageContent>();
		for (String key : PAGES.keySet()) {
			contents.put(key, pageContentService.selectOne(PageContent.newInstance(key)));
		}
		mv.addObject("contents", contents);
		mv.setViewName("/admin/page");
		return mv;
	}

	/**
	 * 편집 폼 (에디터 + 파일 업로드)
	 */
	@RequestMapping(value = "/edit/{key}", method = RequestMethod.GET)
	public ModelAndView getEdit(ModelAndView mv, @PathVariable("key") String key) {
		String pageTitle = PAGES.get(key);
		if (pageTitle == null) {
			mv.setViewName("redirect:/admin/page/");
			return mv;
		}
		PageContent pc = pageContentService.selectOne(PageContent.newInstance(key));
		if (pc == null) {
			pc = PageContent.newInstance(key);
			pc.setViewType("HTML");
		}
		mv.addObject("title", "페이지 관리 - " + pageTitle);
		mv.addObject("menu", 4);
		mv.addObject("pageTitle", pageTitle);
		mv.addObject("pageKey", key);
		mv.addObject("content", pc);
		mv.setViewName("/admin/page/edit");
		return mv;
	}

	/**
	 * 저장 (에디터 HTML 또는 업로드 파일 id).
	 * 파일 자체는 /upload/image, /upload/file 로 먼저 업로드되고 여기서는 id 만 저장한다.
	 */
	@ResponseBody
	@RequestMapping(value = "/save", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String save(PageContent input, HttpServletRequest request) {
		JSONObject json = new JSONObject();

		if (!isAdmin(request)) {
			json.put("result", -1);
			json.put("msg", "관리자 계정으로 로그인하세요.");
			return json.toString();
		}
		if (input.getPageKey() == null || !PAGES.containsKey(input.getPageKey())) {
			json.put("result", -1);
			json.put("msg", "잘못된 페이지입니다.");
			return json.toString();
		}

		// 표시 방식에 따라 불필요한 필드 정리 (정합성 유지)
		if ("FILE".equalsIgnoreCase(input.getViewType())) {
			input.setViewType("FILE");
			input.setContent(null);
		} else {
			input.setViewType("HTML");
			input.setFileId(null);
			input.setFileType(null);
		}

		try {
			input.setUpdatedBy(authenticationFacade.getAuthentication().getName());
		} catch (Exception ignore) {
			// 인증 이름을 못 가져와도 저장은 진행
		}

		int result = pageContentService.update(input);
		json.put("result", result);
		return json.toString();
	}
}
