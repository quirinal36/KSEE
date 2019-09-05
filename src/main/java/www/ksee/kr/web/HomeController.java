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
import www.ksee.kr.vo.Board;
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
		mv.setViewName("index");
		return mv;
	}
	@RequestMapping(value="/search")
	public ModelAndView getCompanyView(Locale locale, ModelAndView mv,
			Board board) {
		logger.info(locale.toString());
		
		mv.addObject("title", "검색");
		mv.addObject("paging", board);
		mv.setViewName("/group/home");
		return mv;
	}
	@RequestMapping(value = "/company", method = RequestMethod.GET)
	public ModelAndView getCompanyView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("company");
		return mv;
	}
	@RequestMapping(value = "/information", method = RequestMethod.GET)
	public ModelAndView getInformationView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("information");
		return mv;
	}
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public ModelAndView getNoticeView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("notice");
		return mv;
	}
	@RequestMapping(value = "/picture", method = RequestMethod.GET)
	public ModelAndView getPictureView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("picture");
		return mv;
	}
	
	@RequestMapping(value="/links")
	public ModelAndView getLinksView(ModelAndView mv) {
		mv.setViewName("/links");
		return mv;
	}
	@RequestMapping(value="/error_400")
	public ModelAndView getError404View(ModelAndView mv) {
		mv.setViewName("/error/404");
		return mv;
	}
	@RequestMapping(value="/error_500")
	public ModelAndView getError503View(ModelAndView mv) {
		mv.setViewName("/error/503");
		return mv;
	}
	@RequestMapping(value="/inc/head_admin")
	public ModelAndView getAdminHeadView(ModelAndView mv) {
		mv.setViewName("/inc/head_admin");
		return mv;
	}
}
