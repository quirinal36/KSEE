package www.ksee.kr.web;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import www.ksee.kr.vo.Popup;

@RequestMapping(value="/popup")
@Controller
public class PopupController {

	@ResponseBody
	@RequestMapping(value = "/insert")
	public String insert(Popup popup) {
		JSONObject json = new JSONObject();
		
		return json.toString(); 
	}
}
