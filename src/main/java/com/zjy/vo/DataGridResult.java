/**
 * 
 */
package com.zjy.vo;

import java.io.Serializable;
import java.util.List;
import java.util.Map;


/**
 * @author Mervyn
 *
 */
public class DataGridResult implements Serializable {

	private long total;
	private List<?> rows;
	private Integer pageSize;
	private Integer pageNum;
	private Map<String, Object> obj;

	public DataGridResult() {
		super();
	}

	public DataGridResult(long total, List<?> rows, Integer pageSize, Integer pageNum) {
		this.total = total;
		this.rows = rows;
		this.pageSize = pageSize;
		this.pageNum = pageNum;
	}

	public DataGridResult(long total, List<?> rows, Integer pageSize, Integer pageNum, Map<String, Object> obj) {
		this.total = total;
		this.rows = rows;
		this.pageSize = pageSize;
		this.pageNum = pageNum;
		this.obj = obj;
	}

	public Integer getPageNum() {
		return pageNum;
	}

	public void setPageNum(Integer pageNum) {
		this.pageNum = pageNum;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public long getTotal() {
		return total;
	}

	public void setTotal(long total) {
		this.total = total;
	}

	public List<?> getRows() {
		return rows;
	}

	public void setRows(List<?> rows) {
		this.rows = rows;
	}

	public Map<String, Object> getObj() {
		return obj;
	}

	public void setObj(Map<String, Object> obj) {
		this.obj = obj;
	}

}