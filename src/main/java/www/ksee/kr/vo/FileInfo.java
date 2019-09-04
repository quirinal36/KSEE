package www.ksee.kr.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FileInfo {
	public static FileInfo newInstance(int boardId) {
		FileInfo result = new FileInfo();
		result.setBoardId(boardId);
		return result;
	}
	int id;
	int uploader;
	int boardId;
	Date wdate;
	String url;
	String name;
	String newFilename;
	int size;
	String contentType;
	Date udate;
}
