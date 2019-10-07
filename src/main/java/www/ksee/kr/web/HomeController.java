package www.ksee.kr.web;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.vo.Board;
import www.ksee.kr.vo.Paging;
import www.ksee.kr.vo.Symposium;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController extends KseeController {
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		Board notice = Board.newInstance(0, Board.TYPE_NOTICE);
		notice.setTotalCount(boardService.count(notice));
		List<Board> noticeList = boardService.select(notice);
		mv.addObject("noticeList", noticeList);
		
		Board freeBoard = Board.newInstance(0, Board.TYPE_FREE);
		freeBoard.setTotalCount(boardService.count(freeBoard));
		List<Board> freeBoardList = boardService.select(freeBoard);
		mv.addObject("freeBoardList", freeBoardList);
		
		Board newsBoard = Board.newInstance(0, Board.TYPE_NEWS);
		newsBoard.setTotalCount(boardService.count(newsBoard));
		List<Board> newsBoardList = boardService.select(newsBoard);
		mv.addObject("newsBoardList", newsBoardList);
		
		mv.setViewName("index");
		return mv;
	}
	@RequestMapping(value="/search")
	public ModelAndView getCompanyView(Locale locale, ModelAndView mv,
			Board board) {
		mv.addObject("title", "검색");
		
		List<Integer> boardTypes = new ArrayList<Integer>();
		boardTypes.add(Board.TYPE_NOTICE);
		boardTypes.add(Board.TYPE_NEWS);
		boardTypes.add(Board.TYPE_MEMBER);
		boardTypes.add(Board.TYPE_SPEAKER);
		boardTypes.add(Board.TYPE_FREE);
		
		List<List<Board>> listOfBoardList = new ArrayList<List<Board>>();
		Iterator<Integer> boardTypeIter = boardTypes.iterator();
		while(boardTypeIter.hasNext()) {	
			int boardType = boardTypeIter.next();
			if(board.getPageNo() == 0) {
				board.setPageNo(1);
			}
			board.setPageSize(Paging.PAGE_SIZE_LIST);
			board.setBoardType(boardType);
			int count = boardService.count(board);
			board.setTotalCount(count);
			List<Board> boardList = boardService.select(board);
			listOfBoardList.add(boardList);
		}
		mv.addObject("boardList", listOfBoardList);
		
		List<List<Symposium>> listOfSympList = new ArrayList<List<Symposium>>();
		List<Integer> sympTypes = new ArrayList<Integer>();
		sympTypes.add(Symposium.SYMP_TYPE_DOMESTIC);
		sympTypes.add(Symposium.SYMP_TYPE_INTERNATIONAL);
		Iterator<Integer> sympTypeIter = sympTypes.iterator();
		while(sympTypeIter.hasNext()) {
			Integer sympType = sympTypeIter.next();
			Symposium symposium = new Symposium();
			symposium.setQuery(board.getQuery());
			if(board.getPageNo() == 0) {
				symposium.setPageNo(1);
			}else {
				symposium.setPageNo(board.getPageNo());
			}
			symposium.setSympType(sympType);
			symposium.setPageSize(Paging.PAGE_SIZE_LIST);
			int count = sympService.count(symposium);
			symposium.setTotalCount(count);
			
			List<Symposium> sympList = sympService.select(symposium);
			listOfSympList.add(sympList);
		}
		mv.addObject("sympList", listOfSympList);
		mv.addObject("paging", board);
		
		mv.setViewName("/home");
		return mv;
	}
	@RequestMapping(value = "/company", method = RequestMethod.GET)
	public ModelAndView getCompanyView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("company");
		return mv;
	}
	@RequestMapping(value = "/information", method = RequestMethod.GET)
	public ModelAndView getInformationView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("information");
		return mv;
	}
	@RequestMapping(value = "/notice", method = RequestMethod.GET)
	public ModelAndView getNoticeView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("notice");
		return mv;
	}
	@RequestMapping(value = "/picture", method = RequestMethod.GET)
	public ModelAndView getPictureView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("picture");
		return mv;
	}
	
	@RequestMapping(value="/links")
	public ModelAndView getLinksView(ModelAndView mv) {
		mv.setViewName("/links");
		return mv;
	}
	@RequestMapping(value="/error_400")
	public ModelAndView getError404View(ModelAndView mv) {
		mv.setViewName("/error/404");
		return mv;
	}
	@RequestMapping(value="/error_500")
	public ModelAndView getError503View(ModelAndView mv) {
		mv.setViewName("/error/503");
		return mv;
	}
	@RequestMapping(value="/inc/head_admin")
	public ModelAndView getAdminHeadView(ModelAndView mv) {
		mv.setViewName("/inc/head_admin");
		return mv;
	}
}
