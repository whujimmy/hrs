package com.zjy.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.zjy.entity.Visit;
import com.zjy.vo.VisitResult;

public interface VisitMapper {
    int deleteByPrimaryKey(String id);

    int insert(Visit visit);

    int insertSelective(Visit record);

    Visit selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Visit record);

    int updateByPrimaryKeyWithBLOBs(Visit record);

    int updateByPrimaryKey(Visit record);

    int updateDiagnostic(@Param("registrationNo")String registrationNo, @Param("diagnostic")String diagnostic);
    
    List<VisitResult> selectByPatientNo(Map<String, Object> map);

	Visit selectByNo(@Param("registrationNo")String registrationNo);

}