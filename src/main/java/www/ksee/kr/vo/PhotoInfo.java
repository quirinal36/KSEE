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
	private int id;
	private String patientId;
	private String doctor;
	private String uploader;
	private String classification;
	private Date date;
	private String photoUrl;
	private int sync;
	private String comment;
	private String name;
	private String thumbnailFilename;
	private String newFilename;
	private int size;
	private int thumbnailSize;
	private String url;
	private String thumbnailUrl;
	private String contentType;
	private String search;
	private int orderById;
	private String [] photo;
	
	@Override
	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}
}