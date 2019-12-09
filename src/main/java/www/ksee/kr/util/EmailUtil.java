package www.ksee.kr.util;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Iterator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.sendgrid.SendGrid;
import com.sendgrid.SendGridException;
import com.sun.xml.internal.messaging.saaj.packaging.mime.internet.MimeUtility;

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
	
	public int sendGridMultiEmail(MemberMail mailVO) throws FileNotFoundException, IOException, SendGridException {
		SendGrid sendGrid = new SendGrid(this.apiKey);
		SendGrid.Email email = new SendGrid.Email();
		email.addTo(mailVO.getReceivers());
		email.setFrom(mailVO.getSender());
		email.setFromName("한국효소공학");
		email.setSubject(mailVO.getTitle());
		email.setHtml(mailVO.getContent());
		
		FileUtil fileUtil = new FileUtil();
		final String uploadPath = fileUtil.makeUserPath();
		Iterator<FileInfo> iter = mailVO.getFiles().iterator();
		while(iter.hasNext()) {
			FileInfo fileInfo = iter.next();
			File attach = new File(uploadPath +File.separator + fileInfo.getNewFilename());
			email.addAttachment(MimeUtility.encodeText(fileInfo.getName()), attach);
		}
		
		SendGrid.Response response = sendGrid.send(email);
		
		if (response.getCode() != 200) {
			System.out.print(String.format("An error occured: %s", response.getMessage()));
			return 0;
		}else {
			logger.info(response.getMessage());
			
			return response.getCode();
		}
	}
}
