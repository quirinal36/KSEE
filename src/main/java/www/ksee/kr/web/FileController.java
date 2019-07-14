package www.ksee.kr.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.logging.Logger;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.imgscalr.Scalr;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import www.ksee.kr.service.PhotoInfoService;
import www.ksee.kr.vo.PhotoInfo;

@Controller
public class FileController {
	private final Logger logger = Logger.getLogger(this.getClass().getSimpleName());
	@Resource(name="photoInfoService")
	protected PhotoInfoService photoInfoService;
	
	@ResponseBody 
	@RequestMapping(value = "/upload", method = {RequestMethod.GET, RequestMethod.POST})
    public String upload2(MultipartHttpServletRequest request, HttpServletResponse response) {
		JSONObject json = new JSONObject();
		
		Iterator<String> itr = request.getFileNames();
        MultipartFile mpf;
        List<PhotoInfo> list = new LinkedList<>();
        while (itr.hasNext()) {
            mpf = request.getFile(itr.next());
            logger.info("Uploading {}" + mpf.getOriginalFilename());
            String newFilenameBase = UUID.randomUUID().toString();
            String originalFileExtension = mpf.getOriginalFilename().substring(mpf.getOriginalFilename().lastIndexOf("."));
            String newFilename = newFilenameBase + originalFileExtension;
            
            String srcPath = request.getSession().getServletContext().getRealPath("/upload");
            logger.info("srcPath: " + srcPath);
			String contentType = mpf.getContentType();
			
			File newFile = new File(srcPath + "/" + newFilename);
            try {
                mpf.transferTo(newFile);
                
                BufferedImage thumbnail = Scalr.resize(ImageIO.read(newFile), 290);
                String thumbnailFilename = newFilenameBase + "-thumbnail.png";
                File thumbnailFile = new File(srcPath + "/" + thumbnailFilename);
                ImageIO.write(thumbnail, "png", thumbnailFile);
                
                PhotoInfo photo = new PhotoInfo();
                photo.setName(mpf.getOriginalFilename());
                photo.setThumbnailFilename(thumbnailFilename);
                photo.setNewFilename(newFilename);
                photo.setSize((int)mpf.getSize());
                photo.setThumbnailSize((int)thumbnailFile.length());
                photo.setContentType(contentType);
                
                int result = photoInfoService.insert(photo);
                json.put("url", "/picture/"+photo.getId());
                json.put("result", result);
                
                photo.setUrl(getWebappDir(request) +"/picture/"+photo.getId());
                photo.setThumbnailUrl(getWebappDir(request) + "/thumbnail/"+photo.getId());
                
                list.add(photo);
            } catch(IOException e) {
                logger.info("Could not upload file "+mpf.getOriginalFilename() + e.getLocalizedMessage());
            }
        }
        Map<String, Object> files = new HashMap<>();
        files.put("files", list);
        
        
        return json.toString();
	}
	public String getWebappDir(HttpServletRequest request) {
		return request.getContextPath();
	}
	@RequestMapping(value = "/picture/{id}", method = RequestMethod.GET)
    public void picture(HttpServletRequest request,
    		HttpServletResponse response, @PathVariable int id) {
		PhotoInfo param = new PhotoInfo();
		param.setId(id);

        PhotoInfo image = photoInfoService.selectOne(param);
        String srcPath = request.getSession().getServletContext().getRealPath("/upload");
        File imageFile = new File(srcPath+"/"+image.getNewFilename());
        response.setContentType(image.getContentType());
        response.setContentLength(image.getSize());
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.info("Could not show picture "+id +"/" + e.getLocalizedMessage());
        }
    }
	@RequestMapping(value = "/thumbnail/{id}", method = RequestMethod.GET)
    public void thumbnail(HttpServletRequest request,
    		HttpServletResponse response, @PathVariable int id) {
		PhotoInfo param = new PhotoInfo();
		param.setId(id);
		String srcPath = request.getSession().getServletContext().getRealPath("/upload");
		
		PhotoInfo image = photoInfoService.selectOne(param);
        File imageFile = new File(srcPath+"/"+image.getThumbnailFilename());
        response.setContentType(image.getContentType());
        response.setContentLength(image.getSize());
		
//		File imageFile = new File(srcPath + "/90eb2393-ebbc-4766-a30c-4936f60837f8.png");
//		response.setContentType("image/png"); 
//		response.setContentLength(8898);
		
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.info("Could not show picture "+id +"/" + e.getLocalizedMessage());
        }
    }
	
	/***************************************************
	 * URL: /upload  
	 * upload(): receives files
	 * @param request : MultipartHttpServletRequest auto passed
	 * @param response : HttpServletResponse auto passed
	 * @return List<FileMeta> as json format
	 ****************************************************/
	/*
	@RequestMapping(value="/upload/old", method = RequestMethod.POST)
	@ResponseBody
	public synchronized List<FileMeta> upload(MultipartHttpServletRequest request, HttpServletResponse response) {
		logger.info("upload controller~!!");
		List<FileMeta> files = new ArrayList<FileMeta>();
		
		//1. build an iterator
		Iterator<String> itr =  request.getFileNames();
		MultipartFile mpf = null;
		//2. get each file
		while(itr.hasNext()){
			//2.1 get next MultipartFile
			mpf = request.getFile(itr.next()); 
			logger.info(mpf.getOriginalFilename() +" uploaded! "+files.size());
			//2.2 if files > 10 remove the first from the list
			if(files.size() >= 10) files.remove(0);
				// files.pop();
			//2.3 create new fileMeta
			FileMeta fileMeta = new FileMeta();
			fileMeta.setFileName(mpf.getOriginalFilename());
			fileMeta.setFileSize(mpf.getSize()/1024+" Kb");
			fileMeta.setFileType(mpf.getContentType());
			
			String srcPath = request.getSession().getServletContext().getRealPath("/upload");
			final String uploadedFileUri = srcPath + "/" + mpf.getOriginalFilename();
			fileMeta.setFileUri(uploadedFileUri);
			logger.info(fileMeta.getFileUri());
			try {
				fileMeta.setBytes(mpf.getBytes());
				// copy file to local disk 
				FileCopyUtils.copy(mpf.getBytes(), new FileOutputStream(uploadedFileUri));
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			//2.4 add to files
			files.add(fileMeta);
		}
		// result will be like this
		// [{"fileName":"app_engine-85x77.png","fileSize":"8 Kb","fileType":"image/png"},...]
		return files;
	}
	*/
	
	/***************************************************
	 * URL: /rest/controller/get/{value}
	 * get(): get file as an attachment
	 * @param response : passed by the server
	 * @param value : value from the URL
	 * @return void
	 ****************************************************/
	@RequestMapping(value = "/upload/get/{value}", method = RequestMethod.GET)
	public void get(HttpServletResponse response,@PathVariable String value){
		/*
		FileMeta getFile = files.get(Integer.parseInt(value));
		try {      
			response.setContentType(getFile.getFileType());
			response.setHeader("Content-disposition", "attachment; filename=\""+getFile.getFileName()+"\"");
			FileCopyUtils.copy(getFile.getBytes(), response.getOutputStream());
		}catch (IOException e) {
			e.printStackTrace();
		}
		*/
	}
}
