package com.irats.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.irats.pojo.User;
import com.irats.service.LoginService;
import com.irats.service.RegisterService;
import com.irats.utils.E3Result;

/**
 * 注册处理Controller
 * @author pan tao
 *
 */
@Controller
public class RegisterController {
	@Autowired
	private LoginService loginService;
	@Autowired
	private RegisterService registerService;
	@RequestMapping("/checkName")
	@ResponseBody
	public E3Result checkInfo(String username) {
		//调用服务查看用户名是否存在
		E3Result result = loginService.checkName(username);
		return result;
	}
	
	@RequestMapping("/user/register")
	@ResponseBody
	public E3Result register(User user) {
		//调用服务注册信息
		user.setPower("0");
		E3Result result = registerService.addUser(user);
		return result;
	}
	
	@RequestMapping("/user/register-login")
	@ResponseBody
	public E3Result loginAndRegister(User user,HttpServletRequest request) {
		//调用服务注册信息
		user.setPower("0");
		E3Result result = registerService.addUser(user);
		HttpSession session = request.getSession();
		session.setAttribute("user", user);
		return result;
	}
	
	
}
