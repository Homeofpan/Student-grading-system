package com.irats.service;
/**
 * 登录服务接口
 * @author pan tao
 *
 */

import com.irats.pojo.User;
import com.irats.utils.E3Result;

public interface RegisterService {
	
	E3Result addUser(User user);
}
