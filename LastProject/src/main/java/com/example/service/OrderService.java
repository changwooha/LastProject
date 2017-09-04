package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.example.dao.OrderDao;
import com.example.dto.Driver;
import com.example.dto.OrderDetail;

@Service
public class OrderService {
	
	@Autowired
	@Qualifier("orderDao")
	OrderDao orderDao;

	public void insertByCode(OrderDetail order, String mbrId) {
		orderDao.insertByCode(order, mbrId);
	}

	public List<OrderDetail> selectByUserId(String mbrId) {
		List<OrderDetail> order = orderDao.selectByUserId(mbrId);
		return order;
	}

	public List<Driver> selectByDate(String ordDeliveryDate) {
		List<Driver> driver = orderDao.selectByDate(ordDeliveryDate);
		return driver;
	}

	public int selectInstallTime(String prdCode, String prdQuantity) {
		int installTime = orderDao.selectInstallTime(prdCode, prdQuantity);
		return installTime;
	}

	public void insertOrd(String ordDeliveryDate, String ordName, String ordPhone, String mbrId, String ordMemo, String ordAddress, int drNo, int installTime) {
		orderDao.insertOrd(ordDeliveryDate, ordName, ordPhone, mbrId, ordMemo, ordAddress, drNo, installTime);
	}

	public List<Integer> selectOrdByMbrId(String mbrId) {
		List<Integer> ordNo = orderDao.selectOrdByMbrId(mbrId);
		return ordNo;
	}

	public void updateOrderDetail(String odtNo, String mbrId, int ordNo) {
		orderDao.updateOrderDetail(odtNo, mbrId, ordNo);
	}
}
