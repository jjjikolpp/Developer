package com.controller;


import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@org.springframework.stereotype.Controller
public class Controller {
	@RequestMapping(value="AJAX_POST_URL", method=RequestMethod.POST)
	public void head(){
		System.out.println("head 완료");
		//이게 왜 안돼는지 모르겠다~
	}
}