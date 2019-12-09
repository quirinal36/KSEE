package www.ksee.kr.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class SmartEditorController {
	@RequestMapping(value="/seSkin")
	public ModelAndView getSmartEditor2Skin(ModelAndView mv) {
		mv.setViewName("/smartEditor/SmartEditor2Skin");
		return mv;
	}
	@RequestMapping(value="/smart_editor2_inputarea")
	public ModelAndView getSmartEditor2InputareaView(ModelAndView mv) {
		mv.setViewName("/smartEditor/smart_editor2_inputarea");
		return mv;
	}
	@RequestMapping(value="/smart_editor2_inputarea_ie8")
	public ModelAndView getSmartEditor2IE8InputArearView(ModelAndView mv) {
		mv.setViewName("/smartEditor/smart_editor2_inputarea_ie8");
		return mv;
	}
}
