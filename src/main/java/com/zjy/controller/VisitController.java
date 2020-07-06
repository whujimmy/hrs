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

import com.zjy.service.VisitService;
import com.zjy.vo.DataGridResult;

/**
 * @author Mervyn
 *
 */
@Controller
@RequestMapping(value = "/visit")
public class VisitController {
	
	@Autowired
	private VisitService visitService;
	
	/**
	 * 根据条件获取病历列表
	 * @author Mervyn
	 * 
	 * @param pageSize
	 * @param pageNumber
	 * @param patientNo
	 * @param departmentNo
	 * @param beginDateStr
	 * @param endDateStr
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value = "/queryCasesList", method = RequestMethod.POST)
	@ResponseBody
	public DataGridResult queryCasesList(@RequestParam(value = "pageSize", required = true) int pageSize,
            @RequestParam(value = "pageNumber", required = true) int pageNumber,
            @RequestParam(value = "patientNo") String patientNo,
			@RequestParam(value="department") String departmentNo,
			@RequestParam(value="beginDate") String beginDateStr,
			@RequestParam(value="endDate") String endDateStr) throws ParseException {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("patientNo", patientNo);
		if (departmentNo != null && !"".equals(departmentNo))
			map.put("departmentNo", departmentNo);
		if (beginDateStr != null && !"".equals(beginDateStr))
			map.put("beginDate", new SimpleDateFormat("yyyy-MM-dd").parse(beginDateStr));
		if (endDateStr != null && !"".equals(endDateStr))
			map.put("endDate", new SimpleDateFormat("yyyy-MM-dd").parse(endDateStr));
		
		DataGridResult dataGridResult = visitService.selectByPatientNoPage(map, pageNumber, pageSize);
		
		return dataGridResult;
	}
}
