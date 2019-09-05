package www.ksee.kr.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.BoardService;
import www.ksee.kr.vo.Board;
import www.ksee.kr.vo.FileInfo;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.UserVO;

@Controller
@RequestMapping(value="/group")
public class GroupController extends KseeController {
	@Autowired
	BoardService boardService;
	
	@RequestMapping(value= "/", method = RequestMethod.GET)
	public ModelAndView getGroupView(ModelAndView mv) {
		mv.addObject("title", "학회소식");
		mv.setViewName("/group/home");
		return mv;
	}
	@RequestMapping(value= "/notice")
	public ModelAndView getNoticeView(ModelAndView mv,
			Board board) {
		board.setBoardType(Board.TYPE_NOTICE);
		int totalCount = boardService.count(board);
		board.setTotalCount(totalCount);
		List<Board> boardList = boardService.select(board);
		
		mv.addObject("list", boardList);
		mv.addObject("paging", board);
		mv.setViewName("/group/notice");
		mv.addObject("title", "공지사항");
		return mv;
	}
	@RequestMapping(value="/notice/write")
	public ModelAndView getWriteNoticeView(ModelAndView mv, HttpServletRequest request) {
		UserVO user = getUser();
		
		mv.addObject("current", request.getServletPath());
		mv.addObject("listUrl", request.getContextPath() +"/group/notice");
		mv.addObject("user", user);
		mv.setViewName("/board/write");
		return mv;
	}
	@RequestMapping(value="/notice/view/{id}")
	public ModelAndView getDetailNoticeView(ModelAndView mv,
			@PathVariable(value="id", required = true)Integer id) {
		Board board= boardService.selectOne(Board.newInstance(id));
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		mv.addObject("title", "공지사항");
		
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		mv.setViewName("/board/detail");
		return mv;
	}
	@RequestMapping(value="/news")
	public ModelAndView getNewsView(ModelAndView mv,
			Board board) {
		board.setBoardType(Board.TYPE_NEWS);
		int totalCount = boardService.count(board);
		board.setTotalCount(totalCount);
		List<Board> boardList = boardService.select(board);
		
		mv.addObject("list", boardList);
		mv.addObject("paging", board);
		mv.setViewName("/group/news");
		mv.addObject("title", "관련소식");
		return mv;
	}
}
