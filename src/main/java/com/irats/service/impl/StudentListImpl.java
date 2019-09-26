package com.irats.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.irats.dao.ILoginDao;
import com.irats.pojo.User;
import com.irats.service.StudentList;
@Service
public class StudentListImpl implements StudentList {
	@Autowired
	private ILoginDao dao;
/*	@Override
	public StudentResult getList(int pages, int rows) {
		//设置分页
		PageHelper.startPage(pages, rows);
		//执行查询
		List<User> userList = dao.selectAll();
		System.out.println(userList.get(0).getUsername());
		//创建返回对象
		StudentResult result = new StudentResult();
		result.setRows(userList);
		//获取分页结果
		PageInfo<User> list = new PageInfo<>(userList);
		long total = list.getTotal();
		result.setTotal(total);
		return result;
	}*/
	@Override
	public List<User> getAll(User user) {
		List<User> list = dao.selectAll(user);
		if(list.size() == 0 || list == null) {
			return new ArrayList<>();
		}
		return list;
	}

}
