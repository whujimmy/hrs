package com.zjy.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zjy.entity.Duty;
import com.zjy.entity.Patient;
import com.zjy.entity.Registration;
import com.zjy.service.DoctorService;
import com.zjy.service.DutyService;
import com.zjy.service.PatientService;
import com.zjy.service.RegistrationService;
import com.zjy.util.Constants;
import com.zjy.util.CryptographyHelper;
import com.zjy.vo.DataResult;

/**
 * 
 * TODO
 *
 * @author zhoujiayi
 * @version $Id: PatientController.java, v 0.1 2018年3月30日 上午10:23:22 zhoujiayi Exp $
 */
@RequestMapping("/patient")
@Controller
public class PatientController {

	@Autowired
	private PatientService patientService;
	
	@Autowired
	private RegistrationService registrationService;
	
	@Autowired
	private DoctorService doctorService;
	
	@Autowired
	private DutyService dutyService;
	
	@RequestMapping(value="/registration", method=RequestMethod.GET)
	public String toRegistrate() {
		return "patient/registration";
	}
	
	@RequestMapping(value="/showInformation")
	public ModelAndView showInformation(@RequestParam(required=true) String no) {
		Patient patient = patientService.selectByPatientNo(no);
		ModelAndView m = new ModelAndView("/patient/information");
		m.addObject("patient", patient);
		return m;
	}
	
	@RequestMapping(value="/showUpdatePassword")
	public String showUpdatePassword() {
		return "patient/updatePassword";
	}
	
	@RequestMapping(value = "/showAppointment")
	public String showAppointment() {
		return "patient/appointment";
	}
	
	@RequestMapping(value="/showQueryRegistration")
	public ModelAndView showQueryRegistration(@RequestParam(required=true) String no) {
		Patient patient = patientService.selectByPatientNo(no);
		ModelAndView m = new ModelAndView("/patient/queryRegistration");
		m.addObject("patient", patient);
		return m;
	}
	
	@RequestMapping(value="/showQueryCases")
	public ModelAndView showQueryCases(@RequestParam(required=true) String no) {
		Patient patient = patientService.selectByPatientNo(no);
		ModelAndView m = new ModelAndView("/patient/queryCases");
		m.addObject("patient", patient);
		return m;
	}
	
	/**
	 * 用户注册
	 * @author Mervyn
	 * 
	 * @param name
	 * @param password
	 * @param birth
	 * @param phone
	 * @param gender
	 * @return
	 */
	@RequestMapping(value="/register", method=RequestMethod.POST)
	@ResponseBody
	public ModelAndView registrate(@RequestParam(value = "name", required = true) String name,
			@RequestParam(value = "password", required = true) String password,
			@RequestParam(value = "birth", required = true) String birth,
			@RequestParam(value = "phone", required = true) String phone,
			@RequestParam(value = "gender", required = true) String gender) {
		
		DataResult dataResult = new DataResult();
		
		Patient patient = new Patient();
		do {
			patient.setPatientNo();
		} while (patientService.selectByPatientNo(patient.getPatientNo()) != null);
		patient.setId();
		patient.setPatientNo();
		patient.setPatientName(name);
		patient.setPatientSalt(CryptographyHelper.getRandomSalt());
		patient.setPatientPassword(CryptographyHelper.encrypt(password, patient.getPatientSalt()));
		patient.setPatientSex(gender);
		try {
			patient.setPatientBirth(new SimpleDateFormat("yyyy-MM-dd").parse(birth));
		} catch (ParseException e) {
			throw new RuntimeException("日期格式化错误");
		}
		patient.setPatientPhone(phone);
		patient.setIsDeleted(Constants.NOT_DELETED);
		patient.setCreateTime();
		patient.setUpdateTime();
		
		dataResult = patientService.insert(patient);

		ModelAndView m = new ModelAndView("/patient/registrationSuccess");
		if (dataResult.isStatus()) {
			m.addObject("patient", patient);
			m.addObject("status",true);
		} else {
			m.addObject("status",false);
		}
		return m;
//		return dataResult;
		
	}
	
	/**
	 * 修改手机号
	 * @author Mervyn
	 * 
	 * @param phone
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/updatePhone", method=RequestMethod.POST)
	@ResponseBody
	public DataResult updatePhone(@RequestParam(value = "phone", required = true) String phone,
			HttpServletRequest request, HttpServletResponse response) {
		
		DataResult dataResult;
		
		Patient patient = (Patient) request.getSession().getAttribute(Constants.SESSION_USER);
		
		dataResult = patientService.updatePhone(patient, phone);
		
		return dataResult;
		
	}
	
	/**
	 * 修改密码
	 * @author Mervyn
	 * 
	 * @param oldPassword
	 * @param newPassword
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/updatePassword", method=RequestMethod.POST)
	@ResponseBody
	public DataResult updatePhone(@RequestParam(value="oldPassword") String oldPassword,
			@RequestParam(value="newPassword") String newPassword,
			HttpServletRequest request, HttpServletResponse response) {

		DataResult dataResult;

		Patient patient = (Patient) request.getSession().getAttribute(Constants.SESSION_USER);

		dataResult = patientService.updatePassword(patient, oldPassword, newPassword);
		
		return dataResult;
	}
	
	/**
	 * 预约挂号
	 * @author Mervyn
	 * 
	 * @param departmentNo
	 * @param doctorNo
	 * @param viewDate
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@RequestMapping(value = "/appointment", method = RequestMethod.POST)
	@ResponseBody
	public DataResult appointment(@RequestParam(value="department") String departmentNo,
			@RequestParam(value="doctor") String doctorNo,
			@RequestParam(value="viewDate") String viewDate,
			HttpServletRequest request) throws ParseException {
		
		DataResult dataResult;
		
		Registration registration = new Registration();
		registration.setId();
		registration.setRegistrationNo();
		registration.setDepartmentNo(departmentNo);
		registration.setDoctorNo(doctorNo);
		registration.setPatientNo(((Patient) request.getSession().getAttribute(Constants.SESSION_USER)).getPatientNo());
		registration.setAppointmentTime(new Date());
		registration.setVisitTime(new SimpleDateFormat("yyyy-MM-dd").parse(viewDate));
		registration.setStatus(Constants.APPOINT_TYPE);
		registration.setCreateTime();
		registration.setUpdateTime();
		
		dataResult = registrationService.insert(registration);
		if (dataResult.isStatus()) {
			Duty duty = dutyService.selectDutyByNo(doctorNo);

			Calendar calendar = Calendar.getInstance();
			calendar.setTime(new SimpleDateFormat("yyyy-MM-dd").parse(viewDate));
			int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
			switch (dayOfWeek) {
			case 1:
				duty.setSundayRest(duty.getSundayRest()-1);
				break;
			case 2:
				duty.setMondayRest(duty.getMondayRest()-1);
				break;
			case 3:
				duty.setTuesdayRest(duty.getTuesdayRest()-1);
				break;
			case 4:
				duty.setWednesdayRest(duty.getWednesdayRest()-1);
				break;
			case 5:
				duty.setThursdayRest(duty.getThursdayRest()-1);
				break;
			case 6:
				duty.setFridayRest(duty.getFridayRest()-1);
				break;
			case 7:
				duty.setSaturdayRest(duty.getSaturdayRest()-1);
				break;
			}
			dutyService.updateByPrimaryKeySelective(duty);
		}
		return dataResult;
	}
}
