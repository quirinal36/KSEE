package www.ksee.kr.web;

import java.io.File;
import java.io.IOException;
import java.util.Optional;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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

@RequestMapping(value="/popup")
@Controller
public class PopupController {
	final int IMG_WIDTH = 624;
	final int IMG_HEIGHT = 337;
	
	@Autowired
	private PhotoInfoService photoInfoService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private PopupService popupService;
	
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	public String insert(Popup popup,
			@RequestParam(value="pictures", required = false)Optional<Integer> picture) {
		FileUtil fileUtil = new FileUtil();
		JSONObject json = new JSONObject();
		if(picture.isPresent()) {
			PhotoInfo photoInfo = PhotoInfo.newInstance(0);
			photoInfo.setId(picture.get());
			photoInfo = photoInfoService.selectOne(photoInfo);
			
			File file = new File(fileUtil.makeUserPath() + File.separator + photoInfo.getNewFilename());
			logger.info(file.getAbsolutePath());
			if(file.exists()) {
				logger.info("file length: " + file.length());
				try {
					fileUtil.resizeTo(IMG_WIDTH, IMG_HEIGHT, file);
				} catch (IOException e) {
					e.printStackTrace();
				}
				popup.setFileId(photoInfo.getId());
			}
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
}
