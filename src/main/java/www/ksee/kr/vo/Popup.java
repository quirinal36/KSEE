package www.ksee.kr.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Popup {
	int id;
	String symposiumTitle;
	String startDate;
	String finishDate;
	int fileId;
	Date wdate;
	Date mdate;
}
