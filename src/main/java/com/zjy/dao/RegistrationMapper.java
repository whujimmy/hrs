package com.zjy.dao;

import java.util.List;
import java.util.Map;

import com.zjy.entity.Registration;
import com.zjy.vo.DeptAccountResult;
import com.zjy.vo.RegistrationResult;

public interface RegistrationMapper {
    int deleteByPrimaryKey(String id);

    int insert(Registration record);

    int insertSelective(Registration record);

    Registration selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Registration record);

    int updateByPrimaryKey(Registration record);

    Registration selectRegistrationByNo(String regNo);
    
    List<RegistrationResult> selectRegistrationInfoByPage(Map<String, Object> map);
    
    int cancelRegistration(String registrationNo);
    
    List<Registration> selectByDate(String time);
    
    List<DeptAccountResult> registrationAccountByDept();

	int updateStatus(Registration reg);
}