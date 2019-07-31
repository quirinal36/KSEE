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
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import www.ksee.kr.service.FileMetaService;
import www.ksee.kr.service.PhotoInfoService;
import www.ksee.kr.vo.FileMeta;
import www.ksee.kr.vo.PhotoInfo;

@Controller
public class FileController {
	private final Logger logger = Logger.getLogger(this.getClass().getSimpleName());
	@Resource(name="photoInfoService")
	protected PhotoInfoService photoInfoService;
	@Resource(name="fileMetaService")
	protected FileMetaService fileMetaService;
	
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
		
        try {
            InputStream is = new FileInputStream(imageFile);
            IOUtils.copy(is, response.getOutputStream());
        } catch(IOException e) {
            logger.info("Could not show picture "+id +"/" + e.getLocalizedMessage());
        }
    }
	
	
	
	/***************************************************
	 * URL: /rest/controller/get/{value}
	 * get(): get file as an attachment
	 * @param response : passed by the server
	 * @param value : value from the URL
	 * @return void
	 ****************************************************/
	@RequestMapping(value = "/upload/get/{value}", method = RequestMethod.GET)
	public void get(HttpServletResponse response, @PathVariable String value){
		FileMeta param = FileMeta.newInstance(Integer.parseInt(value));
		FileMeta getFile = fileMetaService.selectOne(param);
		
		try {      
			response.setContentType(getFile.getFileType());
			response.setContentLength(getFile.getSize());
			response.setHeader("Content-disposition", "attachment; filename=\""+getFile.getFileName()+"\"");
			InputStream is = new FileInputStream(new File(getFile.getUrl()));
			FileCopyUtils.copy(is, response.getOutputStream());
		}catch (IOException e) {
			e.printStackTrace();
		}
	}
}
