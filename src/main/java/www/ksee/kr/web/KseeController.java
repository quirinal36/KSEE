package www.ksee.kr.web;

import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.AuthenticationManager;

import www.ksee.kr.security.AuthenticationFacade;
import www.ksee.kr.service.BoardService;
import www.ksee.kr.service.FileInfoService;
import www.ksee.kr.service.MenuService;
import www.ksee.kr.service.PhotoInfoService;
import www.ksee.kr.service.UserService;
import www.ksee.kr.vo.Menus;
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
	@Autowired
	BoardService boardService;
	@Autowired
	MenuService menuService;
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
		for(int i=1; i<UserVO.ROLES.length; i++) {
			if(request.isUserInRole(UserVO.ROLES[i])) {
				result = true;
				break;
			}
		}
		return result;
	}
	
	protected Menus getCurMenus(String currentUrl, HttpServletRequest request) {
		logger.info((String)request.getAttribute("javax.servlet.forward.request_uri"));
		
		Menus curMenu = new Menus();
		curMenu.setUrl(currentUrl);
		curMenu = menuService.selectOne(curMenu);
		return curMenu;
	}
}
