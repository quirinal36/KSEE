package www.ksee.kr.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.vo.Board;
import www.ksee.kr.vo.FileInfo;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.UserVO;

@RequestMapping(value="/community")
@Controller
public class CommunityController extends KseeController{
	
	@RequestMapping(value="/board")
	public ModelAndView getFreeBoardView(ModelAndView mv,
			Board board) {
		mv.addObject("title", "자유게시판");
		
		board.setBoardType(Board.TYPE_FREE);
		board.setPageSize(Board.PAGE_SIZE_NORMAL);
		
		int totalCount = boardService.count(board);
		board.setTotalCount(totalCount);
		List<Board> boardList = boardService.select(board);
		
		mv.addObject("list", boardList);
		mv.addObject("paging", board);
		mv.addObject("listUrl", "/community/board/");
		mv.addObject("viewUrl", "/community/board/view/");
		mv.addObject("writeUrl", "/community/board/write/");
		
		mv.setViewName("/community/board");
		return mv;
	}
	
	/**
	 * 자유게시판 글쓰기 화면
	 * @param mv
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/board/write")
	public ModelAndView getWriteFreeBoardView(ModelAndView mv, 
			HttpServletRequest request) {
		UserVO user = getUser();
		
		mv.addObject("current", request.getServletPath());
		mv.addObject("listUrl", request.getContextPath() +"/community/board");
		mv.addObject("authUrl", "/member/isLogin");
		mv.addObject("user", user);
		mv.addObject("boardType", Board.TYPE_FREE);
		mv.setViewName("/board/write");
		return mv;
	}
	/**
	 * 회원동정 상세보기
	 * @param request
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/board/view/{id}")
	public ModelAndView getDetailFreeBoardView(HttpServletRequest request,
			ModelAndView mv,
			@PathVariable(value="id", required = true)Integer id) {
		Board board= boardService.selectOne(Board.newInstance(id));
		board.setViewCount(board.getViewCount() + 1);
		boardService.update(board);
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		mv.addObject("title", "자유게시판");
		
		mv.addObject("listUrl", request.getContextPath() +"/community/board");
		mv.addObject("edit_url", request.getContextPath()+"/community/board/edit/");
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		mv.setViewName("/board/detail");
		return mv;
	}
	
	/**
	 * 회원동정 수정하기 화면
	 * 
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/board/edit/{id}")
	public ModelAndView getMemberEditView(ModelAndView mv,
			@PathVariable(value="id", required = true)Integer id) {
		Board board= boardService.selectOne(Board.newInstance(id));
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		mv.addObject("title", "회원동정");
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		
		mv.setViewName("/board/edit");
		return mv;
	}
}
