package www.ksee.kr.vo;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ApplyVO extends Paging{
	int id;
	int sympId;
	int memberType;
	int isSpeaker;
	int national;
	String username;
	String classification;
	String level;
	String telephone;
	String email;
	String domain;
	int fileId;
	Date mdate;
}
