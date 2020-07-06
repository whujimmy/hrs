package com.zjy.entity;

import java.util.Date;

/**
 * 
 * TODO
 *
 * @author zhoujiayi
 * @version $Id: Consultation.java, v 0.1 2018年3月30日 上午10:43:30 zhoujiayi Exp $
 */
public class Consultation {

    /**
     * 预约编号
     */
    private String registrationNo;

    /**
     * 病人编号
     */
    private String patientNo;

    /**
     * 病人姓名
     */
    private String patientName;

    /**
     * 年龄
     */
    private Date patientBirth;


    /**
     * 性别
     */
    private String patientSex;


    /**
     * 就诊科室
     */
    private String departmentName;

    /**
     * 首诊大夫
     */
    private String doctorName;

    /**
     * 预约时间
     */
    private Date appointmentTime;

    /**
     * 病例
     */
    private String diagnosticDescription;

    public String getRegistrationNo() {
        return registrationNo;
    }

    public void setRegistrationNo(String registrationNo) {
        this.registrationNo = registrationNo;
    }

    public String getPatientNo() {
        return patientNo;
    }

    public void setPatientNo(String patientNo) {
        this.patientNo = patientNo;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public Date getPatientBirth() {
        return patientBirth;
    }

    public void setPatientBirth(Date patientBirth) {
        this.patientBirth = patientBirth;
    }

    public String getPatientSex() {
        return patientSex;
    }

    public void setPatientSex(String patientSex) {
        this.patientSex = patientSex;
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

    public Date getAppointmentTime() {
        return appointmentTime;
    }

    public void setAppointmentTime(Date appointmentTime) {
        this.appointmentTime = appointmentTime;
    }

    public String getDiagnosticDescription() {
        return diagnosticDescription;
    }

    public void setDiagnosticDescription(String diagnosticDescription) {
        this.diagnosticDescription = diagnosticDescription;
    }

}
