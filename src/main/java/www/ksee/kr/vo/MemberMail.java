package www.ksee.kr.vo;

import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberMail {
	String sender;
	String title;
	String content;
	List<FileInfo> files;
	String[] receivers;
}
