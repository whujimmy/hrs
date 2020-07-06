/**
 * 
 */
package com.zjy.scheduled;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.zjy.entity.Duty;
import com.zjy.entity.Registration;
import com.zjy.service.DutyService;
import com.zjy.service.RegistrationService;
import com.zjy.util.Constants;

/**
 * 定时任务
 * @author Mervyn
 *
 */
@Component
public class ScheduledTask {
	
	@Autowired
	private DutyService dutyService;
	
	@Autowired
	private RegistrationService registrationService;
	
	/**
	 * 每天将值班表中前一天有值班的医生的剩余挂号数更新为最大可预约挂号数
	 * @author Mervyn
	 *
	 */
	@Scheduled(cron = "0 0 0 * * ? ")//每天0点执行
	public void resetDutyTable() {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
		Duty duty = new Duty();
		switch (dayOfWeek) {
		case 1:
			duty.setSaturdayRest(Constants.MAX_APPOINTMENT);
			break;
		case 2:
			duty.setSundayRest(Constants.MAX_APPOINTMENT);
			break;
		case 3:
			duty.setMondayRest(Constants.MAX_APPOINTMENT);
			break;
		case 4:
			duty.setTuesdayRest(Constants.MAX_APPOINTMENT);
			break;
		case 5:
			duty.setWednesdayRest(Constants.MAX_APPOINTMENT);
			break;
		case 6:
			duty.setThursdayRest(Constants.MAX_APPOINTMENT);
			break;
		case 7:
			duty.setFridayRest(Constants.MAX_APPOINTMENT);
			break;
		}
		dutyService.updateDuty(duty);
	}

	/**
	 * 过期未就诊的预约挂号从预约状态置为未就诊状态
	 * @author Mervyn
	 *
	 */
	@Scheduled(cron = "0 0 0 * * ? ")//每天0点执行
	public void expiredRegistration() {
		List<Registration> registrationList = registrationService.selectByDate(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
		for (Registration registration: registrationList) {
			registration.setStatus(Constants.UN_VISIT_TYPE);
			registration.setUpdateTime();
			registrationService.updateByPrimaryKeySelective(registration);
		}
	}
}
