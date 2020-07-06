/**
 * 
 */
package com.zjy.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.zjy.dao.DepartmentMapper;
import com.zjy.dao.DoctorMapper;
import com.zjy.entity.Department;
import com.zjy.vo.BatchResult;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;

/**
 * @author Mervyn
 *
 */

@Service
public class DepartmentService {
	
	@Autowired
	private DepartmentMapper departmentMapper;
	
	@Autowired
	private DoctorMapper doctorMapper;
	
	public DataResult insert(Department department) {
		DataResult dataResult = new DataResult();
		try {
			if (departmentMapper.insert(department) == 1) {
				dataResult.setStatus(true);
				dataResult.setTips("添加科室成功");
			} else {
				dataResult.setStatus(false);
				dataResult.setTips("添加科室失败");
			}
		} catch(Exception e) {
			dataResult.setStatus(false);
			dataResult.setTips("添加科室失败");
		}
		
		return dataResult;
	}
	
	public BatchResult<Department> deleteByDeptNo(String departmentNoArray[]) {
		BatchResult<Department> batchResult = new BatchResult<Department>();
		for (int i = 0; i < departmentNoArray.length; ++i) {
			if (doctorMapper.selectCountByDeptNo(departmentNoArray[i]) == 0) {
				if (departmentMapper.deleteByDeptNo(departmentNoArray[i]) == 1) {
					batchResult.addSuccess();
				} else {
					batchResult.addFail();
					batchResult.addToFailList(departmentMapper.selectByDeptNo(departmentNoArray[i]));
				}
			} else {
				batchResult.addFail();
				batchResult.addToFailList(departmentMapper.selectByDeptNo(departmentNoArray[i]));
				batchResult.setTips("科室下还有医生，不允许删除。");
			}
		}
		
		return batchResult;
	}
	
	public Department selectByDeptNo(String departmentNo) {
		return departmentMapper.selectByDeptNo(departmentNo);
	}
	
	public DataGridResult selectList(int pageNum, int pageSize) {
		return queryListByName(null, pageNum, pageSize);
	}
	
	public DataGridResult queryListByName(Department department, int pageNum, int pageSize) {
		PageHelper.startPage(pageNum, pageSize);
		List<Department> departmentList = departmentMapper.selectPageListByName(department);
		PageInfo<Department> pageInfo = new PageInfo<Department>(departmentList);
		DataGridResult dataGridResult = new DataGridResult(pageInfo.getTotal(), pageInfo.getList(), pageInfo.getPageSize(),
				pageInfo.getPageNum());
		return dataGridResult;
	}

    public DataResult updateByNo(String departmentNo, String depName) {
        // TODO Auto-generated method stub
        DataResult dataResult = new DataResult();
        try {
            if(departmentMapper.updateByNo(departmentNo, depName)==1) {
                dataResult.setStatus(true);
                dataResult.setTips("修改成功");
            }
        } catch (Exception e) {
            dataResult.setStatus(false);
            dataResult.setTips("修改失败");
        }
        return dataResult;
    }
    
    public List<Department> selectDepartment() {
    	return departmentMapper.selectDepartment();
    }
}
