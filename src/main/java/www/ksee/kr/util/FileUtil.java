package www.ksee.kr.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import www.ksee.kr.vo.FileInfo;
import www.ksee.kr.vo.PhotoInfo;

public class FileUtil {

	/**
	 * 사진 파일을 저장할 디렉터리 가져오기
	 * 
	 * @param userId
	 * @return
	 */
	public String makeUserPath() {
		String path = System.getProperty("user.dir");
		StringBuilder builder = new StringBuilder()
				.append(path.substring(0, path.lastIndexOf(File.separator)))
				.append(File.separator).append("webapps").append(File.separator)
				.append("repository").append(File.separator)
				.append("upload").append(File.separator);
		
		File file = new File(builder.toString());
		file.mkdirs();
		return file.getAbsolutePath();
	}
	
	public List<PhotoInfo> parsePhotoInfo(String[] input, int boardId) {
		List<PhotoInfo> photoList = new ArrayList<PhotoInfo>();
		if(input.length>0) {
			for(String pictureId : input) {
				PhotoInfo photoInfo = new PhotoInfo();
				photoInfo.setId(Integer.parseInt(pictureId));
				photoInfo.setBoardId(boardId);
				photoList.add(photoInfo);
			}
		}
		return photoList;
	}
	public List<FileInfo> parseFileInfo(String[] input, int boardId) {
		List<FileInfo> fileList = new ArrayList<FileInfo>();
		for(String fileId : input) {
			FileInfo photoInfo = new FileInfo();
			photoInfo.setId(Integer.parseInt(fileId));
			photoInfo.setBoardId(boardId);
			fileList.add(photoInfo);
		}
		return fileList;
	}
}
