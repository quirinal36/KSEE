package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.EmailResultDAO;
import www.ksee.kr.vo.EmailResult;

@Component("emailResultService")
public class EmailResultService implements DataService<EmailResult> {
	@Autowired
	EmailResultDAO dao;
	@Override
	public int insert(EmailResult input) {
		// TODO Auto-generated method stub
		return 0;
	}
	public int insert(List<EmailResult> list) {
		return dao.insert(list);
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
