package com.zjy.controller;

import java.text.ParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjy.entity.Doctor;
import com.zjy.entity.Duty;
import com.zjy.service.DoctorService;
import com.zjy.service.DutyService;
import com.zjy.util.Constants;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;

/**
 * 医生排班功能
 * TODO
 *
 * @author zhoujiayi
 * @version $Id: SchedulingController.java, v 0.1 2018年3月21日 上午10:54:01 zhoujiayi Exp $
 */
@RequestMapping("/duty")
@Controller
public class DutyController {
    
    @Autowired
    private DutyService dutyService;
    
    @Autowired
    private DoctorService doctorService;
    
    /**
     * 排班调整
     * 只能输入医生编号，先查看单个医生的值班情况，
     * 每一次只能对一个医生进行修改
     * 
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/changeScheduling")
    public String viewScheduling(@RequestParam("id")String id, ModelMap model) {
        Duty duty = dutyService.queryDutyById(id);
        model.put("duty", duty);
        return "";
    }
    
    /**
     * 各科室排班表（像课程表那样）
     * 必须选择科室
     * @return
     */
    @RequestMapping("/schedulingList")
    public String schedulingList(@RequestParam("depNo")String depNo) {
        Map<String,List<String>> map = dutyService.queryscheduling(depNo);
        
        return "";
    }
    
    /**
     * 根据医生姓名查询值班表
     * @author Mervyn
     * 
     * @param pageSize
     * @param pageNumber
     * @param doctorName
     * @return
     * @throws ParseException
     */
	@RequestMapping(value = "/queryDutyList", method = RequestMethod.POST)
	@ResponseBody
	public DataGridResult queryDutyList(@RequestParam(value = "pageSize", required = true) int pageSize,
    		@RequestParam(value = "pageNumber", required = true) int pageNumber,
    		@RequestParam(value="doctorName") String doctorName) throws ParseException {
		
		Map<String, String> map = new HashMap<String, String>();
		if (doctorName != null && !"".equals(doctorName))
			map.put("doctorName", doctorName);
		DataGridResult dataGridResult = dutyService.selectDutyByPage(map, pageNumber, pageSize);
		
		return dataGridResult;
	}
	
	/**
	 * 添加排班
	 * @author Mervyn
	 * 
	 * @param dutyTime
	 * @param doctorNo
	 * @return
	 */
	@RequestMapping(value = "/addDuty", method = RequestMethod.POST)
	@ResponseBody
	public DataResult addDuty(@RequestParam(value="dutyTime") String dutyTime,
			@RequestParam(value="doctorNo") String doctorNo) {
		DataResult dataResult;
		
		String[] dutyTimeArr = dutyTime.split(",");
		Duty duty = new Duty();
		duty.setDoctorNo(doctorNo);
		duty.setId();
		duty.init();
		for (String s : dutyTimeArr) {
			if ("1".equals(s)) {
				duty.setMonday(Constants.ON_DUTY);
				duty.setMondayRest(Constants.MAX_APPOINTMENT);
			} else if ("2".equals(s)) {
				duty.setTuesday(Constants.ON_DUTY);
				duty.setTuesdayRest(Constants.MAX_APPOINTMENT);
			} else if ("3".equals(s)) {
				duty.setWednesday(Constants.ON_DUTY);
				duty.setWednesdayRest(Constants.MAX_APPOINTMENT);
			} else if ("4".equals(s)) {
				duty.setThursday(Constants.ON_DUTY);
				duty.setThursdayRest(Constants.MAX_APPOINTMENT);
			} else if ("5".equals(s)) {
				duty.setFriday(Constants.ON_DUTY);
				duty.setFridayRest(Constants.MAX_APPOINTMENT);
			} else if ("6".equals(s)) {
				duty.setSaturday(Constants.ON_DUTY);
				duty.setSaturdayRest(Constants.MAX_APPOINTMENT);
			} else if ("7".equals(s)) {
				duty.setSunday(Constants.ON_DUTY);
				duty.setSundayRest(Constants.MAX_APPOINTMENT);
			}
		}
		dataResult = dutyService.insertSelective(duty);
		return dataResult;
	}
	
	/**
	 * 根据医生查找排班
	 * @author Mervyn
	 * 
	 * @param doctorNo
	 * @return
	 */
	@RequestMapping(value = "/selectDuty", method = RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> selectDuty(@RequestParam(value="doctorNo") String doctorNo) {
		Map<String, Object> map = new HashMap<String, Object>();
		Doctor doctor = doctorService.selectByDoctorNo(doctorNo);
		Duty duty = dutyService.selectDutyByNo(doctorNo);
		map.put("doctorName", doctor.getDoctorName());
		map.put("duty", duty);
		return map;
	}
	
	/**
	 * 根据医生修改排班，因为update有点问题，所以先删再添加
	 * @author Mervyn
	 * 
	 * @param dutyTime
	 * @param doctorNo
	 * @return
	 */
	@RequestMapping(value = "/editDuty", method = RequestMethod.POST)
	@ResponseBody
	public DataResult editDuty(@RequestParam(value="dutyTime") String dutyTime,
			@RequestParam(value="doctorNo") String doctorNo) {

		Duty dTemp = dutyService.selectDutyByNo(doctorNo);
		if (dTemp != null) {
			dutyService.deleteByDoctorNo(doctorNo);
		}
		return addDuty(dutyTime, doctorNo);
	}
}
