package com.zjy.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.Consts;
import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

public class SendCodeToPhone {
	
	public static void doPost(String phone, HttpServletRequest request) throws Exception{
		
		//创建一个浏览器
		CloseableHttpClient client = 
				 HttpClients.createDefault();
		
		//定义post请求
		HttpPost post = 
		new HttpPost("http://106.ihuyi.com/webservice/sms.php?method=Submit");
		
		//定义发送请求参数    表单项 input
		List<NameValuePair> list = new ArrayList<>();
		list.add(new BasicNameValuePair("account", "C89466886"));
		list.add(new BasicNameValuePair("password", "c34f25ad2cc9669b7d011587df61ccda"));
		list.add(new BasicNameValuePair("mobile", phone));
		
		int mobile_code = (int)((Math.random()*9+1)*100000);

	    String content = new String("您的验证码是：" + mobile_code + "。请不要把验证码泄露给其他人。");
		list.add(new BasicNameValuePair("content", content));
		request.getSession().setAttribute(Constants.PHONE_CODE, mobile_code+"");
		
		
		//定义一个form表单发送post请求和参数  表单  form
		HttpEntity he = new UrlEncodedFormEntity(list,Consts.UTF_8);
		
		//设置post请求发送参数
		post.setEntity(he);
		
		//发送请求并执行，响应信息
		CloseableHttpResponse response = client.execute(post);
		
		int statusCode = 
				response.getStatusLine().getStatusCode();
		if(statusCode == HttpStatus.SC_OK){
			String xml = 
					EntityUtils.toString(response.getEntity(), Consts.UTF_8);
			
			Document doc = DocumentHelper.parseText(xml);
			Element root = doc.getRootElement();

			String code = root.elementText("code");
			String msg = root.elementText("msg");
			String smsid = root.elementText("smsid");

			System.out.println(code);
			System.out.println(msg);
			System.out.println(smsid);

			 if("2".equals(code)){
				System.out.println("短信提交成功");
			}
		}
		
		 //关闭资源
		 response.close();
		 client.close();
		
	}

}
