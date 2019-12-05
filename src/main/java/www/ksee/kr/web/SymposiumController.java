package www.ksee.kr.web;

import java.time.LocalDate;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

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
import www.ksee.kr.util.SymposiumUtil;
import www.ksee.kr.vo.ApplyVO;
import www.ksee.kr.vo.Paging;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.Symposium;
import www.ksee.kr.vo.SymposiumDetail;
import www.ksee.kr.vo.UserVO;

@RequestMapping(value="/symposium")
@Controller
public class SymposiumController extends KseeController{
	@Autowired
	SymposiumService sympService;
	@Autowired
	SymposiumDetailService sympDetailService;
	
	@RequestMapping(value= {"/", "/{where}"})
	public ModelAndView getHistoryView(Locale locale, ModelAndView mv, HttpServletRequest request,
			Symposium symp, @PathVariable(value="where", required = true)Optional<String> where) {
		String currentUrl = "/symposium/";
		
		if(symp.getPageNo() == 0) {
			symp.setPageNo(1);
		}
		symp.setPageSize(Paging.PAGE_SIZE_LIST);
		if(where.isPresent()) {
			currentUrl += where.get();
			if(where.get().equalsIgnoreCase("domestic")) {
				symp.setSympType(Symposium.SYMP_TYPE_DOMESTIC);
				mv.addObject("title", Symposium.DOMESTIC_TITLE);
			}else if(where.get().equalsIgnoreCase("international")){
				symp.setSympType(Symposium.SYMP_TYPE_INTERNATIONAL);
				mv.addObject("title", Symposium.INTERNATIONAL_TITLE);
			}
		}else {
			currentUrl += "domestic";
			symp.setSympType(Symposium.SYMP_TYPE_DOMESTIC);
			mv.addObject("title", Symposium.DOMESTIC_TITLE);
		}
		mv.addObject("curMenu", getCurMenus(currentUrl));
		
		int total = sympService.count(symp);
		symp.setTotalCount(total);
		List<Symposium> list = sympService.select(symp);
		
		if(where.isPresent()) {
			mv.addObject("where", where.get());
		}
		
		mv.addObject("today", LocalDate.now().toString());
		mv.addObject("list", list);
		mv.addObject("paging", symp);
		mv.addObject("locale", locale);
		mv.setViewName("/symposium/domestic");
		return mv;
	}
	
	@RequestMapping(value= {"/{where}/view/{id}/{tab}", "/{where}/view/{id}"})
	public ModelAndView getDetailView(ModelAndView mv, @PathVariable(value="id", required = true)Integer id,
			@PathVariable(value="tab", required = false)Optional<Integer>tab,
			HttpServletRequest request, Locale locale,
			@PathVariable(value="where", required = true)String where) {
		Symposium symposium = new Symposium();
		SymposiumDetail detail = new SymposiumDetail();
		if(where.equalsIgnoreCase("domestic")) {
			mv.addObject("title", Symposium.DOMESTIC_TITLE);
			String currentUrl = "/symposium/domestic";
			mv.addObject("curMenu", getCurMenus(currentUrl));
		}else if(where.equalsIgnoreCase("international")){
			mv.addObject("title", Symposium.INTERNATIONAL_TITLE);
			String currentUrl = "/symposium/international";
			mv.addObject("curMenu", getCurMenus(currentUrl));
		}
		
		mv.addObject("where", where);
		
		if(tab.isPresent()) {
			detail.setStype(tab.get());
		}else {
			detail.setStype(1);
		}
		
		mv.addObject("tab", detail.getStype());
		symposium.setId(id);
		symposium = sympService.selectOne(symposium);
		sympService.updateViewCnt(symposium);
		mv.addObject("symposium", symposium);
		
		detail.setSymposiumId(symposium.getId());
		detail.setLang(locale.toString());
		List<SymposiumDetail> detailList = sympDetailService.select(detail);
		
		mv.addObject("detailList",detailList);
		
		detail = sympDetailService.selectOne(detail);
		
		if(detail == null && detailList.size()>0) {
			int tabNum = detailList.get(0).getStype();
			mv.setViewName("redirect:/symposium/"+where+"/view/"+id+"/"+tabNum);
		}else {
			mv.addObject("detail", detail);
			mv.setViewName("/symposium/detail");
		}
		
		if(detail != null) {
			SymposiumUtil util = new SymposiumUtil();
			List<PhotoInfo> photos = util.selectPhotos(sympDetailService, detail);
			mv.addObject("photos", photos);
		}
		mv.addObject("today", LocalDate.now().toString());
		mv.addObject("locale", locale);
		return mv;
	}
	
	/**
	 * 참가신청 화면
	 * @param mv
	 * @param sympId
	 * @return
	 */
	@RequestMapping(value="/apply/{id}")
	public ModelAndView getApplyView(Locale locale, ModelAndView mv,
			@PathVariable(value="id")Integer sympId) {
		UserVO user = getUser();
		mv.addObject("user", user);
		
		mv.addObject("title", "참가신청");
		
		Symposium symposium = new Symposium();
		symposium.setId(sympId);
		symposium = sympService.selectOne(symposium);
		
		LocalDate applyStartDate = LocalDate.parse(symposium.getApplyStart());
		LocalDate applyFinishDate = LocalDate.parse(symposium.getApplyFinish());
		LocalDate today = LocalDate.now();
		if(applyStartDate.isAfter(today)) {
			final String msg = messageSource.getMessage("symposium.apply.msg.ready", null, locale);
			mv.addObject("expired_msg", msg);
			mv.addObject("expired", true);
		}
		if(applyFinishDate.isBefore(today)) {
			final String msg = messageSource.getMessage("symposium.apply.msg.expired", null, locale);
			mv.addObject("expired_msg", msg);
			mv.addObject("expired", true);
		}
		mv.addObject("symposium", symposium);
		mv.setViewName("/symposium/apply");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/apply", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String applySend(ApplyVO apply,
			@RequestParam(value="files")Optional<String> files) {
		if(files.isPresent()) {
			for(String fileId : files.get().split(",")) {
				apply.setFileId(Integer.parseInt(fileId));
			}
		}
		
		JSONObject json = new JSONObject();
		json.put("result", applyService.insert(apply));
		return json.toString();
	}
}
