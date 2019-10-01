package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/admin/domestic")
@Controller
public class AdminDomesticController {

	/**
	 * 국내 학술대회
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/")
	public ModelAndView getAdminDomestic(ModelAndView mv) {
		mv.addObject("title", "국내 학술대회");
		mv.addObject("menu", 1);
		mv.setViewName("/admin/domestic");
		return mv;
	}
	
	@RequestMapping(value="/write")
	public ModelAndView getWriteView(ModelAndView mv) {
		mv.addObject("title", "국내 학술대회");
		mv.setViewName("/admin/domestic/write");
		return mv;
	}
	@RequestMapping(value="/list")
	public ModelAndView getAdminDomesticList(ModelAndView mv) {
		mv.addObject("title", "신청현황 - 제8회 한국효소공학연구회 심포지엄");
		mv.addObject("menu", 1);
		mv.setViewName("/admin/domesticList");
		return mv;
	}
}
