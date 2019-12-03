package www.ksee.kr.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Iterator;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor.HSSFColorPredefined;
import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.HorizontalAlignment;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

import lombok.Getter;
import www.ksee.kr.vo.ApplyVO;
import www.ksee.kr.vo.UserVO;

@Getter
public class ExcelMaker {
	Workbook wb;
	Sheet sheet;
	
	public ExcelMaker() {
		
	}
	
	public void makeSheet(final String title) {
		this.wb = new HSSFWorkbook();
		this.sheet = this.wb.createSheet(title);		
	}
	private CellStyle getBodyStyle() {
		// 데이터용 경계 스타일 테두리
		CellStyle bodyStyle = this.wb.createCellStyle();
		bodyStyle.setBorderTop(BorderStyle.THIN);
		bodyStyle.setBorderBottom(BorderStyle.THIN);
		bodyStyle.setBorderLeft(BorderStyle.THIN);
		bodyStyle.setBorderRight(BorderStyle.THIN);
		return bodyStyle;
	}
	private CellStyle getHeadStyle() {		
		// table header style
		CellStyle headStyle = this.wb.createCellStyle();
		// 가는 경계선
		headStyle.setBorderTop(BorderStyle.THIN);
		headStyle.setBorderBottom(BorderStyle.THICK);
		headStyle.setBorderLeft(BorderStyle.THIN);
		headStyle.setBorderRight(BorderStyle.THIN);
		
		// 베경색
		headStyle.setFillForegroundColor(HSSFColorPredefined.GREY_25_PERCENT.getIndex());
		headStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
		
		// 데이터 가운데정렬
		headStyle.setAlignment(HorizontalAlignment.CENTER);
		
		return headStyle;
	}
	
	public void makeHead(final String[] headers) {
		CellStyle headStyle = getHeadStyle();
		int rowNo = this.sheet.getLastRowNum();
		Row row = this.sheet.createRow(++rowNo);
		for(int i = 0; i<headers.length; i++) {
			Cell cell = row.createCell(i);
			cell.setCellStyle(headStyle);
			cell.setCellValue(headers[i]);
		}
	}
	
	public void makeApplicationBody(List<ApplyVO> applyList, final String[] headers) {
		CellStyle bodyStyle = getBodyStyle();
		Iterator<ApplyVO> iter = applyList.iterator();
		while(iter.hasNext()) {
			ApplyVO item = iter.next();
			int rowNo = this.sheet.getLastRowNum();
			Row row = this.sheet.createRow(++rowNo);
			
			for(int i = 0; i<headers.length; i++) {
				Cell cell = row.createCell(i);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(getApplyItem(item, i));
			}
		}
	}
	
	public void makeUserBody(List<UserVO> userList, final String[] headers) {
		CellStyle bodyStyle = getBodyStyle();
		Iterator<UserVO> iter = userList.iterator();
		while(iter.hasNext()) {
			UserVO item = iter.next();
			int rowNo = this.sheet.getLastRowNum();
			Row row = this.sheet.createRow(++rowNo);
			
			for(int i = 0; i<headers.length; i++) {
				Cell cell = row.createCell(i);
				cell.setCellStyle(bodyStyle);
				cell.setCellValue(getUserItem(item, i));
			}
		}
	}
	
	private String getUserItem(UserVO user, int i) {
		switch(i) {
		case 0:
			return String.valueOf(user.getId());
		case 1:
			return user.getRole_name_kr();
		case 2:
			return user.getUsername();
		case 3:
			return user.getClassification();
		case 4:
			return user.getLevel();
		case 5:
			if(user.getEmail() != null && user.getEmail().length()>0) {
				return user.getEmail() +"@" + user.getDomain();
			}
		case 6:
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  
			return dateFormat.format(user.getMdate());
		}
		return null;
	}
	private String getApplyItem(ApplyVO item, int i) {
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");  

		switch(i) {
		case 0:
			return dateFormat.format(item.getMdate());
		case 1:
			if(item.getMemberType() == 2) {
				return "일반";	
			}else if(item.getMemberType() == 3) {
				return "기업";
			}else if(item.getMemberType() == 4) {
				return "학생";
			}
			break;
		case 2:
			if(item.getIsSpeaker() == 1) {
				return "O";
			}else if(item.getIsSpeaker() == 2){
				return "X";
			}
			break;
		case 3:
			if(item.getNational() == 1) {
				return "대한민국";
			}else if(item.getNational() == 2) {
				return "중국";
			}else if(item.getNational() == 3) {
				return "일본";
			}
			break;
		case 4:
			return item.getUsername();
		case 5:
			return item.getClassification();
		case 6:
			return item.getLevel();
		case 7:
			return item.getTelephone();
		case 8:
			if(item.getEmail() != null && item.getEmail().length()>0) {
				return item.getEmail() +"@" + item.getDomain();
			}
		}
		return null;
	}
}
