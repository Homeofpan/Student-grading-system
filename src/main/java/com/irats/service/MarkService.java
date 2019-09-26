package com.irats.service;

import java.util.List;

import com.irats.pojo.Mark;
import com.irats.utils.E3Result;
import com.irats.utils.MarkSearch;

public interface MarkService {

	//查询列表
	List<Mark> getMark(Mark mark);
	//根据id查询
	Mark getById(Integer id);
	//根据id评分
	E3Result updateMark(Mark mark);
	
	//查询评分记录
	List<Mark> searchMark(MarkSearch markSearch);
}
