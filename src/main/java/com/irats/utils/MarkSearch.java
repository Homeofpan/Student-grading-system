package com.irats.utils;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.irats.pojo.Mark;

public class MarkSearch extends Mark {
	
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	private Date beginTime;
	
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8")
	private Date endTime;
	
	private double average;
	
	public double getAverage() {
		return average;
	}
	public void setAverage(double average) {
		this.average = average;
	}
	public Date getBeginTime() {
		return beginTime;
	}
	public void setBeginTime(Date beginTime) {
		this.beginTime = beginTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	@Override
	public String toString() {
		return "MarkSearch [beginTime=" + beginTime + ", endTime=" + endTime + "]";
	}
	
	
}
