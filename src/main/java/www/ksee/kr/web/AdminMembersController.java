package www.ksee.kr.web;

import java.util.List;
import java.util.logging.Logger;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.UserService;
import www.ksee.kr.vo.UserRole;
import www.ksee.kr.vo.UserVO;

@RequestMapping("/admin/members")
@Controller
public class AdminMembersController {
	@Autowired
	UserService userService;
	final Logger logger = Logger.getLogger(this.getClass().getSimpleName());
	/**
	 * 회원관리 
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/", method = RequestMethod.GET)
	public ModelAndView getAdminMembers(ModelAndView mv, UserVO user) {
		if(user.getPageNo() == 0) {
			user.setPageNo(1);
		}
		int totalCount = userService.count(user);
		user.setPageSize(10);
		user.setTotalCount(totalCount);
		
		List<UserVO> members = userService.search(user);
		
		mv.addObject("members", members);
		mv.addObject("paging", user);
		
		mv.addObject("title", "회원관리");
		mv.addObject("menu", 0);
		mv.setViewName("/admin/members");
		return mv;
	}
	@RequestMapping(value="/view/{id}")
	public ModelAndView getAdminMemberView(ModelAndView mv, 
			@PathVariable(value="id", required=true)Integer id) {
		UserVO user = UserVO.newInstanse(id);
		user = userService.selectOne(user);
		
		List<UserRole> userRoles = userService.selectRoles();
		
		mv.addObject("userRoles", userRoles);
		mv.addObject("user", user);
		mv.addObject("title", "회원관리");
		mv.addObject("menu", 0);
		mv.setViewName("/admin/memberView");
		return mv;
	}
	
	/**
	 * 
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/edit", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String editUserInfo(UserVO user) {
		logger.info(user.toString());
		JSONObject json = new JSONObject();
		int result = userService.update(user);
		json.put("result", result);
		return json.toString();
	}
}
