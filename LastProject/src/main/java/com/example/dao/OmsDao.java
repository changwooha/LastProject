package com.example.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.example.dto.Driver;
import com.example.dto.Member;
import com.example.dto.Order;
import com.example.dto.OrderDetail;
import com.example.dto.Product;
import com.example.mapper.OmsMapper;

@Repository
public class OmsDao {

	@Autowired
	@Qualifier("omsMapper")
	private OmsMapper omsMapper;

	public Member findByNameAndPhoneNumber(String mbrName, String mbrPhone) {
		// 전달인자가 2개 이상일 때에는 hashmap으로 전달한다
		HashMap<String, Object> params = new HashMap<>();
		params.put("mbrName", mbrName);
		params.put("mbrPhone", mbrPhone);
		
		Member member = omsMapper.findByNameAndPhoneNumber(params);
		return member;
	}

	public ArrayList<Product> productList() {
		ArrayList<Product> products = omsMapper.productList();
		return products;
	}

	public void orderConfirm(Member member, Product product) {
		omsMapper.orderConfirm(member, product);
	}

	public void insertOrderList(String prdName, int quantityList, String mbrId) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("prdName", prdName);
		params.put("prdQuantity", quantityList);
		params.put("mbrId", mbrId);
		omsMapper.insertOrderList(params);
	}

	public void insertOrder(String mbrId, String ordAddress, String ordPhone, String ordName, int drNo, Date dbDate, int totalInstallTime, String ordMemo) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("mbrId", mbrId);
		params.put("ordAddress", ordAddress);
		params.put("ordPhone", ordPhone);
		params.put("ordName", ordName);
		params.put("drNo", drNo);
		params.put("dbDate", dbDate);
		params.put("totalInstallTime", totalInstallTime);
		params.put("ordMemo", ordMemo);
		omsMapper.insertOrder(params);
	}

	public ArrayList<Driver> selectDriverEnableTimeByDate(Date dbDate, int totalInstallTime) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("dbDate", dbDate);
		params.put("totalInstallTime", totalInstallTime);
		ArrayList<Driver> driverEnableTimeByDate = omsMapper.selectDriverEnableTimeByDate(params);
		return driverEnableTimeByDate;
	}

	public List<Order> findOrderList(String mbrId, String mbrName, String mbrPhone, Date stDate,
			Date fhDate) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("mbrId", mbrId);
		params.put("mbrName", mbrName);
		params.put("mbrPhone", mbrPhone);
		params.put("stDate", stDate);
		params.put("fhDate", fhDate);
		List<Order> findOrderList = omsMapper.findOrderList(params);
//		System.out.println(params);
		return findOrderList;
	}

	public List<OrderDetail> findOrderDetailByOrderNo(int ordNo) {
		List<OrderDetail> orderDetail = omsMapper.findOrderDetailByOrderNo(ordNo);
		return orderDetail;
	}

	public List<Product> findProductNameByOrderNo(int ordNo) {
		List<Product> productDetail = omsMapper.findProductNameByOrderNo(ordNo);
		return productDetail;
	}

	public Order findOrderByOrderNo(int ordNo) {
		Order order = omsMapper.findOrderByOrderNo(ordNo);
		return order;
	}

	public void updateOrder(String mbrId, String ordAddress, String ordPhone, String ordName, int drNo, Date dbDate,
			int totalInstallTime, String ordMemo, int ordNo) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("mbrId", mbrId);
		params.put("ordAddress", ordAddress);
		params.put("ordPhone", ordPhone);
		params.put("ordName", ordName);
		params.put("drNo", drNo);
		params.put("dbDate", dbDate);
		params.put("totalInstallTime", totalInstallTime);
		params.put("ordMemo", ordMemo);
		params.put("ordNo", ordNo);
		omsMapper.updateOrder(params);
		
	}

	public void deleteOrderList(int ordNo) {
		omsMapper.deleteOrderList(ordNo);
	}

	public void updateOrderList(int ordNo, String prdCode, int quantityList, String mbrId) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("ordNo", ordNo);
		params.put("prdCode", prdCode);
		params.put("quantityList", quantityList);
		params.put("mbrId", mbrId);
		omsMapper.updateOrderList(params);
		
	}

	public void deleteOrder(int ordNo) {
		omsMapper.deleteOrder(ordNo);
	}

	public List<Product> filterProductList(String searchOption, String keyword) {
		HashMap<String, Object> params = new HashMap<>();
		params.put("searchOption", searchOption);
		params.put("keyword", keyword);
		List<Product> products = omsMapper.filterProductList(params);
		return products;
	}
}
