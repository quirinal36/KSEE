package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.SymposiumDetail;

@Repository("SymposiumDetailDAO")
public class SymposiumDetailDAO implements DataAccess<SymposiumDetail> {
	@Autowired
	SqlSessionTemplate sqlSession;
	
	final String namespace = "symposium_detail_sql";
	@Override
	public int insert(SymposiumDetail input) {
		return sqlSession.insert(namespace +".insert", input);
	}

	@Override
	public int update(SymposiumDetail input) {
		return sqlSession.update(namespace +".update", input);
	}

	@Override
	public int delete(SymposiumDetail input) {
		return sqlSession.delete(namespace +".delete", input);
	}

	@Override
	public List<SymposiumDetail> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<SymposiumDetail> select(SymposiumDetail input) {
		return sqlSession.selectList(namespace +".select", input);
	}

	@Override
	public SymposiumDetail selectOne(SymposiumDetail input) {
		return sqlSession.selectOne(namespace +".select_one", input);
	}

	@Override
	public int count(SymposiumDetail input) {
		return sqlSession.selectOne(namespace +".count", input);
	}

	public String selectSymposiumTitle(SymposiumDetail input) {
		return sqlSession.selectOne(namespace +".select_title", input);
	}
	public String selectTypeTitle(SymposiumDetail input) {
		return sqlSession.selectOne(namespace +".select_type_title", input);
	}
	public int updatePhotos(List<PhotoInfo> list) {
		return sqlSession.update(namespace +".update_photos", list);
	}
	public int deletePhotos(List<PhotoInfo> list) {
		return sqlSession.delete(namespace +".delete_photos", list);
	}
	public List<PhotoInfo> selectPhotos(SymposiumDetail input){
		return sqlSession.selectList(namespace +".select_photos", input);
	}
}
