package com.irats.service;

import java.util.List;

import com.irats.pojo.WorkRecord;
import com.irats.utils.E3Result;

public interface WorkRecordeService {
	//根据id获取工作记录
	WorkRecord getRecordById(Integer id);
	List<WorkRecord> getRecorde(WorkRecord record);
	//批量删除工作记录
	E3Result deleteRecord(Integer id);
	//修改工作记录
	E3Result updateRecord(WorkRecord record);
	//新增工作记录
	E3Result addRecord(WorkRecord record);
	//根据学生id来查询对应的学生的工作记录是否存在
	List<WorkRecord> selectById(Integer id);
}
