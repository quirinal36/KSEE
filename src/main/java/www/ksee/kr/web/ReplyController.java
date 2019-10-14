package www.ksee.kr.web;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import www.ksee.kr.service.ReplyService;
import www.ksee.kr.vo.Reply;
import www.ksee.kr.vo.UserVO;

@RequestMapping(value="/reply")
@Controller
public class ReplyController extends KseeController{
	@Autowired
	ReplyService service;
	
	@ResponseBody
	@RequestMapping(value="/insert", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String insert(Reply reply, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		if(isLoginedUser(request)) {
			UserVO user = getUser();
			reply.setWriter(user.getId());
			json.put("result", service.insert(reply));
		}else {
			json.put("msg", "로그인 해주세요.");
			json.put("result", -1);
		}
		
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/update", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String update(Reply reply, HttpServletRequest request) {
		JSONObject json = new JSONObject();
		if(isLoginedUser(request)) {
			json.put("result", service.update(reply));
		}else {
			json.put("result", -1);
			json.put("msg", "로그인 해주세요.");
		}
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/delete", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String delete(Reply reply) {
		JSONObject json = new JSONObject();
		
		json.put("result", service.delete(reply));
		
		return json.toString();
	}
}
