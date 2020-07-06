package com.zjy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zjy.entity.Department;

public interface DepartmentMapper {
    int deleteByDeptNo(String departmentNo);

    int insert(Department record);

    int insertSelective(Department record);

    Department selectByPrimaryKey(String id);

    int updateByNoSelective(Department record);

    int updateByPrimaryKey(Department record);

    Department selectByDeptNo(String departmentNo);
    
    List<Department> selectPageListByName(Department departmentName);
    
    List<Department> selectDepartment();

    int updateByNo(@Param("departmentNo")String departmentNo, @Param("depName")String depName);
}