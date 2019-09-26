package com.irats.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.irats.pojo.User;

public class LoginInterceptor implements HandlerInterceptor {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		//获取session对象
		HttpSession session = request.getSession();
		//从session中获取user对象
		User user = (User) session.getAttribute("user");
		//判断用户是否登录
		if(user == null) {
			//如果未登录,拦截;并且重定向到登录页面
			response.sendRedirect("/admin");
			return false;
		}
		//判断用户是否为管理员
		if("0".equals(user.getPower())) {
		//如果不是管理员直接拦截,重定向去查询页面
			session.removeAttribute("user");
			response.sendRedirect("/admin");
		}
		
		//如果登录并且为管理员,放行
		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {

	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {

	}

}
