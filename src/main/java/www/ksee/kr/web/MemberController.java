package www.ksee.kr.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.WebAuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.UserService;
import www.ksee.kr.vo.UserVO;

@RequestMapping("/member")
@Controller
public class MemberController {
	final Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	UserService userService;
	
	@Autowired
	AuthenticationManager authenticationManager;
	
	@RequestMapping("/login")
	public ModelAndView getLoginView(ModelAndView mv) {
		mv.setViewName("/member/login");
		return mv;
	}
	@RequestMapping(value="/signup", method = RequestMethod.GET)
	public ModelAndView getSignupView(ModelAndView mv) {
		mv.setViewName("/member/signup");
		return mv;
	}
	
	/**
	 * 회원가입 결과
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/signup", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String saveUser(UserVO user,
			HttpServletRequest request) {
		final String inputPwd = user.getPassword();
		int result = userService.insert(user);
		// 회원가입 직후 로그인
		UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(user.getLogin(), inputPwd);
		authToken.setDetails(new WebAuthenticationDetails(request));
		Authentication authentication = authenticationManager.authenticate(authToken);
		SecurityContextHolder.getContext().setAuthentication(authentication);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	
	/**
	 * 중복 아이디가 존재하는지 
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/get", method = RequestMethod.GET, produces = "application/json; charset=utf8")
	public String getUser(UserVO user) {
		List<UserVO> findUsers = userService.select(user);
		
		JSONObject json = new JSONObject();
		if(findUsers != null && findUsers.size()>0) {
			json.put("result", findUsers.size());
			json.put("message", "이미 사용 중인 아이디입니다.");
		}else if(userService.isValid(user)==false) {
			json.put("result", 1);
			json.put("message", "5~20자의 영문 소문자, 숫자만 사용 가능합니다.");
		}else {
			json.put("result", 0);
			json.put("message", "사용 가능한 아이디입니다.");
		}
		
		return json.toString();
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
	@RequestMapping(value="/loginProcess", method= RequestMethod.POST)
	public ModelAndView getLoginProcessPostView(ModelAndView mv) {
		mv.setViewName("/member/login");
		return mv;
	}
	@RequestMapping(value="/loginProcess", method= RequestMethod.GET)
	public ModelAndView getLoginProcessView(ModelAndView mv) {
		mv.setViewName("/member/login");
		return mv;
	}
}
