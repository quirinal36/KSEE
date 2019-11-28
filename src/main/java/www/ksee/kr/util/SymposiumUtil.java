package www.ksee.kr.util;

import java.io.File;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import www.ksee.kr.service.SymposiumDetailService;
import www.ksee.kr.service.SymposiumService;
import www.ksee.kr.vo.PhotoInfo;
import www.ksee.kr.vo.Symposium;
import www.ksee.kr.vo.SymposiumDetail;
import www.ksee.kr.vo.SymposiumTypes;

public class SymposiumUtil {
	
	public Symposium insert(SymposiumService service, Symposium symposium) {
		service.insert(symposium);
		return symposium;
	}
	public int update(SymposiumService service, Symposium symposium) {
		return service.update(symposium);
	}
	public List<Symposium> search(SymposiumService service, Symposium symposium){
		if(symposium.getPageNo() == 0) {
			symposium.setPageNo(1);
		}
		int total = service.count(symposium);
		symposium.setPageSize(10);
		symposium.setTotalCount(total);
		
		List<Symposium> result = new ArrayList<Symposium>();
		result = service.select(symposium);
		
		return result;
	}
	
	public Symposium selectOne(SymposiumService service, Integer id) {
		Symposium param = new Symposium();
		param.setId(id);
		Symposium result = service.selectOne(param);
		return result;
	}
	
	public List<SymposiumTypes> getSymposiumDetailTypes(SymposiumService service){
		List<SymposiumTypes> types = service.selectSymposiumTypes();
		return types;
	}
	
	public SymposiumDetail getSymposiumDetail(SymposiumDetailService service, SymposiumDetail detail) {
		return service.selectOne(detail);
	}
	
	public List<SymposiumDetail> getSymposiumDetails(SymposiumDetailService service, SymposiumDetail detail) {
		return service.select(detail);
	}
	
	public String getSymposiumTitle(SymposiumDetailService service, SymposiumDetail detail) {
		return service.selectSymposiumTitle(detail);
	}
	public String getTypeTitle(SymposiumDetailService service, SymposiumDetail detail) {
		return service.selectTypeTitle(detail);
	}
	public int deleteSymposiumDetail(SymposiumDetailService service, SymposiumDetail detail) {
		return service.delete(detail);
	}
	public int updateDetail(SymposiumDetailService service, SymposiumDetail detail) {
		return service.update(detail);
	}
	public int insertDetail(SymposiumDetailService service, SymposiumDetail detail) {
		return service.insert(detail);
	}
	/**
	 * 원래 있던 Photo 중에 삭제해야할게 있으면 삭제한뒤,
	 * 지금 들어온 Photo 들의 symposiumDetailId 를 update 한다.
	 * 
	 * @param service
	 * @param photos
	 * @param detail
	 * @return
	 */
	public int updatePhoto(SymposiumDetailService service, List<PhotoInfo>photos, SymposiumDetail detail) {
		List<PhotoInfo> dPhotos = selectPhotos(service, detail);
		Map<Integer, PhotoInfo> editPhotoMap = photos.stream().collect(Collectors.toMap(PhotoInfo::getId, item->item));
		
		// 삭제할 파일을 골라낸다.
		List<PhotoInfo> deletePhotos = new ArrayList<PhotoInfo>();
		Iterator<PhotoInfo> iter = dPhotos.iterator();
		while(iter.hasNext()) {
			PhotoInfo item = iter.next();
			if(!editPhotoMap.containsKey(item.getId()) ) {
				deletePhotos.add(item);
			}
		}
		
		if(deletePhotos.size() > 0) {
			// 삭제할 파일은 삭제한다.
			String srcPath = new FileUtil().makeUserPath();
			int deleteResult = service.deletePhotos(deletePhotos);
			if(deleteResult > 0) {
				Iterator<PhotoInfo> dIter = deletePhotos.iterator();
				while(dIter.hasNext()) {
					PhotoInfo photoInfo = dIter.next();
					File photo = new File(srcPath + File.separator + photoInfo.getNewFilename());
					photo.delete();
				}
			}
		}
		return service.updatePhotos(photos);
	}
	public List<PhotoInfo> selectPhotos(SymposiumDetailService service, SymposiumDetail detail) {
		return service.selectPhotos(detail);
	}
}
