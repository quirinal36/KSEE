package www.ksee.kr.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.PageContentService;
import www.ksee.kr.vo.PageContent;

@Controller
@RequestMapping(value="/about")
public class AboutController extends KseeController{

	@Autowired
	private PageContentService pageContentService;

	/** 관리자에서 등록한 페이지 내용(DB)을 모델에 담는다. 없으면 null → JSP 가 기존 내용으로 폴백 */
	private void addPageContent(ModelAndView mv, String pageKey) {
		mv.addObject("pageContent", pageContentService.selectOne(PageContent.newInstance(pageKey)));
	}

	@RequestMapping(value= {"/", "/greet"})
	public ModelAndView getHomeView(ModelAndView mv,
			HttpServletRequest request) {
		final String currentUrl = "/about/greet";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", "인사말");
		addPageContent(mv, "greet");

		mv.setViewName("/about/greet");
		return mv;
	}
	@RequestMapping(value="/history")
	public ModelAndView getHistoryView(ModelAndView mv,
			HttpServletRequest request) {
		final String currentUrl = "/about/history";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", "연혁");
		addPageContent(mv, "history");

		mv.setViewName("/about/history");
		return mv;
	}
	@RequestMapping(value="/term")
	public ModelAndView getTermView(ModelAndView mv,
			HttpServletRequest request) {
		final String currentUrl = "/about/term";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", "정관");
		addPageContent(mv, "term");
		mv.setViewName("/about/term");
		return mv;
	}
	@RequestMapping(value="/member")
	public ModelAndView getMemberView(ModelAndView mv,
			HttpServletRequest request) {
		final String currentUrl = "/about/member";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", "임원진");
		addPageContent(mv, "member");
		mv.setViewName("/about/member");
		return mv;
	}
}
