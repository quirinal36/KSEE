package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.TokenDAO;
import www.ksee.kr.vo.EmailToken;

@Component("tokenService")
public class TokenService implements DataService<EmailToken> {
	@Autowired
	TokenDAO dao;
	
	@Override
	public int insert(EmailToken input) {
		return dao.insert(input);
	}

	@Override
	public int update(EmailToken input) {
		return dao.update(input);
	}

	@Override
	public int delete(EmailToken input) {
		return dao.delete(input);
	}

	@Override
	public List<EmailToken> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<EmailToken> select(EmailToken input) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public EmailToken selectOne(EmailToken input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(EmailToken input) {
		// TODO Auto-generated method stub
		return 0;
	}

}
