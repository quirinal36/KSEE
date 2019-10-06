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
	int id;
	String title;
	String place;
	String startDate;
	String finishDate;
	String applyStart;
	String applyFinish;
	int viewCnt;
	int sympType;
}
