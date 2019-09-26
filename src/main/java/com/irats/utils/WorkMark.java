package com.irats.utils;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

/**
 * 工作评分pojo
 * @author pan tao
 *
 */
public class WorkMark {
	//mark表
    private Integer id;
    private Integer workId;
    private String ifMarkStr;
    private String tip;
    private Integer mark;
    
    
    public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getWorkId() {
		return workId;
	}
	public void setWorkId(Integer workId) {
		this.workId = workId;
	}
	public String getIfMarkStr() {
		return ifMarkStr;
	}
	public void setIfMarkStr(String ifMarkStr) {
		this.ifMarkStr = ifMarkStr;
	}
	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
	public Integer getMark() {
		return mark;
	}
	public void setMark(Integer mark) {
		this.mark = mark;
	}
	public String getSno() {
		return sno;
	}
	public void setSno(String sno) {
		this.sno = sno;
	}
	public String getStuname() {
		return stuname;
	}
	public void setStuname(String stuname) {
		this.stuname = stuname;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public String getWorkname() {
		return workname;
	}
	public void setWorkname(String workname) {
		this.workname = workname;
	}
	public String getShifts() {
		return shifts;
	}
	public void setShifts(String shifts) {
		this.shifts = shifts;
	}
	//工作记录表
    private String sno;
    private String stuname;
    @JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
    private Date date;
    private String start;
    private String end;
    private String workname;
    private String shifts;
}
