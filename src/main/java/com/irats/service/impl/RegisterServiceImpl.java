package com.irats.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

import com.irats.dao.ILoginDao;
import com.irats.pojo.User;
import com.irats.service.RegisterService;
import com.irats.utils.E3Result;
/**
 * 注册服务
 * @author pan tao
 *
 */
@Service
public class RegisterServiceImpl implements RegisterService {
	@Autowired
	private ILoginDao registerDao;
	@Override
	public E3Result addUser(User user) {
		//判断数据库中该用户是否存在
		User someUser = registerDao.selectUserByName(user.getUsername());
		if(someUser != null) {
			return E3Result.build(300, "该用户已经存在");
		}
		//进行密码的加密
		String md5Pass = DigestUtils.md5DigestAsHex(user.getPassword().getBytes());
		user.setPassword(md5Pass);
		registerDao.addUser(user);
		//判断是否插入成功
		if(user.getId() != null) {
			return E3Result.ok(user);
		}
		//插入失败
		return E3Result.build(250, "插入失败");
	}

}
