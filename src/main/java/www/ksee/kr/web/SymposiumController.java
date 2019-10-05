package www.ksee.kr.web;

import java.util.List;
import java.util.Locale;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.SymposiumDetailService;
import www.ksee.kr.service.SymposiumService;
import www.ksee.kr.util.SymposiumUtil;
import www.ksee.kr.vo.Paging;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.Symposium;
import www.ksee.kr.vo.SymposiumDetail;

@RequestMapping(value="/symposium")
@Controller
public class SymposiumController extends KseeController{
	@Autowired
	SymposiumService sympService;
	@Autowired
	SymposiumDetailService sympDetailService;
	
	@RequestMapping(value= {"/", "/domestic"})
	public ModelAndView getHistoryView(ModelAndView mv, HttpServletRequest request,
			Symposium symp) {
		final String currentUrl = "/symposium/domestic";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		if(symp.getPageNo() == 0) {
			symp.setPageNo(1);
		}
		
		symp.setPageSize(Paging.PAGE_SIZE_LIST);
		int total = sympService.count(symp);
		symp.setTotalCount(total);
		List<Symposium> list = sympService.select(symp);
		mv.addObject("list", list);
		mv.addObject("paging", symp);
		mv.setViewName("/symposium/domestic");
		mv.addObject("title", "국내 학술대회");
		
		return mv;
	}
	
	@RequestMapping(value= {"/domestic/view/{id}/{tab}", "/domestic/view/{id}"})
	public ModelAndView getDetailView(ModelAndView mv, @PathVariable(value="id", required = true)Integer id,
			@PathVariable(value="tab", required = false)Optional<Integer>tab,
			HttpServletRequest request, Locale locale) {
		Symposium symposium = new Symposium();
		SymposiumDetail detail = new SymposiumDetail();
		
		final String currentUrl = "/symposium/domestic";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		mv.addObject("title", "국내 학술대회");
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
	@RequestMapping(value="/international")
	public ModelAndView getInternationalView(ModelAndView mv,
			HttpServletRequest request) {
		final String currentUrl = "/symposium/international";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		mv.setViewName("/symposium/international");
		mv.addObject("title", "한중일 학술대회");
		return mv;
	}
	
	@RequestMapping(value="/apply")
	public ModelAndView getApplyView(ModelAndView mv) {
		mv.addObject("title", "참가신청");
		mv.setViewName("/symposium/apply");
		return mv;
	}
	
	
}
