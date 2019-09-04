package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.PhotoInfoDAO;
import www.ksee.kr.vo.PhotoInfo;


@Component("photoInfoService")
public class PhotoInfoService implements DataService<PhotoInfo> {
	@Autowired
	PhotoInfoDAO dao;
	
	@Override
	public int insert(PhotoInfo input) {
		// TODO Auto-generated method stub
		return dao.insert(input);
	}
	
	public int insert(List<PhotoInfo> input) {
		return dao.insert(input);
	}

	@Override
	public int update(PhotoInfo input) {
		return dao.update(input);
	}

	@Override
	public int delete(PhotoInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<PhotoInfo> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<PhotoInfo> select(PhotoInfo input) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public PhotoInfo selectOne(PhotoInfo input) {
		// TODO Auto-generated method stub
		return dao.selectOne(input);
	}

	@Override
	public int count(PhotoInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}

}