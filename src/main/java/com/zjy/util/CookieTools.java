/**
 * 
 */
package com.zjy.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author Mervyn
 *
 */
public class CookieTools {

	/**
	 * 获取cookie
	 * @author Mervyn
	 * 
	 * @param cookieName
	 * @param request
	 * @return
	 */
	public static Cookie getCookie(String cookieName, HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if (cookies != null && cookies.length > 0) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals(cookieName)) {
					return cookie;
				}
			}

		}
		return null;
	}
	
	/**
	 * 添加cookie
	 * @author Mervyn
	 * 
	 * @param cookieName cookie名字
	 * @param cookieValue cookie值
	 * @param maxAge 保存时长
	 * @param response
	 * @param request
	 */
	public static void addCookie(String cookieName, String cookieValue, int maxAge, HttpServletResponse response,
			HttpServletRequest request) {
		
		Cookie cookie = getCookie(cookieName, request);
		if (cookie == null) {
			cookie = new Cookie(cookieName, cookieValue);
		}
		cookie.setMaxAge(maxAge);
		cookie.setPath("/");
		response.addCookie(cookie);
	}
	
	/**
	 * 删除cookie
	 * @author Mervyn
	 * 
	 * @param cookieName
	 * @param response
	 * @param request
	 */
	public static void removeCookie(String cookieName, HttpServletResponse response, HttpServletRequest request) {
		Cookie cookie = getCookie(cookieName, request);
		if (cookie != null) {
			/** 设置Cookie立即失效 */
			cookie.setMaxAge(0);
			cookie.setPath("/");
			response.addCookie(cookie);
		}
	}
}
