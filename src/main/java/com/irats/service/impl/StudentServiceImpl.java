package com.irats.service.impl;

import java.io.File;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.irats.dao.MarkMapper;
import com.irats.dao.StudentMapper;
import com.irats.dao.WorkRecordMapper;
import com.irats.pojo.Mark;
import com.irats.pojo.MarkExample;
import com.irats.pojo.Student;
import com.irats.pojo.StudentExample;
import com.irats.pojo.WorkRecordExample;
import com.irats.pojo.StudentExample.Criteria;
import com.irats.pojo.WorkRecord;
import com.irats.service.StudentService;
import com.irats.service.WorkRecordeService;
import com.irats.utils.E3Result;

/**
 * @author IrAts
 *
 */
@Service
public class StudentServiceImpl implements StudentService {
	
	@Autowired
	private StudentMapper studentMapper;
	
	@Autowired
	private WorkRecordMapper workRecordMapper;
	
	@Autowired
	private MarkMapper markMapper;
	
	@Autowired
	private WorkRecordeService workRecordService;
	/**
	 * 查询student列表
	 */
	@Override
	public List<Student> getStudentListPage(String studentname, String studentno) throws Exception {
		StudentExample example = new StudentExample();
		Criteria cirterir = example.createCriteria();
		//判断设置条件
		if(StringUtils.isNotBlank(studentname)) {
			studentname = new String(studentname.getBytes("iso8859-1"),"utf-8");
			cirterir.andNameEqualTo(studentname);
		}
		if(StringUtils.isNotBlank(studentno)) {
			studentno = new String(studentno.getBytes("iso8859-1"),"utf-8");
			cirterir.andSnoEqualTo(studentno);
		}
		//查询
		List<Student> list = studentMapper.selectByExample(example);
		return list;
	}

	@Override
	public E3Result deleteStudent(String ids,String path) {
		if(StringUtils.isNotBlank(ids)) {
			String[] students = ids.split(",");
			for (String idStr : students) {
				int id = Integer.parseInt(idStr);
				//判断该学生是否有图片
				Student stu = studentMapper.selectByPrimaryKey(id);
/*				String[] split = stu.getImageadr().split("/");
				File file = new File(path,split[3]);*/
				String imageadr = stu.getImageadr().substring(stu.getImageadr().lastIndexOf("/"),stu.getImageadr().length());
				File file = new File(path,imageadr);
				//若存在,取出其图片文件名
				//删除,该图片存储在应用中
				if(file != null) {
					file.delete();
				}
				//将该学生对应的所有工作记录都删除
				//如果没有工作记录则不处理,有则全部删除
				List<WorkRecord> manyRecords = workRecordService.selectById(id);
				E3Result result = null;
				if(manyRecords.size() > 0 && manyRecords != null ) {
					for (WorkRecord workRecord : manyRecords) {
						result =workRecordService.deleteRecord(workRecord.getId());
					}
				}
				if(result.getStatus() != 200) {
					return result;
				}
				//若没有,直接删除该学生
				studentMapper.deleteByPrimaryKey(id);
			}
		}
		return E3Result.ok();
	}

	@Override
	public Student selectStudentBySno(String idStr) {
		int id = Integer.parseInt(idStr);
		Student student = studentMapper.selectByPrimaryKey(id);
		return student;
	}

	@Override
	public void updateStudent(Student student) {
		studentMapper.updateByPrimaryKey(student);
		//将修改了的学生名字更新到工作记录表中
		WorkRecordExample example = new WorkRecordExample();
		com.irats.pojo.WorkRecordExample.Criteria criteria = example.createCriteria();
		criteria.andSnoEqualTo(student.getSno());
		//执行查询
		List<WorkRecord> stuList = workRecordMapper.selectByExample(example);
		if(stuList == null || stuList.size() ==0) {
			return;
		}
		for (WorkRecord workRecord : stuList) {
			workRecord.setStuname(student.getName());
			workRecordMapper.updateByPrimaryKey(workRecord);
		}
		
		//更新到评分表
		MarkExample example2 = new MarkExample();
		com.irats.pojo.MarkExample.Criteria crriteria = example2.createCriteria();
		crriteria.andSnoEqualTo(student.getSno());
		List<Mark> markList = markMapper.selectByExample(example2);
		for (Mark mark : markList) {
			mark.setStuname(student.getName());
			markMapper.updateByPrimaryKey(mark);
		}
		return ;
	}


	@Override
	public void addStudent(MultipartFile img, Student student, String path) throws Exception {
		//插入数据返回id
		studentMapper.insertStudentGetId(student);
		String imageadr = "";
		//判断是否有文件传输进来
		if(img.getSize() != 0 ) {
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
			//调用studentMapper更新数据
			studentMapper.updateByPrimaryKey(student);
		}
	}

	@Override
	public E3Result checkStudentIfExist(String sno, String stuname) {
		//设置查询条件
		StudentExample example = new StudentExample();
		Criteria criteria = example.createCriteria();
		criteria.andSnoEqualTo(sno);
		criteria.andNameEqualTo(stuname);
		//查询学生
		List<Student> list = studentMapper.selectByExample(example);
		if(list.size() == 0) {
			//学生不存在
			return E3Result.build(209, "该学生不存在!无法添加工作记录,请检查学生信息");
		}
		//学生存在返回成功
		return E3Result.ok();
	}

	@Override
	public Student getStudentBySnoAndName(String sno, String name) {
		StudentExample example = new StudentExample();
		Criteria createCriteria = example.createCriteria();
		createCriteria.andNameEqualTo(name);
		createCriteria.andSnoEqualTo(sno);
		List<Student> list = studentMapper.selectByExample(example);
		Student student = null;
		if(list.size() != 0) {
			student = list.get(0);
		}
		return student;
	}
	
	
	

}
