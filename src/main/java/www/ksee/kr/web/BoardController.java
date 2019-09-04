package www.ksee.kr.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.BoardService;
import www.ksee.kr.vo.Board;
import www.ksee.kr.vo.FileInfo;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.UserVO;

@RequestMapping(value = "/board")
@Controller
public class BoardController extends KseeController{
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value = "/board_edit")
	public ModelAndView getBoardEditView(ModelAndView mv) {
		mv.setViewName("/board/board_edit");
		
		return mv;
	}

	@RequestMapping(value = "/board_view")
	public ModelAndView getBoardView(ModelAndView mv) {
		mv.setViewName("/board/board_view");
		return mv;
	}

	@RequestMapping(value = "/board_write")
	public ModelAndView getBoardWriteView(ModelAndView mv) {
		mv.setViewName("/board/board_write");
		return mv;
	}
	@ResponseBody
	@RequestMapping(value="/insertBoard", method= {RequestMethod.GET, RequestMethod.POST})
	public String writeBoard (Board board, HttpServletResponse response,
			@RequestParam(value="pictures")String pictures,
			@RequestParam(value="files")String files,
			HttpServletRequest request) throws IOException {
		UserVO user = getUser();
		board.setWriter(user.getId());

		int result = boardService.insert(board);
		
		if(result > 0 && board.getId()>0) {
			if(pictures.length() > 0) {
				photoInfoService.update(parsePhotoInfo(pictures.split(","), board.getId()));
			}
			if(files.length() > 0) {
				fileInfoService.update(parseFileInfo(files.split(","), board.getId()));
			}
		}
		
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
	
	private List<PhotoInfo> parsePhotoInfo(String[] input, int boardId) {
		List<PhotoInfo> photoList = new ArrayList<PhotoInfo>();
		for(String pictureId : input) {
			PhotoInfo photoInfo = new PhotoInfo();
			photoInfo.setId(Integer.parseInt(pictureId));
			photoInfo.setBoardId(boardId);
			photoList.add(photoInfo);
		}
		return photoList;
	}
	private List<FileInfo> parseFileInfo(String[] input, int boardId) {
		List<FileInfo> fileList = new ArrayList<FileInfo>();
		for(String fileId : input) {
			FileInfo photoInfo = new FileInfo();
			photoInfo.setId(Integer.parseInt(fileId));
			photoInfo.setBoardId(boardId);
			fileList.add(photoInfo);
		}
		return fileList;
	}
}
