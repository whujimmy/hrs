package com.zjy.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zjy.entity.Doctor;
import com.zjy.entity.Patient;
import com.zjy.service.DoctorService;
import com.zjy.service.LoginService;
import com.zjy.service.PatientService;
import com.zjy.util.Constants;
import com.zjy.util.CookieTools;
import com.zjy.util.SendCodeToPhone;
import com.zjy.vo.DataResult;

/**
 * 用户登陆
 * 根据不同身份进入不同页面
 * TODO
 *
 * @author zhoujiayi
 * @version $Id: LoginController.java, v 0.1 2018年3月21日 上午10:52:37 zhoujiayi Exp $
 */
@Controller
public class LoginController {
    
    @Autowired
    private LoginService loginService;
    
    @Autowired
    private DoctorService doctorService;
    
    @Autowired
    private PatientService patientService;

    /**
     * 退出登录
     * @author Mervyn
     * 
     * @param request
     * @param response
     * @return
     * @throws IOException 
     * @throws ServletException 
     */
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	DataResult dataResult = new DataResult();

		request.getSession().removeAttribute(Constants.SESSION_USER);
		request.getSession().removeAttribute(Constants.SESSION_TYPE);
		request.getSession().removeAttribute(Constants.SESSION_NAME);
		request.getSession().removeAttribute(Constants.SESSION_NO);
    	CookieTools.removeCookie(Constants.COOKIE_NAME, response, request);
    	dataResult.setStatus(true);
    	dataResult.setTips("退出登录成功");

		return "forward:/index.jsp";
    }
    
	@RequestMapping(value = "/toLogin")
	public String toLogin() {
		return "forward:/index.jsp";
	}
	
	@RequestMapping(value = "/doctorIndex")
	public ModelAndView toDoctorIndex(@RequestParam(required=true) String no) {
		Doctor doctor = doctorService.selectByDoctorNo(no);
		ModelAndView m = new ModelAndView("/doctor/doctorindex");
		m.addObject("doctor", doctor);
		return m;
	}
	
	@RequestMapping(value = "/adminIndex")
	public ModelAndView toAdminIndex(@RequestParam(required=true) String no) {
		Doctor admin = doctorService.selectByDoctorNo(no);
		ModelAndView m = new ModelAndView("/admin/adminindex");
		m.addObject("admin", admin);
		return m;
	}
	
	@RequestMapping(value = "/patientIndex")
	public ModelAndView toPatientIndex(@RequestParam(required=true) String no) {
		Patient patient = patientService.selectByPatientNo(no);
		ModelAndView m = new ModelAndView("/patient/patientindex");
		m.addObject("patient", patient);
		return m;
	}
	
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    public DataResult login(@RequestParam(value = "id", required = true) String id,
            @RequestParam(value = "password", required = true) String password,
            @RequestParam(value="type",required=false)String type,
            @RequestParam(value = "remFlag", required = false) String remFlag,
            HttpServletRequest request,
            HttpServletResponse response,
            ModelMap model) {
        
    	DataResult dataResult = null;
    	
    	if (Constants.DOCTOR_TYPE.equals(type)) {
    		dataResult = loginService.DLogin(id, password, request);
    	} else if (Constants.ADMIN_TYPE.equals(type)) {
    		dataResult = loginService.DLogin(id, password, request);
    	} else if (Constants.PATIENT_TYPE.equals(type)) {
    		dataResult = loginService.PLogin(id, password, request);
    	}
    	
        /**
         * 记住我
         * 将用户名和密码保存在本地cookie中，周期为7天
         */
        // "1"表示用户勾选记住密码
        if("1".equals(remFlag) && dataResult.isStatus()){ 
            String loginInfo = id+","+password+","+type;
            System.out.println(loginInfo);
            CookieTools.addCookie(Constants.COOKIE_NAME, loginInfo, Constants.MAX_AGE, response, request);
        }
    	
        return dataResult;
    }
    
    @RequestMapping("/forgetPassword")
    public String forgetPassword(){
    	return "forgetPassword";
    }
    
    @RequestMapping("/getPhone")
    @ResponseBody
    public Map<String, String> getPhone(@RequestParam(value="no") String no,
    		@RequestParam(value="type") String type,
    		HttpServletRequest request) throws Exception {
    	Map<String, String> map = new HashMap<String, String>();
    	String phone;
    	if (Constants.DOCTOR_TYPE.equals(type)) {
    		Doctor doctor = doctorService.selectByDoctorNo(no);
    		phone = doctor.getDoctorPhone();
    	} else {
    		Patient patient = patientService.selectByPatientNo(no);
    		phone = patient.getPatientPhone();
    	}
    	map.put("type", type);
    	map.put("no", no);
		map.put("phone", phone);
    	SendCodeToPhone.doPost(phone, request);
    	return map;
    }
    
    @RequestMapping("/updatePassword")
    @ResponseBody
    public DataResult updatePassword(@RequestParam(value="no") String no,
    		@RequestParam(value="type") String type,
    		@RequestParam(value="password") String password) {
    	DataResult dataResult;
    	if (Constants.DOCTOR_TYPE.equals(type)) {
    		Doctor doctor = doctorService.selectByDoctorNo(no);
    		dataResult = doctorService.updatePasswordByPhone(doctor, password);
    	} else {
    		Patient patient = patientService.selectByPatientNo(no);
    		dataResult = patientService.updatePasswordByPhone(patient, password);
    	}
    	return dataResult;
    }
}
