package com.example.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.example.dto.Driver;
import com.example.dto.OrderDetail;
import com.example.mapper.OrderMapper;


@Repository
public class OrderDao {
	
	@Autowired
	@Qualifier("orderMapper")
	OrderMapper orderMapper;

	public void insertByCode(OrderDetail order, String mbrId) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("mbrId", mbrId);
		params.put("prdCode", order.getPrdCode());
		params.put("odtQuantity", order.getOdtQuantity());
		orderMapper.insertByCode(params);
	}

	public List<OrderDetail> selectByUserId(String mbrId) {
		List<OrderDetail> order = orderMapper.selectByUserId(mbrId);
		return order;
	}

	public List<Driver> selectByDate(String ordDeliveryDate) {
		List<Driver> driver = orderMapper.selectByDate(ordDeliveryDate);
		return driver;
	}

	public int selectInstallTime(String prdCode, String prdQuantity) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("prdCode", prdCode);
		params.put("prdQuantity", prdQuantity);
		int installTime = orderMapper.selectInstallTime(params);
		return installTime;
	}

	public void insertOrd(String ordDeliveryDate, String ordName, String ordPhone, String mbrId, String ordMemo, String ordAddress, int drNo, int installTime) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("ordDeliveryDate", ordDeliveryDate);
		params.put("ordName", ordName);
		params.put("ordPhone", ordPhone);
		params.put("mbrId", mbrId);
		params.put("ordMemo", ordMemo);
		params.put("ordAddress", ordAddress);
		params.put("drNo", drNo);
		params.put("installTime", installTime);
		
		orderMapper.insertOrd(params);
	}

	public List<Integer> selectOrdByMbrId(String mbrId) {
		List<Integer> ordNo = orderMapper.selectOrdByMbrId(mbrId);
		return ordNo;
	}

	public void updateOrderDetail(String odtNo, String mbrId, int ordNo) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("odtNo", odtNo);
		params.put("mbrId", mbrId);
		params.put("ordNo", ordNo);
		orderMapper.updateOrderDetail(params);
	}
}
