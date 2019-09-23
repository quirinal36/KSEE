package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.MenusDAO;
import www.ksee.kr.vo.Menus;

@Component("menuService")
public class MenuService implements DataService<Menus> {
	@Autowired
	private MenusDAO dao;

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
		return dao.select(input);
	}
	public List<Menus> select(List<Menus> list) {
		return dao.select(list);
	}
	public List<Menus> selectSiblings(Menus input){
		return dao.selectSiblings(input);
	}
	@Override
	public Menus selectOne(Menus input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(Menus input) {
		// TODO Auto-generated method stub
		return 0;
	}
	
}
