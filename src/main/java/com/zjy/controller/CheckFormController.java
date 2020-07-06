/**
 * 
 */
package com.zjy.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjy.service.DoctorService;
import com.zjy.service.PatientService;
import com.zjy.util.Constants;

/**
 * @author Mervyn
 *
 */
@Controller
@RequestMapping("/check")
public class CheckFormController {

    @Autowired
    private DoctorService doctorService;
    
    @Autowired
    private PatientService patientService;
	
    /**
     * 登陆验证码表单验证
     * @author Mervyn
     * 
     * @param code
     * @param request
     * @return
     */
    @RequestMapping(value = "/verifyCode", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> checkVerifyCode(@RequestParam(value = "verifyCode") String code, HttpServletRequest request) {
    	Map<String, String> result = new HashMap<String, String>();
    	
    	if (((String)request.getSession().getAttribute(Constants.VERIFY_CODE)).equalsIgnoreCase(code)) {
    		result.put("valid", "true");
    	} else {
    		result.put("valid", "false");
    	}
    	
    	return result;
    }
	
    /**
     * 登陆验证码表单验证
     * @author Mervyn
     * 
     * @param code
     * @param request
     * @return
     */
    @RequestMapping(value = "/phoneCode", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> checkPhoneCode(@RequestParam(value = "phoneCode") String code, HttpServletRequest request) {
    	Map<String, String> result = new HashMap<String, String>();
    	
    	if (((String)request.getSession().getAttribute(Constants.PHONE_CODE)).equalsIgnoreCase(code)) {
    		result.put("valid", "true");
    	} else {
    		result.put("valid", "false");
    	}
    	
    	return result;
    }
    
    /**
     * 检查账户是否存在
     * @author Mervyn
     * 
     * @param id
     * @param type
     * @param request
     * @return
     */
    @RequestMapping(value = "/id", method = RequestMethod.POST)
    @ResponseBody
    public Map<String, String> checkId(@RequestParam(value = "id") String id,
    		@RequestParam(value = "type") String type, HttpServletRequest request) {
    	Map<String, String> result = new HashMap<String, String>();
    	
    	Object obj = null;
    	if (Constants.ADMIN_TYPE.equals(type) || Constants.DOCTOR_TYPE.equals(type)) {
    		obj = doctorService.selectByDoctorNo(id);
    	} else if (Constants.PATIENT_TYPE.equals(type)) {
    		obj = patientService.selectByPatientNo(id);
    	}
    	
    	if (obj == null) {
    		result.put("valid", "false");
    	} else {
    		result.put("valid", "true");
    	}
    	
    	return result;
    }
    
}
