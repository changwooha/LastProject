<%@page import="com.example.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<title>productList</title>
<link rel="stylesheet" href="/controller/resources/button.css">
<style type="text/css">
input {
	border: none;
	background: transparent;
}
</style>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript">
	$(function() {

		function subTotal(element, amountValue) {
			var price = $(element).closest("tr").find('input[name=prdPrice]');
			var priceValue = price.val();

			var sum = $(element).closest("tr").find('input[name=sum]');
			sum.val(priceValue * amountValue);
		}
		


		
		$("tr[data-productcode] a[value='+']").on(
				'click',
				function(event) {
					var amount = $(this).closest("tr").find(
							'input[name=amount]');
					var amountValue = amount.val();
					var installTime = $(this).closest("tr").find(
							'input[name=prdInstallTime]');
					var installTimeValue = installTime.val();
					amount.val(++amountValue);

					subTotal(this, amountValue);
				});

		$("tr[data-productcode] a[value='-']").on('click', function(event) {
			var amount = $(this).closest("tr").find('input[name=amount]');
			var amountValue = amount.val();
			if (amountValue > 0) {
				amount.val(--amountValue);
				subTotal(this, amountValue);
			}
		});

		var num = 0;

		$("tr[data-productcode] a[value='담기']").on('click', function(event) {
			var code = $(this).closest("tr").find('input[name=prdCode]');
			var name = $(this).closest("tr").find('input[name=prdName]');
			var price = $(this).closest("tr").find('input[name=prdPrice]');
			var amount = $(this).closest("tr").find('input[name=amount]');
			var sum = $(this).closest("tr").find('input[name=sum]');
			var prdInstallTime = $(this).closest("tr").find('input[name=prdInstallTime]');
			var totalInstallTime = $(this).closest("tr").find('input[name=totalInstallTime]');

			/* 제품코드 제품명 단가 수량 합계 */
			var codeValue = code.val();
			var nameValue = name.val();
			var priceValue = price.val();
			var amountValue = amount.val();
			var sumValue = sum.val();
			var prdInstallTime = prdInstallTime.val();
			var str = '';

			str += '<tr '+'id=prdtr'+num+' data-productcode='+codeValue+'>';
			str += '<td id="prdCode" name="prdCode">'+ codeValue + '</td>';
			str += '<td id="prdName" name="prdName">'+ nameValue + '</td>';
			str += '<td id="prdPrice" name="prdPrice">'+ priceValue + '</td>';
			str += '<td id="prdQuantity" name="prdQuantity">'+ amountValue + '</td>';
			str += '<td id="prdSum" name="prdSum">' + sumValue+ '</td>';
			str += '<td id="prdInstallTime" name="prdInstallTime">'+ prdInstallTime + '</td>';
			str += '<td><input id="delete" name="delete" type="button" value="삭제" class="miniminiButton" onclick="deleteLine(this);"></td>';str += '</tr>';

			$('#myBody', opener.document).prepend(str);

			num = num + 1;
		});
		$('#search-link').on('click', function(event) {
			event.preventDefault();
			$('#searchForm').submit();
		});
		
		var searchOption = '${ searchOption }';
		var keyword = '${ keyword }';
		$('option[value=' + searchOption + ']').attr('selected', 'selected');
	});
</script>
<body>
	<form id="searchForm" action="searchProduct.action">
	<p align="center">
		<select id="searchOption" name="searchOption" style="height: 25px;">
			<option value="all">전체</option>
			<option value="100">침대/침실가구</option>
			<option value="200">소파/거실가구</option>
			<option value="300">자녀방/서재가구</option>
			<option value="400">식탁/주방가구</option>
		</select> <input id="keyword" name="keyword" style="height: 18px; border-bottom: solid 1px;"
		placeholder="" value="${keyword}" type="text">
		<a href="#" id="search-link" class="miniButton">검색</a>
	</p>
	</form>
	
	<table id="productTable" width="90%" cellpadding="5" cellspacing="0"
		border="1" align="center"
		style="border-collapse: collapse; border: 1px gray solid;">
		<tr>
			<th>코드번호</th>
			<th>상품명</th>
			<th>가격</th>
			<th>재고</th>
			<th>시공 시간</th>
			<th>구매수량</th>
			<th>합계</th>
		</tr>
		<c:forEach var="product" items="${products}">
			<tr data-productcode="${product.prdCode}">
				<td><input id="prdCode" name="prdCode" type="text" size="7"
					readonly value="${ product.prdCode }"></td>
				<td><input id="prdName" name="prdName" type="text" size="10"
					readonly value="${ product.prdName }"></td>
				<td><input id="prdPrice" name="prdPrice" type="text" size="8"
					readonly value="${ product.prdPrice }">원</td>
				<td><input id="prdQuantity" name="prdQuantity" type="text"
					size="4" readonly value="${ product.prdQuantity }"></td>
				<td><input id="prdInstallTime" name="prdInstallTime"
					type="text" size="5" readonly value="${ product.prdInstallTime }"></td>
				<td><input type="hidden" name="productId"
					value="${product.prdCode}"> <input type="text" id="amount"
					name="amount" size=4 value="0" readonly> <a href="#"
					class="calculate" value="+">+</a> <a href="#" class="calculate"
					value="-">-</a></td>
				<td><input type="text" id="sum" name="sum" size="10" value = "0" readonly>원</td>
				<td><a href="#" class="miniButton" id="save" name="save"
					value="담기">담기</a></td>
			</tr>

		</c:forEach>
	</table>
	<input type="hidden" value="${product.prdCode }" name="" id="duvud123">
</body>
</html>
