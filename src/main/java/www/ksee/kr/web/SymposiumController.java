package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value="/symposium")
@Controller
public class SymposiumController {
	@RequestMapping(value="/")
	public ModelAndView getHomeView(ModelAndView mv) {
		mv.setViewName("/symposium/home");
		mv.addObject("title", "2019 학술대회");
		return mv;
	}
	@RequestMapping(value="/history")
	public ModelAndView getHistoryView(ModelAndView mv) {
		mv.setViewName("/symposium/history");
		mv.addObject("title", "국내 학술대회");
		return mv;
	}
	@RequestMapping(value="/international")
	public ModelAndView getInternationalView(ModelAndView mv) {
		mv.setViewName("/symposium/international");
		mv.addObject("title", "한중일 학술대회");
		return mv;
	}
}
