package www.ksee.kr.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

/**
 * DB 로 관리하는 정적 페이지 콘텐츠 한 건.
 * content_key 로 페이지(또는 섹션)를 식별한다. (예: "about.greet", "about.history")
 *
 * <p>필드명을 snake_case 로 두어 컬럼명과 직접 매핑되게 한다(프로젝트 관례).
 */
@Getter
@Setter
public class PageContent {
	private int id;
	private String content_key;
	private String title;
	private String content;     // 한국어 HTML
	private String content_en;  // 영문 HTML (선택)
	private Date udate;
}
