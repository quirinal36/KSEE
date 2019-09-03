package www.ksee.kr.web;

import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@RequestMapping(value="/symposium")
@Controller
public class SymposiumController {
	
	@RequestMapping(value= {"/", "/domestic"})
	public ModelAndView getHistoryView(ModelAndView mv) {
		mv.setViewName("/symposium/domestic");
		mv.addObject("title", "국내 학술대회");
		return mv;
	}
	
	@RequestMapping(value= {"/domestic/view/{id}/{tab}", "/domestic/view/{id}"})
	public ModelAndView getDetailView(ModelAndView mv, @PathVariable(value="id", required = true)Integer id,
			@PathVariable(value="tab", required = false)Optional<Integer>tab) {
		if(tab.isPresent()) {
			mv.addObject("tab", tab.get());
		}else {
			mv.addObject("tab", 1);
		}
		mv.setViewName("/symposium/detail");
		return mv;
	}
	@RequestMapping(value="/international")
	public ModelAndView getInternationalView(ModelAndView mv) {
		mv.setViewName("/symposium/international");
		mv.addObject("title", "한중일 학술대회");
		return mv;
	}
}
