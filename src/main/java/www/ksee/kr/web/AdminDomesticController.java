package www.ksee.kr.web;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.Symposium;
import www.ksee.kr.vo.SymposiumDetail;
import www.ksee.kr.vo.SymposiumTypes;

@RequestMapping("/admin/domestic")
@Controller
public class AdminDomesticController extends KseeController{
	Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	SymposiumService sympService;
	@Autowired
	SymposiumDetailService sympDetailService;
	
	/**
	 * 국내 학술대회
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/")
	public ModelAndView getAdminDomestic(ModelAndView mv, Symposium symp) {
		mv.addObject("title", "국내 학술대회");
		mv.addObject("menu", 1);
		SymposiumUtil util = new SymposiumUtil();
		mv.addObject("list", util.search(sympService, symp));
		mv.setViewName("/admin/domestic");
		return mv;
	}
	
	@RequestMapping(value= {"/write","/write/{id}"}, method = RequestMethod.GET)
	public ModelAndView getWriteView(ModelAndView mv, HttpServletRequest request
			,@PathVariable(value="id", required = false)Optional<Integer> id) {
		if(id.isPresent()) {
			Symposium symposium = new Symposium();
			symposium.setId(id.get());
			symposium = sympService.selectOne(symposium);
			mv.addObject("symposium", symposium);
		}
		mv.addObject("title", "국내 학술대회");
		mv.addObject("listUrl", request.getContextPath() + "/admin/domestic/");
		mv.setViewName("/admin/domestic/write");
		return mv;
	}
	@RequestMapping(value="/list")
	public ModelAndView getAdminDomesticList(ModelAndView mv) {
		mv.addObject("title", "신청현황 - 제8회 한국효소공학연구회 심포지엄");
		mv.addObject("menu", 1);
		mv.setViewName("/admin/domesticList");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/write", method = RequestMethod.POST)
	public String writeSave(Symposium symposium) {
		JSONObject json = new JSONObject();
		
		SymposiumUtil util = new SymposiumUtil();
		util.insert(sympService, symposium);
		json.put("result", symposium.getId());
		return json.toString();
	}
	
	@RequestMapping(value="/detail/{id}")
	public ModelAndView getDetailView(@PathVariable(value="id")Integer id,
			ModelAndView mv) {
		SymposiumDetail sympDetail = new SymposiumDetail();
		sympDetail.setSymposiumId(id);
		
		SymposiumUtil util = new SymposiumUtil();
		List<SymposiumTypes> sympTypes = util.getSymposiumDetailTypes(sympService);

		// 이번 회차 심포지움에 작성되어있는 상세내용들을 가져온뒤
		// map 에 저장을 한다. -> 수정을 할건지 새로 작성할건지 버튼을 정하기 위해
		List<SymposiumDetail> sympDetails = util.getSymposiumDetails(sympDetailService, sympDetail);
		logger.info("sympDetails size: " + sympDetails.size());
		
		mv.addObject("title", "국내 학술대회");
		mv.addObject("types", sympTypes);
		mv.addObject("details", sympDetails);
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
	@RequestMapping(value="/write/content/{type}/{lang}/{symposiumId}", method=RequestMethod.GET)
	public ModelAndView getWriteContentView(@PathVariable(value="type")Integer type,
			@PathVariable(value="lang")String lang,
			@PathVariable(value="symposiumId")Integer symposiumId,
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
		
		mv.addObject("detail", detail);
		mv.addObject("user", getUser());
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
	@RequestMapping(value="/write/content", method=RequestMethod.POST)
	public String writeDetailContent(
			@RequestParam(value="pictures")String pictures,
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
		List<PhotoInfo> editPhotos = fileUtil.parsePhotoInfo(pictures.split(","), sympDetail.getId());
		util.updatePhoto(sympDetailService, editPhotos, sympDetail);
		
		json.put("result", result);
		return json.toString();
	}
	/**
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/delete/content")
	public String getWriteContentView(SymposiumDetail sympDetail) {
		JSONObject json = new JSONObject();
		
		SymposiumUtil util = new SymposiumUtil();
		int result = util.deleteSymposiumDetail(sympDetailService, sympDetail);
		json.put("result", result);
		
		return json.toString();
	}
}
