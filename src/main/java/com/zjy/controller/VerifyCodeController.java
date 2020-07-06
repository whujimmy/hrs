/**
 * 
 */
package com.zjy.controller;

import java.io.IOException;
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

import com.zjy.entity.Doctor;
import com.zjy.service.AdminService;
import com.zjy.util.Constants;
import com.zjy.util.CryptographyHelper;
import com.zjy.util.IdGenerator;
import com.zjy.util.VerifyCodeGenerator;

/**
 * @author Mervyn
 *
 */

@RequestMapping("/verify")
@Controller
public class VerifyCodeController {

	@RequestMapping(value = "/generateVerify", method = RequestMethod.GET)
	public void generateVerify(HttpServletRequest request, HttpServletResponse response) throws IOException {
		VerifyCodeGenerator.execute(request, response);
	}
	
}
