package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.PopupDAO;
import www.ksee.kr.vo.Popup;

@Component("popupService")
public class PopupService  implements DataService<Popup>{
	@Autowired
	private PopupDAO dao;
	@Override
	public int insert(Popup input) {
		return dao.insert(input);
	}

	@Override
	public int update(Popup input) {
		return dao.update(input);
	}
	public int update(List<Popup> input) {
		return dao.update(input);
	}
	@Override
	public int delete(Popup input) {
		return dao.delete(input);
	}

	@Override
	public List<Popup> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Popup> select(Popup input) {
		return dao.select(input);
	}

	@Override
	public Popup selectOne(Popup input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(Popup input) {
		return dao.count(input);
	}

}
