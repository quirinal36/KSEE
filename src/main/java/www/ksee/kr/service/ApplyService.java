package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.ApplyDAO;
import www.ksee.kr.vo.ApplyVO;

@Component("applyService")
public class ApplyService implements DataService<ApplyVO> {
	@Autowired
	private ApplyDAO dao;
	
	@Override
	public int insert(ApplyVO input) {
		if(input.getNationalCustom() != null && input.getNationalCustom().length() > 0) {
			input.setNationalCustom(firstCharToUpper(input.getNationalCustom()));
		}
		return dao.insert(input);
	}

	@Override
	public int update(ApplyVO input) {
		if(input.getNationalCustom() != null && input.getNationalCustom().length() > 0) {
			input.setNationalCustom(firstCharToUpper(input.getNationalCustom()));
		}
		return dao.update(input);
	}
	public int update(List<ApplyVO> input) {
		return dao.update(input);
	}
	@Override
	public int delete(ApplyVO input) {
		return dao.delete(input);
	}
	public int delete(List<ApplyVO> list) {
		return dao.delete(list);
	}
	@Override
	public List<ApplyVO> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ApplyVO> select(ApplyVO input) {
		return dao.select(input);
	}
	public List<ApplyVO> selectFiles(ApplyVO input){
		return dao.selectFiles(input);
	}
	@Override
	public ApplyVO selectOne(ApplyVO input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(ApplyVO input) {
		// TODO Auto-generated method stub
		return 0;
	}
	public ApplyVO search(ApplyVO input) {
		return dao.search(input);
	}
	
	/**
	 * 첫 글자는 대문자료 변경
	 * 
	 * @param input
	 * @return
	 */
	public String firstCharToUpper(String input) {
		final String first = input.substring(0, 1).toUpperCase();
		final String all = new StringBuilder().append(first).append(input.substring(1, input.length())).toString();
		
		return all;
	}
}
