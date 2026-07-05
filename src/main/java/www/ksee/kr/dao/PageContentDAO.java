package www.ksee.kr.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.PageContent;

/**
 * 정적 페이지 콘텐츠 DAO. page_content_sql (파라미터 바인딩 #{}) 매퍼 사용.
 */
@Repository("PageContentDAO")
public class PageContentDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	private final String namespace = "page_content_sql";

	public PageContent selectByKey(String key) {
		PageContent param = new PageContent();
		param.setContent_key(key);
		return sqlSession.selectOne(namespace + ".selectByKey", param);
	}

	public int insert(PageContent input) {
		return sqlSession.insert(namespace + ".insert", input);
	}

	public int update(PageContent input) {
		return sqlSession.update(namespace + ".update", input);
	}
}
