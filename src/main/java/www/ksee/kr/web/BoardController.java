package www.ksee.kr.web;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.BoardService;
import www.ksee.kr.util.FileUtil;
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
	
	/**
	 * 
	 * @param id
	 * @param response
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value="/delete/{id}", method= {RequestMethod.GET, RequestMethod.POST})
	public String editBoard (@PathVariable(value="id", required = true)Integer id, HttpServletResponse response) {
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		
		int result = boardService.delete(Board.newInstance(id));
		if(result > 0) {
			List<File> files = new ArrayList<File>();
			String srcPath = new FileUtil().makeUserPath();
			if(photoList.size() > 0) {
				Iterator<PhotoInfo> iter = photoList.iterator();
				while(iter.hasNext()) {
					PhotoInfo photo = iter.next();
					File file = new File(srcPath + File.separator + photo.getNewFilename());
					files.add(file);
				}
			}
			if(fileList.size() > 0) {
				Iterator<FileInfo> iter = fileList.iterator();
				while(iter.hasNext()) {
					FileInfo info = iter.next();
					File file = new File(srcPath + File.separator + info.getNewFilename());
					files.add(file);
				}
			}
			if(files.size() > 0) {
				Iterator<File> iter = files.iterator();
				while(iter.hasNext()) {
					File file = iter.next();
					if(file.exists()) {
						file.delete();
					}
				}
			}
		}
		JSONObject json = new JSONObject();
		json.put("result", result);
		return json.toString();
	}
			
	/**
	 * 글 수정하기
	 * 
	 * @param board
	 * @param response
	 * @param pictures
	 * @param files
	 * @param request
	 * @return
	 * @throws IOException
	 */
	@ResponseBody
	@RequestMapping(value="/editBoard", method= {RequestMethod.GET, RequestMethod.POST})
	public String editBoard (Board board, HttpServletResponse response,
			@RequestParam(value="pictures", required = false)String pictures,
			@RequestParam(value="files", required = false)String files,
			HttpServletRequest request) throws IOException {
		UserVO user = getUser();
		board.setWriter(user.getId());
		int result = boardService.update(board);
		
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
	/**
	 * 새글 작성
	 * 
	 * @param board
	 * @param response
	 * @param pictures
	 * @param files
	 * @param request
	 * @return
	 * @throws IOException
	 */
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
