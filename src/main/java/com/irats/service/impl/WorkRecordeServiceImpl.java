package com.irats.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.irats.dao.MarkMapper;
import com.irats.dao.WorkRecordMapper;
import com.irats.pojo.Mark;
import com.irats.pojo.MarkExample;
import com.irats.pojo.Student;
import com.irats.pojo.WorkRecord;
import com.irats.pojo.WorkRecordExample;
import com.irats.pojo.WorkRecordExample.Criteria;
import com.irats.service.StudentService;
import com.irats.service.WorkRecordeService;
import com.irats.utils.E3Result;
/**
 * 工作记录service
 * @author pan tao
 *
 */
@Service
public class WorkRecordeServiceImpl implements WorkRecordeService {
	@Autowired
	private WorkRecordMapper mapper;
	
	@Autowired
	private MarkMapper markMapper;
	
	@Autowired
	private StudentService studentService;
	
	@Override
	public List<WorkRecord> getRecorde(WorkRecord record) {
		//创建条件对象
		WorkRecordExample example = new WorkRecordExample();
		Criteria criteria = example.createCriteria();
		//根据传入条件
		//判断学生姓名是否为空
		if(StringUtils.isNotBlank(record.getStuname())) {
			criteria.andStunameEqualTo(record.getStuname());
		}
		//判断学生学号是否为空
		if(StringUtils.isNotBlank(record.getSno())) {
			criteria.andSnoEqualTo(record.getSno());
		}
		//判断工作班次是否为空
		if(StringUtils.isNotBlank(record.getWorkname())) {
			criteria.andWorknameEqualTo(record.getWorkname());
		}
		//判断工作地点是否为空
		if(StringUtils.isNotBlank(record.getShifts())) {
			criteria.andShiftsEqualTo(record.getShifts());
		}
		//判断工作日期是否为空
		if(record.getDate() != null) {
			criteria.andDateEqualTo(record.getDate());
		}
		//设置条件
		//执行查询
		List<WorkRecord> list = mapper.selectByExample(example);
		//返回查询结果
		if(list.size() ==0 || list == null) {
			return new ArrayList<>();
		}
		return list;
	}
	/**
	 * 删除工作记录
	 */
	@Transactional
	@Override
	public E3Result deleteRecord(Integer id) {
		WorkRecordExample example = new WorkRecordExample();
		Criteria criteria = example.createCriteria();
		criteria.andIdEqualTo(id);
		//执行删除
		mapper.deleteByExample(example);
		MarkExample example2 = new MarkExample();
		com.irats.pojo.MarkExample.Criteria criteria2 = example2.createCriteria();
		criteria2.andWorkIdEqualTo(id);
		markMapper.deleteByExample(example2);
		return E3Result.ok();
	}
	@Override
	public E3Result updateRecord(WorkRecord record) {
		mapper.updateByPrimaryKey(record);
		return E3Result.ok();
	}
	@Override
	public E3Result addRecord(WorkRecord record) {
		mapper.insert(record);
		if(record.getId() > 0) {
			Mark mark = new Mark();
			mark.setDate(record.getDate());
			mark.setSno(record.getSno());
			mark.setWorkname(record.getWorkname());
			mark.setWorkId(record.getId());
			mark.setStuname(record.getStuname());
			mark.setShifts(record.getShifts());
			mark.setStart(record.getStart());
			mark.setEnd(record.getEnd());
			mark.setIfmark("未评分");
			markMapper.insert(mark);
			return E3Result.ok();
		}
		return E3Result.build(257, "插入的数据失败,请重新操作");
	}
	@Override
	public WorkRecord getRecordById(Integer id) {
		WorkRecord record = mapper.selectByPrimaryKey(id);
		return record;
	}
	
	
	/**
	 * 通过学生id来判断该学生是否存在学生工作记录
	 */
	@Transactional
	@Override
	public List<WorkRecord> selectById(Integer id) {
		String idStr = String.valueOf(id);
		//通过该学生id找出该学生的学号
		Student student = studentService.selectStudentBySno(idStr);
		//根据学号找到该学生的工作记录
		WorkRecordExample example = new WorkRecordExample();
		Criteria criteria = example.createCriteria();
		criteria.andSnoEqualTo(student.getSno());
		List<WorkRecord> workRecords = mapper.selectByExample(example);
		if(workRecords.size() == 0 || workRecords == null) {
			return null;
		}
		return workRecords;
	}

}
