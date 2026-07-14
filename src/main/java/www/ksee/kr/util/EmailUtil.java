package www.ksee.kr.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import com.sendgrid.SendGrid;
import com.sendgrid.SendGridException;
import javax.mail.internet.MimeUtility;

import www.ksee.kr.vo.EmailVO;
import www.ksee.kr.vo.FileInfo;
import www.ksee.kr.vo.MemberMail;

public class EmailUtil {
	Logger logger = LoggerFactory.getLogger(getClass());
	
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
	
	public String sendGridMultiEmail(MemberMail mailVO) throws FileNotFoundException, IOException, SendGridException {
		JSONObject json = new JSONObject();
		
		SendGrid.Email sendEmail = new SendGrid.Email();
		sendEmail.addBcc(mailVO.getReceivers());
		sendEmail.setFrom(mailVO.getSender());
		sendEmail.setFromName("한국효소공학");
		sendEmail.setSubject(mailVO.getTitle());
		sendEmail.setHtml(mailVO.getContent());
		sendEmail.addTo(mailVO.getReceiver());
		
		if(mailVO.getFiles() != null && mailVO.getFiles().size() > 0) {
			FileUtil fileUtil = new FileUtil();
			final String uploadPath = fileUtil.makeUserPath();
			Iterator<FileInfo> iter = mailVO.getFiles().iterator();
			while(iter.hasNext()) {
				FileInfo fileInfo = iter.next();
				File attach = new File(uploadPath +File.separator + fileInfo.getNewFilename());
				sendEmail.addAttachment(MimeUtility.encodeText(fileInfo.getName()), attach);
			}
		}
		SendGrid sendGrid = new SendGrid(this.apiKey);
		SendGrid.Response response = sendGrid.send(sendEmail);
		
		logger.info("mail sent result: " + response.getMessage());
		json.put("code", response.getCode());
		
		if (response.getCode() != 200) {
			System.out.print(String.format("An error occured: %s", response.getMessage()));
		}else {
			logger.info("code : " + response.getCode());
			logger.info("message : " + response.getMessage());
			json.put("message", response.getMessage());
		}
		
		return json.toString();
	}
	
	public void res() throws UnirestException {
		HttpResponse<String> response = Unirest.get("https://api.sendgrid.com/v3/messages?limit=10&query=a")
				  .header("authorization", this.apiKey)
				  .asString();
	}
}
