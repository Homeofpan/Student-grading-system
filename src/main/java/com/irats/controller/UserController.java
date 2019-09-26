package com.irats.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.irats.pojo.Mark;
import com.irats.pojo.User;
import com.irats.service.LoginService;
import com.irats.service.MarkService;
import com.irats.service.StudentList;
import com.irats.service.UserService;
import com.irats.utils.E3Result;
import com.irats.utils.MarkSearch;

@Controller
public class UserController {
	@Autowired
	private StudentList service;
	@Autowired
	private UserService userService;
	
	@Autowired
	private LoginService loginService;
	
	@Autowired
	private MarkService markService;
/*	@RequestMapping("/user-list")
	@ResponseBody
	public StudentResult showResult(int offset,int limit) {
		//调用服务
		System.out.println(offset);
		System.out.println(limit);
		int page = (offset / limit) + 1;
		StudentResult list = service.getList(page,limit);
		return list;
	}*/
	
	@RequestMapping("/user")
	@ResponseBody
	public List<User> getAll(String username){
		User user = new User();
		user.setUsername(username);
		List<User> lsit = service.getAll(user);
		return lsit;
	}
	
	@RequestMapping("/user-delete")
	@ResponseBody E3Result deleteUser(String username) {
		E3Result result = userService.deleteUser(username);
		return result;
	}
	
	
	/**
	 * 修改管理员权限
	 * @param username
	 * @param power
	 * @param request
	 * @return
	 */
	@RequestMapping("/edit")
	@ResponseBody
	public E3Result editUser(String username,String power,HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		User loginUser = (User) session.getAttribute("user");
		if(!"admin".equals(loginUser.getUsername())) {
			return E3Result.build(205, "你不是管理员不能修改信息");
		}
		if("admin".equals(username) && "0".equals(power)) {
			return E3Result.build(400, "管理员不能降级,修改失败");
		}
		User user = new User();
		user.setPower(power);
		user.setUsername(username);
		E3Result result = userService.updateUser(user);
		return result;
	}
	
	@RequestMapping("/power/power-edit")
	public String getEdit(String username,String power,HttpServletRequest request) {
		if("0".equals(power)) {
			request.setAttribute("power","用户");
			request.setAttribute("power2", "超级管理员");
		}
		if("1".equals(power)) {
			request.setAttribute("power","超级管理员");
			request.setAttribute("power2", "用户");
		}
		request.setAttribute("username",username);
		return "/score/editpage/power-edit";
	}
	
	
	
	/**
	 * 查询学生对应的平均分
	 */
	@RequestMapping("/selectMark/sno")
	@ResponseBody
	public E3Result showAvgScore(String sno,String trueName,
			@DateTimeFormat(pattern="yyyy-MM-dd")Date startTime,@DateTimeFormat(pattern="yyyy-MM-dd")Date endTime) {
		MarkSearch markSearch = new MarkSearch();
		//补全属性
		markSearch.setSno(sno);
		markSearch.setStuname(trueName);
		markSearch.setBeginTime(startTime);
		markSearch.setEndTime(endTime);
		markSearch.setIfmark("已评分");
		
		//调用服务查询
		List<Mark> markList = markService.searchMark(markSearch);
		
		//遍历该list计算出平均分
		if(markList.size() ==0 || markList ==null) {
			return E3Result.build(456, "该学生对应的平均分不存在,请确认学号,姓名,日期是否填写正确");
		}
		
		
		double total = 0.0;
		for (Mark mark : markList) {
			total += mark.getMark();

		}
		
		double avgScore = total / markList.size();
		MarkSearch m = new MarkSearch();
		m.setAverage(avgScore);
		return E3Result.ok(m);
	}
	
	
	@RequestMapping("/user/change")
	@ResponseBody
	public E3Result updateUserName(String newusername,String password,HttpSession session) {
		User user = (User) session.getAttribute("user");
		if("admin".equals(user.getUsername())) {
			return E3Result.build(278, "不能修改超级管理员的用户名");
		}
		if(!DigestUtils.md5DigestAsHex(password.getBytes()).equals(user.getPassword())) {
			return E3Result.build(250, "用户密码不正确,不能修改");
		}
		E3Result e3result = loginService.checkName(newusername);
		if(e3result.getStatus() != 200) {
			return e3result;
		}
		User newUser= new User();
		newUser.setUsername(newusername);
		newUser.setId(user.getId());
		userService.updateUserName(newUser);
		user.setUsername(newusername);
		session.setAttribute("user",user);
		return E3Result.ok();
	}
	
	/**
	 * 检查用户名是否存在
	 */
	@RequestMapping("/checknew/user")
	@ResponseBody
	public E3Result checkUserName(String newusername) {
		//调用服务根据名字查找相应的用户是否存在
		E3Result result = loginService.checkName(newusername);
		if(result.getStatus() != 200) {
			return result;
		}
		return result;
	}
	
}
