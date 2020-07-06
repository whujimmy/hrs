package com.zjy.util;

/**
 * 
 * 验证码(大写字母、小写字母、数字) 
 * @author Mervyn
 *
 */

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class VerifyCodeGenerator {

	private static final int IMG_WIDTH = 120;
	private static final int IMG_HEIGHT = 35;
	private static Random random = new Random();
	private static Font font = new Font("微软雅黑", Font.BOLD, 30);
	
	public static String execute(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String verifyCode = "";
		
		response.setContentType("image/jpeg");
		BufferedImage image = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, BufferedImage.TYPE_INT_RGB);
		Graphics g = image.getGraphics();
		g.fillRect(0, 0, IMG_WIDTH, IMG_HEIGHT);
		g.setColor(Color.BLACK);
		g.drawRect(0, 0, IMG_WIDTH-1, IMG_HEIGHT-1);
		
		for (int i = 0; i < 50; ++i) {
			g.setColor(new Color(180 + random.nextInt(75), 180 + random.nextInt(75), 180 + random.nextInt(75)));
			
			int x1 = 2 + random.nextInt(IMG_WIDTH - 4);
			int y1 = 2 + random.nextInt(IMG_HEIGHT - 4);
			int x2 = 2 + random.nextInt(IMG_WIDTH - 4);
			int y2 = 2 + random.nextInt(IMG_HEIGHT - 4);
			g.drawLine(x1, y1, x2, y2);
		}
		
		g.setFont(font);
		for (int i = 0; i < 4; ++i) {
			String temp = generatorVerify();
			verifyCode += temp;
			g.setColor(new Color(random.nextInt(20), random.nextInt(40), random.nextInt(20)));
			
			int offset = transferFrom(g);
			g.drawString(temp,  26 * i + offset, 28);
		}
		
		request.getSession().setAttribute(Constants.VERIFY_CODE, verifyCode);
		g.dispose();
		ImageIO.write(image, "jpeg", response.getOutputStream());
		
		return verifyCode;
	}
	
	private static int transferFrom(Graphics g) {
		Graphics2D gr = (Graphics2D) g;
		AffineTransform tr = gr.getTransform();

		double shx = Math.random();

		if (shx < 0.25) {
			shx = 0.25;
		}
		if (shx > 0.55) {
			shx = 0.55;
		}

		int temp = random.nextInt(2);
		int offsetLeft = 2;
		if (temp == 0) {
			shx = 0 - shx;
			offsetLeft = 10;
		}
		tr.setToShear(shx, 0);
		gr.setTransform(tr);
		return offsetLeft;
	}
	
	private static String generatorVerify() {
		int flag = random.nextInt(3);
		switch(flag) {
			case 0: // 生成大写字母(A-Z|65-90)
				long temp = Math.round(Math.random() * 25 + 65);
				return String.valueOf((char) temp);
			case 1: // 生成小写字母(a-z|97-122)
				temp = Math.round(Math.random() * 25 + 97);
				return String.valueOf((char) temp);
			default: // 生成数字(0-9)
				return String.valueOf(Math.round(Math.random() * 9));
		}
	}
}