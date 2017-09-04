package com.example.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.Driver;
import com.example.dto.Member;
import com.example.dto.Order;
import com.example.dto.OrderDetail;
import com.example.dto.Product;
import com.example.service.OmsService;

@Controller
@RequestMapping(value = "oms")
public class OrderController {

	@Autowired
	@Qualifier("omsService")
	private OmsService omsService;

	// main에서 고객조회 window창 띄우기
	@RequestMapping(value = "searchMember.action", method = RequestMethod.GET)
	public String searchMemberForm() {
		return "order/memberSearch";
	}

	// 멤버검색
	@RequestMapping(value = "searchMember.action", method = RequestMethod.POST)
	@ResponseBody
	public String searchMember(String mbrName, String mbrPhone, String mbrId) {

		Member member = omsService.authenticate(mbrName, mbrPhone);
		if (member == null) {
			System.out.println("검색결과없음");
		} else {
		}
		return "";
	}

	// 데이터가 들어있는 테이블 가져오기
	@RequestMapping(value = "memberTable.action", method = RequestMethod.GET)
	public String searchItem(Model model, String mbrName, String mbrPhone, String mbrId) {

		Member member = omsService.authenticate(mbrName, mbrPhone);

		model.addAttribute("member", member);

		return "order/searchItem";
	}

	/////////////////////// 주문목록//////////////////////////////////

	// 주문목록 팝업 띄우기
	@RequestMapping(value = "productList.action", method = RequestMethod.GET)
	public String openWindow(Model model) {

		ArrayList<Product> products = omsService.productList();
		model.addAttribute("products", products);

		return "order/searchProduct";

	}

	// /날짜/총시공시간/-->오더확정하기
	@RequestMapping(value = "orderConfirm.action", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String orderConfirm(Model model, HttpServletRequest request, HttpServletResponse response, Date installDate,
			String mbrId, String ordName, String ordAddress, String ordPhone) throws IOException {

		String[] sproductCodeList = request.getParameterValues("productCodeList");
		String[] sQuantityList = request.getParameterValues("quantityList");
		String[] sprdInstallTime = request.getParameterValues("prdInstallTime");

		ArrayList<Product> productList = new ArrayList<>();
		ArrayList<Integer> quantityList = new ArrayList<>();
		int totalInstallTime = 0;
		for (int i = 0; i < sproductCodeList.length; i++) {
			Product product = new Product();
			productList.add(i, product);
			productList.get(i).setPrdCode(sproductCodeList[i]);
			productList.get(i).setPrdInstallTime(Integer.parseInt(sprdInstallTime[i]));
			totalInstallTime += productList.get(i).getPrdInstallTime() * (Integer.parseInt(sQuantityList[i]));
			quantityList.add(i, Integer.parseInt(sQuantityList[i]));
		}
		System.out.println(totalInstallTime);
		// 날짜 받아와서 형변환
		java.sql.Date dbDate = new java.sql.Date(installDate.getTime());
		System.out.println(dbDate);
		ArrayList<Driver> driverEnableByDate = omsService.findDriverEnableTimeByDate(dbDate, totalInstallTime);

		if (driverEnableByDate.size() == 0) {
			System.out.println("시공가능한 기사가 없습니다");
			return "error";
		} else {
			for (int i = 0; i < driverEnableByDate.size(); i++) {
				System.out.println(driverEnableByDate.get(i).getDrNo());
			}
		}
		int drNo = driverEnableByDate.get(0).getDrNo();
		omsService.insertOrder(mbrId, ordAddress, ordPhone, ordName, drNo, dbDate, totalInstallTime);

		for (int i = 0; i < productList.size(); i++) {
			omsService.insertOrderList(productList.get(i).getPrdCode(), quantityList.get(i), mbrId);
		}
		return "success";

	}

	
	////////////////// 오더조회 ///////////////////
	
	// 조회 창으로 이동하기
	@RequestMapping(value = "orderList.action", method = RequestMethod.GET)
	public String orderList() {
		return "order/orderList";
	}
	
	// 조건검색
	@RequestMapping(value = "findOrderList.action", method = { RequestMethod.GET, RequestMethod.POST })
	@ResponseBody
	public String findOrderList(Model model, HttpServletRequest request, HttpServletResponse response, String mbrId,
			String mbrName, String mbrPhone, Date startDate, Date finishDate) throws IOException {

		java.sql.Date stDate = new java.sql.Date(startDate.getTime());
		java.sql.Date fhDate = new java.sql.Date(finishDate.getTime());

		List<Order> orderList = omsService.findOrderList(mbrId, mbrName, mbrPhone, stDate, fhDate);
		if (orderList.size() == 0) {
			return "error";
		} else {
			return "success";
			}
		}

	
	// 조건에 맞는 테이블 가져오기
	@RequestMapping(value = "filterOrderList.action", method = RequestMethod.GET)
	public String filterOrderList(Model model, HttpServletRequest request, HttpServletResponse response,String mbrId,
			String mbrName, String mbrPhone, Date startDate, Date finishDate) {
		System.out.println(mbrName);
		java.sql.Date stDate = new java.sql.Date(startDate.getTime());
		java.sql.Date fhDate = new java.sql.Date(finishDate.getTime());

		List<Order> orderList = omsService.findOrderList(mbrId, mbrName, mbrPhone, stDate, fhDate);
		model.addAttribute("orderList", orderList);
		
		return "order/filterOrderList";
	}
	// 상세페이지로 이동
	@RequestMapping(value="orderDetail.action", method=RequestMethod.GET)
	public String orderDetail(@RequestParam("ordNo") int ordNo, Model model){
		System.out.println(ordNo);
		List<Order> order = omsService.findOrderByOrderNo(ordNo);
		List<OrderDetail> orderDetail = omsService.findOrderDetailByOrderNo(ordNo);
		System.out.println(orderDetail.get(0).getPrdName());
		//List<Product> productDetail = omsService.findProductNameByOrderNo(ordNo);
		//System.out.println(productDetail.get(0).getprd);
		//System.out.println(order);
		
		model.addAttribute("orderDetail", orderDetail);
		model.addAttribute("order", order);
		return "order/orderDetail";
		
	}

}