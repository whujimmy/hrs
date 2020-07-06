package com.zjy.dao;

import java.util.List;
import java.util.Map;

import com.zjy.entity.Patient;

public interface PatientMapper {
    int deleteByPrimaryKey(String id);

    int insert(Patient record);

    int insertSelective(Patient record);

    Patient selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Patient record);

    int updateByPrimaryKey(Patient record);

    Patient selectByPatientNo(String id);
    
    List<Patient> pageQueryPatientByWhere(Map<String, String> map);
}