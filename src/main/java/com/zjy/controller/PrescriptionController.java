/**
 * 
 */
package com.zjy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjy.service.PrescriptionService;
import com.zjy.vo.DataGridResult;

/**
 * @author Mervyn
 *
 */
@Controller
@RequestMapping(value = "/prescription")
public class PrescriptionController {

	@Autowired
	private PrescriptionService prescriptionService;
	
	@RequestMapping(value="/queryPrescriptionList", method=RequestMethod.POST)
	@ResponseBody
	public DataGridResult selectByRegistrationNo(@RequestParam(value = "pageSize", required = false) Integer pageSize,
            @RequestParam(value = "pageNumber", required = false) Integer pageNumber,
            @RequestParam(value="registrationNo")String registrationNo) {
		if (pageNumber == null)
			pageNumber = 1;
		if (pageSize == null)
			pageSize = 10;
		return prescriptionService.selectByRegistrationNoPage(registrationNo, pageNumber, pageSize);
	}
}
