/**
 * 
 */
package com.zjy.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjy.dao.MedicineMapper;
import com.zjy.entity.Department;
import com.zjy.entity.Medicine;
import com.zjy.vo.BatchResult;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;

/**
 * @author Mervyn
 *
 */

@Service
public class MedicineService {
    
    @Autowired
    private MedicineMapper mMapper;

    public Map<String, Object> queryByMedicineName(String medicineName, int a, int b) {
        // TODO Auto-generated method stub
        Map<String, Object> result = new HashMap<String, Object>();
        List<Medicine> rows = mMapper.selectByMedicineName(medicineName,a,b);
        result.put("rows", rows);
        result.put("total", mMapper.count(medicineName));
        return result;
    }

    public DataResult addMedicine(Medicine medicine) {
        // TODO Auto-generated method stub
        DataResult dataResult = new DataResult();
        if(medicine.getMedicineLastAddAccount()==null)
        	medicine.setMedicineLastAddAccount(0);
        try {
            if(mMapper.insertSelective(medicine)==1) {
                dataResult.setStatus(true);
                dataResult.setTips("添加成功");
            }else {
                dataResult.setStatus(false);
                dataResult.setTips("添加失败");
            }
        } catch (Exception e) {
            // TODO: handle exception
            dataResult.setStatus(false);
            dataResult.setTips("添加失败");
        }
        return dataResult;
    }

    public DataGridResult queryListByName(String name, int pageNum, int pageSize) {
        // TODO Auto-generated method stub
        PageHelper.startPage(pageNum, pageSize);
        List<Medicine> medicineList = mMapper.selectPageListByName(name);
        PageInfo<Medicine> pageInfo = new PageInfo<Medicine>(medicineList);
        DataGridResult dataGridResult = new DataGridResult(pageInfo.getTotal(), pageInfo.getList(), pageInfo.getPageSize(),
                pageInfo.getPageNum());
        return dataGridResult;
    }

    public Medicine selectByMedicineNo(String medicineNo) {
        // TODO Auto-generated method stub
        return mMapper.selectByMedicineNo(medicineNo);
    }

    public BatchResult<Medicine> deleteByMedicineNo(String medicineNoArray[]) {
        // TODO Auto-generated method stub
        BatchResult<Medicine> batchResult = new BatchResult<Medicine>();
        for (int i = 0; i < medicineNoArray.length; ++i) {
            if (mMapper.deleteByMedicineNo(medicineNoArray[i]) == 1) {
                batchResult.addSuccess();
            } else {
                batchResult.addFail();
                batchResult.addToFailList(mMapper.selectByMedicineNo(medicineNoArray[i]));
                batchResult.setTips("删除失败！");
            }
        }
        return batchResult;
    }

    public DataResult updateByNo(Medicine medicine) {
        // TODO Auto-generated method stub
        DataResult dataResult = new DataResult();
        try {
            if(mMapper.updateByNo(medicine)==1) {
                dataResult.setStatus(true);
                dataResult.setTips("修改成功");
            }
        } catch (Exception e) {
            dataResult.setStatus(false);
            dataResult.setTips("修改失败");
        }
        return dataResult;
    }

}
