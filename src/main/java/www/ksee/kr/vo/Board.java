package www.ksee.kr.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import org.springframework.data.annotation.Id;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class Board extends Paging{
	public static final int TYPE_NOTICE = 1;
	public static final int TYPE_NEWS = 2;
	public static final int TYPE_MEMBER = 3;
	public static final int TYPE_SPEAKER = 4;
	public static final int TYPE_FREE = 5;
	
	public static final int TYPE_GROUP = 7;
	public static final int PAGE_SIZE_NORMAL = 10;
	public static final int PAGE_SIZE_CARD = 9;
	public static Board newInstance(int id) {
		Board board = new Board();
		board.setId(id);
		return board;
	}
	int id;
	String title;
	String content;
	Date wdate;
	Date udate;
	int writer;
	int boardType;
	String writerName;
	int fileCnt;
	int pictureCnt;
	int viewCount;
	String boardName;
}
