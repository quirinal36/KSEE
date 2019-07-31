package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value = "/board")
@Controller
public class BoardController {

	@RequestMapping(value = "/board_edit")
	public ModelAndView getBoardEditView(ModelAndView mv) {
		mv.setViewName("/board/board_edit");
		
		return mv;
	}

	@RequestMapping(value = "/board_view")
	public ModelAndView getBoardView(ModelAndView mv) {
		mv.setViewName("/board/board_view");
		return mv;
	}

	@RequestMapping(value = "/board_write")
	public ModelAndView getBoardWriteView(ModelAndView mv) {
		mv.setViewName("/board/board_write");
		return mv;
	}
	
}
