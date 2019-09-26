package com.irats.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.irats.pojo.User;
import com.irats.service.LoginService;
import com.irats.utils.CookieUtils;
import com.irats.utils.E3Result;

/**
 * 登录处理
 * @author pan tao
 *
 */
@Controller
public class LoginController {
	@Autowired
	private LoginService loginService;
	
	/**
	 * 登录判断用户是否存在,并且密码是否正确,还有用户是否为管理员
	 * @param username
	 * @param password
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/user/login",method=RequestMethod.POST)
	@ResponseBody
	public E3Result toIndex(String username,String password,String flag,String code,
			HttpServletRequest request,HttpServletResponse response,
			HttpSession session) {
		//获取验证码
		code = code.toLowerCase();
		String vcode = (String) session.getAttribute("randomcode_key");
		vcode = vcode.toLowerCase();
		//如果验证码错误返回信息
		if(!code.equals(vcode)) {
			return E3Result.build(256, "验证码错误");
		}
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);	
		//调用服务从数据库找到该用户
		E3Result result = loginService.findUser(user);	
		//调用服务查询数据库,判断用户是否存在,并且密码是否正确
		if (result.getStatus() != 200) {
			return result;
		}
		User loginUser = (User) result.getData();
		session.setAttribute("user",loginUser);
		
		//将用户信息放入cooike中
		if(flag.equals("true")) {
		CookieUtils.setCookie(request, response, username,password,120,true);
		}
		return result;
	}
	
	
	/**
	 * 用户退出登录功能
	 * @param request
	 * @return
	 */
	@RequestMapping("/login/logout")
	public String loginOut(HttpServletRequest request) {
		//获取session
		HttpSession session = request.getSession(false);
		session.removeAttribute("user");
		return "redirect:/admin";
		
	}
	
	
	
	/**
	 * 管理员密码修改
	 * 
	 */
	@RequestMapping("/user/changePassword")
	@ResponseBody
	public E3Result changePassword(String oldpassword,String newpassword,HttpSession session) {
		User user = (User) session.getAttribute("user");
		//验证密码是否相同,匹配则可以改密码
		if(!user.getPassword().equals(DigestUtils.md5DigestAsHex(oldpassword.getBytes()))) {
			//密码不匹配
			return E3Result.build(201, "原密码错误,不能修改密码!");
		}
		//匹配,将密码写入user
		user.setPassword(DigestUtils.md5DigestAsHex(newpassword.getBytes()));
		//调用服务修改密码
		loginService.changeUserPassword(user);
		session.setAttribute("user", user);
		return E3Result.ok();
	}
	

	
}
