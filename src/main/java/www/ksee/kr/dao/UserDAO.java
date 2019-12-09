package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.UserRole;
import www.ksee.kr.vo.UserVO;

@Repository("UserDAO")
public class UserDAO implements DataAccess<UserVO> {
	@Autowired
	SqlSessionTemplate sqlSession;
	final String namespace = "user_sql";
	@Override
	public int insert(UserVO input) {
		return sqlSession.insert(namespace+".insert", input);
	}
	public int insert(List<UserVO> input) {
		return sqlSession.insert(namespace+".insert_list", input);
	}
	@Override
	public int update(UserVO input) {
		return sqlSession.update(namespace +".update", input);
	}

	@Override
	public int delete(UserVO input) {
		return sqlSession.delete(namespace +".delete", input);
	}

	@Override
	public List<UserVO> select() {
		return sqlSession.selectList(namespace + ".select_all");
	}

	@Override
	public List<UserVO> select(UserVO input) {
		return sqlSession.selectList(namespace +".select", input);
	}

	@Override
	public UserVO selectOne(UserVO input) {
		return sqlSession.selectOne(namespace +".select_one", input);
	}
	public UserVO selectFindId(UserVO input) {
		return sqlSession.selectOne(namespace +".select_findid", input);
	}
	@Override
	public int count(UserVO input) {
		return sqlSession.selectOne(namespace+".count", input);
	}
	public List<UserVO> search(UserVO input){
		return sqlSession.selectList(namespace +".search", input);
	}
	public List<UserRole> selectRoles(){
		return sqlSession.selectList(namespace +".roles");
	}
	public List<UserVO> selectByIds(List<UserVO> list){
		return sqlSession.selectList(namespace +".select_by_id", list);
	}
}
