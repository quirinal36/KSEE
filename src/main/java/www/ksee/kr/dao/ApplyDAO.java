package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.ApplyVO;

@Repository("ApplyDAO")
public class ApplyDAO implements DataAccess<ApplyVO> {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String namespace = "apply_sql";
	
	@Override
	public int insert(ApplyVO input) {
		return sqlSession.insert(namespace +".insert", input);
	}

	@Override
	public int update(ApplyVO input) {
		return sqlSession.update(namespace +".update", input);
	}
	public int update(List<ApplyVO> list) {
		return sqlSession.update(namespace +".update_list", list);
	}
	@Override
	public int delete(ApplyVO input) {
		return sqlSession.delete(namespace +".delete", input);
	}
	public int delete(List<ApplyVO> input) {
		return sqlSession.delete(namespace +".delete_list", input);
	}
	@Override
	public List<ApplyVO> select() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<ApplyVO> select(ApplyVO input) {
		return sqlSession.selectList(namespace +".select", input);
	}
	public List<ApplyVO> selectFiles(ApplyVO input){
		return sqlSession.selectList(namespace +".select_files", input);
	}
	@Override
	public ApplyVO selectOne(ApplyVO input) {
		return sqlSession.selectOne(namespace +".select_one", input);
	}

	@Override
	public int count(ApplyVO input) {
		// TODO Auto-generated method stub
		return 0;
	}
	public ApplyVO search(ApplyVO input) {
		return sqlSession.selectOne(namespace+".search", input);
	}
}
