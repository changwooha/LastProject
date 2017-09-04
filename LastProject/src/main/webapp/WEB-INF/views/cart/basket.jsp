<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript">
$(function() {
	$('#commit').click(function() {
		alert($('#date').val());
		
		
		var count = $('tr[id^=prdtr]').length;
		var productList = [];
		var quantityList = [];
		var odtNo = [];

		var ordName = $('#name').val();
		var ordDeliveryDate = $('#date').val();
		var ordAddress = $('#addr').val();
		var ordMemo = $('#comment').val();
		var ordPhone = $('#phone').val();
		
		for(var i = 0; i < count; i++) {
			productList.push($('#prdtr'+i).attr("data-productcode"));
			quantityList.push($('#prdtr'+i).children('#prdQuantity').text());
			odtNo.push($('#odtNo'+i).val());
		}
		
		$.ajaxSettings.traditional = true; // userId[]:aa13 -> userId:aaa
		$.ajax({
			type:'POST',
			url: 'pay.action',
			data:{'productList':productList, 'quantityList':quantityList, 'ordDeliveryDate':ordDeliveryDate, 'ordAddress':ordAddress, 'ordMemo':ordMemo, 'odtNo':odtNo, 'ordName':ordName, 'ordPhone':ordPhone},
			success: function(){
				alert('성공');
				location.href='itemList.action'; 
				}
		})
	})
})

</script>

<table id="marketTable">
	<tr>
		<th>품 명</th>
		<th>개 당 가 격</th>
		<th>색 상</th>
		<th>수 량</th>
		<th>전 체 가 격</th>
	</tr>
	<c:forEach var="order" items="${order}" varStatus="status">
		<tr id="prdtr${status.index}" data-productcode="${detail[status.index].prdCode}">
			<td>${detail[status.index].prdName}</td>
			<td>${detail[status.index].prdPrice}</td>
			<td>${detail[status.index].prdColor}</td>
			<td id="prdQuantity">${order.odtQuantity}</td>
			<td>${detail[status.index].prdPrice * order.odtQuantity}</td>
		</tr>
		<input id="odtNo${status.index}" type="hidden" name="odtNo" value="${order.odtNo}">
		<input type="hidden" name="odtNo" value="${order.odtNo}">
	</c:forEach>
</table>
<br>
<div>
	<h5>받는사람</h5>
	<input id="name">
	<h5>배송지</h5>
	<input id="addr">
	<h5>연락처</h5>
	<input id="phone">
	<h5>배송희망일</h5>
	<input type="date" id="date">
	<h5>배송 시 요구사항</h5>
	<input id="comment">
	<br>
	<button id="commit">결제</button>
</div>