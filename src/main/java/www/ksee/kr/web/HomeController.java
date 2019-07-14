package www.ksee.kr.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.StringReader;
import java.net.URI;
import java.net.URISyntaxException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpression;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

import org.apache.commons.io.FileUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;
import org.springframework.web.util.UriUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import www.ksee.kr.Config;
import www.ksee.kr.security.config.UserDetailService;
import www.ksee.kr.service.UserService;
import www.ksee.kr.vo.UserVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Autowired
	private UserService userService;
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		mv.addObject("serverTime", formattedDate);
		
		mv.setViewName("home");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/getdata")
	public String getData(@RequestParam(value="service_id")Optional<String> serviceId,
			@RequestParam(value="operation_id")Optional<String> operationId,
			@RequestParam(value="authKey")Optional<String> auth_key,
			@RequestParam(value="system_id")Optional<String> system_id) {
		JSONObject json = new JSONObject();
		json.put("service_id", serviceId.get());
		json.put("operationId", operationId.get());
		json.put("authKey", auth_key.get());
		json.put("system_id", system_id.get());
		
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/load/data", method=RequestMethod.GET)
	public String loadData(@RequestParam(value="service_id")Optional<String> serviceId,
			@RequestParam(value="operation_id")Optional<String> operationId) {
		String response = new String();
		try {
			File file = ResourceUtils.getFile("classpath:connect.properties");
			String data = FileUtils.readFileToString(file, Config.ENCODING);
			JSONObject connectInfo = new JSONObject(data);
			
//			StringBuilder uriBuilder = new StringBuilder()
//					.append(connectInfo.getString("connect.url"))
//					.append("?system_id=").append(connectInfo.getString("connect.system_id"))
//					.append("&authKey=").append(connectInfo.getString("connect.auth_key"))
//					.append("&service_id=").append(connectInfo.getString("connect.service_id"))
//					.append("&operation_id=").append(connectInfo.getString("connect.operation_id"));
//			URI uri = new URI(uriBuilder.toString());
//			
//			response = restTemplate.getForObject(uri, String.class);
//			logger.info(response);
			
			
			MultiValueMap<String, String> params = new LinkedMultiValueMap<>();
			params.add("system_id", connectInfo.getString("connect.system_id"));
			params.add("authKey", connectInfo.getString("connect.auth_key"));
			params.add("service_id", connectInfo.getString("connect.service_id"));
			params.add("operation_id", connectInfo.getString("connect.operation_id"));
			UriComponents uriComp = UriComponentsBuilder.fromHttpUrl(connectInfo.getString("connect.url")).queryParams(params).build();
			
			RestTemplate restTemplate = new RestTemplate(new HttpComponentsClientHttpRequestFactory());
			response = restTemplate.getForObject(uriComp.toUri(), String.class);
			logger.info(response);
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return response;
	}
	
	@ResponseBody
	@RequestMapping(value="/data/save", method=RequestMethod.GET)
	public String dataSave() {
		logger.info("data save");
		List<UserVO> list = new ArrayList<>();
		
		try {
			File file = ResourceUtils.getFile("classpath:data.xml");
			String data = FileUtils.readFileToString(file, Config.ENCODING);
			
			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			factory.setNamespaceAware(true);
			DocumentBuilder builder;
			Document doc = null;

			builder = factory.newDocumentBuilder();
            doc = builder.parse(new InputSource(new StringReader(data)));
            XPathFactory xpathFactory = XPathFactory.newInstance();
            XPath xpath = xpathFactory.newXPath();
            XPathExpression expr = xpath.compile("//fields/field");
            NodeList nodeList = (NodeList) expr.evaluate(doc, XPathConstants.NODESET);
            logger.info("logger length : "+nodeList.getLength());
            for(int i=0; i<nodeList.getLength(); i++) {
            	logger.info("____________________________");
            	NodeList child = nodeList.item(i).getChildNodes();
            	Map<String, String> map = new HashMap<>();
            	for(int j=0; j<child.getLength(); j++) {
            		
            		Node node = child.item(j);
            		if(node.getNodeType() == Node.ELEMENT_NODE) {
	            		map.put(node.getNodeName(), node.getTextContent());
            		}
            	}
            	UserVO user = UserVO.parse(map);
            	logger.info(user.toString());
            	list.add(user);
            }
		}catch(FileNotFoundException e) {
			logger.info(e.getLocalizedMessage());
		} catch (IOException e) {
			logger.info(e.getLocalizedMessage());
		} catch (ParserConfigurationException e) {
			logger.info(e.getLocalizedMessage());
		} catch (SAXException e) {
			logger.info(e.getLocalizedMessage());
		} catch (XPathExpressionException e) {
			logger.info(e.getLocalizedMessage());
		}
		
		JSONObject json = new JSONObject();
		JSONArray array = new JSONArray();
		Iterator<UserVO> iter = list.iterator();
		while(iter.hasNext()) {
			array.put(new JSONObject(iter.next().toString()));
		}
		json.put("list", list);
		json.put("result", userService.insert(list));
		
		return json.toString();
	}
}
