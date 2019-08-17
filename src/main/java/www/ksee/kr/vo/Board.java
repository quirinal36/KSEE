package www.ksee.kr.vo;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;

import org.springframework.data.annotation.Id;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor(access=AccessLevel.PROTECTED)
@ToString
@Getter
@Setter
public class Board {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name="id")
	private int id;
	
	@Column(name="title", nullable = false)
	private String title;
	
	@Column(name="content", nullable = false)
	private String content;
	
	@Column(name="wdate", nullable = false)
	private Date wdate;
	
	@Column(name="udate", nullable = false)
	private Date udate;
}
