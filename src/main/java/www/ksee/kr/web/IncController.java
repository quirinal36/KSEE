package www.ksee.kr.web;

import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import www.ksee.kr.service.MenuService;
import www.ksee.kr.vo.Menus;

@RequestMapping("/inc")
@Controller
public class IncController extends KseeController{
	
	@RequestMapping(value = "/header", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getHeaderView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		Menus parent = new Menus();
		parent.setParent(0);
		
		List<Menus> parents = menuService.select(parent);
		List<Menus> children = menuService.select(parents);
		
		mv.addObject("locale", locale);
		
		mv.addObject("parents", parents);
		mv.addObject("children", children);
		
		mv.setViewName("/inc/header");
		return mv;
	}
	@RequestMapping(value = "/header_admin", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getHeaderAdminView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("/inc/header_admin");
		return mv;
	}
	@RequestMapping(value = "/footer", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getFooterView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("/inc/footer");
		return mv;
	}
	@RequestMapping(value = "/head", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getHeadView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication) {
		mv.setViewName("/inc/head");
		return mv;
	}
	@RequestMapping(value = "/lnb_wrap", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getLnbWrapView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication,
			Menus menus) {
		Menus parent = new Menus();
		parent.setParent(0);
		List<Menus> parents = menuService.select(parent);
		mv.addObject("parents", parents);
		
		parent.setParent(menus.getId());
		List<Menus> children = menuService.select(parents);
		mv.addObject("children", children);
		
		Iterator<Menus> iter = children.iterator();
		while(iter.hasNext()) {
			Menus curMenu = iter.next();
			if(curMenu.getId() == menus.getId()) {
				mv.addObject("curMenu", curMenu);
			}
		}
		
		mv.setViewName("/inc/lnb_wrap");
		return mv;
	}
	@RequestMapping(value = "/contentsTitle", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView getContentsTitleView(Locale locale, ModelAndView mv,
			HttpServletRequest req, Authentication authentication,
			Menus menus) {
		List<Menus> siblings = menuService.selectSiblings(menus);
		siblings.sort(new Comparator<Menus>() {
			@Override
			public int compare(Menus o1, Menus o2) {
				return o1.getId() > o2.getId() ? 1 : -1;
			}
		});
		
		for(Menus m : siblings) {
			if(m.getId() == menus.getId()) {
				menus.setTitle(m.getTitle());
				menus.setUrl(m.getUrl());
				menus.setParent(m.getParent());
			}
		}
		
		if(siblings.size() > 1) {
			Menus prev;
			int minId = siblings.get(0).getId();
			int maxId = siblings.get(siblings.size()-1).getId();
			if(menus.getId() == minId) {
				prev = siblings.get(siblings.size() - 1);
			}else {
				prev = siblings.get(menus.getId() - 1 - minId);
			}
			
			Menus next;
			if(menus.getId() == maxId) {
				next = siblings.get(0);
			}else {
				next = siblings.get(menus.getId() + 1 - minId);
			}
			
			menus.setPrev(prev);
			menus.setNext(next);
		}
		mv.addObject("curMenu", menus);
		mv.setViewName("/inc/contentsTitle");
		return mv;
	}
}
