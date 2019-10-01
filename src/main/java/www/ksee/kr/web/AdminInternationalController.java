package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/admin/international")
@Controller
public class AdminInternationalController {

	@RequestMapping(value="/list")
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
	@RequestMapping(value="/")
	public ModelAndView getAdminInternational(ModelAndView mv) {
		mv.addObject("title", "한중일 학술대회");
		mv.addObject("menu", 2);
		mv.setViewName("/admin/international");
		return mv;
	}
}
