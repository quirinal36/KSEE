package www.ksee.kr.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Symposium extends Paging{
	int id;
	String title;
	String place;
	String startDate;
	String finishDate;
	String applyStart;
	String applyFinish;
	int viewCnt;
}
