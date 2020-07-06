/**
 * 
 */
package com.zjy.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Mervyn
 *
 */
public class BatchResult<T> {
	private int numOfSuccess = 0;
	private int numOfFail = 0;
	private List<T> failEntityList = new ArrayList<T>();
	private String tips;

	public String getTips() {
		return tips;
	}

	public void setTips(String tips) {
		this.tips = tips;
	}

	public void addSuccess() {
		this.numOfSuccess++;
	}
	
	public void addFail() {
		this.numOfFail++;
	}
	
	public void addToFailList(T failEntity) {
		this.failEntityList.add(failEntity);
	}

	public int getNumOfSuccess() {
		return numOfSuccess;
	}

	public void setNumOfSuccess(int numOfSuccess) {
		this.numOfSuccess = numOfSuccess;
	}

	public int getNumOfFail() {
		return numOfFail;
	}

	public void setNumOfFail(int numOfFail) {
		this.numOfFail = numOfFail;
	}

	public List<T> getFailEntityList() {
		return failEntityList;
	}

	public void setFailEntityList(List<T> failEntityList) {
		this.failEntityList = failEntityList;
	}
}
