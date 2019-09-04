package www.ksee.kr.vo;

import java.sql.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class PhotoInfo implements Cloneable{
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
	
	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
}