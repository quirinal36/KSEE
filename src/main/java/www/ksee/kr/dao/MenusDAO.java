package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.Menus;

@Repository("MenusDAO")
public class MenusDAO implements DataAccess<Menus> {
	@Autowired
	SqlSessionTemplate sqlSession;
	final String namespace = "menu_sql";
	
	@Override
	public int insert(Menus input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int update(Menus input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Menus input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Menus> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Menus> select(Menus input) {
		return sqlSession.selectList(namespace +".select", input);
	}
	public List<Menus> select(List<Menus> list) {
		return sqlSession.selectList(namespace +".select_list", list);
	}
	public List<Menus> selectSiblings(Menus input){
		return sqlSession.selectList(namespace+".select_siblings", input);
	}
	@Override
	public Menus selectOne(Menus input) {
		return sqlSession.selectOne(namespace +".select_one", input);
	}

	@Override
	public int count(Menus input) {
		// TODO Auto-generated method stub
		return 0;
	}

}
