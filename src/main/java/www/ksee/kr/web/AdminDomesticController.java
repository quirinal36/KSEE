package www.ksee.kr.web;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.SymposiumDetailService;
import www.ksee.kr.service.SymposiumService;
import www.ksee.kr.util.FileUtil;
import www.ksee.kr.util.SymposiumUtil;
import www.ksee.kr.vo.ApplyVO;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.Symposium;
import www.ksee.kr.vo.SymposiumDetail;
import www.ksee.kr.vo.SymposiumTypes;

@RequestMapping("/admin")
@Controller
public class AdminDomesticController extends KseeController{
	@Autowired
	SymposiumService sympService;
	@Autowired
	SymposiumDetailService sympDetailService;
	
	@ResponseBody
	@RequestMapping(value="/symposium/delete/{id}", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String deleteSymposium(@PathVariable(value="id", required = true)Integer id) {
		JSONObject json = new JSONObject();
		Symposium symposium = new Symposium();
		symposium.setId(id);
		int result = sympService.delete(symposium);
		json.put("result", result);
		return json.toString();
	}
	/**
	 * 국내 학술대회
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/{where}/")
	public ModelAndView getAdminDomestic(ModelAndView mv, Symposium symp,
			@PathVariable(value="where", required = true)String where) {
		
		if(where.equalsIgnoreCase("domestic")) {
			symp.setSympType(Symposium.SYMP_TYPE_DOMESTIC);
			mv.addObject("title", Symposium.DOMESTIC_TITLE);
		}else if(where.equalsIgnoreCase("international")){
			symp.setSympType(Symposium.SYMP_TYPE_INTERNATIONAL);
			mv.addObject("title", Symposium.INTERNATIONAL_TITLE);
		}
		
		mv.addObject("menu", 1);
		SymposiumUtil util = new SymposiumUtil();
		mv.addObject("paging", symp);
		mv.addObject("where", where);
		mv.addObject("list", util.search(sympService, symp));
		mv.setViewName("/admin/domestic");
		return mv;
	}
	
	/**
	 * 글작성 페이지
	 * 글수정 페이지(id 가 있을 경우)
	 * @param mv
	 * @param request
	 * @param id
	 * @return
	 */
	@RequestMapping(value= {"/{where}/write","/{where}/write/{id}"}, method = RequestMethod.GET)
	public ModelAndView getWriteView(ModelAndView mv, HttpServletRequest request
			,@PathVariable(value="id", required = false)Optional<Integer> id,
			@PathVariable(value="where", required = true)String where) {
		if(id.isPresent()) {
			Symposium symposium = new Symposium();
			symposium.setId(id.get());
			symposium = sympService.selectOne(symposium);
			mv.addObject("symposium", symposium);
		}
		if(where.equalsIgnoreCase("domestic")) {
			mv.addObject("title", Symposium.DOMESTIC_TITLE);
		}else if(where.equalsIgnoreCase("international")){
			mv.addObject("title", Symposium.INTERNATIONAL_TITLE);
		}
		mv.addObject("where", where);
		mv.addObject("listUrl", request.getContextPath() + "/admin/"+where+"/");
		mv.setViewName("/admin/domestic/write");
		return mv;
	}
	/**
	 * 글작성하기
	 * @param symposium
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/{where}/write", method = RequestMethod.POST)
	public String writeSave(Symposium symposium,
			@PathVariable(value="where", required = true)String where) {
		if(where.equalsIgnoreCase("domestic")) {
			symposium.setSympType(Symposium.SYMP_TYPE_DOMESTIC);
		}else if(where.equalsIgnoreCase("international")){
			symposium.setSympType(Symposium.SYMP_TYPE_INTERNATIONAL);
		}
		
		JSONObject json = new JSONObject();
		
		SymposiumUtil util = new SymposiumUtil();
		util.insert(sympService, symposium);
		
		json.put("result", symposium.getId());
		return json.toString();
	}
	@ResponseBody
	@RequestMapping(value="/symposium/update/{id}", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String editSymposium(Symposium symposium) {
		SymposiumUtil util = new SymposiumUtil();
		int result = util.update(sympService, symposium);
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	@RequestMapping(value="/{where}/detail/{id}")
	public ModelAndView getDetailView(@PathVariable(value="id")Integer id,
			@PathVariable(value="where", required = true)String where,
			ModelAndView mv) {
		SymposiumDetail sympDetail = new SymposiumDetail();
		sympDetail.setSymposiumId(id);
		
		SymposiumUtil util = new SymposiumUtil();
		List<SymposiumTypes> sympTypes = util.getSymposiumDetailTypes(sympService);

		// 이번 회차 심포지움에 작성되어있는 상세내용들을 가져온뒤
		// map 에 저장을 한다. -> 수정을 할건지 새로 작성할건지 버튼을 정하기 위해
		List<SymposiumDetail> sympDetails = util.getSymposiumDetails(sympDetailService, sympDetail);
		
		if(where.equalsIgnoreCase("domestic")) {
			mv.addObject("title", Symposium.DOMESTIC_TITLE);
		}else if(where.equalsIgnoreCase("international")){
			mv.addObject("title", Symposium.INTERNATIONAL_TITLE);
		}
		
		mv.addObject("menu", 1);
		mv.addObject("types", sympTypes);
		mv.addObject("details", sympDetails);
		mv.addObject("where", where);
		mv.addObject("symposium", util.selectOne(sympService, id));
		mv.setViewName("/admin/domestic/detail");
		return mv;
	}
	
	/**
	 * 심포지움 세부항목 글작성하기 / 수정하기
	 * 
	 * @param type
	 * @param lang
	 * @param symposiumId
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/{where}/write/content/{type}/{lang}/{symposiumId}", method=RequestMethod.GET)
	public ModelAndView getWriteContentView(@PathVariable(value="type")Integer type,
			@PathVariable(value="lang")String lang,
			@PathVariable(value="symposiumId")Integer symposiumId,
			@PathVariable(value="where", required = true)String where,
			ModelAndView mv) {
		SymposiumDetail symp = new SymposiumDetail();
		symp.setSymposiumId(symposiumId);
		symp.setStype(type);
		symp.setLang(lang);
		
		SymposiumUtil util = new SymposiumUtil();
		SymposiumDetail detail = util.getSymposiumDetail(sympDetailService, symp);
		if(detail == null) {
			detail = new SymposiumDetail();
			detail.setSympTitle(util.getSymposiumTitle(sympDetailService, symp));
			detail.setTypeTitle(util.getTypeTitle(sympDetailService, symp));
			detail.setSymposiumId(symposiumId);
			detail.setStype(type);
			detail.setLang(lang);
		}else {
			List<PhotoInfo> photos = util.selectPhotos(sympDetailService, detail);
			mv.addObject("photos", photos);
		}
		
		if(where.equalsIgnoreCase("domestic")) {
			mv.addObject("title", Symposium.DOMESTIC_TITLE);
		}else if(where.equalsIgnoreCase("international")){
			mv.addObject("title", Symposium.INTERNATIONAL_TITLE);
		}
		mv.addObject("detail", detail);
		mv.addObject("user", getUser());
		mv.addObject("where", where);
		mv.setViewName("/admin/contentWrite");
		return mv;
	}
	
	/**
	 * 저장 / 수정하기
	 * 
	 * @param type
	 * @param lang
	 * @param symposiumId
	 * @param sympDetail
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/{where}/write/content", method=RequestMethod.POST)
	public String writeDetailContent(
			@RequestParam(value="pictures")String pictures,
			@PathVariable(value="where", required = true)String where,
			SymposiumDetail sympDetail) {
		JSONObject json = new JSONObject();
		SymposiumUtil util = new SymposiumUtil();
		int result = 0;
		
		if(sympDetail.getId() > 0) {
			// edit
			result = util.updateDetail(sympDetailService, sympDetail);
		}else {
			// write
			result = util.insertDetail(sympDetailService, sympDetail);
		}

		FileUtil fileUtil = new FileUtil();
		if(pictures.length() > 0) {
			List<PhotoInfo> editPhotos = fileUtil.parsePhotoInfo(pictures.split(","), sympDetail.getId());
			util.updatePhoto(sympDetailService, editPhotos, sympDetail);
		}
		json.put("result", result);
		return json.toString();
	}
	/**
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/{where}/delete/content")
	public String getWriteContentView(SymposiumDetail sympDetail,
			@PathVariable(value="where", required = true)String where) {
		JSONObject json = new JSONObject();
		
		SymposiumUtil util = new SymposiumUtil();
		int result = util.deleteSymposiumDetail(sympDetailService, sympDetail);
		json.put("result", result);
		
		return json.toString();
	}
	
	@RequestMapping(value="/apply/list/{sympId}")
	public ModelAndView getApplyListView(ModelAndView mv,
			@PathVariable(value="sympId")Integer sympId,
			@RequestParam(value="query")Optional<String> query) {
		ApplyVO apply = new ApplyVO();
		apply.setSympId(sympId);
		if(query.isPresent()) {
			apply.setQuery(query.get());
		}
		List<ApplyVO> applyList = applyService.select(apply);
		mv.addObject("applyList", applyList);
		mv.addObject("paging", apply);
		mv.addObject("sympId", sympId);
		mv.setViewName("/admin/domesticList");
		return mv;
	}
	
	@RequestMapping(value="/apply/list/{sympId}/excel")
	public void excelDown(@PathVariable(value="sympId")Integer sympId,
			HttpServletResponse response) throws IOException {
		ApplyVO apply = new ApplyVO();
		apply.setSympId(sympId);
		List<ApplyVO> applyList = applyService.select(apply);
		Symposium symposium = new Symposium();
		symposium.setId(sympId);
		symposium = sympService.selectOne(symposium);
		
		Workbook wb = new HSSFWorkbook();
		Sheet sheet = wb.createSheet(symposium.getTitle());
		
		Row row = null;
		Cell cell = null;
		int rowNo = 0;
		
		// table header style
		CellStyle headStyle = wb.createCellStyle();
		// 가는 경계선
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THICK);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		
		// 베경색
		headStyle.setFillForegroundColor(HSSFColorPredefined.GREY_25_PERCENT.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		// 데이터 가운데정렬
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		
		// 데이터용 경계 스타일 테두리
		CellStyle bodyStyle = wb.createCellStyle();
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		
		// 헤더생성
		row = sheet.createRow(rowNo++);
		for(int i = 0; i<header.length; i++) {
			cell = row.createCell(i);
			cell.setCellStyle(headStyle);
			cell.setCellValue(header[i]);
		}
		
		Iterator<ApplyVO> iter = applyList.iterator();
		while(iter.hasNext()) {
			ApplyVO item = iter.next();
			row = sheet.createRow(rowNo++);
			
			for(int i = 0; i<header.length; i++) {
				cell = row.createCell(i);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(getString(item, i));
			}
		}
		
		// 컨텐츠 타입과 파일명
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment; filename=\"export.xls\"");
		response.setCharacterEncoding("UTF-8");
		// 엑셀 출력
		wb.write(response.getOutputStream());
		wb.close();
	}
	
	String [] header = {"신청일","구분","발표자","국적","이름","소속","직위","연락처","이메일 주소"};
	private String getString(ApplyVO item, int i) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  

		switch(i) {
		case 0:
			return dateFormat.format(item.getMdate());
		case 1:
			if(item.getMemberType() == 2) {
				return "일반";	
			}else if(item.getMemberType() == 3) {
				return "기업";
			}else if(item.getMemberType() == 4) {
				return "학생";
			}
		case 2:
			if(item.getIsSpeaker() == 0) {
				return "O";
			}else if(item.getIsSpeaker() == 1) {
				return "X";
			}
		case 3:
			if(item.getNational() == 1) {
				return "대한민국";
			}else if(item.getNational() == 2) {
				return "중국";
			}else if(item.getNational() == 3) {
				return "일본";
			}
		case 4:
			return item.getUsername();
		case 5:
			return item.getClassification();
		case 6:
			return item.getLevel();
		case 7:
			return item.getTelephone();
		case 8:
			return item.getEmail() +"@" + item.getDomain();

		}
		return null;
	}
	
}
