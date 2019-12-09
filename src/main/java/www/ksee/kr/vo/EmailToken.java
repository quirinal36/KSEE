package www.ksee.kr.vo;

import java.io.File;
import java.io.IOException;
import java.time.Duration;
import java.time.LocalDate;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.io.FileUtils;
import org.springframework.util.ResourceUtils;

import com.sendgrid.SendGridException;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import www.ksee.kr.Config;
import www.ksee.kr.util.EmailUtil;

@Getter
@Setter
@ToString
public class EmailToken extends PasswordResetToken {
	public static final int IS_EMAIL = 0;
	public static final int IS_PWD = 1;
	
	int user_id;
	int used;
	int isPwd;
	
	public EmailToken() {
		
	}
	public static EmailToken newInstance(Integer userId) {
		EmailToken result = new EmailToken();
		result.setUser_id(userId);
		return result;
	}
	public static EmailToken newInstance(Integer userId, String token) {
		EmailToken result = new EmailToken();
		result.setUser_id(userId);
		result.setToken(token);
		return result;
	}
	public boolean isValidToken(String input) {
		boolean result = false;
		
		// 현재시간
		ZonedDateTime current = ZonedDateTime.now(ZoneId.systemDefault());
		
		LocalDate expiredDate = registDate.toLocalDate();//LocalDateTime.parse(getRegistDate(), DateTimeFormatter.ofPattern(this.DATE_FORMAT));
		expiredDate = expiredDate.plusDays(1);
		// 만료시간
		ZonedDateTime end = ZonedDateTime.of(expiredDate.getYear(), expiredDate.getMonthValue(), expiredDate.getDayOfMonth(), 0,0,0,0, ZoneId.systemDefault());
		
		// 만료 까지 남은시간
		Duration timeElapsed = Duration.between(current, end);
		
		if(timeElapsed.toMillis() > 0 && used == 0 && input.equals(this.token)) {
			result = true;
		}
		return result;
	}
	public void sendEmail(String appUrl, final String subject,
			UserVO user,
			EmailToken usertoken, Locale locale)
			throws IOException, SendGridException {
		final String senderEmail = Config.NO_REPLY_EMAIL;
		EmailVO emailVO = new EmailVO(assembleEmail(user), senderEmail);
		
		final String template = new StringBuilder()
				.append("classpath:txt/email_newpassword_")
				.append(locale.getLanguage())
				.append(".html").toString();
		File fileMsg = ResourceUtils.getFile(template);
		String data = FileUtils.readFileToString(fileMsg, Config.ENCODING);

		// 패턴에 맞는 ${ } 기호가 나오는지 판별한다.
		final String regex = "[\\$][\\{]\\w+[\\}]";
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(data);
		if (matcher.find()) {
			// 사용자이름
			data = data.replace(matcher.group(0), user.getUsername());
		}
		if (matcher.find()) {
			// 이메일인증 링크
			String returnUrl = new StringBuilder()
					.append(appUrl)
					.append("/member/validate/token")
					.append("?token=").append(usertoken.getToken())
					.append("&userId=").append(user.getId())
					.append("&lang=").append(locale)
					.toString();

			data = data.replace(matcher.group(0), returnUrl);
		}

		emailVO.setSubject(subject);
		emailVO.setMessage(data);

		File file = ResourceUtils.getFile("classpath:sendgrid.env");
		String apiKey = FileUtils.readFileToString(file, Config.ENCODING);
		
		EmailUtil emailUtil = new EmailUtil(apiKey);
		emailUtil.sendGridEmailHtml(emailVO);
	}
	private String assembleEmail(UserVO user) {
		return new StringBuilder().append(user.getEmail()).append("@").append(user.getDomain()).toString();
	}
}
