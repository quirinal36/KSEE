package www.ksee.kr.web;

import java.io.File;
import java.io.IOException;
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

import www.ksee.kr.service.PhotoInfoService;
import www.ksee.kr.service.PopupService;
import www.ksee.kr.util.FileUtil;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.Popup;

@RequestMapping(value="/admin/popup")
@Controller
public class PopupController extends KseeController{
	final int IMG_WIDTH = 624;
	final int IMG_HEIGHT = 337;
	
	@Autowired
	private PhotoInfoService photoInfoService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private PopupService popupService;
	
	/**
	 * 팝업관리
	 * @param mv
	 * @return
	 */
	@RequestMapping(value="/")
	public ModelAndView getAdminPopup(ModelAndView mv) {
		mv.addObject("title", "팝업관리");
		mv.addObject("menu", 3);
		
		Popup popup = new Popup();
		List<Popup> list = popupService.select(popup);
		
		mv.addObject("list", list);		
		mv.setViewName("/admin/popup");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String insert(Popup popup,
			@RequestParam(value="pictures", required = false)Optional<Integer> picture,
			HttpServletRequest request) {
		FileUtil fileUtil = new FileUtil();
		JSONObject json = new JSONObject();
		if(isAdmin(request)) {
			if(picture.isPresent()) {
				PhotoInfo photoInfo = PhotoInfo.newInstance(0);
				photoInfo.setId(picture.get());
				photoInfo = photoInfoService.selectOne(photoInfo);
				
				File file = new File(fileUtil.makeUserPath() + File.separator + photoInfo.getNewFilename());
				if(file.exists()) {
					try {
						fileUtil.resizeTo(IMG_WIDTH, IMG_HEIGHT, file);
					} catch (IOException e) {
						e.printStackTrace();
					}
					popup.setFileId(photoInfo.getId());
				}
			}		
		}else {
			json.put("result", -1);
			json.put("msg", "관리자 계정으로 로그인 해주세요.");
		}
		json.put("result", popupService.insert(popup));
		return json.toString();
	}
	
	@RequestMapping(value="/insertForm")
	public ModelAndView getInsertView(ModelAndView mv) {
		mv.addObject("title", "팝업 등록");
		mv.addObject("menu", 3);
		
		mv.setViewName("/admin/popup/insertForm");
		return mv;
	}
	
	@RequestMapping(value= {"/editForm", "/editForm/{id}"})
	public ModelAndView getEditView(ModelAndView mv,
			@PathVariable(value="id")Optional<Integer>id) {
		mv.addObject("title", "팝업 수정");
		mv.addObject("menu", 3);
		
		if(id.isPresent()) {
			Popup popup = new Popup();
			popup.setId(id.get());
			
			popup = popupService.selectOne(popup);
			
			mv.addObject("popup", popup);
			
			if(popup.getFileId() > 0) {
				PhotoInfo photoInfo = PhotoInfo.newInstance(0);
				photoInfo.setId(popup.getFileId());
				photoInfo = photoInfoService.selectOne(photoInfo);
				mv.addObject("photo", photoInfo);
			}
		}
		
		mv.setViewName("/admin/popup/editForm");
		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "/edit", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String edit(Popup popup,
			@RequestParam(value="pictures", required = false)Optional<Integer> picture,
			HttpServletRequest request) {
		FileUtil fileUtil = new FileUtil();
		JSONObject json = new JSONObject();
		if(isAdmin(request)) {
			if(picture.isPresent()) {
				PhotoInfo photoInfo = PhotoInfo.newInstance(0);
				photoInfo.setId(picture.get());
				photoInfo = photoInfoService.selectOne(photoInfo);
				
				File file = new File(fileUtil.makeUserPath() + File.separator + photoInfo.getNewFilename());
				if(file.exists()) {
					try {
						fileUtil.resizeTo(IMG_WIDTH, IMG_HEIGHT, file);
					} catch (IOException e) {
						e.printStackTrace();
					}
					popup.setFileId(photoInfo.getId());
				}
			}
			
			int result = popupService.update(popup);
			json.put("result", result);
		}else {
			json.put("result", -1);
			json.put("msg", "관리자 계정으로 로그인 해주세요.");
		}
		return json.toString();
	}
	
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String delete(@PathVariable(value="id")Optional<Integer>id,
			HttpServletRequest request) {
		JSONObject json = new JSONObject();
		
		if(isAdmin(request)) {
			if(id.isPresent()) {
				Popup popup = new Popup();
				popup.setId(id.get());
				
				int result = popupService.delete(popup);
				json.put("result", result);
			}
		}else {
			json.put("result", -1);
			json.put("msg", "관리자 계정으로 로그인 해주세요.");
		}
		return json.toString();
	}
}
