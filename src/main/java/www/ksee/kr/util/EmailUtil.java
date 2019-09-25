package www.ksee.kr.util;

import com.sendgrid.SendGrid;
import com.sendgrid.SendGridException;

import www.ksee.kr.vo.EmailVO;

public class EmailUtil {
	final private String apiKey;

	public EmailUtil(String apiKey) {
		super();
		this.apiKey = apiKey;
	}

	public void sendGridEmailHtml(EmailVO info) throws SendGridException {
		SendGrid sendgrid = new SendGrid(this.apiKey);
		SendGrid.Email email = new SendGrid.Email();
		email.addTo(info.getToEmail());
		email.setFrom(info.getSenderEmail());
		email.setSubject(info.getSubject());
		email.setHtml(info.getMessage());

		SendGrid.Response response = sendgrid.send(email);
		if (response.getCode() != 200) {
			System.out.print(String.format("An error occured: %s", response.getMessage()));
			return;
		}
	}
	public void sendGridEmail(EmailVO info) throws SendGridException {
		SendGrid sendgrid = new SendGrid(this.apiKey);
		SendGrid.Email email = new SendGrid.Email();
		email.addTo(info.getToEmail());
		email.setFrom(info.getSenderEmail());
		email.setSubject(info.getSubject());
		email.setText(info.getMessage());

		SendGrid.Response response = sendgrid.send(email);
		if (response.getCode() != 200) {
			System.out.print(String.format("An error occured: %s", response.getMessage()));
			return;
		}
	}
}
