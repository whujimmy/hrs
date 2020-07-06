/**
 * 
 */
package com.zjy.vo;

import java.util.Date;

/**
 * @author Mervyn
 *
 */
public class VisitResult {
	
	private String registrationNo;
	
	private String departmentName;

	private String doctorName;
	
	private Date visitTime;
	
	private String diagnosticDescription;

	public String getRegistrationNo() {
		return registrationNo;
	}

	public void setRegistrationNo(String registrationNo) {
		this.registrationNo = registrationNo;
	}

	public String getDepartmentName() {
		return departmentName;
	}

	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}

	public String getDoctorName() {
		return doctorName;
	}

	public void setDoctorName(String doctorName) {
		this.doctorName = doctorName;
	}

	public Date getVisitTime() {
		return visitTime;
	}

	public void setVisitTime(Date visitTime) {
		this.visitTime = visitTime;
	}

	public String getDiagnosticDescription() {
		return diagnosticDescription;
	}

	public void setDiagnosticDescription(String diagnosticDescription) {
		this.diagnosticDescription = diagnosticDescription;
	}
	
}
