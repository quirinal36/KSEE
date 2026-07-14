package www.ksee.kr.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import www.ksee.kr.dao.PageContentDAO;
import www.ksee.kr.vo.PageContent;

@Component("pageContentService")
public class PageContentService implements DataService<PageContent> {
	@Autowired
	private PageContentDAO dao;

	@Override
	public int insert(PageContent input) {
		return dao.insert(input);
	}

	@Override
	public int update(PageContent input) {
		return dao.update(input);
	}

	@Override
	public int delete(PageContent input) {
		return dao.delete(input);
	}

	@Override
	public List<PageContent> select() {
		return dao.select();
	}

	@Override
	public List<PageContent> select(PageContent input) {
		return dao.select(input);
	}

	@Override
	public PageContent selectOne(PageContent input) {
		return dao.selectOne(input);
	}

	@Override
	public int count(PageContent input) {
		return dao.count(input);
	}
}
