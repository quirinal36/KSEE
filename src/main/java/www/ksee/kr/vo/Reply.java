package www.ksee.kr.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Reply extends Paging{
	int id;
	int writer;
	String writerName;
	int parent;
	int boardId;
	Date mdate;
	Date udate;
}
