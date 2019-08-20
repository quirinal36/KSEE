package www.ksee.kr.security.config;

import java.util.Arrays;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import www.ksee.kr.dao.UserDAO;
import www.ksee.kr.vo.UserVO;

@Service
public class UserDetailService implements UserDetailsService { 
	Logger logger = LoggerFactory.getLogger(UserDetailsService.class);
	
	@Autowired
	private UserDAO dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserVO user = new UserVO();
		user.setLogin(username);
		user = dao.selectOne(user);
		if(user != null) {
			GrantedAuthority authority = new SimpleGrantedAuthority(user.getRole_name());
			UserDetails userDetails = (UserDetails)new User(user.getLogin()
					,user.getPassword(), Arrays.asList(authority));
					
			return userDetails;
		}else {
			return null;
		}
	}
	
	/**
	 * 지금 로그인하는 User의 로그인 로그를 저장한다
	 * 
	 * @param username
	 */
	public void updateUserLoginLog(String username) {
//		if(dao.selectUserLoginLog(username) == null) {
//			dao.insertLoginLog(username);
//		}
//		dao.updateUserLoginLog(username);
	}
}
