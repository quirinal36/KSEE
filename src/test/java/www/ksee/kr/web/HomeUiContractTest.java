package www.ksee.kr.web;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;
import static org.junit.Assert.assertTrue;

import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Paths;

import org.junit.Test;

public class HomeUiContractTest {

	@Test
	public void homeCardsUseExplicitGridAreas() throws Exception {
		String jsp = read("src/main/webapp/WEB-INF/views/index.jsp");
		String css = read("src/main/webapp/resources/css/index.css");

		assertTrue(jsp.contains("class=\"idx_card_grid\""));
		assertEquals(4, occurrences(jsp, " idx_card "));
		assertTrue(jsp.contains("idx_card_popup"));
		assertTrue(jsp.contains("idx_card_notice"));
		assertTrue(jsp.contains("idx_card_news"));
		assertTrue(jsp.contains("idx_card_free"));
		assertTrue(css.contains("\"popup notice\""));
		assertTrue(css.contains("\"news free\""));
		assertFalse(css.contains(".idx_cont > div > div:nth-child"));
	}

	@Test
	public void chatbotUsesIsolatedFixedPortal() throws Exception {
		String javascript = read("src/main/webapp/resources/js/docs-chatbot.js");
		String portalCss = read("src/main/webapp/resources/css/docs-chatbot-portal.css");

		assertTrue(javascript.contains("root.appendChild(panel)"));
		assertTrue(javascript.contains("root.appendChild(toggle)"));
		assertTrue(javascript.contains("document.body.appendChild(root)"));
		assertFalse(javascript.contains("document.body.appendChild(panel)"));
		assertFalse(javascript.contains("document.body.appendChild(toggle)"));
		assertTrue(portalCss.contains("position: fixed"));
		assertTrue(portalCss.contains("contain: layout paint"));
		assertTrue(portalCss.contains("pointer-events: none"));
	}

	@Test
	public void chatbotRendersInternalAnswerLinksAsActionsWithoutSources() throws Exception {
		String javascript = read("src/main/webapp/resources/js/docs-chatbot.js");

		assertTrue(javascript.contains("function extractAnswerActions"));
		assertTrue(javascript.contains("function appendActions"));
		assertTrue(javascript.contains("\\[([^\\]\\r\\n]+)\\]\\((\\/[^\\s)]+)\\)"));
		assertTrue(javascript.contains("button.href = contextPath + action.path"));
		assertFalse(javascript.contains("source.title || '기능 문서'"));
	}

	@Test
	public void symposiumGuideUsesApplicantLanguageAndLinks() throws Exception {
		String guide = read("docs/04-symposium-application.md");

		assertTrue(guide.contains("## 4.2 참가신청 안내"));
		assertTrue(guide.contains("[국내 학술대회](/symposium/domestic)"));
		assertTrue(guide.contains("[참가신청 조회](/symposium/apply/search)"));
		assertFalse(guide.contains("JSON 결과 반환"));
	}

	private String read(String path) throws Exception {
		byte[] bytes = Files.readAllBytes(Paths.get(path));
		return new String(bytes, StandardCharsets.UTF_8);
	}

	private int occurrences(String text, String value) {
		int count = 0;
		int position = 0;
		while ((position = text.indexOf(value, position)) >= 0) {
			count++;
			position += value.length();
		}
		return count;
	}
}
