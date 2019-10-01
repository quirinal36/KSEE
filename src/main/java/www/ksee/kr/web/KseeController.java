package www.ksee.kr.web;

import java.util.logging.Logger;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.security.authentication.AuthenticationManager;

import www.ksee.kr.security.AuthenticationFacade;
import www.ksee.kr.service.BoardService;
import www.ksee.kr.service.FileInfoService;
import www.ksee.kr.service.MenuService;
import www.ksee.kr.service.PhotoInfoService;
import www.ksee.kr.service.TokenService;
import www.ksee.kr.service.UserService;
import www.ksee.kr.vo.Menus;
import www.ksee.kr.vo.UserVO;

public class KseeController {
	protected final Logger logger = Logger.getLogger(this.getClass().getSimpleName());
	
	@Autowired
	protected AuthenticationFacade authenticationFacade;
	@Autowired
	protected AuthenticationManager authenticationManager;
	// 한영 번역시 프로퍼티파일을 불러오는 역할
	@Autowired
	protected MessageSource messageSource;
	
	@Autowired
	protected UserService userService;	
	@Autowired
	protected PhotoInfoService photoInfoService;
	@Autowired
	protected FileInfoService fileInfoService;
	@Autowired
	protected BoardService boardService;
	@Autowired
	protected MenuService menuService;
	@Autowired
	protected TokenService tokenService;
	
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
		Menus curMenu = new Menus();
		curMenu.setUrl(currentUrl);
		curMenu = menuService.selectOne(curMenu);
		return curMenu;
	}
	/**
	 * 현재 사이트의 기본 URL 을 만드는 메소드
	 * 
	 * @param req
	 * @return
	 */
	protected String getBaseUrl(HttpServletRequest req) {
		return new StringBuilder().append(req.getScheme()).append("://").append(req.getServerName()).append(":")
				.append(req.getServerPort()) + req.getContextPath().toString();
	}
}
