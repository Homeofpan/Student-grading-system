package com.irats.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.irats.pojo.Mark;
import com.irats.pojo.Student;
import com.irats.service.MarkService;
import com.irats.service.StudentService;
import com.irats.utils.E3Result;

/**
 * 评分处理
 * @author pan tao
 *
 */
@Controller
public class MarkController {

	@Autowired
	private MarkService markService;
	
	@Autowired
	private StudentService studentService;
	
	@RequestMapping("/mark/mark_list")
	@ResponseBody
	public List<Mark> getMark(String stuname,String sno,String shifts,
			String workname,@DateTimeFormat(pattern="yyyy-MM-dd")Date date,String ifmark) throws Exception{
		stuname = new String(stuname.getBytes("ISO-8859-1"), "UTF-8");
		shifts = new String(shifts.getBytes("ISO-8859-1"), "UTF-8");
		ifmark = new String(ifmark.getBytes("ISO-8859-1"), "UTF-8");
		workname = new String(workname.getBytes("ISO-8859-1"), "UTF-8");
		Mark mark =new Mark();
		mark.setDate(date);
		mark.setSno(sno);
		mark.setStuname(stuname);
		mark.setIfmark(ifmark);
		mark.setShifts(shifts);
		mark.setWorkname(workname);
		//调用服务执行
		List<Mark> markList = markService.getMark(mark);
		return markList;
	}
	
	
	/**
	 * 跳转controller
	 */
	@RequestMapping("/mark/goto_edit")
	public String gotoMarkEdit(String id,HttpServletRequest request) {
		//根据id查询对应评分
		Mark mark = markService.getById(Integer.valueOf(id));
		request.setAttribute("mark", mark);
		//查找学生图片回显
		String sno = mark.getSno();
		String name = mark.getStuname();
		Student student = studentService.getStudentBySnoAndName(sno,name);
		request.setAttribute("student_image", student.getImageadr());
		//回显日期
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(mark.getDate());
		request.setAttribute("date", date);
		return "/score/editpage/mark_edit";
	}
	
/*	@RequestMapping("/mark/goto_edit")
	public String gotoMarkEdit(String id,HttpServletRequest request) {
		//根据id查询对应评分
		Mark mark = markService.getById(Integer.valueOf(id));
		request.setAttribute("mark", mark);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String date = sdf.format(mark.getDate());
		request.setAttribute("date", date);
		return "/score/editpage/mark_edit";
	}*/
	
	/**
	 * 评分Controller
	 */
	@RequestMapping("/mark/doScore")
	@ResponseBody
	public E3Result doMark(String id,String score,String tip) {
		Mark mark = new Mark();
		//补全评分信息
		if(StringUtils.isBlank(score)) {
			return E3Result.build(254, "分数为空,评分失败");
		}
		mark.setMark(Integer.valueOf(score));
		mark.setTip(tip);
		mark.setId(Integer.valueOf(id));
		//执行服务评分
		E3Result result = markService.updateMark(mark);
		return result;
	}
}
