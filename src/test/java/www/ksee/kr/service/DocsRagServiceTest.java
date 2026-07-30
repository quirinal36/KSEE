package www.ksee.kr.service;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import org.junit.Before;
import org.junit.Test;

import www.ksee.kr.service.DocsRagService.SearchResult;
import www.ksee.kr.service.DocsRagService.Source;

public class DocsRagServiceTest {

	private DocsRagService service;

	@Before
	public void setUp() {
		service = new DocsRagService();
		service.initialize();
	}

	@Test
	public void retrievesMemberDocumentForPasswordResetQuestion() {
		SearchResult result = service.search("비밀번호 재설정 이메일은 어떻게 보내나요?");

		assertFalse(result.getContext().isEmpty());
		assertTrue(hasSource(result, "member"));
	}

	@Test
	public void retrievesRouteDocumentForExactAdminUrl() {
		SearchResult result = service.search("/admin/members/download/excel URL 기능");

		assertFalse(result.getContext().isEmpty());
		assertTrue(hasSource(result, "route-catalog") || hasSource(result, "admin"));
	}

	@Test
	public void returnsNoContextForOutOfScopeQuestion() {
		SearchResult result = service.search("양자역학 파동함수의 고유상태를 계산해줘");

		assertEquals("", result.getContext());
		assertTrue(result.getSources().isEmpty());
	}

	private boolean hasSource(SearchResult result, String key) {
		for (Source source : result.getSources()) {
			if (key.equals(source.getKey())) {
				return true;
			}
		}
		return false;
	}
}
