package www.ksee.kr.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpEntity;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

/**
 * Google reCAPTCHA 검증 서비스
 * 
 * @author KSEE
 */
@Service
public class RecaptchaService {
    
    private static final Logger logger = LoggerFactory.getLogger(RecaptchaService.class);
    
    @Value("${recaptcha.secret.key}")
    private String secretKey;
    
    @Value("${recaptcha.site.key}")
    private String siteKey;
    
    @Value("${recaptcha.verify.url}")
    private String verifyUrl;
    
    /**
     * reCAPTCHA 응답을 Google API로 검증
     * 
     * @param recaptchaResponse 클라이언트에서 받은 reCAPTCHA 응답
     * @param clientIp 클라이언트 IP 주소
     * @return 검증 성공 여부
     */
    public boolean verifyRecaptcha(String recaptchaResponse, String clientIp) {
        if (recaptchaResponse == null || recaptchaResponse.trim().isEmpty()) {
            logger.warn("reCAPTCHA response is empty");
            return false;
        }
        
        try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
            HttpPost httpPost = new HttpPost(verifyUrl);
            
            // POST 파라미터 설정
            List<NameValuePair> params = new ArrayList<>();
            params.add(new BasicNameValuePair("secret", secretKey));
            params.add(new BasicNameValuePair("response", recaptchaResponse));
            params.add(new BasicNameValuePair("remoteip", clientIp));
            
            httpPost.setEntity(new UrlEncodedFormEntity(params));
            
            try (CloseableHttpResponse response = httpClient.execute(httpPost)) {
                HttpEntity entity = response.getEntity();
                String responseString = EntityUtils.toString(entity);
                
                logger.debug("reCAPTCHA verification response: {}", responseString);
                
                // JSON 응답 파싱
                JSONObject jsonResponse = new JSONObject(responseString);
                boolean success = jsonResponse.getBoolean("success");
                
                if (!success && jsonResponse.has("error-codes")) {
                    logger.warn("reCAPTCHA verification failed: {}", jsonResponse.getJSONArray("error-codes"));
                }
                
                return success;
            }
            
        } catch (IOException e) {
            logger.error("Error verifying reCAPTCHA", e);
            return false;
        } catch (Exception e) {
            logger.error("Unexpected error during reCAPTCHA verification", e);
            return false;
        }
    }
    
    /**
     * reCAPTCHA 사이트 키 반환
     * 
     * @return reCAPTCHA 사이트 키
     */
    public String getSiteKey() {
        return siteKey;
    }
    
    /**
     * 클라이언트 IP 주소 추출
     * 
     * @param request HTTP 요청
     * @return 클라이언트 IP 주소
     */
    public String getClientIp(javax.servlet.http.HttpServletRequest request) {
        String xForwardedFor = request.getHeader("X-Forwarded-For");
        if (xForwardedFor != null && !xForwardedFor.isEmpty()) {
            return xForwardedFor.split(",")[0].trim();
        }
        
        String xRealIp = request.getHeader("X-Real-IP");
        if (xRealIp != null && !xRealIp.isEmpty()) {
            return xRealIp;
        }
        
        return request.getRemoteAddr();
    }
}
