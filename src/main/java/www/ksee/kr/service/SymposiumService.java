package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.SymposiumDAO;
import www.ksee.kr.vo.Symposium;
import www.ksee.kr.vo.SymposiumDetail;
import www.ksee.kr.vo.SymposiumTypes;

@Component("symposiumService")
public class SymposiumService implements DataService<Symposium> {
	@Autowired
	private SymposiumDAO dao;
	
	@Override
	public int insert(Symposium input) {
		return dao.insert(input);
	}

	@Override
	public int update(Symposium input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int delete(Symposium input) {
		return dao.delete(input);
	}

	@Override
	public List<Symposium> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Symposium> select(Symposium input) {
		return dao.select(input);
	}

	@Override
	public Symposium selectOne(Symposium input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(Symposium input) {
		return dao.count(input);
	}
	public List<SymposiumTypes> selectSymposiumTypes(){
		return dao.selectSymposiumTypes();
	}
	public int updateViewCnt(Symposium input) {
		return dao.updateViewCnt(input);
	}
	/*
	public SymposiumDetail selectSymposiumDetail(SymposiumDetail detail) {
		return dao.selectSymposiumDetail(detail);
	}
	public List<SymposiumDetail> selectSymposiumDetails(SymposiumDetail detail) {
		return dao.selectSymposiumDetails(detail);
	}
	public SymposiumDetail selectSymposiumTitle(SymposiumDetail detail) {
		return dao.selectSymposiumTitle(detail);
	}
	public int deleteSymposiumDetail(SymposiumDetail detail) {
		return dao.deleteSymposiumDetail(detail);
	}
	public int updateSymposiumDetail(){}
	*/
}
