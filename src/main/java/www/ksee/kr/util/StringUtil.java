package www.ksee.kr.util;

public class StringUtil {

	/**
	 * 모든 HTML 태그를 제거하고 반환한다.
	 * 
	 * @param html
	 * @throws Exception  
	 */
	public static String removeTag(String html) throws Exception {
		return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
	}
}
