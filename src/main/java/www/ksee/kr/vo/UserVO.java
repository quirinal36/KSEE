package www.ksee.kr.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class UserVO {
	int id;
	int user_role;
	String login;
	String password;
	String username;
	String phone;
	String email;
	String domain;
	String classification;
	String level;
	String address;
	String addressDetail;
	String role_name;
	String telephone;
	
	public UserVO () {
		
	}
	
}
