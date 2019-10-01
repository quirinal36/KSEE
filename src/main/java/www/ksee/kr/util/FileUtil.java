package www.ksee.kr.util;

import java.io.File;

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
}
