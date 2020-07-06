/**
 * 
 */
package com.zjy.vo;

import com.zjy.entity.Doctor;

/**
 * @author Mervyn
 *
 */
public class DoctorResult extends Doctor {
	
	private String departmentName;

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	
}
