package com.zjy.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjy.dao.DoctorMapper;
import com.zjy.dao.RegistrationMapper;
import com.zjy.dao.VisitMapper;
import com.zjy.entity.Doctor;
import com.zjy.entity.Registration;
import com.zjy.entity.Visit;
import com.zjy.util.Constants;
import com.zjy.util.CryptographyHelper;
import com.zjy.vo.ConfirmVo;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;
import com.zjy.vo.RegistrationResult;

@Service
public class DoctorService {

    @Autowired
    private DoctorMapper doctorMapper;
    
    @Autowired
    private VisitMapper visitMapper;
    
    @Autowired
    private RegistrationMapper regMapper;

    public boolean updateByPrimaryKeySelective(Doctor doctor) {
        try{
        	if (doctorMapper.updateByPrimaryKeySelective(doctor) == 1) {
        		return true;
        	}
        }catch (Exception e) {
            throw new RuntimeException("更新医生失败");
        }
        return false;
    }

    public int deleteByPrimaryKey(String id) {
        try{
        	return doctorMapper.deleteByPrimaryKey(id);
        }catch (Exception e) {
        	e.printStackTrace();
            throw new RuntimeException("删除医生失败");
        }
    }

    public Doctor selectByDoctorNo(String id) {
        try {
            return doctorMapper.selectByDoctorNo(id);
        }catch(Exception e) {
        	e.printStackTrace();
        	throw new RuntimeException("根据编号查询医生失败");
        }
    }
    
    public List<Doctor> selectDoctorByDepartment(String departmentNo) {
    	return doctorMapper.selectDoctorByDepartment(departmentNo);
    }
    
    public List<Doctor> selectDoctorByDepartmentAndDuty(Map<String, Object> param){
    	return doctorMapper.selectDoctorByDepartmentAndDuty(param);
    }
    
    public List<Doctor> selectDoctorNoDuty() {
    	return doctorMapper.selectDoctorNoDuty();
    }

	public DataResult updatePassword(Doctor doctor, String oldPassword, String newPassword) {
		DataResult dataResult = new DataResult();
		
		if (!doctor.getDoctorPassword().equals(CryptographyHelper.encrypt(oldPassword, doctor.getDoctorSalt()))) {
			dataResult.setStatus(false);
			dataResult.setTips("旧密码错误");
			return dataResult;
		}
		
		doctor.setDoctorSalt(CryptographyHelper.getRandomSalt());
		doctor.setDoctorPassword(CryptographyHelper.encrypt(newPassword, doctor.getDoctorSalt()));
		
        try {
    		if (doctorMapper.updateByPrimaryKeySelective(doctor)==1) {
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

	public DataGridResult queryListByRegNo(String regNo, int pageNumber,
			int pageSize) {
		PageHelper.startPage(pageNumber, pageSize);
		List<RegistrationResult> departmentList = doctorMapper.queryListByRegNo(regNo);
		PageInfo<RegistrationResult> pageInfo = new PageInfo<RegistrationResult>(departmentList);
		DataGridResult dataGridResult = new DataGridResult(pageInfo.getTotal(), pageInfo.getList(), pageInfo.getPageSize(),
				pageInfo.getPageNum());
		return dataGridResult;
	}

	public Map<String, Object> confirmVisit(String registrationNo) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		Registration reg = doctorMapper.queryRegByNo(registrationNo);
		reg.setUpdateTime();
		reg.setStatus(Constants.VISIT_TYPE);
		
		ConfirmVo confirmVo = doctorMapper.confirm(reg);
		confirmVo.setRegistrationNo(registrationNo);
		map.put("confirm", confirmVo);
		if(regMapper.updateStatus(reg)==1){
			map.put("msg", "suc");
		}else{
			map.put("msg", "fail");
		}
		
		return map;
	}

	public DataResult insertVisit(String registrationNo, String write) {
		// TODO Auto-generated method stub
		DataResult dataResult = new DataResult();
		Registration reg = doctorMapper.queryRegByNo(registrationNo);
		Visit visit = visitMapper.selectByNo(registrationNo);
		if(visit==null){
			visit = new Visit();
			visit.setId();
			visit.setAppointmentTime(reg.getAppointmentTime());
			visit.setCreateTime();
			visit.setDepartmentNo(reg.getDepartmentNo());
			visit.setDiagnosticDescription(write);
			visit.setDoctorNo(reg.getDoctorNo());
			visit.setPatientNo(reg.getPatientNo());
			visit.setRegistrationNo(registrationNo);
			visit.setStatus(reg.getStatus());
			visit.setUpdateTime();
			visit.setVisitTime(reg.getVisitTime());
			if (visitMapper.insert(visit) == 1){
				dataResult.setStatus(true);
				dataResult.setTips("病历编写成功");
			} else {
				dataResult.setStatus(false);
				dataResult.setTips("病历编写失败");
			}
		} else {
			if (visitMapper.updateDiagnostic(registrationNo, write) == 1){
				dataResult.setStatus(true);
				dataResult.setTips("病历编写成功");
			} else {
				dataResult.setStatus(false);
				dataResult.setTips("病历编写失败");
			}
		}
		
		return dataResult;
		
	}

	/**
	 * @author Mervyn
	 * 
	 * @param doctor
	 * @param password
	 * @return
	 */
	public DataResult updatePasswordByPhone(Doctor doctor, String password) {
		DataResult dataResult = new DataResult();
		
		doctor.setDoctorSalt(CryptographyHelper.getRandomSalt());
		doctor.setDoctorPassword(CryptographyHelper.encrypt(password, doctor.getDoctorSalt()));
		
        try {
    		if (doctorMapper.updateByPrimaryKeySelective(doctor)==1) {
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