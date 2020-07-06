package com.zjy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zjy.entity.Prescription;
import com.zjy.vo.PrescriptionResult;

public interface PrescriptionMapper {
    int deleteByPrimaryKey(String id);

    int insert(Prescription record);

    int insertSelective(Prescription record);

    Prescription selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Prescription record);

    int updateByPrimaryKey(Prescription record);

    void addPrescriptions(List<Prescription> list);
    
    List<PrescriptionResult> selectByRegistrationNo(String registrationNo);

	Prescription selectByNo(@Param("registrationNo")String registrationNo, @Param("medicineNo")String medicineNo);
}