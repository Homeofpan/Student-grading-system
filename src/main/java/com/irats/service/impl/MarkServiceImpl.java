package com.irats.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.irats.dao.MarkMapper;
import com.irats.pojo.Mark;
import com.irats.pojo.MarkExample;
import com.irats.pojo.MarkExample.Criteria;
import com.irats.service.MarkService;
import com.irats.utils.E3Result;
import com.irats.utils.MarkSearch;
@Service
public class MarkServiceImpl implements MarkService {
	@Autowired
	private MarkMapper markMapper;
	@Override
	public List<Mark> getMark(Mark mark) {
		MarkExample example = new MarkExample();
		Criteria criteria = example.createCriteria();
		if(StringUtils.isNotBlank(mark.getSno())) {
			criteria.andSnoEqualTo(mark.getSno());
		}
		if(StringUtils.isNotBlank(mark.getStuname())) {
			criteria.andStunameEqualTo(mark.getStuname());
		}
		if(StringUtils.isNotBlank(mark.getWorkname())) {
			criteria.andWorknameEqualTo(mark.getWorkname());
		}
		if(StringUtils.isNotBlank(mark.getShifts())) {
			criteria.andShiftsEqualTo(mark.getShifts());
		}
		if(StringUtils.isNotBlank(mark.getIfmark())) {
			criteria.andIfmarkEqualTo(mark.getIfmark());
		}
		if(mark.getDate() != null) {
			criteria.andDateEqualTo(mark.getDate());
		}
		//执行查询
		List<Mark> list = markMapper.selectByExample(example);
		if(list ==null || list.size() == 0) {
			return new ArrayList<>();
		}
		return list;
	}
	@Override
	public Mark getById(Integer id) {
		Mark mark = markMapper.selectByPrimaryKey(id);
		if(mark == null)
		{
			return new Mark();
		}
		return mark;
	}
	
	/**
	 * 评分服务
	 */
	@Override
	public E3Result updateMark(Mark mark) {
		mark.setIfmark("已评分");
		markMapper.updateByPrimaryKeySelective(mark);
		return E3Result.ok();
	}
	
	@Override
	public List<Mark> searchMark(MarkSearch markSearch) {
		List<Mark> list = markMapper.selectMarkByManyCondition(markSearch);
		return list; 
	}

}
