package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.ReplyDAO;
import www.ksee.kr.vo.Reply;

@Component("replyService")
public class ReplyService implements DataService<Reply>{
	@Autowired
	private ReplyDAO dao;

	@Override
	public int insert(Reply input) {
		return dao.insert(input);
	}

	@Override
	public int update(Reply input) {
		return dao.update(input);
	}

	@Override
	public int delete(Reply input) {
		return dao.delete(input);
	}

	@Override
	public List<Reply> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Reply> select(Reply input) throws NullPointerException {
		return dao.select(input);
	}

	@Override
	public Reply selectOne(Reply input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(Reply input) {
		return dao.count(input);
	}
	
}
