package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value="/about")
public class AboutController {

	@RequestMapping(value="/greet")
	public ModelAndView getHomeView(ModelAndView mv) {
		mv.setViewName("/about/greet");
		mv.addObject("title", "인사말");
		return mv;
	}
	@RequestMapping(value="/history")
	public ModelAndView getHistoryView(ModelAndView mv) {
		mv.setViewName("/about/history");
		mv.addObject("title", "연혁");
		return mv;
	}
	@RequestMapping(value="/term")
	public ModelAndView getTermView(ModelAndView mv) {
		mv.setViewName("/about/term");
		mv.addObject("title", "정관");
		return mv;
	}
	@RequestMapping(value="/member")
	public ModelAndView getMemberView(ModelAndView mv) {
		mv.setViewName("/about/member");
		mv.addObject("title", "임원진");
		return mv;
	}
}
