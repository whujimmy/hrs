package com.zjy.entity;

import java.util.Calendar;
import java.util.Date;

import com.zjy.util.Constants;
import com.zjy.util.IdGenerator;

public class Doctor {
    private String id;

    private String doctorNo;

    private String doctorName;

    private String doctorPassword;

    private String doctorSalt;

    private String doctorSex;

    private Date doctorBirth;

    private String doctorPhone;

    private Double doctorRegistrationFee;

    private Date doctorHireTime;

    private String doctorDepartmentNo;

    private Date doctorQuitTime;

    private String type;

    private Date createTime;

    private Date updateTime;

    public String getId() {
        return id;
    }

    public void setId() {
        this.id = IdGenerator.generateUUIDforPrimaryKey();
    }

    public String getDoctorNo() {
        return doctorNo;
    }

    public void setDoctorNo() {
        this.doctorNo = IdGenerator.generateNumber(this.getDoctorDepartmentNo(), Constants.DOCTOR_NO_DIGITS);
    }
    
    public void setDoctorNo(String doctorNo){
    	this.doctorNo = doctorNo;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName == null ? null : doctorName.trim();
    }

    public String getDoctorPassword() {
        return doctorPassword;
    }

    public void setDoctorPassword(String doctorPassword) {
        this.doctorPassword = doctorPassword == null ? null : doctorPassword.trim();
    }

    public String getDoctorSalt() {
        return doctorSalt;
    }

    public void setDoctorSalt(String doctorSalt) {
        this.doctorSalt = doctorSalt == null ? null : doctorSalt.trim();
    }

    public String getDoctorSex() {
        return doctorSex;
    }

    public void setDoctorSex(String doctorSex) {
        this.doctorSex = doctorSex == null ? null : doctorSex.trim();
    }

    public Date getDoctorBirth() {
        return doctorBirth;
    }

    public void setDoctorBirth(Date doctorBirth) {
        this.doctorBirth = doctorBirth;
    }

    public String getDoctorPhone() {
        return doctorPhone;
    }

    public void setDoctorPhone(String doctorPhone) {
        this.doctorPhone = doctorPhone == null ? null : doctorPhone.trim();
    }

    public Double getDoctorRegistrationFee() {
        return doctorRegistrationFee;
    }

    public void setDoctorRegistrationFee(Double doctorRegistrationFee) {
        this.doctorRegistrationFee = doctorRegistrationFee;
    }

    public Date getDoctorHireTime() {
        return doctorHireTime;
    }

    public void setDoctorHireTime(Date doctorHireTime) {
        this.doctorHireTime = doctorHireTime;
    }

    public String getDoctorDepartmentNo() {
        return doctorDepartmentNo;
    }

    public void setDoctorDepartmentNo(String doctorDepartmentNo) {
        this.doctorDepartmentNo = doctorDepartmentNo == null ? null : doctorDepartmentNo.trim();
    }

    public Date getDoctorQuitTime() {
        return doctorQuitTime;
    }

    public void setDoctorQuitTime(Date doctorQuitTime) {
        this.doctorQuitTime = doctorQuitTime;
    }

    public String getType() {
        return type;
    }

    public void setType() {
        this.type = Constants.DOCTOR_TYPE;
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