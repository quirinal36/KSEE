package www.ksee.kr.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.PageContent;

@Repository("PageContentDAO")
public class PageContentDAO implements DataAccess<PageContent> {
	@Autowired
	private SqlSessionTemplate sqlSession;
	private final String namespace = "page_content_sql";

	@Override
	public int insert(PageContent input) {
		// page_key 기준 upsert
		return sqlSession.insert(namespace + ".save", input);
	}

	@Override
	public int update(PageContent input) {
		// page_key 기준 upsert
		return sqlSession.insert(namespace + ".save", input);
	}

	@Override
	public int delete(PageContent input) {
		return sqlSession.delete(namespace + ".delete", input);
	}

	@Override
	public List<PageContent> select() {
		return sqlSession.selectList(namespace + ".select");
	}

	@Override
	public List<PageContent> select(PageContent input) {
		return sqlSession.selectList(namespace + ".select", input);
	}

	@Override
	public PageContent selectOne(PageContent input) {
		return sqlSession.selectOne(namespace + ".select_one", input);
	}

	@Override
	public int count(PageContent input) {
		return sqlSession.selectOne(namespace + ".count", input);
	}
}
