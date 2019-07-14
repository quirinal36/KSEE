package www.ksee.kr.vo;

import java.util.Date;
import java.util.Iterator;
import java.util.Map;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

public class UserVO {
	public static final String IDX_KEY = "idx";
	public static final String MID_KEY = "mId";
	public static final String MNAME_KEY = "mName";
	public static final String DEPARTMENT_ID_KEY = "department_id";
	public static final String DEPARTMENT_NAME_KEY = "department_name";
	public static final String TEAM_ID_KEY = "team_id";
	public static final String TEAM_NAME_KEY = "team_name";
	public static final String JOB_CODE_KEY = "job_code";
	public static final String JOB_NAME_KEY = "job_name";
	public static final String JOB_SPOT_KEY = "job_spot";
	public static final String JOB_DETAIL_KEY = "job_detail";
	public static final String JOB_RANK_KEY = "job_rank";
	public static final String EMAIL_KEY = "email";
	public static final String ULEVEL_KEY = "uLevel";
	public static final String SIGN_DATE_KEY = "signDate";
			
	private int idx;
	private String mId;
	private String mName;
	private String department_id;
	private String department_name;
	private String team_id;
	private String team_name;
	private String job_code;
	private String job_name;
	private String job_spot;
	private String job_detail;
	private String job_rank;
	private String email;
	private String uLevel;
	private Date signDate;
	
	public UserVO () {
		
	}
	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getmName() {
		return mName;
	}

	public void setmName(String mName) {
		this.mName = mName;
	}

	public String getDepartment_id() {
		return department_id;
	}

	public void setDepartment_id(String department_id) {
		this.department_id = department_id;
	}

	public String getDepartment_name() {
		return department_name;
	}

	public void setDepartment_name(String department_name) {
		this.department_name = department_name;
	}

	public String getTeam_id() {
		return team_id;
	}

	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}

	public String getTeam_name() {
		return team_name;
	}

	public void setTeam_name(String team_name) {
		this.team_name = team_name;
	}

	public String getJob_code() {
		return job_code;
	}

	public void setJob_code(String job_code) {
		this.job_code = job_code;
	}

	public String getJob_name() {
		return job_name;
	}

	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}

	public String getJob_spot() {
		return job_spot;
	}

	public void setJob_spot(String job_spot) {
		this.job_spot = job_spot;
	}

	public String getJob_detail() {
		return job_detail;
	}

	public void setJob_detail(String job_detail) {
		this.job_detail = job_detail;
	}

	public String getJob_rank() {
		return job_rank;
	}

	public void setJob_rank(String job_rank) {
		this.job_rank = job_rank;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getuLevel() {
		return uLevel;
	}

	public void setuLevel(String uLevel) {
		this.uLevel = uLevel;
	}

	public Date getSignDate() {
		return signDate;
	}

	public void setSignDate(Date signDate) {
		this.signDate = signDate;
	}
	public static UserVO parse(Map<String, String> map) {
		UserVO user = new UserVO();
		Iterator<String> keys = map.keySet().iterator();
		while(keys.hasNext()) {
			String key = keys.next();
			String value = map.get(key);
			switch(key) {
			case IDX_KEY:
				user.setIdx(Integer.parseInt(value));
				break;
			case MID_KEY:
				user.setmId(value);
				break;
			case MNAME_KEY:
				user.setmName(value);
				break;
			case DEPARTMENT_ID_KEY:
				user.setDepartment_id(value);
				break;
			case DEPARTMENT_NAME_KEY:
				user.setDepartment_name(value);
				break;
			case TEAM_ID_KEY:
				user.setTeam_id(value);
				break;
			case TEAM_NAME_KEY:
				user.setTeam_name(value);
				break;
			case JOB_CODE_KEY:
				user.setJob_code(value);
				break;
			case JOB_NAME_KEY:
				user.setJob_name(value);
				break;
			case JOB_SPOT_KEY:
				user.setJob_spot(value);
				break;
			case JOB_DETAIL_KEY:
				user.setJob_detail(value);
				break;
			case JOB_RANK_KEY:
				user.setJob_rank(value);
				break;
			case EMAIL_KEY:
				user.setEmail(value);
				break;
			case ULEVEL_KEY:
				user.setuLevel(value);
				break;
			}
		}
		return user;
	}
	@Override
	public String toString() {
		return ToStringBuilder.reflectionToString(this, ToStringStyle.JSON_STYLE);
	}
}
