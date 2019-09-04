package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.PhotoInfo;


@Repository("PhotoInfoDAO")
public class PhotoInfoDAO implements DataAccess<PhotoInfo> {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String namespace = "photo_info_sql";
	@Override
	public int insert(PhotoInfo input) {
		return sqlSession.insert(namespace + ".insert", input);
	}
	
	public int insert(List<PhotoInfo> input) {
		return sqlSession.insert(namespace + ".insert_list", input);
	}
	
	@Override
	public int update(PhotoInfo input) {
		return sqlSession.update(namespace +".update", input);
	}
	public int update(List<PhotoInfo> list) {
		return sqlSession.update(namespace +".update_list", list);
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
		return sqlSession.selectList(namespace +".select", input);
	}
	@Override
	public PhotoInfo selectOne(PhotoInfo input) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne(namespace + ".select_one", input);
	}
	@Override
	public int count(PhotoInfo input) {
		// TODO Auto-generated method stub
		return 0;
	}
}