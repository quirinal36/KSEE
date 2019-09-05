package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/admin")
@Controller
public class AdminController {
	
	/**
	 * 관리자 첫화면
	 * @param mv
	 * @return
	 */
	@RequestMapping("/")
	public ModelAndView getAdminIndex(ModelAndView mv) {
		mv.addObject("title", "관리자페이지");
		//mv.setViewName("/admin/index");
		mv.setViewName("redirect:/admin/members");
		return mv;
	}
	
	/**
	 * 회원관리 
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/members")
	public ModelAndView getAdminMembers(ModelAndView mv) {
		mv.addObject("title", "회원관리");
		mv.addObject("menu", 0);
		mv.setViewName("/admin/members");
		return mv;
	}
	@RequestMapping(value="/members/view")
	public ModelAndView getAdminMemberView(ModelAndView mv) {
		mv.addObject("title", "회원관리");
		mv.addObject("menu", 0);
		mv.setViewName("/admin/memberView");
		return mv;
	}
	
	/**
	 * 국내 학술대회
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/domestic")
	public ModelAndView getAdminDomestic(ModelAndView mv) {
		mv.addObject("title", "국내 학술대회");
		mv.addObject("menu", 1);
		mv.setViewName("/admin/domestic");
		return mv;
	}
	@RequestMapping(value="/domestic/list")
	public ModelAndView getAdminDomesticList(ModelAndView mv) {
		mv.addObject("title", "신청현황 - 제8회 한국효소공학연구회 심포지엄");
		mv.addObject("menu", 1);
		mv.setViewName("/admin/domesticList");
		return mv;
	}
	@RequestMapping(value="/international/list")
	public ModelAndView getAdminInternationalList(ModelAndView mv) {
		mv.addObject("title", "신청현황 - 제8회 한중일 효소공학 심포지엄");
		mv.addObject("menu", 2);
		mv.setViewName("/admin/domesticList");
		return mv;
	}
	
	/**
	 * 한중일 학술대회
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/international")
	public ModelAndView getAdminInternational(ModelAndView mv) {
		mv.addObject("title", "한중일 학술대회");
		mv.addObject("menu", 2);
		mv.setViewName("/admin/international");
		return mv;
	}
	
	/**
	 * 팝업관리
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/popup")
	public ModelAndView getAdminPopup(ModelAndView mv) {
		mv.addObject("title", "팝업관리");
		mv.addObject("menu", 3);
		mv.setViewName("/admin/popup");
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
