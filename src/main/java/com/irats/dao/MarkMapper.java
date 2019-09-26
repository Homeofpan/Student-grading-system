package com.irats.dao;

import com.irats.pojo.Mark;
import com.irats.pojo.MarkExample;
import com.irats.utils.MarkSearch;

import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface MarkMapper {
    int countByExample(MarkExample example);

    int deleteByExample(MarkExample example);

    int deleteByPrimaryKey(Integer id);

    int insert(Mark record);

    int insertSelective(Mark record);

    List<Mark> selectByExample(MarkExample example);

    Mark selectByPrimaryKey(Integer id);

    int updateByExampleSelective(@Param("record") Mark record, @Param("example") MarkExample example);

    int updateByExample(@Param("record") Mark record, @Param("example") MarkExample example);

    int updateByPrimaryKeySelective(Mark record);

    int updateByPrimaryKey(Mark record);

	List<Mark> selectMarkByManyCondition(MarkSearch markSearch);
}