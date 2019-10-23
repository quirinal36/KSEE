package www.ksee.kr.vo;

import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
public class ApplyVO extends Paging{
	int id;
	int sympId;
	int memberType;
	int isSpeaker;
	int national;
	String username;
	String classification;
	String level;
	String telephone;
	String email;
	String domain;
	int fileId;
	Date mdate;
	int status;
	
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}
