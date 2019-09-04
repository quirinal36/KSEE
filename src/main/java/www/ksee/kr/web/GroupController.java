package www.ksee.kr.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value="/group")
@Controller
public class GroupController extends KseeController {

	@RequestMapping(value= {"/", "/notice"})
	public ModelAndView getNoticeView(ModelAndView mv) {
		mv.setViewName("/group/notice");
		mv.addObject("title", "학회소식");
		return mv;
	}
	@RequestMapping(value="/notice/write")
	public ModelAndView getWriteNoticeView(ModelAndView mv, HttpServletRequest request) {
		mv.addObject("current", request.getServletPath());
		mv.setViewName("/board/write");
		return mv;
	}
	@RequestMapping(value="/notice/view/{id}")
	public ModelAndView getDetailNoticeView(ModelAndView mv,
			@PathVariable(value="id", required = true)Integer id) {
		
		mv.setViewName("/board/detail");
		return mv;
	}
	@RequestMapping(value="/news")
	public ModelAndView getNewsView(ModelAndView mv) {
		mv.setViewName("/group/news");
		mv.addObject("title", "관련소식");
		return mv;
	}
}
