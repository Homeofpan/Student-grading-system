package com.irats.service;

import java.util.List;

import com.irats.pojo.User;

public interface StudentList {
	/*StudentResult getList(int pages,int rows);*/
	List<User> getAll(User user);
}
