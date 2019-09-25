package www.ksee.kr.vo;

import java.sql.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PasswordResetToken {
	protected final Logger logger = LoggerFactory.getLogger(getClass());
	
	private final String DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
	
	public static final int EXPIRATION = 60 * 24;
	
	Integer id;
	int userId;
	String token;
	Date registDate;
	String username;
	
	public PasswordResetToken() {
		
	}
	public PasswordResetToken(Integer userId) {
		this.userId = userId;
	}
	public PasswordResetToken(Integer userId, String token) {
		this.userId = userId;
		this.token = token;
	}

}
