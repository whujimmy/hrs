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
import com.zjy.dao.VisitMapper;
import com.zjy.entity.Department;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.VisitResult;

/**
 * @author Mervyn
 *
 */

@Service
public class VisitService {
    
    @Autowired
    private VisitMapper visitMapper;

    public boolean updateDiagnostic(String registrationNo, String diagnostic) {
        // TODO Auto-generated method stub
        if(visitMapper.updateDiagnostic(registrationNo,diagnostic)==1) {
            return true;
        }
        return false;
    }
	
	public DataGridResult selectByPatientNoPage(Map<String, Object> map, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<VisitResult> visitList = visitMapper.selectByPatientNo(map);
		PageInfo<VisitResult> pageInfo = new PageInfo<VisitResult>(visitList);
		DataGridResult dataGridResult = new DataGridResult(pageInfo.getTotal(), pageInfo.getList(), pageInfo.getPageSize(),
				pageInfo.getPageNum());
		return dataGridResult;
	}
}
