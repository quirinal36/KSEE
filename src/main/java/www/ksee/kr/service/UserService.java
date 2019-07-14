package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.UserDAO;
import www.ksee.kr.vo.UserVO;

@Component("userService")
public class UserService implements DataService<UserVO> {
	@Autowired
	private UserDAO dao;
	
	@Override
	public int insert(UserVO input) {
		// TODO Auto-generated method stub
		return 0;
	}
	public int insert(List<UserVO> list) {
		return dao.insert(list);
	}
	@Override
	public int update(UserVO input) {
		// TODO Auto-generated method stub
		return 0;
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
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public UserVO selectOne(UserVO input) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int count(UserVO input) {
		// TODO Auto-generated method stub
		return 0;
	}

}
