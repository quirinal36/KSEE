package www.ksee.kr.web;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/inc")
@Controller
public class IncController {

	@RequestMapping(value = "/header", method = RequestMethod.GET)
	public ModelAndView getHeaderView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("/inc/header");
		return mv;
	}
	@RequestMapping(value = "/footer", method = RequestMethod.GET)
	public ModelAndView getFooterView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("/inc/footer");
		return mv;
	}
	@RequestMapping(value = "/head", method = RequestMethod.GET)
	public ModelAndView getHeadView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("/inc/head");
		return mv;
	}
}
