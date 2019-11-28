package www.ksee.kr.web;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Optional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.Config;
import www.ksee.kr.service.PopupService;
import www.ksee.kr.vo.Board;
import www.ksee.kr.vo.Paging;
import www.ksee.kr.vo.Popup;
import www.ksee.kr.vo.Symposium;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController extends KseeController {
	@Autowired
	PopupService popupService;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public ModelAndView home(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		Popup pp = new Popup();
		pp.setToday(LocalDate.now().toString());
		pp.setLang(locale.getLanguage());
		
		List<Popup> popupList = popupService.select(pp);
		mv.addObject("popups", popupList);
		
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
		mv.addObject("today", LocalDate.now().toString());
		mv.addObject("locale", locale);
		
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
	
	@RequestMapping(value="/term/privacy")
	public ModelAndView getPrivacyView(ModelAndView mv) {
		mv.setViewName("/term/privacy");
		return mv;
	}
	@RequestMapping(value="/term/email")
	public ModelAndView getEmailTermView(ModelAndView mv) {
		mv.setViewName("/term/email");
		return mv;
	}
	/**
	 * JAVASCRIPT i18n 을 위함
	 * properties 파일을 읽어와 List 형태로 돌려준다.
	 * 
	 * @param propertiesName
	 * @param response
	 * @param locale
	 */
	@RequestMapping(value="/properties/{propertiesName}")
	public void getProperties(@PathVariable("propertiesName")Optional<String> propertiesName, 
			HttpServletResponse response, Locale locale) {
		response.setCharacterEncoding(Config.ENCODING);
		
		if(propertiesName.isPresent()) {
			try {
				List<String> readLines = FileUtils.readLines(ResourceUtils.getFile("classpath:messages/" + propertiesName.get() + ".properties"), Config.ENCODING);
				OutputStream outputStream = response.getOutputStream();
				IOUtils.writeLines(readLines, null, outputStream, Config.ENCODING);
			} catch (FileNotFoundException e) {
				logger.info(e.getLocalizedMessage());
			} catch (IOException e) {
				logger.info(e.getLocalizedMessage());
			}
		}
	}
}
