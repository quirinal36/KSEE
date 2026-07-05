package www.ksee.kr.web;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.PageContentService;

@Controller
@RequestMapping(value="/about")
public class AboutController extends KseeController{

	@Autowired
	private PageContentService pageContentService;

	@RequestMapping(value= {"/", "/greet"})
	public ModelAndView getHomeView(ModelAndView mv,
			HttpServletRequest request, Locale locale) {
		final String currentUrl = "/about/greet";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", "인사말");

		// DB 에 저장된 내용이 있으면 사용, 없으면 JSP 가 spring:message 로 폴백
		mv.addObject("pageContent", pageContentService.getForRender("about.greet", locale));

		mv.setViewName("/about/greet");
		return mv;
	}
	@RequestMapping(value="/history")
	public ModelAndView getHistoryView(ModelAndView mv,
			HttpServletRequest request, Locale locale) {
		final String currentUrl = "/about/history";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", "연혁");

		mv.addObject("pageContent", pageContentService.getForRender("about.history", locale));

		mv.setViewName("/about/history");
		return mv;
	}
	@RequestMapping(value="/term")
	public ModelAndView getTermView(ModelAndView mv,
			HttpServletRequest request) {
		final String currentUrl = "/about/term";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", "정관");		
		mv.setViewName("/about/term");
		return mv;
	}
	@RequestMapping(value="/member")
	public ModelAndView getMemberView(ModelAndView mv,
			HttpServletRequest request) {
		final String currentUrl = "/about/member";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", "임원진");		
		mv.setViewName("/about/member");
		return mv;
	}
}
