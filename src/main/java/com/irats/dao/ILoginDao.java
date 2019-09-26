package com.irats.dao;

import java.util.List;

import com.irats.pojo.User;

public interface ILoginDao {

	 User selectUser(User user);
	 User selectUserByName(String username);
	 void addUser(User user);
	 //查询所有
	 List<User> selectAll(User user);
	 //删除用户
	 void deleteUser(String username);
	 void updateUser(User user);
	 
	 //修改密码
	 void updateUserPassword(User user);
	 
	 void updateUsernameById(User user);
	 
	 
}
