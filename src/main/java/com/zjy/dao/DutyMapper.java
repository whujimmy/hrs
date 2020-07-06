package com.zjy.dao;

import java.util.List;
import java.util.Map;

import com.zjy.entity.Duty;
import com.zjy.vo.DutyResult;

public interface DutyMapper {
    int deleteByPrimaryKey(String id);
    
    int deleteByDoctorNo(String doctorNo);

    int insert(Duty record);

    int insertSelective(Duty record);

    Duty selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Duty record);

    int updateByPrimaryKey(Duty record);

    Duty selectDutyByNo(String id);
    
    List<String> selectDoctorByDuty(Duty duty);
    
    int updateDuty(Duty duty);
    
    List<DutyResult> selectDutyByPage(Map<String, String> map);
}