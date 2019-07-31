package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value="/community")
@Controller
public class CommunityController {
	@RequestMapping(value="/board")
	public ModelAndView getBoardView(ModelAndView mv) {
		mv.setViewName("/community/board");
		mv.addObject("title", "자유게시판");
		return mv;
	}
}
