package www.ksee.kr.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Symposium extends Paging{
	public final static int SYMP_TYPE_DOMESTIC = 1;
	public final static int SYMP_TYPE_INTERNATIONAL = 2;
	public final static int SYMP_TYPE_ALL = 3;
	public final static String DOMESTIC_TITLE = "국내 학술대회";
	public final static String INTERNATIONAL_TITLE = "한중일 학술대회";
	
	int id;
	String title;
	String place;
	String title_en;
	String place_en;
	String startDate;
	String finishDate;
	String applyStart;
	String applyFinish;
	int viewCnt;
	int sympType;
}
