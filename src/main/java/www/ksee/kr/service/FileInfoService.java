package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.FileInfoDAO;
import www.ksee.kr.vo.ApplyVO;
import www.ksee.kr.vo.FileInfo;
import www.ksee.kr.vo.PhotoInfo;

@Component("fileInfoService")
public class FileInfoService implements DataService<FileInfo>{
	@Autowired
	FileInfoDAO dao;
	
	@Override
	public int insert(FileInfo input) {
		return dao.insert(input);
	}
	public int insert(List<FileInfo> input) {
		return dao.insert(input);
	}
	@Override
	public int update(FileInfo input) {
		return dao.update(input);
	}
	public int update(List<FileInfo> list) {
		return dao.update(list);
	}
	@Override
	public int delete(FileInfo input) {
		return dao.delete(input);
	}

	@Override
	public List<FileInfo> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<FileInfo> select(FileInfo input) {
		return dao.select(input);
	}

	@Override
	public FileInfo selectOne(FileInfo input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(FileInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}
	public List<FileInfo> selectApplications(ApplyVO apply){
		return dao.selectApplications(apply);
	}
	public List<FileInfo> selectById(List<FileInfo> list){
		return dao.selectById(list);
	}
}
