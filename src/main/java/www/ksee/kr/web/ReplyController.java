package www.ksee.kr.web;

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
	public String insert(Reply reply) {
		JSONObject json = new JSONObject();
		UserVO user = getUser();
		reply.setWriter(user.getId());
		json.put("result", service.insert(reply));
		
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/update", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String update(Reply reply) {
		JSONObject json = new JSONObject();
		
		json.put("result", service.update(reply));
		
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
