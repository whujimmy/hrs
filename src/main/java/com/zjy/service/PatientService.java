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
import com.zjy.dao.PatientMapper;
import com.zjy.entity.Department;
import com.zjy.entity.Patient;
import com.zjy.util.CryptographyHelper;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;

/**
 * @author Mervyn
 *
 */

@Service
public class PatientService {

	@Autowired
	private PatientMapper patientMapper;
	
	public DataResult insert(Patient patient) {
		DataResult dataResult = new DataResult();
        try {
    		if (patientMapper.insert(patient)==1) {
    			dataResult.setStatus(true);
    			dataResult.setTips("添加病人成功");
    		}
        }catch(Exception e) {
			dataResult.setStatus(false);
			dataResult.setTips("添加病人失败");
        }
		return dataResult;
	}
	
	public DataResult updateByPrimaryKeySelective(Patient patient) {
		DataResult dataResult = new DataResult();
        try {
    		if (patientMapper.updateByPrimaryKeySelective(patient)==1) {
    			dataResult.setStatus(true);
    			dataResult.setTips("更新病人成功");
    		}
        }catch(Exception e) {
			dataResult.setStatus(false);
			dataResult.setTips("更新病人失败");
        }
		return dataResult;
	}
	
	public DataResult updatePhone(Patient patient, String phone) {
		DataResult dataResult = new DataResult();
		
		patient.setPatientPhone(phone);
		patient.setUpdateTime();
        try {
    		if (patientMapper.updateByPrimaryKeySelective(patient)==1) {
    			dataResult.setStatus(true);
    			dataResult.setTips("修改手机号成功");
    		} else {
    			dataResult.setStatus(false);
    			dataResult.setTips("修改手机号失败");
    		}
        }catch(Exception e) {
			dataResult.setStatus(false);
			dataResult.setTips("修改手机号失败");
        }
        
		return dataResult;
	}
	
	public DataResult updatePassword(Patient patient, String oldPassword, String newPassword) {
		DataResult dataResult = new DataResult();
		
		if (!patient.getPatientPassword().equals(CryptographyHelper.encrypt(oldPassword, patient.getPatientSalt()))) {
			dataResult.setStatus(false);
			dataResult.setTips("旧密码错误");
			return dataResult;
		}
		
		patient.setPatientSalt(CryptographyHelper.getRandomSalt());
		patient.setPatientPassword(CryptographyHelper.encrypt(newPassword, patient.getPatientSalt()));
		
        try {
    		if (patientMapper.updateByPrimaryKeySelective(patient)==1) {
    			dataResult.setStatus(true);
    			dataResult.setTips("修改密码成功");
    		} else {
    			dataResult.setStatus(false);
    			dataResult.setTips("修改密码失败");
    		}
        }catch(Exception e) {
			dataResult.setStatus(false);
			dataResult.setTips("修改密码失败");
        }
        
		return dataResult;
	}
	
    public Patient selectByPatientNo(String id) {
        try {
            return patientMapper.selectByPatientNo(id);
        }catch(Exception e) {
            throw new RuntimeException("根据编号查询病人失败");
        }
    }
    
	public DataGridResult pageQueryPatientByWhere(Map<String, String> map, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Patient> patientList = patientMapper.pageQueryPatientByWhere(map);
		PageInfo<Patient> pageInfo = new PageInfo<Patient>(patientList);
		DataGridResult dataGridResult = new DataGridResult(pageInfo.getTotal(), pageInfo.getList(), pageInfo.getPageSize(),
				pageInfo.getPageNum());
		return dataGridResult;
	}

	/**
	 * @author Mervyn
	 * 
	 * @param patient
	 * @param password
	 * @return
	 */
	public DataResult updatePasswordByPhone(Patient patient, String password) {
		DataResult dataResult = new DataResult();
		
		patient.setPatientSalt(CryptographyHelper.getRandomSalt());
		patient.setPatientPassword(CryptographyHelper.encrypt(password, patient.getPatientSalt()));
		
        try {
    		if (patientMapper.updateByPrimaryKeySelective(patient)==1) {
    			dataResult.setStatus(true);
    			dataResult.setTips("修改密码成功");
    		} else {
    			dataResult.setStatus(false);
    			dataResult.setTips("修改密码失败");
    		}
        }catch(Exception e) {
			dataResult.setStatus(false);
			dataResult.setTips("修改密码失败");
        }
        
		return dataResult;
	}
}
