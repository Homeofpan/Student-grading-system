package com.irats.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * 首页展示
 * @author pan tao
 *
 */
@Controller
public class PageController {

	@RequestMapping("/")
	public String showPage() {
		return "index";
	}
	
	@RequestMapping("/score/{page}")
	public String showScore(@PathVariable String page) {
		return "/score/" + page;
	}
	
	
	@RequestMapping("/outPage/{page}")
	public String showStudent(@PathVariable String page) {
		return "/outPage/" + page;
	}
	
	
	@RequestMapping("/{page}")
	public String showWelcome(@PathVariable String page) {
		return page;
	}
	
	@RequestMapping("/score/editpage/{page}")
	public String showPower(@PathVariable String page) {
		return "/score/editpage/" + page;
	}
	
	
}
