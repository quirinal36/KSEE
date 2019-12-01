package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.Popup;

@Repository("PopupDAO")
public class PopupDAO implements DataAccess<Popup> {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String namespace = "popup_sql";
	
	@Override
	public int insert(Popup input) {
		return sqlSession.insert(namespace +".insert", input);
	}

	@Override
	public int update(Popup input) {
		return sqlSession.update(namespace +".update", input);
	}
	public int update(List<Popup> input) {
		return sqlSession.update(namespace +".update_order", input);
	}
	@Override
	public int delete(Popup input) {
		return sqlSession.delete(namespace +".delete", input);
	}

	@Override
	public List<Popup> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Popup> select(Popup input) {
		return sqlSession.selectList(namespace +".select", input);
	}

	@Override
	public Popup selectOne(Popup input) {
		return sqlSession.selectOne(namespace +".select_one", input);
	}

	@Override
	public int count(Popup input) {
		return sqlSession.selectOne(namespace +".count", input);
	}

}
