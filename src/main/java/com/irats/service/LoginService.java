package com.irats.service;

import com.irats.pojo.User;
import com.irats.utils.E3Result;

public interface LoginService {

	//查询登录信息
	E3Result findUser(User user);
	//查询用户名是否存在
	E3Result checkName(String username);
	
	//修改密码
	void changeUserPassword(User user);
}
