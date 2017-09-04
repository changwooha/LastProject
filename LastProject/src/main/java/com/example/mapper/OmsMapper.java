package com.example.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.example.dto.Driver;
import com.example.dto.Member;
import com.example.dto.Order;
import com.example.dto.OrderDetail;
import com.example.dto.Product;

public interface OmsMapper {

	Member findByNameAndPhoneNumber(HashMap<String, Object> params);
	ArrayList<Product> productList();
	void orderConfirm(Member member, Product product);
	void insertOrderList(HashMap<String, Object> params);
	void insertOrder(HashMap<String, Object> params);
	ArrayList<Driver> selectDriverEnableTimeByDate(HashMap<String, Object> params);
	List<Order> findOrderList(HashMap<String, Object> params);
	List<OrderDetail> findOrderDetailByOrderNo(int ordNo);
	List<Product> findProductNameByOrderNo(int ordNo);
	List<Order> findOrderByOrderNo(int ordNo);
}
