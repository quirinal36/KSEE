package www.ksee.kr.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import www.ksee.kr.vo.Board;

/**
 * 챗봇 전용 게시판 DAO.
 * chatbot_board_sql (파라미터 바인딩 #{}) 매퍼를 사용하여 안전하게 게시글을 쓴다.
 */
@Repository("ChatbotBoardDAO")
public class ChatbotBoardDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;

	private final String namespace = "chatbot_board_sql";

	/** 게시글 작성. useGeneratedKeys 로 input.id 가 채워진다. */
	public int insertPost(Board input) {
		return sqlSession.insert(namespace + ".insert", input);
	}

	/** 게시글 수정 (title/title_en/content 중 null 이 아닌 항목만 반영). */
	public int updatePost(Board input) {
		return sqlSession.update(namespace + ".update", input);
	}

	/** 게시글 삭제 (id 기준). */
	public int deletePost(Board input) {
		return sqlSession.delete(namespace + ".delete", input);
	}
}
