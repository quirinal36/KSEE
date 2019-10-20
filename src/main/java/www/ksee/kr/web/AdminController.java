package www.ksee.kr.web;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.PopupService;
import www.ksee.kr.vo.Popup;

@RequestMapping("/admin")
@Controller
public class AdminController {
	@Autowired
	PopupService popupService;
	/**
	 * 관리자 첫화면
	 * @param mv
	 * @return
	 */
	@RequestMapping("/")
	public ModelAndView getAdminIndex(ModelAndView mv) {
		mv.addObject("title", "관리자페이지");
		//mv.setViewName("/admin/index");
		mv.setViewName("redirect:/admin/members/");
		return mv;
	}
	
	/**
	 * 사이드메뉴
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/sidebar")
	public ModelAndView getAdminSidebar(ModelAndView mv) {
		mv.setViewName("/admin/sidebar");
		return mv;
	}
}
