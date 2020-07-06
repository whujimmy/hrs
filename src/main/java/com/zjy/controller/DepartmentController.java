/**
 * 
 */
package com.zjy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjy.entity.Department;
import com.zjy.service.DepartmentService;

/**
 * @author Mervyn
 *
 */
@Controller
@RequestMapping("/department")
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 获取科室列表
	 * @author Mervyn
	 * 
	 * @return
	 */
	@RequestMapping("/loadDepartment")
	@ResponseBody
	public List<Department> loadDepartment() {
		return departmentService.selectDepartment();
	}
	
}
