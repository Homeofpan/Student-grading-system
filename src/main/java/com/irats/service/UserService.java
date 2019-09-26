package com.irats.service;

import com.irats.pojo.User;
import com.irats.utils.E3Result;

public interface UserService {

	E3Result deleteUser(String username);
	E3Result updateUser(User user);
	
	//修改用户名
	void updateUserName(User user);
	
	
}
