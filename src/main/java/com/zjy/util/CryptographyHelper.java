package com.zjy.util;

import org.apache.shiro.crypto.SecureRandomNumberGenerator;
import org.apache.shiro.crypto.hash.SimpleHash;

/**
 * 密码加密
 * @author Mervyn
 *
 */
public class CryptographyHelper {
	private static SecureRandomNumberGenerator srg = new SecureRandomNumberGenerator();
	private static final String ALGORITHM_MATHOD = "md5";
	private static final int HASH_ITERATIONS = 5;
	
	public static String getRandomSalt() {
		return srg.nextBytes().toHex();
	}
	
	public static String encrypt(String password, String salt) {
		return new SimpleHash(ALGORITHM_MATHOD, password, salt, HASH_ITERATIONS).toHex();
	}
}
