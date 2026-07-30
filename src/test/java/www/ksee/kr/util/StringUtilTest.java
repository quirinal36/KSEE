package www.ksee.kr.util;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertFalse;

import org.junit.Test;

public class StringUtilTest {

	@Test
	public void removeTagConvertsRichHtmlToPlainText() throws Exception {
		String html = "<p data-start=\"1\">안녕하세요.<span aria-hidden=\"true\"> 기능 문서</span></p>";

		String text = StringUtil.removeTag(html);

		assertEquals("안녕하세요. 기능 문서", text);
		assertFalse(text.contains("<"));
		assertFalse(text.contains(">"));
	}

	@Test
	public void removeTagDropsScriptContentAndHandlesNull() throws Exception {
		assertEquals("안전한 내용", StringUtil.removeTag("<script>alert('xss')</script><p>안전한 내용</p>"));
		assertEquals("", StringUtil.removeTag(null));
	}
}
