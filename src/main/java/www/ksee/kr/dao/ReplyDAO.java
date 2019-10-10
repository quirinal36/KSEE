package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.Reply;

@Repository("ReplyDAO")
public class ReplyDAO implements DataAccess<Reply> {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	private final String namespace = "reply_sql";
	
	@Override
	public int insert(Reply input) {
		return sqlSession.insert(namespace+".insert", input);
	}

	@Override
	public int update(Reply input) {
		return sqlSession.update(namespace+".update", input);
	}

	@Override
	public int delete(Reply input) {
		return sqlSession.delete(namespace+".delete", input);
	}

	@Override
	public List<Reply> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Reply> select(Reply input) throws NullPointerException{
		return sqlSession.selectList(namespace+".select", input);
	}

	@Override
	public Reply selectOne(Reply input) {
		return sqlSession.selectOne(namespace+".select_one", input);
	}

	@Override
	public int count(Reply input) {
		return sqlSession.selectOne(namespace+".count", input);
	}

}
