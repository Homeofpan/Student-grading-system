package com.irats.service.impl;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import com.irats.dao.ILoginDao;
import com.irats.pojo.User;
import com.irats.service.LoginService;
import com.irats.utils.E3Result;
/**
 * 登录service
 * @author pan tao
 *
 */
@Service
public class LoginServiceImpl implements LoginService{
	@Autowired
	private ILoginDao iloginDao;
	@Override
	public E3Result findUser(User user) {
		//判断用户名是否为空
		if(StringUtils.isBlank(user.getUsername())) {
			return E3Result.build(201, "用户名或密码为空");
		}
		if(StringUtils.isBlank(user.getPassword())) {
			return E3Result.build(201, "用户名或密码为空");
		}
		User userFrom = iloginDao.selectUser(user);
		//判断用户名是否存在
		if(userFrom == null) {
			return E3Result.build(204, "用户名不存在");
		}
		if (!DigestUtils.md5DigestAsHex(user.getPassword().getBytes()).equals(userFrom.getPassword())) {
			return E3Result.build(203, "密码错误请重新登录");
		}
		//返回成功结果
		return E3Result.ok(userFrom);
	}
	
	/**
	 * 判断用户名是否注册过
	 */
	@Override
	public E3Result checkName(String username) {
		User user = iloginDao.selectUserByName(username);
		//判断用户名是否为空
		//如果不为空,返回用户名已存在的信息
		if(user != null) {
			return E3Result.build(204,"用户名已存在");
		}
		//如果为空,就返回用户名可以使用的信息
		return E3Result.ok("用户名能使用");
	}
	
	/**
	 * 修改密码
	 */
	@Override
	public void changeUserPassword(User user) {
		iloginDao.updateUserPassword(user);
	}

}
