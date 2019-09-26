package com.irats.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.irats.dao.ILoginDao;
import com.irats.pojo.User;
import com.irats.service.UserService;
import com.irats.utils.E3Result;

/**
 * 用户数据处理Service
 * @author pan tao
 *
 */
@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private ILoginDao dao;
	
	@Override
	public E3Result deleteUser(String username) {
		dao.deleteUser(username);
		return E3Result.ok();
	}
	
	
	@Override
	public E3Result updateUser(User user) {
		dao.updateUser(user);
		return E3Result.ok();
	}
	
	
	/**
	 * 修改用户名
	 */
	@Override
	public void updateUserName(User user) {
		dao.updateUsernameById(user);
	}
	
	

}
