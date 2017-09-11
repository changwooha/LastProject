package com.example.controller;


import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

/**
 * Application 전체에 적용되는 Date Formatter 클래스
 * 전역적으로 지정 가능하다.
 * @author Administrator
 *
 */
public class DateToStringConverter implements Converter<Date, String> {

	
	/**
	 * Date을 String형식으로 Convert하는 메서드
	 */
	public String convert(Date arg0) {
		// TODO Auto-generated method stub
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		return format.format(arg0);
	}


}
