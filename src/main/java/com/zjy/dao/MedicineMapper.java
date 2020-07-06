package com.zjy.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.zjy.entity.Medicine;

public interface MedicineMapper {
    int deleteByPrimaryKey(String id);

    int insert(Medicine record);

    int insertSelective(Medicine record);

    Medicine selectByPrimaryKey(String id);

    int updateByPrimaryKeySelective(Medicine record);

    int updateByPrimaryKey(Medicine record);

    List<Medicine> selectByMedicineName(String medicineName, int a, int b);

    int count(String medicineName);

    List<Medicine> selectPageListByName(@Param("name")String name);

    Medicine selectByMedicineNo(String medicineNo);

    int deleteByMedicineNo(@Param("medicineNo")String medicineNo);

    int updateByNo(Medicine medicine);
}