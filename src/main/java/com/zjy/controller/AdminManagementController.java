/**
 * 
 */
package com.zjy.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjy.entity.Department;
import com.zjy.entity.Doctor;
import com.zjy.service.AdminService;
import com.zjy.service.DepartmentService;
import com.zjy.service.PatientService;
import com.zjy.util.Constants;
import com.zjy.util.CryptographyHelper;
import com.zjy.vo.BatchResult;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;

/**
 * @author Mervyn
 *
 */
@Controller
@RequestMapping("/admin")
public class AdminManagementController {

	@Autowired
	private AdminService adminService;
	
	@Autowired
	private DepartmentService departmentService;
	
	@Autowired
	private PatientService patientService;
	
    /**
     * 新增医生
     * @param doctor
     * @return
     */
    @RequestMapping(value="/addDoctor", method = RequestMethod.POST)
    @ResponseBody
    public DataResult insertDoctor(Doctor doctor,
    		@RequestParam("birth")String birth,
    		@RequestParam("hireTime")String hireTime) {
    	DataResult dataResult;
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    	doctor.setId();
    	doctor.setDoctorNo();
    	doctor.setDoctorSalt(CryptographyHelper.getRandomSalt());
    	doctor.setDoctorPassword(CryptographyHelper.encrypt(doctor.getDoctorPassword(), doctor.getDoctorSalt()));
    	doctor.setCreateTime();
    	doctor.setUpdateTime();
    	doctor.setType();
    	try {
			doctor.setDoctorBirth(sdf.parse(birth));
			doctor.setDoctorHireTime(sdf.parse(hireTime));
		} catch (ParseException e) {
			e.printStackTrace();
		}
        dataResult = adminService.insert(doctor);
        
        return dataResult;
    }
    
    /**
     * 医生列表    条件查询
     * 条件：姓名，科室，状态（在职-1/离职-0），入职时间
     * @return
     */
    @RequestMapping(value="/queryDoctorList", method=RequestMethod.POST)
    @ResponseBody
    public DataGridResult queryDoctorList(@RequestParam(value = "pageSize", required = true) int pageSize,
                                  @RequestParam(value = "pageNumber", required = true) int pageNumber,
                                  @RequestParam(value="name")String name,
                                  @RequestParam("depNo")String depNo,
                                  @RequestParam("status")String status,
                                  @RequestParam("startTime")String startTime,
                                  @RequestParam("endTime")String endTime) {
       
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("name", null==name?"":name);
        param.put("depNo", null==depNo?"":depNo);
        param.put("status", null==status?"":status);
        try {
            param.put("startTime", null==startTime||"".equals(startTime)?"":sdf.parse(startTime));
            param.put("endTime", null==endTime||"".equals(endTime)?"":sdf.parse(endTime));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        DataGridResult dataGridResult = adminService.queryDoctorByPage(param, pageNumber, pageSize);
        return dataGridResult;
    }
    
    /**
     * 删除医生--医生离职
     * @param doctorNos
     * @return
     */
    @RequestMapping(value = "/deleteDoctor", method = RequestMethod.POST)
    @ResponseBody
    public BatchResult<Doctor> deleteDoctor(@RequestParam("doctorNos") String doctorNos) {
        BatchResult<Doctor> batchResult;
        
        String[] doctorNoArray = doctorNos.split(",");
        
        batchResult = adminService.deleteByDoctorNo(doctorNoArray);
        
        return batchResult;
    }

    
    /**
     * 根据编号查医生
     * @param doctorNo
     * @return
     */
    @RequestMapping(value="/selectByDoctorNo", method = RequestMethod.POST)
    @ResponseBody
    public Doctor selectByDoctorNo(@RequestParam("doctorNo") String doctorNo) {
        Doctor doctor = adminService.selectByDoctorNo(doctorNo);
        return doctor;
    }
    
    /**
     * 修改医生
     * @author Mervyn
     * 
     * @param doctor
     * @param birth
     * @param request
     * @return
     * @throws ParseException
     */
    @RequestMapping(value="/updateDoctor", method = RequestMethod.POST)
    @ResponseBody
    public DataResult updateDoctor(Doctor doctor,
    		@RequestParam(value="birth")String birth,
    		HttpServletRequest request) throws ParseException {
        DataResult dataResult;
        doctor.setDoctorNo(request.getParameter("doctorNo"));
        doctor.setDoctorBirth(new SimpleDateFormat("yyyy-MM-dd").parse(birth));
        dataResult = adminService.updateDoctor(doctor);
        return dataResult;
    }
    
    
    @RequestMapping(value = "/showAddDepartment")
    public String showAddDepartment() {
        return "admin/addDepartment";
    }
    
    @RequestMapping(value = "/showQueryDepartment")
    public String showQueryDepartment() {
        return "admin/queryDepartment";
    }
    
    @RequestMapping(value = "/showAddDDoctor")
    public String showAddDDoctor() {
        return "admin/addDoctor";
    }
    
    @RequestMapping(value = "/showQueryPatient")
    public String showQueryPatient() {
    	return "admin/queryPatient";
    }
    
    @RequestMapping(value = "/showQueryAppointment")
    public String showQueryAppointment() {
    	return "admin/queryAppointment";
    }
    
    @RequestMapping(value = "/showRegistrationAccountByDept")
    public String showRegistrationAccountByDept() {
    	return "admin/registrationAccountByDept";
    }
    
    /**
     * 添加部门
     * @author Mervyn
     * 
     * @param name
     * @return
     */
    @RequestMapping(value = "/addDepartment", method = RequestMethod.POST)
    @ResponseBody
    public DataResult addDepartment(@RequestParam("name") String name) {
    	DataResult dataResult;
    	
    	Department department = new Department();
    	department.setId();
		do {
	    	department.setDepartmentNo();
		} while (departmentService.selectByDeptNo(department.getDepartmentNo()) != null);
    	department.setDepartmentNo();
    	if (name != null && !"".equals(name))
    		department.setDepartmentName(name);
    	department.setIsDeleted(Constants.NOT_DELETED);
    	department.setCreateTime();
    	department.setUpdateTime();
    	
    	dataResult = departmentService.insert(department);
    	
        return dataResult;
    }
    
    /**
     * 删除部门
     * @param departmentNos
     * @return
     */
    @RequestMapping(value = "/deleteDepartment", method = RequestMethod.POST)
    @ResponseBody
    public BatchResult<Department> deleteDepartment(@RequestParam("departmentNos") String departmentNos) {
    	BatchResult<Department> batchResult;
    	
    	String[] departmentNoArray = departmentNos.split(",");
    	
    	batchResult = departmentService.deleteByDeptNo(departmentNoArray);
    	
        return batchResult;
    }
    

    /**
     * 根据编号查科室
     * @param departmentNo
     * @return
     */
    @RequestMapping(value="/selectByDepNo", method = RequestMethod.POST)
    @ResponseBody
    public Department selectByDepNo(@RequestParam("departmentNo") String departmentNo) {
        Department department = departmentService.selectByDeptNo(departmentNo);
        return department;
    }
    
    
    /**
     * 修改科室
     * @param departmentNo
     * @param depName
     * @return
     */
    @RequestMapping(value="/updateDepartment", method = RequestMethod.POST)
    @ResponseBody
    public DataResult updateDepartment(@RequestParam("departmentNo") String departmentNo,
                                 @RequestParam("depName") String depName) {
        DataResult dataResult = new DataResult();
        if(depName==null||"".equals(depName)) {
            dataResult.setStatus(false);
            dataResult.setTips("修改失败,科室名称不能为空！");
            return dataResult;
        }
        dataResult = departmentService.updateByNo(departmentNo, depName);
        return dataResult;
    }
    
    
    /**
     * 根据科室名查询部门信息并分页
     * @author Mervyn
     * 
     * @param pageSize
     * @param pageNumber
     * @param departmentName
     * @return
     */
    @RequestMapping(value = "/queryDepartmentList", method = RequestMethod.POST)
    @ResponseBody
    public DataGridResult queryDepartmentList(@RequestParam(value = "pageSize", required = true) int pageSize,
    		@RequestParam(value = "pageNumber", required = true) int pageNumber,
    		@RequestParam(value = "departmentName") String departmentName) {
    	Department department = new Department();
    	if (departmentName != null && !"".equals(departmentName))
    		department.setDepartmentName(departmentName);
    	DataGridResult dataGridResult = departmentService.queryListByName(department, pageNumber, pageSize);
    	return dataGridResult;
    }
    
    /**
     * 根据条件获取病人信息
     * @author Mervyn
     * 
     * @param pageSize
     * @param pageNumber
     * @param patientName
     * @param patientSex
     * @param patientMinAge
     * @param patientMaxAge
     * @param patientPhone
     * @return
     */
    @RequestMapping(value = "/queryPatientList", method = RequestMethod.POST)
    @ResponseBody
    public DataGridResult queryPatientList(@RequestParam(value = "pageSize", required = true) int pageSize,
    		@RequestParam(value = "pageNumber", required = true) int pageNumber,
    		@RequestParam(value = "patientName") String patientName,
    		@RequestParam(value = "patientSex") String patientSex,
    		@RequestParam(value = "patientMinAge") String patientMinAge,
    		@RequestParam(value = "patientMaxAge") String patientMaxAge,
    		@RequestParam(value = "patientPhone") String patientPhone) {
    	Map<String, String> map = new HashMap<String, String>();
    	if (patientName != null && !"".equals(patientName))
    		map.put("patientName", patientName);
    	if (patientSex != null && !"".equals(patientSex))
    		map.put("patientSex", patientSex);
    	if (patientMinAge != null && !"".equals(patientMinAge))
    		map.put("patientMinAge", patientMinAge);
    	if (patientMaxAge != null && !"".equals(patientMaxAge))
    		map.put("patientMaxAge", patientMaxAge);
    	if (patientPhone != null && !"".equals(patientPhone))
    		map.put("patientPhone", patientPhone);
    	DataGridResult dataGridResult = patientService.pageQueryPatientByWhere(map, pageNumber, pageSize);
    	return dataGridResult;
    }
}
