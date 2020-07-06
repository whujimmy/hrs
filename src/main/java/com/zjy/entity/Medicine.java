package com.zjy.entity;

import java.util.Calendar;
import java.util.Date;

import com.zjy.util.Constants;
import com.zjy.util.IdGenerator;

public class Medicine {
    private String id;

    private String medicineNo;

    private String medicineName;

    private Double medicinePrice;

    private Integer medicineAmount;

    private Integer medicineLastAddAccount;

    private Date updateTime;

    public String getId() {
        return id;
    }

    public void setId() {
        this.id = IdGenerator.generateUUIDforPrimaryKey();
    }

    public String getMedicineNo() {
        return medicineNo;
    }

    public void setMedicineNo() {
        this.medicineNo = IdGenerator.generateNumber(Constants.MEDICINE_NO_PREFIX, Constants.MEDICINE_NO_DIGITS);
    }
    
    public void setMedicineNo(String medicineNo){
    	this.medicineNo = medicineNo;
    }

    public String getMedicineName() {
        return medicineName;
    }

    public void setMedicineName(String medicineName) {
        this.medicineName = medicineName == null ? null : medicineName.trim();
    }

    public Double getMedicinePrice() {
        return medicinePrice;
    }

    public void setMedicinePrice(Double medicinePrice) {
        this.medicinePrice = medicinePrice;
    }

    public Integer getMedicineAmount() {
        return medicineAmount;
    }

    public void setMedicineAmount(Integer medicineAmount) {
        this.medicineAmount = medicineAmount;
    }

    public Integer getMedicineLastAddAccount() {
        return medicineLastAddAccount;
    }

    public void setMedicineLastAddAccount(Integer medicineLastAddAccount) {
        this.medicineLastAddAccount = medicineLastAddAccount;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime() {
        this.updateTime = Calendar.getInstance().getTime();
    }
}