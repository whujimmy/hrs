package com.zjy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.zjy.entity.Doctor;
import com.zjy.service.DoctorService;

/**
 * 菜单 ： 医生管理 TODO
 *
 * @author zhoujiayi
 * @version $Id: DoctorManagermentController.java, v 0.1 2018年3月21日 上午9:54:55 zhoujiayi Exp $
 */
@Controller
public class DoctorManagementController {

    @Autowired
    private DoctorService service;
   
    /**
     * 管理员功能
     * 修改医生信息
     * 在医生查询结果的倒数第二列是修改按钮
     * 点击修改弹出模态框，先调详情，点保存后再调这个方法
     * 修改信息保存后要改updateTime
     * 
     * @param doctor
     * @return
     */
    @RequestMapping("/updateDoctor")
    public String updateDoctor(Doctor doctor) {
        if(service.updateByPrimaryKeySelective(doctor)) {
            return "";
        }
        return "";
    }
    
    /**
     * 管理员功能
     * 详情
     * 在医生查询结果的最后一列是详情按钮
     * 点击后弹出模态框
     * 
     * @param id
     * @param model
     * @return
     */
    @RequestMapping("/doctorDetail")
    public String doctorDetail(@RequestParam("id") String id,ModelMap model) {
        Doctor doctor = service.selectByDoctorNo(id);
        model.put("doctor", doctor);
        return "";
    }
}
