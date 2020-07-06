/**
 * 
 */
package com.zjy.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjy.service.RegistrationService;
import com.zjy.vo.DeptAccountResult;

/**
 * @author Mervyn
 *
 */
@Controller
@RequestMapping(value="/statistics")
public class StatisticsController {
	
	@Autowired
	private RegistrationService registrationService;
	
	@RequestMapping("/registrationAccountByDept")
	@ResponseBody
	public List<DeptAccountResult> registrationAccountByDept() {
		return registrationService.registrationAccountByDept();
	}
}
