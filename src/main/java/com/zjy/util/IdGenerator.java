/**
 * 
 */
package com.zjy.util;

import java.util.Random;
import java.util.UUID;

/**
 * ID生成工具类
 * 
 * @author Mervyn
 *
 */
public class IdGenerator {
	
	private static Random random = new Random();
	
	/**
	 * 获取UUID
	 * @return
	 */
	public static String generateUUIDforPrimaryKey() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
	
	/**
	 * 生成各实体的编号
	 * @param prefix 编号所需前缀
	 * @param iterativeTimes 随机数位数
	 * @return 返回生成的编号
	 */
	public static String generateNumber(String prefix, int numOfDigits) {
		String number = prefix;
		for (int i = 0; i < numOfDigits; ++i) {
			number += random.nextInt(10);
		}
		return number;
	}
	
}
