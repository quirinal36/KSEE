package www.ksee.kr.vo;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PhotoInfo implements Cloneable{
	public static PhotoInfo newInstance(int boardId) {
		PhotoInfo result = new PhotoInfo();
		result.setBoardId(boardId);
		return result;
	}
	
	int id;
	int uploader;
	Date wdate;
	String url;
	String name;
	String thumbnailFilename;
	String newFilename;
	int size;
	int thumbnailSize;
	String thumbnailUrl;
	String contentType;
	String search;
	int orderById;
	int boardId;
	
	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
}