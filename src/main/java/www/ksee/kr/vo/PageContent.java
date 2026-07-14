package www.ksee.kr.vo;

import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import lombok.Getter;
import lombok.Setter;

/**
 * 관리자 페이지에서 편집하는 소개 페이지(인사말/임원진/정관/연혁)의 내용.
 * pageKey 별 1건씩 저장된다.
 */
@Getter
@Setter
public class PageContent {
	String pageKey;     // greet, member, term, history
	String viewType;    // HTML(에디터) | FILE(이미지/PDF 업로드)
	String content;     // viewType=HTML 일 때 에디터 HTML
	Integer fileId;     // viewType=FILE 일 때 업로드 파일 id
	String fileType;    // IMAGE | PDF
	String updatedBy;
	Date updatedAt;

	public static PageContent newInstance(String pageKey) {
		PageContent pc = new PageContent();
		pc.setPageKey(pageKey);
		return pc;
	}

	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}
