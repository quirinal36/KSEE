package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.EmailToken;

@Repository("TokenDAO")
public class TokenDAO implements DataAccess<EmailToken> {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String namespace = "token_sql";
	
	@Override
	public int insert(EmailToken input) {
		return sqlSession.insert(namespace +".insert", input);
	}

	@Override
	public int update(EmailToken input) {
		return sqlSession.update(namespace +".update", input);
	}

	@Override
	public int delete(EmailToken input) {
		// TODO Auto-generated method stub
		return 0;
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
		return sqlSession.selectOne(namespace +".select_one", input);
	}

	@Override
	public int count(EmailToken input) {
		// TODO Auto-generated method stub
		return 0;
	}

}
