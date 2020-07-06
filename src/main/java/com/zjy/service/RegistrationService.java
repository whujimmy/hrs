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
import com.zjy.dao.RegistrationMapper;
import com.zjy.entity.Registration;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;
import com.zjy.vo.DeptAccountResult;
import com.zjy.vo.RegistrationResult;

/**
 * @author Mervyn
 *
 */

@Service
public class RegistrationService {

	@Autowired
	private RegistrationMapper registrationMapper;
	
	public DataResult insert(Registration registration) {
		DataResult dataResult = new DataResult();
		try {
			if (registrationMapper.insert(registration) == 1) {
				dataResult.setStatus(true);
				dataResult.setTips("预约成功");
			} else {
				dataResult.setStatus(false);
				dataResult.setTips("预约失败");
			}
		} catch(Exception e) {
			e.printStackTrace();
			dataResult.setStatus(false);
			dataResult.setTips("预约失败");
		}
		return dataResult;
	}
	
	public DataGridResult selectRegistrationInfoByPage(Map<String, Object> map, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<RegistrationResult> registrationList = registrationMapper.selectRegistrationInfoByPage(map);
		PageInfo<RegistrationResult> pageInfo = new PageInfo<RegistrationResult>(registrationList);
		DataGridResult dataGridResult = new DataGridResult(pageInfo.getTotal(), pageInfo.getList(), pageInfo.getPageSize(),
				pageInfo.getPageNum());
		return dataGridResult;
	}
	
	public DataResult cancelRegistration(String registrationNo) {
		DataResult dataResult = new DataResult();
		
		try {
			if (registrationMapper.cancelRegistration(registrationNo)==1) {
				dataResult.setStatus(true);
				dataResult.setTips("取消成功");
			} else {
				dataResult.setStatus(false);
				dataResult.setTips("取消失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			dataResult.setStatus(false);
			dataResult.setTips("取消失败");
		}
		
		return dataResult;
	}
	
	public List<Registration> selectByDate(String time) {
		return registrationMapper.selectByDate(time);
	}
	
	public int updateByPrimaryKeySelective(Registration registration) {
		return registrationMapper.updateByPrimaryKeySelective(registration);
	}
	
    public List<DeptAccountResult> registrationAccountByDept() {
    	return registrationMapper.registrationAccountByDept();
    }
}
