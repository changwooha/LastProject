package com.example.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.dto.Driver;
import com.example.dto.Member;
import com.example.dto.OrderDetail;
import com.example.dto.Product;
import com.example.service.OrderService;
import com.example.service.ProductService;

@Controller
public class CartController {
   
   @Autowired
   @Qualifier("productService")
   ProductService productService;
   
   @Autowired
   @Qualifier("orderService")
   OrderService orderService;
   
   @RequestMapping(value = "productDetail.action", method = RequestMethod.POST)
   public @ResponseBody Product selectProduct(Product product){
      
      String prdCode = product.getPrdCode();
      
      Product data = productService.selectProductByCode(prdCode);
      
      // 수량 
      String code = product.getPrdCode();
      int sum = productService.codeByAmount(code);
      data.setPrdQuantity(sum);
      
      return data;
   }
   
   @RequestMapping(value = "cart/cart.action", method = RequestMethod.POST)
   @ResponseBody
   public String cart(OrderDetail order, HttpSession session) {
	   
	  Member member = (Member) session.getAttribute("loginmember");
	  
	  if(member != null) {
		  String mbrId = member.getMbrId();
		  orderService.insertByCode(order, mbrId);
	  } else {
		  return "redirect:/login";
	  }
      return "success";
   }
   
   @SuppressWarnings("unused")
   @RequestMapping(value = "/basket.action", method = RequestMethod.GET)
   public String basket(Model model, HttpSession session, HttpServletResponse response) {
      
	  Member member = (Member) session.getAttribute("loginmember");
	  
	  if(member != null) {
	  
		  String mbrId = member.getMbrId();
		  
		  System.out.println(mbrId);
		   
	      List<OrderDetail> order = orderService.selectByUserId(mbrId);
	      List<Product> products = new ArrayList<>();
	      
	      for (int i = 0; i < order.size(); i++) {
	         
	         String prdCode = order.get(i).getPrdCode();
	         
	         Product data = productService.selectProductByCode(prdCode);
	         
	         products.add(data);
	         
	      }
	      
	      for (int i = 0; i < products.size(); i++) {
	    	  System.out.println(products.get(i).getPrdName());
	      }
      
	      if (order.size() != 0) {
	    	  model.addAttribute("order", order);
	          model.addAttribute("detail", products);
	      } else {
	    	  PrintWriter writer = null;
			try {
				response.setCharacterEncoding("EUC-KR");
				writer = response.getWriter();
				writer.println("<script>alert('장바구니가 비었습니다.'); location.href='itemList.action'; </script>");
				writer.flush();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				writer.close();
			}
	      }
	      return "cart/basket";
	      
      } else {
    	  return "redirect:/login";
      }
      
   }
   
   @RequestMapping(value = "/pay.action", method = {RequestMethod.GET, RequestMethod.POST})
   @ResponseBody
   public String pay(HttpServletRequest request, HttpSession session) {
	   
	   String[] productList = request.getParameterValues("productList");
	   String[] quantityList = request.getParameterValues("quantityList");
	   String[] odtNo = request.getParameterValues("odtNo");
	   String ordDeliveryDate = request.getParameter("ordDeliveryDate");
	   String ordAddress = request.getParameter("ordAddress");
	   String ordMemo = request.getParameter("ordMemo");
	   String ordName = request.getParameter("ordName");
	   String ordPhone = request.getParameter("ordPhone");
	   
	   Member member = (Member) session.getAttribute("loginmember");
	   String mbrId = member.getMbrId();
	   
	   List<Driver> driver = orderService.selectByDate(ordDeliveryDate);
	   
	   if (driver != null) {
		   int drNo = driver.get(0).getDrNo();
		   int installTime = 0;
		   for(int i=0; i<productList.length; i++){
			   installTime += orderService.selectInstallTime(productList[i], quantityList[i]);
		   }
		   
		   orderService.insertOrd(ordDeliveryDate, ordName, ordPhone, mbrId, ordMemo, ordAddress, drNo, installTime);
		   
		   List<Integer> ordNo = orderService.selectOrdByMbrId(mbrId);
		   
		   System.out.println(ordNo.get(ordNo.size()-1));
		   
		   for(int i=0; i<productList.length; i++){
				orderService.updateOrderDetail(odtNo[i], mbrId, ordNo.get(ordNo.size()-1));
			}
		   
		   return "success";
		   
	   } else {
		   return null;
	   }
   }
}