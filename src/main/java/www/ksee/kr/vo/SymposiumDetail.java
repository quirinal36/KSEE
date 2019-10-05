package www.ksee.kr.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class SymposiumDetail {
	int id;
	int writer;
	int symposiumId;
	int stype;
	String lang;
	String content;
	String username;
	String typeTitle;
	String sympTitle;
	
	public String getStrStype() {
		return String.valueOf(this.stype);
	}
}
