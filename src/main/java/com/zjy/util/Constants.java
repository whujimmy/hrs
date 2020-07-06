/**
 * 
 */
package com.zjy.util;

/**
 * 常量类
 * 
 * @author Mervyn
 *
 */
public class Constants {
	// 存放在session中用户常量
	public static final String SESSION_USER = "hrs_session_user";
	// 存放在session中用户类型常量
	public static final String SESSION_TYPE = "hrs_session_type";
	// 存放在session中id常量
	public static final String SESSION_NO = "hrs_session_no";
	// 存放在session中姓名常量
	public static final String SESSION_NAME = "hrs_session_name";
	// 存放在session中手机验证码
	public static final String PHONE_CODE = "phone_code";
	// 定义存放在Session中验证码常量
	public final static String VERIFY_CODE = "verify_code";
	// 定义Cookie的名字
	public static final String COOKIE_NAME = "hrs_cookie";
	// 定义Cookie的生命周期7天
	public static final int MAX_AGE = 60 * 60 * 24 * 7;
	// 值班最大可预约挂号数
	public static final int MAX_APPOINTMENT = 30;
	
	//各实体编号随机数位数
	public static final int DEPARTMENT_NO_DIGITS = 3;
	public static final int DOCTOR_NO_DIGITS = 3;
	public static final int PATIENT_NO_DIGITS = 3;
	public static final int MEDICINE_NO_DIGITS = 3;
	public static final int REGISTRATION_NO_DIGITS = 6;
	
	//各实体编号前缀
	public static final String DEPARTMENT_NO_PREFIX = "D";
	public static final String MEDICINE_NO_PREFIX = "M";
	public static final String REGISTRATION_NO_PREFIX = "R";
	
	//是否删除：1-已删除；0-未删除
	public static final String DELETED = "1";
	public static final String NOT_DELETED = "0";
	
	//性别：1-男；0-女
	public static final String MALE = "1";
	public static final String FEMALE = "0";
	
	//医生类型：0-医生；1-管理员；2-病人；
	public static final String DOCTOR_TYPE = "0";
	public static final String ADMIN_TYPE = "1";
	public static final String PATIENT_TYPE = "2";
	
	//某日是否值班：1-是；0-否
	public static final String ON_DUTY = "1";
	public static final String NOT_ON_DUTY = "0";
	
	//预约挂号状态：0-取消；1-预约；2-就诊；3-未就诊；
	public static final String CANCEL_TYPE = "0";
	public static final String APPOINT_TYPE = "1";
	public static final String VISIT_TYPE = "2";
	public static final String UN_VISIT_TYPE = "3";
}
