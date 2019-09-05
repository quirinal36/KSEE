package www.ksee.kr.web;

import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.AuthenticationManager;

import www.ksee.kr.security.AuthenticationFacade;
import www.ksee.kr.service.FileInfoService;
import www.ksee.kr.service.PhotoInfoService;
import www.ksee.kr.service.UserService;
import www.ksee.kr.vo.UserVO;

public class KseeController {
	@Resource(name="userService")
	protected UserService userService;
	@Autowired
	protected AuthenticationFacade authenticationFacade;
	protected final Logger logger = Logger.getLogger(this.getClass().getSimpleName());
	@Resource(name="photoInfoService")
	protected PhotoInfoService photoInfoService;
	@Resource(name="fileInfoService")
	protected FileInfoService fileInfoService;
	@Autowired
	AuthenticationManager authenticationManager;
	@Autowired
	protected MessageSource messageSource;
	
	protected UserVO getUser() {
		String authUser = authenticationFacade.getAuthentication().getName();
		
		UserVO searchUser = new UserVO();
		searchUser.setLogin(authUser);
		UserVO user = userService.selectOne(searchUser);
		
		return user;
	}
	/**
	 * 로그인한 사용자
	 * @param request
	 * @return
	 */
	protected boolean isLoginedUser(HttpServletRequest request) {
		boolean result = false;
		for(int i=1; i<UserVO.ROLES.length-1; i++) {
			if(request.isUserInRole(UserVO.ROLES[i])) {
				result = true;
				break;
			}
		}
		return result;
	}
}
