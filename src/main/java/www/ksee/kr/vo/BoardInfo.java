package www.ksee.kr.vo;

import java.util.HashMap;
import java.util.Map;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BoardInfo {
	String currentUrl;
	String title;
	int type;
	String listUrl;
	String viewUrl;
	String writeUrl;
	String editUrl;
	String delUrl;
	String authUrl;
	String listViewName;
	String writeViewName;
	String detailViewName;
	String editViewName;
	
	public static Map<String, BoardInfo> init(){
		Map<String, BoardInfo> map = new HashMap<String, BoardInfo>();
		
		BoardInfo notice = new BoardInfo();
		notice.setCurrentUrl("/group/notice");
		notice.setTitle("공지사항");
		notice.setType(Board.TYPE_NOTICE);
		notice.setListUrl("/group/notice/");
		notice.setViewUrl("/group/notice/view/");
		notice.setWriteUrl("/group/notice/write/");
		notice.setEditUrl("/group/notice/edit/");
		notice.setDelUrl("/board/delete/");
		notice.setAuthUrl("/member/isAdmin");
		notice.setListViewName("/group/list");
		notice.setWriteViewName("/board/write");
		notice.setDetailViewName("/board/detail");
		notice.setEditViewName("/board/edit");
		map.put("notice", notice);
		
		BoardInfo news = new BoardInfo();
		news.setCurrentUrl("/group/news");
		news.setTitle("관련소식");
		news.setType(Board.TYPE_NEWS);
		news.setListUrl("/group/news/");
		news.setViewUrl("/group/news/view/");
		news.setWriteUrl("/group/news/write/");
		news.setEditUrl("/group/news/edit/");
		news.setDelUrl("/board/delete/");
		news.setAuthUrl("/member/isLogin");
		news.setListViewName("/group/list");
		news.setWriteViewName("/board/write");
		news.setDetailViewName("/board/detail");
		news.setEditViewName("/board/edit");
		map.put("news", news);
		
		BoardInfo member = new BoardInfo();
		member.setCurrentUrl("/group/member");
		member.setTitle("회원동정");
		member.setType(Board.TYPE_MEMBER);
		member.setListUrl("/group/member/");
		member.setViewUrl("/group/member/view/");
		member.setWriteUrl("/group/member/write/");
		member.setEditUrl("/group/member/edit/");
		member.setDelUrl("/board/delete/");
		member.setAuthUrl("/member/isLogin");
		member.setListViewName("/group/list");
		member.setWriteViewName("/board/write");
		member.setDetailViewName("/board/detail");
		member.setEditViewName("/board/edit");
		map.put("member", member);
		
		BoardInfo speaker = new BoardInfo();
		speaker.setCurrentUrl("/group/speaker");
		speaker.setTitle("연사제안");
		speaker.setType(Board.TYPE_SPEAKER);
		speaker.setListUrl("/group/speaker/");
		speaker.setViewUrl("/group/speaker/view/");
		speaker.setWriteUrl("/group/speaker/write/");
		speaker.setEditUrl("/group/speaker/edit/");
		speaker.setDelUrl("/board/delete/");
		speaker.setAuthUrl("/member/isLogin");
		speaker.setListViewName("/community/board");
		speaker.setWriteViewName("/board/write");
		speaker.setDetailViewName("/board/detail");
		speaker.setEditViewName("/board/edit");
		map.put("speaker", speaker);
		
		BoardInfo free = new BoardInfo();
		free.setCurrentUrl("/group/free");
		free.setTitle("자유게시판");
		free.setType(Board.TYPE_FREE);
		free.setListUrl("/group/free/");
		free.setViewUrl("/group/free/view/");
		free.setWriteUrl("/group/free/write/");
		free.setEditUrl("/group/free/edit/");
		free.setDelUrl("/board/delete/");
		free.setAuthUrl("/member/isLogin");
		free.setListViewName("/community/board");
		free.setWriteViewName("/board/write");
		free.setDetailViewName("/board/detail");
		free.setEditViewName("/board/edit");
		map.put("free", free);
		return map;
	}
}
