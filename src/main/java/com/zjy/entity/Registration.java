package com.zjy.entity;

import java.util.Calendar;
import java.util.Date;

import com.zjy.util.Constants;
import com.zjy.util.IdGenerator;

public class Registration {
    private String id;

    private String registrationNo;

    private String patientNo;

    private String departmentNo;

    private String doctorNo;

    private Date appointmentTime;

    private Date visitTime;

    private String status;

    private Date createTime;

    private Date updateTime;

    public String getId() {
        return id;
    }

    public void setId() {
        this.id = IdGenerator.generateUUIDforPrimaryKey();
    }

    public String getRegistrationNo() {
        return registrationNo;
    }

    public void setRegistrationNo() {
        this.registrationNo = IdGenerator.generateNumber(Constants.REGISTRATION_NO_PREFIX, Constants.REGISTRATION_NO_DIGITS);
    }

    public String getPatientNo() {
        return patientNo;
    }

    public void setPatientNo(String patientNo) {
        this.patientNo = patientNo == null ? null : patientNo.trim();
    }

    public String getDepartmentNo() {
        return departmentNo;
    }

    public void setDepartmentNo(String departmentNo) {
        this.departmentNo = departmentNo == null ? null : departmentNo.trim();
    }

    public String getDoctorNo() {
        return doctorNo;
    }

    public void setDoctorNo(String doctorNo) {
        this.doctorNo = doctorNo == null ? null : doctorNo.trim();
    }

    public Date getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(Date appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public Date getVisitTime() {
        return visitTime;
    }

    public void setVisitTime(Date visitTime) {
        this.visitTime = visitTime;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime() {
        this.createTime = Calendar.getInstance().getTime();
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime() {
        this.updateTime = Calendar.getInstance().getTime();
    }
}