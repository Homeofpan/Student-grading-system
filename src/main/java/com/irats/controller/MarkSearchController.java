package com.irats.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.irats.pojo.Mark;
import com.irats.service.MarkService;
import com.irats.utils.MarkSearch;

@Controller
public class MarkSearchController {

	@Autowired
	private MarkService markService;
	
	@RequestMapping("/mark/mark_show")
	@ResponseBody
	public List<Mark> searchMark(String stuname,String sno,String shifts,String workname,
			@DateTimeFormat(pattern="yyyy-MM-dd")Date beginTime,
			@DateTimeFormat(pattern="yyyy-MM-dd")Date endTime,String ifmark){
		MarkSearch markSearch = new MarkSearch();
		List<Mark> list = new ArrayList<>();
		try {
			//解决中文乱码并补全属性
			if(StringUtils.isNotBlank(stuname)) {
				markSearch.setStuname(new String(stuname.getBytes("iso8859-1"),"utf-8"));
			}
			if(StringUtils.isNotBlank(ifmark)) {
				markSearch.setIfmark(new String(ifmark.getBytes("iso8859-1"),"utf-8"));
			}
			if(StringUtils.isNotBlank(workname)) {
				markSearch.setWorkname(new String(workname.getBytes("iso8859-1"),"utf-8"));
			}
			if(StringUtils.isNotBlank(shifts)) {
				markSearch.setShifts(new String(shifts.getBytes("iso8859-1"),"utf-8"));
			}
			markSearch.setSno(sno);
			markSearch.setBeginTime(beginTime);
			markSearch.setEndTime(endTime);
			
			//查询
			list = markService.searchMark(markSearch);
			//返回结果
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	/**
	 * 展示平均分
	 * @param stuname
	 * @param sno
	 * @param ifmark
	 * @param beginTime
	 * @param endTime
	 * @return
	 */
	@RequestMapping("/mark/average_show")
	@ResponseBody
	public List<MarkSearch> showAverage(String stuname, String sno, String ifmark,
			@DateTimeFormat(pattern = "yyyy-MM-dd") Date beginTime,
			@DateTimeFormat(pattern = "yyyy-MM-dd") Date endTime) {
		// 设置查询条件
		MarkSearch markSearch = new MarkSearch();
		List<MarkSearch> list = new ArrayList<>();
		try {
			// 解决中文乱码并补全属性
			if (StringUtils.isNotBlank(stuname)) {
				markSearch.setStuname(new String(stuname.getBytes("iso8859-1"), "utf-8"));
			}
			if (StringUtils.isNotBlank(ifmark)) {
				markSearch.setIfmark(new String(ifmark.getBytes("iso8859-1"), "utf-8"));
			}
			markSearch.setSno(sno);
			markSearch.setBeginTime(beginTime);
			markSearch.setEndTime(endTime);
			// 查询获取原生数据:没有平均分
			List<Mark> markList = markService.searchMark(markSearch);

			// 总分哈希表
			Map<String, Integer> summap = new HashMap<>();
			// 记录数哈希表
			Map<String, Integer> timemap = new HashMap<>();

			// 遍历结果集,将信息放入map中
			for (Mark mark : markList) {
				String mapkey = mark.getStuname() + "_" + mark.getSno();

				// 记录学生出现次数
				if (timemap.get(mapkey) == null) {
					timemap.put(mapkey, 1);
				} else {
					timemap.put(mapkey, timemap.get(mapkey) + 1);
				}

				// 判断map中是否存在该学生
				if (summap.get(mapkey) == null) {
					// 不存在,将学生信息放入
					// key为: 学生姓名_学号 value为: 分数
					summap.put(mapkey, mark.getMark());
				} else {
					// 存在
					// 取出该学生的分数,记录总分并放回
					summap.put(mapkey, summap.get(mapkey) + mark.getMark());
				}
			}

			// 遍历hashmap将数据封装为对象
			for (String key : summap.keySet()) {
				String[] split = key.split("_");
				MarkSearch markAvg = new MarkSearch();
				markAvg.setStuname(split[0]);
				markAvg.setSno(split[1]);
				markAvg.setAverage((summap.get(key) * 1.0) / timemap.get(key));
				list.add(markAvg);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;

	}
}
