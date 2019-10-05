package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.SymposiumDetailDAO;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.SymposiumDetail;

@Component("symposoumDetailService")
public class SymposiumDetailService implements DataService<SymposiumDetail> {
	@Autowired
	SymposiumDetailDAO dao;
	
	@Override
	public int insert(SymposiumDetail input) {
		return dao.insert(input);
	}

	@Override
	public int update(SymposiumDetail input) {
		return dao.update(input);
	}

	@Override
	public int delete(SymposiumDetail input) {
		return dao.delete(input);
	}

	@Override
	public List<SymposiumDetail> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SymposiumDetail> select(SymposiumDetail input) {
		return dao.select(input);
	}

	@Override
	public SymposiumDetail selectOne(SymposiumDetail input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(SymposiumDetail input) {
		return dao.count(input);
	}
	public String selectTypeTitle(SymposiumDetail input) {
		return dao.selectTypeTitle(input);
	}
	public String selectSymposiumTitle(SymposiumDetail input) {
		return dao.selectSymposiumTitle(input);
	}
	public int updatePhotos(List<PhotoInfo> list) {
		return dao.updatePhotos(list);
	}
	public int deletePhotos(List<PhotoInfo> list) {
		return dao.deletePhotos(list);
	}
	public List<PhotoInfo> selectPhotos(SymposiumDetail input) {
		return dao.selectPhotos(input);
	}
}
