package www.ksee.kr.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.Config;
import www.ksee.kr.service.ReplyService;
import www.ksee.kr.vo.Board;
import www.ksee.kr.vo.BoardInfo;
import www.ksee.kr.vo.FileInfo;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.Reply;
import www.ksee.kr.vo.UserVO;

@Controller
@RequestMapping(value="/group")
public class GroupController extends KseeController {
	@Autowired
	ReplyService replyService;
	/**
	 * 공지사항, 자유게시판, 관련소식 모두 보여주기
	 * 
	 * @param mv
	 * @param board
	 * @return
	 */
	@RequestMapping(value= "/", method = RequestMethod.GET)
	public ModelAndView getGroupView(ModelAndView mv, 
			HttpServletRequest request, Board board) {
		final String currentUrl = "/group/notice";
		mv.addObject("curMenu", getCurMenus(currentUrl));
		
		mv.addObject("title", "공지사항");
		
		board.setBoardType(Board.TYPE_GROUP);
		board.setPageSize(10);
		
		int totalCount = boardService.count(board);
		board.setTotalCount(totalCount);
		List<Board> list = boardService.select(board);
		
		mv.addObject("paging", board);
		mv.addObject("list", list);
		mv.setViewName("/group/home");
		return mv;
	}

	/************************************************************************
	 * 	공지사항 관련 메소드
	 * 	1. /notice			: 게시판 리스트
	 *  2. /notice/write	: 게시판 글 쓰기
	 *  3. /notice/view		: 게시판 글 상세보기
	 *  4. /notice/edit		: 게시판 글 수정
	 ************************************************************************/
	/**
	 * 공지사항 리스트 
	 * @param mv
	 * @param board
	 * @return
	 */
	@RequestMapping(value= "/{name}")
	public ModelAndView getNoticeView(ModelAndView mv,
			HttpServletRequest request,
			Board board, 
			@PathVariable(value="name", required=true)String name) {
		BoardInfo boardInfo = BoardInfo.init().get(name);
		
		final String currentUrl = boardInfo.getCurrentUrl();
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", boardInfo.getTitle());
		
		board.setBoardType(boardInfo.getType());
		int totalCount = boardService.count(board);
		board.setTotalCount(totalCount);
		List<Board> boardList = boardService.select(board);
		
		mv.addObject("list", boardList);
		mv.addObject("paging", board);
		mv.addObject("listUrl", boardInfo.getListUrl());
		mv.addObject("viewUrl", boardInfo.getViewUrl());
		mv.addObject("writeUrl", boardInfo.getWriteUrl());
		
		mv.setViewName(boardInfo.getListViewName());
		return mv;
	}
	/**
	 * 공지사항 글쓰기 화면
	 * @param mv
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/{name}/write")
	public ModelAndView getWriteNoticeView(ModelAndView mv, 
			HttpServletRequest request,
			@PathVariable(value="name", required=true)String name) {
		
		BoardInfo boardInfo = BoardInfo.init().get(name);
		final String currentUrl = boardInfo.getCurrentUrl();

		mv.addObject("opengraph-api", Config.OPENGRAPH_API);
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", boardInfo.getTitle());
		mv.addObject("user", getUser());
		mv.addObject("current", request.getServletPath());
		mv.addObject("listUrl", request.getContextPath() + boardInfo.getListUrl());
		mv.addObject("authUrl", boardInfo.getAuthUrl());
		mv.addObject("boardType", boardInfo.getType());
		mv.setViewName(boardInfo.getWriteViewName());
		return mv;
	}
	/**
	 * 공지사항 상세보기
	 * @param request
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/{name}/view/{id}")
	public ModelAndView getDetailNoticeView(HttpServletRequest request,
			ModelAndView mv,
			@PathVariable(value="id", required = true)Integer id,
			@PathVariable(value="name", required=true)String name) {
		BoardInfo boardInfo = BoardInfo.init().get(name);
		
		boolean isLogined = isLoginedUser(request);
		if(isLogined) {
			UserVO user = getUser();
			mv.addObject("user", user);
		}
		final String currentUrl = boardInfo.getCurrentUrl();
		mv.addObject("curMenu", getCurMenus(currentUrl));
		mv.addObject("title", boardInfo.getTitle());
		
		Board board= boardService.selectOne(Board.newInstance(id));
		board.setViewCount(board.getViewCount() + 1);
		boardService.update(board);
		List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
		List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
		
		Reply reply = new Reply();
		reply.setBoardId(board.getId());
		List<Reply> replyList = replyService.select(reply);
		
		mv.addObject("replyList", replyList);
		mv.addObject("listUrl", request.getContextPath() +boardInfo.getListUrl());
		mv.addObject("edit_url", request.getContextPath()+boardInfo.getEditUrl());
		mv.addObject("del_url", request.getContextPath()+boardInfo.getDelUrl());
		mv.addObject("fileList", fileList);
		mv.addObject("photoList", photoList);
		mv.addObject("board", board);
		mv.setViewName(boardInfo.getDetailViewName());
		return mv;
	}
	
	/**
	 * 공지사항 수정하기 화면
	 * 
	 * @param mv
	 * @param id
	 * @return
	 */
	@RequestMapping(value="/{name}/edit/{id}")
	public ModelAndView getNoticeEditView(ModelAndView mv,
			HttpServletRequest request,
			@PathVariable(value="id", required = true)Integer id,
			@PathVariable(value="name", required=true)String name) {
		BoardInfo boardInfo = BoardInfo.init().get(name);
		if(isLoginedUser(request)) {
			UserVO user = getUser();
			mv.addObject("user", user);
			
			final String currentUrl = boardInfo.getCurrentUrl();
			mv.addObject("curMenu", getCurMenus(currentUrl));
			mv.addObject("title", boardInfo.getTitle());
			
			Board board= boardService.selectOne(Board.newInstance(id));
			
			if(user.getId() == board.getWriter()) {
				List<FileInfo> fileList = fileInfoService.select(FileInfo.newInstance(id));
				List<PhotoInfo> photoList = photoInfoService.select(PhotoInfo.newInstance(id));
				
				mv.addObject("fileList", fileList);
				mv.addObject("photoList", photoList);
				mv.addObject("board", board);
				mv.addObject("detailUrl", currentUrl+"/view/"+board.getId());
				mv.setViewName(boardInfo.getEditViewName());	
			}else {
				mv.setViewName("redirect:/member/login");
			}			
		}else {
			mv.setViewName("redirect:/member/login");
		}
		return mv;
	}
}