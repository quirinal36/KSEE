package www.ksee.kr.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Menus {
	int id;
	String title;
	int parent;
	String url;
	Menus prev;
	Menus next;
	String title_en;
	
	public static Menus newInstance(int id) {
		Menus menu = new Menus();
		menu.setId(id);
		return menu;
	}
}
