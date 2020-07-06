package com.zjy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 数据统计功能，使用Echarts
 * 日就诊量趋势，日营业额趋势
 * 同时显示近一周和近一月
 * TODO
 *
 * @author zhoujiayi
 * @version $Id: DataStatisticsController.java, v 0.1 2018年3月21日 上午11:08:56 zhoujiayi Exp $
 */
@Controller
public class DataStatisticsController {
    
    /**
     * 日就诊量，需要返回两组数据
     * 
     * @return
     */
    @RequestMapping("/visitingQuantity")
    public String visitingQuantity() {
        return "";
    }
    
    /**
     * 日营业额，需返回两组数据
     * 
     * @return
     */
    @RequestMapping("/viewTurnover")
    public String viewTurnover() {
        
        return "";
    }
}
