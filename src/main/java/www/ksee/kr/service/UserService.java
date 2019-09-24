package www.ksee.kr.service;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.UserDAO;
import www.ksee.kr.vo.UserVO;

@Component("userService")
public class UserService implements DataService<UserVO> {
	Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private UserDAO dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public int insert(UserVO input) {
		input.setPassword(passwordEncoder.encode(input.getPassword()));
		return dao.insert(input);
	}
	public int insert(List<UserVO> list) {
		return dao.insert(list);
	}
	@Override
	public int update(UserVO input) {
		input.setPassword(passwordEncoder.encode(input.getPassword()));
		return dao.update(input);
	}

	@Override
	public int delete(UserVO input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<UserVO> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<UserVO> select(UserVO input) {
		return dao.select(input);
	}

	@Override
	public UserVO selectOne(UserVO input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(UserVO input) {
		// TODO Auto-generated method stub
		return 0;
	}
	public boolean isValid(UserVO input) {
		logger.info("isValid");
		
		final String regex = "^[a-z]{1}[a-z0-9_]{4,19}$";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(input.getLogin());
		logger.info("matcher.matches(): " + matcher.matches());
		return matcher.matches();
	}
}
