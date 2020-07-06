/**
 * 
 */
package com.zjy.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjy.service.RegistrationService;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;

/**
 * @author Mervyn
 *
 */
@Controller
@RequestMapping("/registration")
public class RegistrationController {

	@Autowired
	private RegistrationService registrationService;
	
	/**
	 * 根据条件查询挂号列表
	 * @author Mervyn
	 * 
	 * @param pageSize
	 * @param pageNumber
	 * @param patientNo
	 * @param departmentNo
	 * @param beginDateStr
	 * @param endDateStr
	 * @param status
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value = "/queryRegistrationList", method = RequestMethod.POST)
	@ResponseBody
	public DataGridResult queryRegistrationList(@RequestParam(value = "pageSize", required = true) int pageSize,
    		@RequestParam(value = "pageNumber", required = true) int pageNumber,
    		@RequestParam(value="patientNo", required=false) String patientNo,
			@RequestParam(value="department") String departmentNo,
			@RequestParam(value="beginDate") String beginDateStr,
			@RequestParam(value="endDate") String endDateStr,
			@RequestParam(value="status") String status) throws ParseException {
		
		Map<String, Object> map = new HashMap<String, Object>();
		if (patientNo != null && !"".equals(patientNo))
			map.put("patientNo", patientNo);
		if (departmentNo != null && !"".equals(departmentNo))
			map.put("departmentNo", departmentNo);
		if (status != null && !"".equals(status))
			map.put("status", status);
		if (beginDateStr != null && !"".equals(beginDateStr))
			map.put("beginDate", new SimpleDateFormat("yyyy-MM-dd").parse(beginDateStr));
		if (endDateStr != null && !"".equals(endDateStr))
			map.put("endDate", new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr));
		
		DataGridResult dataGridResult = registrationService.selectRegistrationInfoByPage(map, pageNumber, pageSize);
		
		return dataGridResult;
	}
	
	@RequestMapping(value="/cancelRegistration", method=RequestMethod.POST)
	@ResponseBody
	public DataResult cancelRegistration(@RequestParam(value="registrationNo") String registrationNo) {
		return registrationService.cancelRegistration(registrationNo);
	}
}
