package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping("/member")
@Controller
public class MemberController {

	@RequestMapping("/login")
	public ModelAndView getLoginView(ModelAndView mv) {
		mv.setViewName("/member/login");
		return mv;
	}
	@RequestMapping("/signup")
	public ModelAndView getSignupView(ModelAndView mv) {
		mv.setViewName("/member/signup");
		return mv;
	}
	@RequestMapping("/findId")
	public ModelAndView getFindIdView(ModelAndView mv) {
		mv.setViewName("/member/findId");
		return mv;
	}
	@RequestMapping("/findPwd")
	public ModelAndView getFindPwdView(ModelAndView mv) {
		mv.setViewName("/member/findPwd");
		return mv;
	}
	@RequestMapping("/newPwd")
	public ModelAndView getNewPwdView(ModelAndView mv) {
		mv.setViewName("/member/newPwd");
		return mv;
	}
	@RequestMapping("/myinfo")
	public ModelAndView getMyinfoView(ModelAndView mv) {
		mv.setViewName("/member/myinfo");
		return mv;
	}
	@RequestMapping("/edit")
	public ModelAndView getEditView(ModelAndView mv) {
		mv.setViewName("/member/edit");
		return mv;
	}
	@RequestMapping("/delete")
	public ModelAndView getDeleteView(ModelAndView mv) {
		mv.setViewName("/member/delete");
		return mv;
	}
}
