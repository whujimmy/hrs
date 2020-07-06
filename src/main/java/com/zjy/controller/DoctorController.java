/**
 * 
 */
package com.zjy.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.zjy.dao.VisitMapper;
import com.zjy.entity.Doctor;
import com.zjy.entity.Duty;
import com.zjy.entity.Patient;
import com.zjy.entity.Prescription;
import com.zjy.service.DoctorService;
import com.zjy.service.DutyService;
import com.zjy.service.MedicineService;
import com.zjy.service.PrescriptionService;
import com.zjy.util.Constants;
import com.zjy.vo.ConfirmVo;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;

/**
 * @author Mervyn
 *
 */
@Controller
@RequestMapping("/doctor")
public class DoctorController {

	@Autowired
	private DoctorService doctorService;
	
	@Autowired
	private DutyService dutyService;
	
	@Autowired
	private MedicineService medicineService;
  
	@Autowired
	private PrescriptionService preService;
    
  /**
	 * 根据部门和值班时间获取医生
	 * @author Mervyn
	 * 
	 * @param departmentNo
	 * @param viewDate
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping("/loadDoctor")
	@ResponseBody
	public List<Doctor> loadDoctor(@RequestParam(value="departmentNo") String departmentNo,
			@RequestParam(value="viewDate") String viewDate) throws ParseException {
		Date date = new SimpleDateFormat("yyyy-MM-dd").parse(viewDate);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
		Duty duty = new Duty();
		switch (dayOfWeek) {
		case 1:
			duty.setSunday(Constants.ON_DUTY);
			break;
		case 2:
			duty.setMonday(Constants.ON_DUTY);
			break;
		case 3:
			duty.setTuesday(Constants.ON_DUTY);
			break;
		case 4:
			duty.setWednesday(Constants.ON_DUTY);
			break;
		case 5:
			duty.setThursday(Constants.ON_DUTY);
			break;
		case 6:
			duty.setFriday(Constants.ON_DUTY);
			break;
		case 7:
			duty.setSaturday(Constants.ON_DUTY);
			break;
		}
		List<String> doctorNos = dutyService.selectDoctorByDuty(duty);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("departmentNo", departmentNo);
		if (doctorNos.size() == 0)
			return new ArrayList<Doctor>();
		param.put("doctorNos", doctorNos);
		return doctorService.selectDoctorByDepartmentAndDuty(param);
	}
	
	/**
	 * 开药时药品查询列表
	 * @param pageSize
	 * @param pageNumber
	 * @param medicineName
	 * @return
	 */
	@RequestMapping("/queryMedicine")
	@ResponseBody
	public DataGridResult queryMedicine(@RequestParam(value = "pageSize", required = true) int pageSize,
	                                    @RequestParam(value = "pageNumber", required = true) int pageNumber,
	                                    @RequestParam("medicineName") String medicineName) {
	    
	    DataGridResult dataGridResult = medicineService.queryListByName(medicineName, pageNumber, pageSize);
        return dataGridResult;
	}
	
	
	/**
	 * 开药时的记录，添加到处方表
	 * @param prescription
	 * @return
	 */
	@RequestMapping(value="/addMedicine", method=RequestMethod.POST)
	@ResponseBody
	public DataResult addMedicine(Prescription prescription) {
	    DataResult dataResult;
	    prescription.setId();
	    dataResult = preService.insertPrescription(prescription);
	    return dataResult;
	}
	
	/**
	 * 列出所有未排班的医生
	 * @author Mervyn
	 * 
	 * @return
	 */
	@RequestMapping(value="/selectDoctorNoDuty", method=RequestMethod.GET)
	@ResponseBody
	public List<Doctor> selectDoctorNoDuty() {
		return doctorService.selectDoctorNoDuty();
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

		Doctor doctor = (Doctor) request.getSession().getAttribute(Constants.SESSION_USER);

		dataResult = doctorService.updatePassword(doctor, oldPassword, newPassword);
		
		return dataResult;
	}
	
	/**
	 * 医生分页查看当日挂号
	 * @param pageSize
	 * @param pageNumber
	 * @param regNo
	 * @return
	 */
	@RequestMapping(value = "/queryRegisterList", method = RequestMethod.POST)
    @ResponseBody
    public DataGridResult queryRegisterList(@RequestParam(value = "pageSize", required = true) int pageSize,
    		@RequestParam(value = "pageNumber", required = true) int pageNumber,
    		@RequestParam(value = "regNo") String regNo) {
    	DataGridResult dataGridResult = doctorService.queryListByRegNo(regNo, pageNumber, pageSize);
    	return dataGridResult;
    }
	
	/**
	 * 确认就诊
	 * @param registrationNo
	 * @return
	 */
	@RequestMapping("/confirmVisit")
	public String confirmVisit(String registrationNo, HttpServletRequest request){
		Map<String, Object> map = doctorService.confirmVisit(registrationNo);
		if("suc".equals(map.get("msg").toString())){
			request.getSession().setAttribute("confirm",(ConfirmVo)map.get("confirm"));
			return "doctor/visitDetail";
		}
		return "";
		
	}
	
	@RequestMapping(value="/showUpdatePassword")
	public ModelAndView showUpdatePassword(@RequestParam(required=true) String no) {
		Doctor doctor = doctorService.selectByDoctorNo(no);
		ModelAndView m = new ModelAndView("/doctor/updatePassword");
		m.addObject("doctor", doctor);
		return m;
	}
	
	/**
	 * 编写病例之后加入visit表
	 * @param registrationNo
	 * @param write
	 * @return
	 */
	@RequestMapping("/insertVisit")
	@ResponseBody
	public DataResult insertVisit(String registrationNo, String write){
		return doctorService.insertVisit(registrationNo,write);
	}
}
