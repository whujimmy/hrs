package com.zjy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjy.dao.DoctorMapper;
import com.zjy.dao.DutyMapper;
import com.zjy.entity.Doctor;
import com.zjy.vo.BatchResult;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;
import com.zjy.vo.DoctorResult;

/**
 * 
 * TODO
 *
 * @author zhoujiayi
 * @version $Id: AdminService.java, v 0.1 2018年3月29日 下午3:26:00 zhoujiayi Exp $
 */
@Service
public class AdminService {
    
    @Autowired
    private DoctorMapper doctorMapper;
    
    @Autowired
    private DutyMapper dutyMapper;

    public DataResult insert(Doctor doctor) {
    	DataResult dataResult = new DataResult();
        try{
            if (doctorMapper.insert(doctor) == 1) {
                dataResult.setStatus(true);
                dataResult.setTips("插入成功");
            }
        }catch (Exception e) {
            dataResult.setStatus(false);
            dataResult.setTips("插入失败");
        }
        return dataResult;
    }
    
    public DataGridResult queryDoctorByPage(Map<String, Object> param, int pageNumber, int pageSize) {
        // TODO Auto-generated method stub
        PageHelper.startPage(pageNumber, pageSize);
        List<DoctorResult> doctortList = doctorMapper.queryDoctor(param);
        PageInfo<DoctorResult> pageInfo = new PageInfo<DoctorResult>(doctortList);
        DataGridResult dataGridResult = new DataGridResult(pageInfo.getTotal(), pageInfo.getList(), pageInfo.getPageSize(),
                pageInfo.getPageNum());
        return dataGridResult;
    }

    public BatchResult<Doctor> deleteByDoctorNo(String doctorNoArray[]) {
        // TODO Auto-generated method stub
        BatchResult<Doctor> batchResult = new BatchResult<Doctor>();
        for (int i = 0; i < doctorNoArray.length; ++i) {
            if (doctorMapper.deleteByDoctorNo(doctorNoArray[i]) == 1) {
                batchResult.addSuccess();
                dutyMapper.deleteByDoctorNo(doctorNoArray[i]);
            } else {
                batchResult.addFail();
                batchResult.addToFailList(doctorMapper.selectByDoctorNo(doctorNoArray[i]));
                batchResult.setTips("操作失败");
            }
        }
        
        return batchResult;
    }

    public Doctor selectByDoctorNo(String doctorNo) {
        // TODO Auto-generated method stub
        return doctorMapper.selectByDoctorNo(doctorNo);
    }

    public DataResult updateDoctor(Doctor doctor) {
        // TODO Auto-generated method stub
        DataResult dataResult = new DataResult();
        try {
            if(doctorMapper.updateByNo(doctor)==1) {
                dataResult.setStatus(true);
                dataResult.setTips("修改成功");
            } else {
                dataResult.setStatus(false);
                dataResult.setTips("这？");
            }
        } catch (Exception e) {
            dataResult.setStatus(false);
            dataResult.setTips("修改失败");
        }
        return dataResult;
    }
}
