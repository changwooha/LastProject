package com.example.service;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.example.dao.OmsDao;
import com.example.dto.Driver;
import com.example.dto.Member;
import com.example.dto.Order;
import com.example.dto.OrderDetail;
import com.example.dto.Product;

// Service는 트랜잭션 단위
@Service //@Component
public class OmsService {
	
	@Autowired
	@Qualifier("omsDao")
	private OmsDao omsDao;
	
	
	public Member authenticate(String mbrName, String mbrPhone) {
		Member member = omsDao.findByNameAndPhoneNumber(mbrName, mbrPhone);
		return member;
	}

	public ArrayList<Product> productList() {
		ArrayList<Product> products = omsDao.productList();
		return products;
	}

	public void orderConfirm(Member member, Product product) {
		omsDao.orderConfirm(member, product);
		
	}

	public void insertOrderList(String prdName, int quantityList, String mbrId) {
		omsDao.insertOrderList(prdName, quantityList, mbrId);
		
	}

	public void insertOrder(String mbrId, String ordAddress, String ordPhone, String ordName, int drNo, Date dbDate, int totalInstallTime, String ordMemo) {
		omsDao.insertOrder(mbrId, ordAddress, ordPhone, ordName, drNo, dbDate, totalInstallTime, ordMemo);
		
	}

	public ArrayList<Driver> findDriverEnableTimeByDate(Date dbDate, int totalInstallTime) {
		ArrayList<Driver> driverEnableTimeByDate = omsDao.selectDriverEnableTimeByDate(dbDate, totalInstallTime);
		return driverEnableTimeByDate;
	}

	public List<Order> findOrderList(String mbrId, String mbrName, String mbrPhone, Date stDate,
			Date fhDate) {
		List<Order> findOrderList = omsDao.findOrderList(mbrId, mbrName, mbrPhone, stDate, fhDate);
		return findOrderList;
	}

	public List<OrderDetail> findOrderDetailByOrderNo(int ordNo) {
		List<OrderDetail> orderDetail = omsDao.findOrderDetailByOrderNo(ordNo);
		return orderDetail;
	}

	public Order findOrderByOrderNo(int ordNo) {
		Order order = omsDao.findOrderByOrderNo(ordNo);
		return order;
	}

	public void updateOrder(String mbrId, String ordAddress, String ordPhone, String ordName, int drNo,
			java.sql.Date dbDate, int totalInstallTime, String ordMemo, int ordNo) {
		omsDao.updateOrder(mbrId, ordAddress, ordPhone, ordName, drNo, dbDate, totalInstallTime, ordMemo, ordNo);
		
	}

	public void deleteOrderList(int ordNo) {
		omsDao.deleteOrderList(ordNo);
		
	}

	public void updateOrderList(int ordNo, String prdCode, int quantityList, String mbrId) {
		omsDao.updateOrderList(ordNo, prdCode, quantityList, mbrId);
		
	}

	public void deleteOrder(int ordNo) {
		omsDao.deleteOrder(ordNo);
		
	}

}
