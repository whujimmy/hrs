package com.zjy.entity;

import com.zjy.util.IdGenerator;

public class Prescription {
    private String id;

    private String registrationNo;

    private String medicineNo;

    private Integer medicineAmount;

    public String getId() {
        return id;
    }

    public void setId() {
        this.id = IdGenerator.generateUUIDforPrimaryKey();
    }

    public String getRegistrationNo() {
        return registrationNo;
    }

    public void setRegistrationNo(String registrationNo) {
        this.registrationNo = registrationNo == null ? null : registrationNo.trim();
    }

    public String getMedicineNo() {
        return medicineNo;
    }

    public void setMedicineNo(String medicineNo) {
        this.medicineNo = medicineNo == null ? null : medicineNo.trim();
    }

    public Integer getMedicineAmount() {
        return medicineAmount;
    }

    public void setMedicineAmount(Integer medicineAmount) {
        this.medicineAmount = medicineAmount;
    }
}