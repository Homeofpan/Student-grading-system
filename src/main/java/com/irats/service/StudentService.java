package com.irats.service;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.irats.pojo.Student;
import com.irats.utils.E3Result;



/**
 * 
 * @author IrAts
 *
 */
public interface StudentService {

	List<Student> getStudentListPage(String studentname, String studentno) throws Exception;

	E3Result deleteStudent(String ids,String path);

	Student selectStudentBySno(String id);

	void updateStudent(Student student);

	void addStudent(MultipartFile img, Student student, String path) throws Exception;
	
	E3Result checkStudentIfExist(String sno,String stuname);
	
	Student getStudentBySnoAndName(String sno, String name);

}