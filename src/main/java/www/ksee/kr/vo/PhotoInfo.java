package www.ksee.kr.vo;

import java.sql.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class PhotoInfo implements Cloneable{
	int id;
	String patientId;
	String doctor;
	String uploader;
	String classification;
	Date date;
	String photoUrl;
	int sync;
	String comment;
	String name;
	String thumbnailFilename;
	String newFilename;
	int size;
	int thumbnailSize;
	String url;
	String thumbnailUrl;
	String contentType;
	String search;
	private int orderById;
	String [] photo;
	
	public String[] getPhoto() {
		return photo;
	}

	public void setPhoto(String[] photo) {
		this.photo = photo;
	}

	public PhotoInfo() {
		
	}
	
	public int getId() {
		return id;
	}



	public void setId(int id) {
		this.id = id;
	}



	public String getPatientId() {
		return patientId;
	}



	public void setPatientId(String patientId) {
		this.patientId = patientId;
	}



	public String getDoctor() {
		return doctor;
	}



	public void setDoctor(String doctor) {
		this.doctor = doctor;
	}



	public String getUploader() {
		return uploader;
	}



	public void setUploader(String uploader) {
		this.uploader = uploader;
	}



	public String getClassification() {
		return classification;
	}



	public void setClassification(String classification) {
		this.classification = classification;
	}



	public Date getDate() {
		return date;
	}



	public void setDate(Date date) {
		this.date = date;
	}



	public String getPhotoUrl() {
		return photoUrl;
	}



	public void setPhotoUrl(String photoUrl) {
		this.photoUrl = photoUrl;
	}



	public int getSync() {
		return sync;
	}



	public void setSync(int sync) {
		this.sync = sync;
	}



	public String getComment() {
		return comment;
	}



	public void setComment(String comment) {
		this.comment = comment;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public String getThumbnailFilename() {
		return thumbnailFilename;
	}



	public void setThumbnailFilename(String thumbnailFilename) {
		this.thumbnailFilename = thumbnailFilename;
	}



	public String getNewFilename() {
		return newFilename;
	}



	public void setNewFilename(String newFilename) {
		this.newFilename = newFilename;
	}



	public int getSize() {
		return size;
	}



	public void setSize(int size) {
		this.size = size;
	}



	public int getThumbnailSize() {
		return thumbnailSize;
	}



	public void setThumbnailSize(int thumbnailSize) {
		this.thumbnailSize = thumbnailSize;
	}



	public String getUrl() {
		return url;
	}



	public void setUrl(String url) {
		this.url = url;
	}



	public String getThumbnailUrl() {
		return thumbnailUrl;
	}



	public void setThumbnailUrl(String thumbnailUrl) {
		this.thumbnailUrl = thumbnailUrl;
	}



	public String getContentType() {
		return contentType;
	}



	public void setContentType(String contentType) {
		this.contentType = contentType;
	}



	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}

	public String getSearch() {
		return search;
	}

	public void setSearch(String search) {
		this.search = search;
	}

	public int getOrderById() {
		return orderById;
	}

	public void setOrderById(int orderById) {
		this.orderById = orderById;
	}

	@Override
	public Object clone() throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		return super.clone();
	}
	
}