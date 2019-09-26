package com.irats.pojo;
/**
 * 返回表格的数据
 * @author pan tao
 *
 */

import java.util.List;


public class StudentResult {

	private Long total;
	private List<User> rows;
	public Long getTotal() {
		return total;
	}
	public void setTotal(Long total) {
		this.total = total;
	}
	public List<User> getRows() {
		return rows;
	}
	public void setRows(List<User> rows) {
		this.rows = rows;
	}
	
}
