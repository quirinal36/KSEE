package www.ksee.kr.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class EmailVO {
	final String toEmail;
	final String senderEmail;
	String subject;
	String message;
	
	public EmailVO(String toEmail, String senderEmail) {
		super();
		this.toEmail = toEmail;
		this.senderEmail = senderEmail;
	}
}
