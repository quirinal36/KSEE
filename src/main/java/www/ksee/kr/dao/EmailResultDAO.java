package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.EmailResult;

@Repository("EmailResultDAO")
public class EmailResultDAO implements DataAccess<EmailResult> {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String namespace = "email_sql";
	
	@Override
	public int insert(EmailResult input) {
		// TODO Auto-generated method stub
		return 0;
	}
	public int insert(List<EmailResult> list) {
		return sqlSession.insert(namespace +".insert", list);
	}
	@Override
	public int update(EmailResult input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(EmailResult input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<EmailResult> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<EmailResult> select(EmailResult input) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public EmailResult selectOne(EmailResult input) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int count(EmailResult input) {
		// TODO Auto-generated method stub
		return 0;
	}

}
