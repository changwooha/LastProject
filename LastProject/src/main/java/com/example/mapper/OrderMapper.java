package com.example.mapper;

import java.util.HashMap;
import java.util.List;

import com.example.dto.Driver;
import com.example.dto.OrderDetail;

public interface OrderMapper {

	void insertByCode(HashMap<String, Object> params);

	List<OrderDetail> selectByUserId(String mbrId);

	List<Driver> selectByDate(String ordDeliveryDate);

	int selectInstallTime(HashMap<String, Object> params);

	void insertOrd(HashMap<String, Object> params);

	List<Integer> selectOrdByMbrId(String mbrId);

	void updateOrderDetail(HashMap<String, Object> params);
	
}
