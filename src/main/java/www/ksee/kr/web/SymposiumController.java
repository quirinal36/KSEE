package www.ksee.kr.web;

import java.util.List;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.vo.Board;
import www.ksee.kr.vo.FileInfo;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.UserVO;

@RequestMapping(value="/symposium")
@Controller
public class SymposiumController extends KseeController{
	
	@RequestMapping(value= {"/", "/domestic"})
	public ModelAndView getHistoryView(ModelAndView mv, HttpServletRequest request) {
		final String currentUrl = "/symposium/domestic";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		mv.setViewName("/symposium/domestic");
		mv.addObject("title", "국내 학술대회");
		return mv;
	}
	
	@RequestMapping(value= {"/domestic/view/{id}/{tab}", "/domestic/view/{id}"})
	public ModelAndView getDetailView(ModelAndView mv, @PathVariable(value="id", required = true)Integer id,
			@PathVariable(value="tab", required = false)Optional<Integer>tab,
			HttpServletRequest request) {
		final String currentUrl = "/symposium/domestic";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		mv.addObject("title", "국내 학술대회");
		if(tab.isPresent()) {
			mv.addObject("tab", tab.get());
		}else {
			mv.addObject("tab", 1);
		}
		mv.setViewName("/symposium/detail");
		return mv;
	}
	@RequestMapping(value="/international")
	public ModelAndView getInternationalView(ModelAndView mv,
			HttpServletRequest request) {
		final String currentUrl = "/symposium/international";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		mv.setViewName("/symposium/international");
		mv.addObject("title", "한중일 학술대회");
		return mv;
	}
	
	@RequestMapping(value="/apply")
	public ModelAndView getApplyView(ModelAndView mv) {
		mv.addObject("title", "참가신청");
		mv.setViewName("/symposium/apply");
		return mv;
	}
	
	/************************************************************************
	 * 	연사제안 관련 메소드
	 * 	1. /speaker			: 게시판 리스트
	 *  2. /speaker/write	: 게시판 글 쓰기
	 *  3. /speaker/view	: 게시판 글 상세보기
	 *  4. /speaker/edit	: 게시판 글 수정
	 ************************************************************************/
	/**
	 * 연사제안 리스트 
	 * @param mv
	 * @param board
	 * @return
	 */
	@RequestMapping(value= "/speaker")
	public ModelAndView getSpeakerView(ModelAndView mv,
			Board board,HttpServletRequest request) {
		final String currentUrl = "/symposium/speaker";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		mv.addObject("title", "연사제안");
		
		board.setBoardType(Board.TYPE_SPEAKER);
		board.setPageSize(Board.PAGE_SIZE_NORMAL);
		
		int totalCount = boardService.count(board);
		board.setTotalCount(totalCount);
		List<Board> boardList = boardService.select(board);
		
		mv.addObject("list", boardList);
		mv.addObject("paging", board);
		mv.addObject("listUrl", "/symposium/speaker");
		mv.addObject("viewUrl", "/symposium/speaker/view/");
		mv.addObject("writeUrl", "/symposium/speaker/write/");
		mv.setViewName("/community/board");
		
		return mv;
	}
	/**
	 * 연사제안 글쓰기 화면
	 * @param mv
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/speaker/write")
	public ModelAndView getWriteSpeakerView(ModelAndView mv, 
			HttpServletRequest request) {
		final String currentUrl = "/symposium/speaker";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		UserVO user = getUser();
		
		mv.addObject("current", request.getServletPath());
		mv.addObject("listUrl", request.getContextPath() +"/symposium/speaker");
		mv.addObject("authUrl", "/member/isLogin");
		mv.addObject("user", user);
		mv.addObject("boardType", Board.TYPE_SPEAKER);
		mv.setViewName("/board/write");
		return mv;
	}
	/**
	 * 연사제안 상세보기
	 * @param request
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/speaker/view/{id}")
	public ModelAndView getDetailSpeakerView(HttpServletRequest request,
			ModelAndView mv,
			@PathVariable(value="id", required = true)Integer id) {
		final String currentUrl = "/symposium/speaker";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		Board board= boardService.selectOne(Board.newInstance(id));
		board.setViewCount(board.getViewCount() + 1);
		boardService.update(board);
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		mv.addObject("title", "연사제안");
		
		mv.addObject("listUrl", request.getContextPath() +"/symposium/speaker");
		mv.addObject("edit_url", request.getContextPath()+"/symposium/speaker/edit/");
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		mv.setViewName("/board/detail");
		return mv;
	}
	
	/**
	 * 연사제안 수정하기 화면
	 * 
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/speaker/edit/{id}")
	public ModelAndView getSpeakerEditView(ModelAndView mv,
			HttpServletRequest request,
			@PathVariable(value="id", required = true)Integer id) {
		final String currentUrl = "/symposium/speaker";
		mv.addObject("curMenu", getCurMenus(currentUrl, request));
		
		Board board= boardService.selectOne(Board.newInstance(id));
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		mv.addObject("title", "연사제안");
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		
		mv.setViewName("/board/edit");
		return mv;
	}
}
