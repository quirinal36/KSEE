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

@ToString
@Getter
@Setter
public class Board {
	int id;
	String title;
	String content;
	Date wdate;
	Date udate;
	int writer;
	int boardType;
}
