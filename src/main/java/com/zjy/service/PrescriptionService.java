/**
 * 
 */
package com.zjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjy.dao.PrescriptionMapper;
import com.zjy.entity.Prescription;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;
import com.zjy.vo.PrescriptionResult;
import com.zjy.vo.VisitResult;

/**
 * @author Mervyn
 *
 */

@Service
public class PrescriptionService {
    
    @Autowired
    private PrescriptionMapper prescriptionMapper;

    public boolean addPrescriptions(List<Prescription> list) {
        // TODO Auto-generated method stub
        try {
        	prescriptionMapper.addPrescriptions(list);
            return true;
        } catch (Exception e) {
            // TODO: handle exception
            throw new RuntimeException("处方批量插入失败");
        }
    }

    public DataResult insertPrescription(Prescription prescription) {
        // TODO Auto-generated method stub
        DataResult dataResult = new DataResult();
        try {
            if(prescriptionMapper.insert(prescription)==1) {
                dataResult.setStatus(true);
                dataResult.setTips("插入成功");
            }
        } catch (Exception e) {
            // TODO: handle exception
            dataResult.setStatus(false);
            dataResult.setTips("插入失败");
        }
        return dataResult;
    }
	
	public DataGridResult selectByRegistrationNoPage(String registrationNo, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<PrescriptionResult> prescriptionList = prescriptionMapper.selectByRegistrationNo(registrationNo);
		PageInfo<PrescriptionResult> pageInfo = new PageInfo<PrescriptionResult>(prescriptionList);
		DataGridResult dataGridResult = new DataGridResult(pageInfo.getTotal(), pageInfo.getList(), pageInfo.getPageSize(),
				pageInfo.getPageNum());
		return dataGridResult;
	}
	
	public List<PrescriptionResult> selectByRegistrationNo(String registrationNo) {
		return prescriptionMapper.selectByRegistrationNo(registrationNo);
	}

	public Prescription selectByNo(String registrationNo, String medicineNo) {
		// TODO Auto-generated method stub
		Prescription prescription = prescriptionMapper.selectByNo(registrationNo,medicineNo);
		return prescription;
	}

	public void update(Prescription prescription) {
		// TODO Auto-generated method stub
		prescriptionMapper.updateByPrimaryKey(prescription);
	}

}
