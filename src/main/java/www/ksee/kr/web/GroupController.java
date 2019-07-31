package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value="/group")
@Controller
public class GroupController {

	@RequestMapping(value="/")
	public ModelAndView getHomeView(ModelAndView mv) {
		mv.setViewName("/group/home");
		mv.addObject("title", "학회소식");
		return mv;
	}
	@RequestMapping(value="/notice")
	public ModelAndView getNoticeView(ModelAndView mv) {
		mv.setViewName("/group/notice");
		mv.addObject("title", "공지사항");
		return mv;
	}
	@RequestMapping(value="/news")
	public ModelAndView getNewsView(ModelAndView mv) {
		mv.setViewName("/group/news");
		mv.addObject("title", "관련소식");
		return mv;
	}
}
