package www.ksee.kr.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class EmailResult extends Paging {
	int id;
	String receiver;
	int response;
	String title;
	Date wdate;
}
