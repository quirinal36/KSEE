package www.ksee.kr.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FileInfo {
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
