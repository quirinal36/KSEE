package www.ksee.kr.vo;

import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Popup {
	int id;
	String popupTitle;
	String startDate;
	String finishDate;
	int fileId;
	int enFileId;
	Date wdate;
	Date mdate;
	String today;
	String lang;
	String url; // 이미지 URL
	String link; // 팝업 링크
	int porder;
	
	public static Popup newInstance(int id) {
		Popup popup = new Popup();
		popup.setId(id);
		return popup;
	}
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}
