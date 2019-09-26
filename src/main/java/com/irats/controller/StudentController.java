package com.irats.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.irats.pojo.Student;
import com.irats.service.StudentService;
import com.irats.utils.E3Result;

import java.io.File;



/**
 * 学生管理Controller
 * @author IrAts
 *
 */
@Controller
public class StudentController {

	@Autowired
	private StudentService studentService;
	
	/**
	 * 展示学生列表
	 * @param studentname
	 * @param studentno
	 * @return
	 */
	@RequestMapping("/student/student-list")
	@ResponseBody
	public List<Student> listStudent(String studentname,String studentno) {
		List<Student> list = null;
		try {
			list = studentService.getStudentListPage(studentname,studentno);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	
	/**
	 * 删除学生信息
	 * @param studentnos
	 * @return
	 */
	@RequestMapping("/student/deleteStudent")
	@ResponseBody
	public E3Result deleteStudent(String ids,HttpSession session) {
		//获取图片存放的路径
		String path = session.getServletContext().getRealPath("/student/images");
		E3Result e3Result = studentService.deleteStudent(ids,path);
		return e3Result;
	}
	
	
	
	
	/**
	 * 跳转到学生信息编辑页面
	 * @param id
	 * @param request
	 * @return
	 */
	@RequestMapping("/student/goto_edit")
	public String gotoEdit(String id,HttpServletRequest request) {
		Student student = studentService.selectStudentBySno(id);
		request.setAttribute("student", student);
		return "/score/editpage/student_edit";
	}
	
	
	
	/**
	 * 修改学生信息
	 * @param img
	 * @param student
	 * @param session
	 * @return
	 */
	@RequestMapping("/student/updateStudent")
	public String studentUpdate(MultipartFile img,Student student,
			String preimage,HttpSession session) {
		try {
				String imageadr = "";
				//判断是否有文件传输进来
				if(img.getSize() != 0 ) {
					//获取保存位置
					String path = session.getServletContext().getRealPath("/student/images");
					//获取文件名
					String originalFilename = img.getOriginalFilename();
					//获取文件后缀
					String str = originalFilename.substring(originalFilename.lastIndexOf("."), originalFilename.length());
					//以id作为文件名
					String filename = student.getId() + str;
					File file = new File(path,filename);
					//判断文件是否存在
					if(file != null) {
						//存在则删除
						file.delete();
					}
					//保存文件
					img.transferTo(file);
					imageadr = "/student/images/" + filename;
				}
				//如果上传了文件,将文件上传地址放入student
				if(StringUtils.isNotBlank(imageadr)) {
					student.setImageadr(imageadr);
				}else {
					//如果没上传文件,将原来的地址放回
					student.setImageadr(preimage);
				}
				//调用studentService更新数据
				studentService.updateStudent(student);
				
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return "success";
	}
	
	
	
	/**
	 * 跳转到学生添加页面
	 * @param request
	 * @return
	 */
	@RequestMapping("/student/goto_add")
	public String gotoAdd(HttpServletRequest request) {
		return "/score/editpage/student_add";
	}
	
	/**
	 * 新增学生
	 * @param img
	 * @param student
	 * @param session
	 * @return
	 */
	@RequestMapping("/student/addStudent")
	public String studentAdd(MultipartFile img,Student student,
			HttpSession session,HttpServletRequest request) {
		//判断传入的对象值是否为空,无需判断上传文件是否为空,无照片也可以新增学生
		if(StringUtils.isBlank(student.getAcademy())) {
			request.setAttribute("msg", "填写的信息存在空值,请重新填写");
			return "fail";
		}
		if(StringUtils.isBlank(student.getGrade())) {
			request.setAttribute("msg", "填写的信息存在空值,请重新填写");
			return "fail";
		}
		if(StringUtils.isBlank(student.getName())) {
			request.setAttribute("msg", "填写的信息存在空值,请重新填写");
			return "fail";
		}
		if(StringUtils.isBlank(student.getSno())) {
			request.setAttribute("msg", "填写的信息存在空值,请重新填写");
			return "fail";
		}
		if(StringUtils.isBlank(student.getSex())) {
			request.setAttribute("msg", "填写的信息存在空值,请重新填写");
			return "fail";
		}
		
		//获取保存位置
		String path = session.getServletContext().getRealPath("/student/images");
		//调用服务插入数据
		try {
			studentService.addStudent(img,student,path);
		} catch (Exception e) {
			
			e.printStackTrace();
			return "fail";
		}
		return "success";
	}
	
	
	@RequestMapping("/check/sno")
	@ResponseBody
	public E3Result checkStudent(String sno) {
		try {
			List<Student> list = studentService.getStudentListPage(null, sno);
			if(list == null || list.size() ==0 ) {
				return E3Result.ok();
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return E3Result.build(257, "学生已存在");
	}
}
