package www.ksee.kr.web;

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
	public ModelAndView getHistoryView(ModelAndView mv, HttpServletRequest request,
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
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		int total = sympService.count(symp);
		symp.setTotalCount(total);
		List<Symposium> list = sympService.select(symp);
		
		if(where.isPresent()) {
			mv.addObject("where", where.get());
		}
		mv.addObject("list", list);
		mv.addObject("paging", symp);
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
		}else if(where.equalsIgnoreCase("international")){
			mv.addObject("title", Symposium.INTERNATIONAL_TITLE);
		}
		
		final String currentUrl = "/symposium/domestic";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
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
		mv.addObject("detail", detail);
		
		if(detail != null) {
			SymposiumUtil util = new SymposiumUtil();
			List<PhotoInfo> photos = util.selectPhotos(sympDetailService, detail);
			mv.addObject("photos", photos);
		}
		
		mv.setViewName("/symposium/detail");
		return mv;
	}
	
	/**
	 * 참가신청 화면
	 * @param mv
	 * @param sympId
	 * @return
	 */
	@RequestMapping(value="/apply/{id}")
	public ModelAndView getApplyView(ModelAndView mv,
			@PathVariable(value="id")Integer sympId) {
		UserVO user = getUser();
		mv.addObject("user", user);
		
		mv.addObject("title", "참가신청");
		
		Symposium symposium = new Symposium();
		symposium.setId(sympId);
		symposium = sympService.selectOne(symposium);
		mv.addObject("symposium", symposium);
		mv.setViewName("/symposium/apply");
		return mv;
	}
	
	@RequestMapping(value="/applyList", method = RequestMethod.GET)
	public ModelAndView applyView(ModelAndView mv) {
		mv.setViewName("/symposium/applyList");
		return mv;
	}
	@ResponseBody
	@RequestMapping(value="/apply", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String applySend(ApplyVO apply,
			@RequestParam(value="files")String files) {
		for(String fileId : files.split(",")) {
			apply.setFileId(Integer.parseInt(fileId));
		}
		
		JSONObject json = new JSONObject();
		json.put("result", applyService.insert(apply));
		return json.toString();
	}
}
