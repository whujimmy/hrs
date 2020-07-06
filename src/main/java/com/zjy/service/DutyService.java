/**
 * 
 */
package com.zjy.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjy.dao.DoctorMapper;
import com.zjy.dao.DutyMapper;
import com.zjy.entity.Doctor;
import com.zjy.entity.Duty;
import com.zjy.util.Constants;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;
import com.zjy.vo.DutyResult;

/**
 * @author Mervyn
 *
 */

@Service
public class DutyService {

    @Autowired
    private DutyMapper dutyMapper;
    
    @Autowired
    private DoctorMapper doctorMapper;
    
    public Duty queryDutyById(String id) {
        // TODO Auto-generated method stub
        try {
            return dutyMapper.selectDutyByNo(id);
        } catch (Exception e) {
            // TODO: handle exception
            throw new RuntimeException("医生编号"+id+"有误，查找值班信息失败");
        }
    }

    /**
     * 1--值班     0--不值班
     * 返回的map是根据部门分，周一到周日每天值班医生的姓名集合
     * 如果要区分上午下午，可以再加一个状态值，
     * 同时将map里面的List<String>变为List<String[]>
     * 
     * @param depNo
     * @return
     */
    public Map<String, List<String>> queryscheduling(String depNo) {
        // TODO Auto-generated method stub
        try {
            List<Doctor> list = doctorMapper.queryDoctorByDepNo(depNo);
            Map<String, List<String>> map = new HashMap<String, List<String>>();
            List<String> Monday = new ArrayList<String>();
            List<String> Tuesday = new ArrayList<String>();
            List<String> Wednesday = new ArrayList<String>();
            List<String> Thursday = new ArrayList<String>();
            List<String> Friday = new ArrayList<String>();
            List<String> Saturday = new ArrayList<String>();
            List<String> Sunday = new ArrayList<String>();
            for(Doctor doctor : list) {
               Duty duty = dutyMapper.selectDutyByNo(doctor.getDoctorDepartmentNo());
               if(Constants.ON_DUTY.equals(duty.getMonday())) {
                   Monday.add(doctor.getDoctorName());
               }
               if(Constants.ON_DUTY.equals(duty.getTuesday())) {
                   Tuesday.add(doctor.getDoctorName());
               }
               if(Constants.ON_DUTY.equals(duty.getWednesday())) {
                   Wednesday.add(doctor.getDoctorName());
               }
               if(Constants.ON_DUTY.equals(duty.getThursday())) {
                   Thursday.add(doctor.getDoctorName());
               }
               if(Constants.ON_DUTY.equals(duty.getFriday())) {
                   Friday.add(doctor.getDoctorName());
               }
               if(Constants.ON_DUTY.equals(duty.getSaturday())) {
                   Saturday.add(doctor.getDoctorName());
               }
               if(Constants.ON_DUTY.equals(duty.getSunday())) {
                   Sunday.add(doctor.getDoctorName());
               }
            }
            map.put("Monday", Monday);
            map.put("Tuesday", Tuesday);
            map.put("Wednesday", Wednesday);
            map.put("Thursday", Thursday);
            map.put("Friday", Friday);
            map.put("Saturday", Saturday);
            map.put("Sunday", Sunday);
            return map;
        }catch(Exception e) {
            throw new RuntimeException("查看科室值班表失败");
        }
    }
    
    public List<String> selectDoctorByDuty(Duty duty) {
    	return dutyMapper.selectDoctorByDuty(duty);
    }

    public int updateDuty(Duty duty) {
    	return dutyMapper.updateDuty(duty); 
    }
    
    public Duty selectDutyByNo(String id) {
    	return dutyMapper.selectDutyByNo(id);
    }
    
    public int updateByPrimaryKeySelective(Duty duty) {
    	return dutyMapper.updateByPrimaryKeySelective(duty);
    }
    
	public DataGridResult selectDutyByPage(Map<String, String> map, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<DutyResult> dutyList = dutyMapper.selectDutyByPage(map);
		PageInfo<DutyResult> pageInfo = new PageInfo<DutyResult>(dutyList);
		DataGridResult dataGridResult = new DataGridResult(pageInfo.getTotal(), pageInfo.getList(), pageInfo.getPageSize(),
				pageInfo.getPageNum());
		return dataGridResult;
	}
	
	public DataResult insertSelective(Duty duty) {
		DataResult dataResult = new DataResult();
		try {
			if (dutyMapper.insertSelective(duty) == 1) {
				dataResult.setStatus(true);
				dataResult.setTips("新建排班成功");
			} else {
				dataResult.setStatus(false);
				dataResult.setTips("新建排班失败");
			}
		} catch(Exception e) {
			e.printStackTrace();
			dataResult.setStatus(false);
			dataResult.setTips("新建排班失败");
		}
		return dataResult;
	}
	
	public DataResult deleteByDoctorNo(String doctorNo) {
		DataResult dataResult = new DataResult();
		try {
			if (dutyMapper.deleteByDoctorNo(doctorNo) == 1) {
				dataResult.setStatus(true);
				dataResult.setTips("删除排班成功");
			} else {
				dataResult.setStatus(false);
				dataResult.setTips("删除排班失败");
			}
		} catch(Exception e) {
			e.printStackTrace();
			dataResult.setStatus(false);
			dataResult.setTips("删除排班失败");
		}
		return dataResult;
	}
}
