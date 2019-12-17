package www.ksee.kr.web;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.logging.Logger;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.http.Header;
import org.apache.http.client.HttpClient;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicHeader;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import com.sendgrid.SendGridException;

import www.ksee.kr.Config;
import www.ksee.kr.service.FileInfoService;
import www.ksee.kr.service.UserService;
import www.ksee.kr.util.EmailUtil;
import www.ksee.kr.util.ExcelMaker;
import www.ksee.kr.util.FileUtil;
import www.ksee.kr.vo.FileInfo;
import www.ksee.kr.vo.MemberMail;
import www.ksee.kr.vo.UserRole;
import www.ksee.kr.vo.UserVO;

@RequestMapping("/admin/members")
@Controller
public class AdminMembersController {
	@Autowired
	UserService userService;
	
	@Autowired
	FileInfoService fileService;
	
	final Logger logger = Logger.getLogger(this.getClass().getSimpleName());
	/**
	 * 회원관리 
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/", method = RequestMethod.GET)
	public ModelAndView getAdminMembers(ModelAndView mv, UserVO user) {
		if(user.getPageNo() == 0) {
			user.setPageNo(1);
		}
		int totalCount = userService.count(user);
		user.setPageSize(10);
		user.setTotalCount(totalCount);
		
		List<UserVO> members = userService.search(user);
		
		mv.addObject("members", members);
		mv.addObject("paging", user);
		
		mv.addObject("title", "회원관리");
		mv.addObject("menu", 0);
		mv.setViewName("/admin/members");
		return mv;
	}
	@RequestMapping(value="/view/{id}")
	public ModelAndView getAdminMemberView(ModelAndView mv, 
			@PathVariable(value="id", required=true)Integer id) {
		UserVO user = UserVO.newInstanse(id);
		user = userService.selectOne(user);
		
		List<UserRole> userRoles = userService.selectRoles();
		
		mv.addObject("userRoles", userRoles);
		mv.addObject("user", user);
		mv.addObject("title", "회원관리");
		mv.addObject("menu", 0);
		mv.setViewName("/admin/memberView");
		return mv;
	}
	
	/**
	 * 
	 * @param user
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/edit", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String editUserInfo(UserVO user) {
		JSONObject json = new JSONObject();
		int result = userService.update(user);
		json.put("result", result);
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/download/excel", method = RequestMethod.GET, produces = "ms-vnd/excel; charset=utf8")
	public void excelDown(HttpServletResponse response) throws IOException{
		List<UserVO> userList = userService.select();
		final String [] header = {"번호", "회원구분", "이름", "소속", "직위", "이메일", "가입일"};
		
		final String fileName = "회원리스트";
		
		ExcelMaker eMaker = new ExcelMaker();
		eMaker.makeSheet(fileName);
		eMaker.makeHead(header);
		eMaker.makeUserBody(userList, header);
		
		// 컨텐츠 타입과 파일명
//		final String zipFileName = new String(fileName.getBytes("UTF-8"), "ISO-8859-1");
		final String zipFileName = URLEncoder.encode(fileName, Config.ENCODING);
		response.setHeader("Content-Disposition", "attachment; filename=\""+ zipFileName + ".xls\"");
		// 엑셀 출력
		eMaker.getWb().write(response.getOutputStream());
		eMaker.getWb().close();
	}
	
	@RequestMapping(value="/mail/write")
	public ModelAndView getMailWriteView(ModelAndView mv,
			@RequestParam(value="ids", required=false)Optional<Integer[]> ids) {
		List<UserVO> list = new ArrayList<UserVO>();
		
		if(ids.isPresent()) {
			List<UserVO> users = new ArrayList<UserVO>();
			for(int id : ids.get()) {
				UserVO user = UserVO.newInstanse(id);
				users.add(user);
			}
			
			list = userService.selectByIds(users);
		}else {
			list = userService.select();
		}
		
		mv.addObject("sender", Config.ADMIN_EMAIL);
		mv.addObject("list", list);
		mv.addObject("title", "메일 작성");
		mv.addObject("menu", 0);
		mv.setViewName("/admin/members/writeMail");
		return mv;
	}
	@ResponseBody
	@RequestMapping(value="/mail/write", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String postMailWrite(@RequestParam(value="userId", required=true)Integer[] ids,
			@RequestParam(value="sender", required=true)String sender,
			@RequestParam(value="title", required=false)Optional<String> title,
			@RequestParam(value="content", required=false)Optional<String> content,
			@RequestParam(value="fileIds", required=false)Optional<String> fileIds) throws IOException {
		JSONObject json = new JSONObject();
		
		MemberMail mailVO = new MemberMail();
		
		List<UserVO> users = new ArrayList<UserVO>();
		List<UserVO> list = new ArrayList<UserVO>();
		for(int id : ids) {
			UserVO user = UserVO.newInstanse(id);
			users.add(user);
		}
		list = userService.selectByIds(users);
		String[] receivers = new String[list.size()];
		for(int i=0; i<list.size(); i++) {
			UserVO user = list.get(i);
			receivers[i] = new StringBuilder().append(user.getEmail()).append("@").append(user.getDomain()).toString(); 
		}
		mailVO.setReceivers(receivers);
		
		if(title.isPresent()) {
			mailVO.setTitle(title.get());
		}else {
			mailVO.setTitle("제목이 없습니다.");
		}
		
		if(content.isPresent()) {
			mailVO.setContent(content.get());
		}else {
			mailVO.setContent("");
		}
		
		if(fileIds.isPresent()) {
			String [] files = fileIds.get().split(",");
			if(files.length > 0) {
				List<FileInfo> inputs = new ArrayList<FileInfo>();
				for(String fileId : files) {
					FileInfo fileInfo = new FileInfo();
					try {
						fileInfo.setId(Integer.parseInt(fileId));
						inputs.add(fileInfo);
					}catch(NumberFormatException e) {
						e.printStackTrace();
					}
				}
				if(inputs.size() > 0) {
					List<FileInfo> fileList = fileService.selectById(inputs);
					
					mailVO.setFiles(fileList);
				}
			}
		}
		
		mailVO.setSender(sender);
		
		File file = ResourceUtils.getFile("classpath:sendgrid.env");
		String apiKey = FileUtils.readFileToString(file, Config.ENCODING);
		
		EmailUtil emailUtil = new EmailUtil(apiKey);
		try {
			json.put("result", emailUtil.sendGridMultiEmail(mailVO));
		} catch (SendGridException e) {
			e.printStackTrace();
			json.put("result", 0);
		}
		
		return json.toString();
	}
	@RequestMapping(value="/mail/sent/list")
	public ModelAndView getSentList(ModelAndView mv) {
		/*
		try {
			JSONArray sentList = getSentList();
		} catch (IOException e) {
			e.printStackTrace();
		}
		*/
		mv.addObject("title", "보낸메일함");
		mv.addObject("menu", 0);
		mv.setViewName("/admin/members/sentList");
		return mv;
	}
	/*
	public JSONArray getSentList() throws IOException {
		File file = ResourceUtils.getFile("classpath:sendgrid.env");
		String apiKey = FileUtils.readFileToString(file, Config.ENCODING);
		
		StringBuilder url = new StringBuilder()
				.append("https://api.sendgrid.com/v3/geo/stats");
		
		Header jsonHeader = new BasicHeader(HttpHeaders.CONTENT_TYPE, "application/json");
		Header authHeader = new BasicHeader(HttpHeaders.AUTHORIZATION, apiKey);
		List<Header> headers = new ArrayList<>();
		headers.add(jsonHeader);
		headers.add(authHeader);
		
		HttpClient httpClient = HttpClientBuilder.create()					
				.setMaxConnTotal(100) // connection pool 적용
				.setMaxConnPerRoute(5) // connection pool 적용
				.setDefaultHeaders(headers)
				.build();

		HttpComponentsClientHttpRequestFactory factory = new HttpComponentsClientHttpRequestFactory(); 
		factory.setReadTimeout(5000); // 읽기시간초과, ms 
		factory.setConnectTimeout(3000); // 연결시간초과, ms 
		factory.setHttpClient(httpClient); // 동기실행에 사용될 HttpClient 세팅

		LocalDate startDate = LocalDate.of(2019, 12, 1);
		LocalDate endDate = LocalDate.now();
		
		logger.info(startDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		
		MultiValueMap<String, String> map = new LinkedMultiValueMap<String, String>();
		map.add("start_date", startDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		map.add("end_date", endDate.format(DateTimeFormatter.ofPattern("yyyy-MM-dd")));
		
		RestTemplate restTemplate = new RestTemplate(factory);
		String response = restTemplate.postForObject(url.toString(), map, String.class);
		
		JSONArray result = new JSONArray(response);
		return result;
	}
	*/
	@RequestMapping(value="/mail/sent/detail/{id}")
	public ModelAndView getSentDetail(ModelAndView mv,
			@PathVariable(value="id", required = true)Integer id) {
		mv.addObject("title", "보낸메일");
		mv.addObject("menu", 0);
		mv.setViewName("/admin/members/sentDetail");
		return mv;
	}
}
