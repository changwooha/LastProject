package com.example.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

/**
 * Application 전체에 적용되는 Date Formatter 클래스 전역적으로 지정 가능하다.
 * 
 * @author Administrator
 *
 */
public class StringToDateConverter implements Converter<String, Date> {

	/**
	 * String을 Date로 Convert
	 */
	@Override
	public Date convert(String arg0) {
		// TODO Auto-generated method stub
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		Date date = null;
		try {
			date = format.parse(arg0);

		} catch (Exception e) {
		}
		return date;
	}

}