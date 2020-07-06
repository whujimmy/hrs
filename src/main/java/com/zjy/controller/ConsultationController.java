package com.zjy.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjy.entity.Medicine;
import com.zjy.entity.Prescription;
import com.zjy.service.MedicineService;
import com.zjy.service.PrescriptionService;
import com.zjy.service.VisitService;
import com.zjy.vo.DataGridResult;

/**
 * 就诊相关
 * TODO
 *
 * @author zhoujiayi
 * @version $Id: ConsultationController.java, v 0.1 2018年3月30日 上午10:23:16 zhoujiayi Exp $
 */
@Controller
@RequestMapping(value="/consultationQuery")
public class ConsultationController {

    
    @Autowired
    private VisitService visitService;
    
    @Autowired
    private MedicineService medicineService;
    
    @Autowired
    private PrescriptionService preService;
    
    @RequestMapping("/consultationQuery")
    public String consultationQuery() {
        return "consultationQuery";
    }
    
    /**
     * 药品搜索
     * 根据药品名称模糊匹配
     * @return
     */
    @RequestMapping("/medicineQuery")
    @ResponseBody
    public DataGridResult medicineQuery(@RequestParam(value="medicineName")String medicineName) {
    	DataGridResult dataGridResult = medicineService.queryListByName(medicineName, 1, 10);
        return dataGridResult;
    }
    
    /**
     * 开药时加入处方表
     * @param registrationNo
     * @param medicineNo
     * @return
     */
    @RequestMapping("/addMedicine")
    @ResponseBody
    public Map<String, String> addMedicine(@RequestParam(value="registrationNo")String registrationNo, 
    		@RequestParam(value="medicineNo")String medicineNo){
    	Map<String, String> map = new HashMap<String, String>();
    	Prescription prescription = preService.selectByNo(registrationNo,medicineNo);
    	if(prescription==null){
    		prescription = new Prescription();
	    	prescription.setId();
	    	prescription.setMedicineAmount(1);
	    	prescription.setMedicineNo(medicineNo);
	    	prescription.setRegistrationNo(registrationNo);
	    	preService.insertPrescription(prescription);
	    	
    	}else{
    		prescription.setMedicineAmount(prescription.getMedicineAmount()+1);
    		preService.update(prescription);
    	}
    	Medicine medicine = medicineService.selectByMedicineNo(medicineNo);
    	medicine.setMedicineAmount(medicine.getMedicineAmount()-1);
    	medicineService.updateByNo(medicine);
    	map.put("msg", "success");
    	return map;
    }
}
