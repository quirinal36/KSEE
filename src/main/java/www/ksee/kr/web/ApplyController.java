package www.ksee.kr.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.vo.ApplyVO;
import www.ksee.kr.vo.Symposium;

@RequestMapping(value="/symposium/apply")
@Controller
public class ApplyController extends KseeController{

	@RequestMapping(value="/search", method = RequestMethod.GET)
	public ModelAndView applyView(ModelAndView mv, HttpServletRequest request) {
		final String currentUrl = "/symposium/apply/search";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		mv.addObject("title", "참가신청 조회");
		
		Symposium dome = new Symposium();
		dome.setSympType(Symposium.SYMP_TYPE_DOMESTIC);
		dome.setTotalCount(sympService.count(dome));
		List<Symposium> domeList = sympService.select(dome);
		mv.addObject("domeList", domeList);
		
		Symposium inter = new Symposium();
		inter.setSympType(Symposium.SYMP_TYPE_INTERNATIONAL);
		inter.setTotalCount(sympService.count(inter));
		List<Symposium> interList = sympService.select(inter);
		mv.addObject("interList", interList);
		
		mv.setViewName("/symposium/searchApply");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value="/search", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String search(ApplyVO apply) {
		JSONObject json = new JSONObject();
		
		ApplyVO searchList = applyService.search(apply);
		
		if(searchList != null) {
			json.put("result", 1);
			json.put("status", searchList.getStatus());
		}else {
			json.put("result", 0);
		}
		logger.info(apply.toString());
		
		return json.toString();
	}
}