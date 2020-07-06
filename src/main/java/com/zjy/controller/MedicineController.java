package com.zjy.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zjy.entity.Department;
import com.zjy.entity.Medicine;
import com.zjy.service.MedicineService;
import com.zjy.vo.BatchResult;
import com.zjy.vo.DataGridResult;
import com.zjy.vo.DataResult;

/** 
* @author zhoujiayi
* @version 创建时间：2018年5月2日
*/
@Controller
@RequestMapping("/medicine")
public class MedicineController {
    
    @Autowired
    private MedicineService medicineService;
    
    /**
     * 新增药品
     * @param medicine
     * @return
     */
    @RequestMapping(value="/addMedicine", method = RequestMethod.POST)
    @ResponseBody
    public DataResult addMedicine(Medicine medicine) {
        DataResult dataResult;
        medicine.setId();
        medicine.setMedicineNo();
        medicine.setUpdateTime();
        
        dataResult =  medicineService.addMedicine(medicine);
        
        return dataResult;
    }
    
    /**
     * 分页查询药品列表
     * @param pageSize
     * @param pageNumber
     * @param name
     * @return
     */
    @RequestMapping(value="/queryMedicineList", method = RequestMethod.POST)
    @ResponseBody
    public DataGridResult queryMedicineList(@RequestParam(value = "pageSize", required = true) int pageSize,
                                            @RequestParam(value = "pageNumber", required = true) int pageNumber,
                                            @RequestParam(value = "medicineName") String medicineName) {
        DataGridResult dataGridResult = medicineService.queryListByName(medicineName, pageNumber, pageSize);
        return dataGridResult;
    }
    
    
    /**
     * 根据No查药品
     * @param medicineNo
     * @return
     */
    @RequestMapping(value="/selectByMedicineNo", method = RequestMethod.POST)
    @ResponseBody
    public Medicine selectByMedicineNo(@RequestParam("medicineNo") String medicineNo) {
        Medicine medicine = medicineService.selectByMedicineNo(medicineNo);
        return medicine;
    }
    
    
    /**
     * 删除药品
     * @param medicineNos
     * @return
     */
    @RequestMapping(value = "/deleteMedicine", method = RequestMethod.POST)
    @ResponseBody
    public BatchResult<Medicine> deleteMedicine(@RequestParam("medicineNos") String medicineNos) {
        BatchResult<Medicine> batchResult;
        
        String[] medicineNoArray = medicineNos.split(",");
        
        batchResult = medicineService.deleteByMedicineNo(medicineNoArray);
        
        return batchResult;
    }
    
    
    /**
     * 修改药品信息
     * @param medicine
     * @return
     */
    @RequestMapping(value="/updateMedicine", method = RequestMethod.POST)
    @ResponseBody
    public DataResult updateMedicine(@RequestParam("medicineName") String medicineName,
    		@RequestParam("medicinePrice") double medicinePrice,
    		@RequestParam("medicineLastAddAccount") int medicineLastAddAccount,
    		@RequestParam("mNo") String mNo,@RequestParam("mAmount") int mAmount) {
        DataResult dataResult = new DataResult();
        Medicine medicine = new Medicine();
        medicine.setMedicineNo(mNo);
        //新增之后药品的数量---剩余数
        int after = mAmount + medicineLastAddAccount;
        medicine.setMedicineAmount(after);
        medicine.setMedicinePrice(medicinePrice);
        medicine.setMedicineLastAddAccount(medicineLastAddAccount);
        dataResult = medicineService.updateByNo(medicine);
        return dataResult;
    }
}
