package com.zjy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.zjy.entity.Doctor;
import com.zjy.entity.Registration;
import com.zjy.vo.ConfirmVo;
import com.zjy.vo.DoctorResult;
import com.zjy.vo.RegistrationResult;

public interface DoctorMapper {
    int deleteByPrimaryKey(String id);

    int insert(Doctor record);

    int insertSelective(Doctor record);

    Doctor selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Doctor record);

    int updateByPrimaryKey(Doctor record);

    Doctor selectByDoctorNo(String id);

    List<Doctor> selectDoctorNoDuty();
    
    List<DoctorResult> queryDoctor(Map<String, Object> param);

    List<Doctor> queryDoctorByDepNo(String depNo);
    
    List<Doctor> selectDoctorByDepartment(String departmentNo);
    
    List<Doctor> selectDoctorByDepartmentAndDuty(Map<String, Object> param);

    int selectCountByDeptNo(String departmentNo);
    
    int count(Map<String, Object> param);

    int deleteByDoctorNo(String doctorNo);

    int updateByNo(Doctor doctor);

	List<RegistrationResult> queryListByRegNo(@Param("regNo")String regNo);

	Registration queryRegByNo(@Param("regNo")String regNo);

	ConfirmVo confirm(Registration reg);
}