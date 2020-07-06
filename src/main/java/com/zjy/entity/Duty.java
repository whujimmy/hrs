package com.zjy.entity;

import com.zjy.util.Constants;
import com.zjy.util.IdGenerator;

public class Duty {
    private String id;

    private String doctorNo;

    private String monday;

    private Integer mondayRest;

    private String tuesday;

    private Integer tuesdayRest;

    private String wednesday;

    private Integer wednesdayRest;

    private String thursday;

    private Integer thursdayRest;

    private String friday;

    private Integer fridayRest;

    private String saturday;

    private Integer saturdayRest;

    private String sunday;

    private Integer sundayRest;

    public void init() {
    	this.monday = Constants.NOT_ON_DUTY;
    	this.tuesday = Constants.NOT_ON_DUTY;
    	this.wednesday = Constants.NOT_ON_DUTY;
    	this.thursday = Constants.NOT_ON_DUTY;
    	this.friday = Constants.NOT_ON_DUTY;
    	this.saturday = Constants.NOT_ON_DUTY;
    	this.sunday = Constants.NOT_ON_DUTY;
    }
    
    public String getId() {
        return id;
    }

    public void setId() {
        this.id = IdGenerator.generateUUIDforPrimaryKey();
    }

    public String getDoctorNo() {
        return doctorNo;
    }

    public void setDoctorNo(String doctorNo) {
        this.doctorNo = doctorNo == null ? null : doctorNo.trim();
    }

    public String getMonday() {
        return monday;
    }

    public void setMonday(String monday) {
        this.monday = monday == null ? null : monday.trim();
    }

    public Integer getMondayRest() {
        return mondayRest;
    }

    public void setMondayRest(Integer mondayRest) {
        this.mondayRest = mondayRest;
    }

    public String getTuesday() {
        return tuesday;
    }

    public void setTuesday(String tuesday) {
        this.tuesday = tuesday == null ? null : tuesday.trim();
    }

    public Integer getTuesdayRest() {
        return tuesdayRest;
    }

    public void setTuesdayRest(Integer tuesdayRest) {
        this.tuesdayRest = tuesdayRest;
    }

    public String getWednesday() {
        return wednesday;
    }

    public void setWednesday(String wednesday) {
        this.wednesday = wednesday == null ? null : wednesday.trim();
    }

    public Integer getWednesdayRest() {
        return wednesdayRest;
    }

    public void setWednesdayRest(Integer wednesdayRest) {
        this.wednesdayRest = wednesdayRest;
    }

    public String getThursday() {
        return thursday;
    }

    public void setThursday(String thursday) {
        this.thursday = thursday == null ? null : thursday.trim();
    }

    public Integer getThursdayRest() {
        return thursdayRest;
    }

    public void setThursdayRest(Integer thursdayRest) {
        this.thursdayRest = thursdayRest;
    }

    public String getFriday() {
        return friday;
    }

    public void setFriday(String friday) {
        this.friday = friday == null ? null : friday.trim();
    }

    public Integer getFridayRest() {
        return fridayRest;
    }

    public void setFridayRest(Integer fridayRest) {
        this.fridayRest = fridayRest;
    }

    public String getSaturday() {
        return saturday;
    }

    public void setSaturday(String saturday) {
        this.saturday = saturday == null ? null : saturday.trim();
    }

    public Integer getSaturdayRest() {
        return saturdayRest;
    }

    public void setSaturdayRest(Integer saturdayRest) {
        this.saturdayRest = saturdayRest;
    }

    public String getSunday() {
        return sunday;
    }

    public void setSunday(String sunday) {
        this.sunday = sunday == null ? null : sunday.trim();
    }

    public Integer getSundayRest() {
        return sundayRest;
    }

    public void setSundayRest(Integer sundayRest) {
        this.sundayRest = sundayRest;
    }
}