<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>Home</title>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 달력 js -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript">
	// 멤버검색	
	function openMbChk() {
		window.name = "parentForm";
		window.open("oms/searchMember.action", "chkForm",
				"width=500, height=300, resizable = no, scrollbars = no");
	}
	// 제품목록
	function openProductList() {
		//window.name = "parentForm";
		window.open("oms/productList.action", "pdList",
				"width=1100, height=700, resizable=no, scrollbars = no");
	}
	//
	$(function() {
		$(document).ready(function() { // 로딩시 alert
			alert("안녕 효현이라능");
		});

		$('#orderConfirm').click(
			function() { 
				var count = $('tr[id^=prdtr]').length;
				var productCodeList = [];
				var quantityList = [];
				var prdInstallTime = [];
				var installDate = $("#datepicker").val();
				var mbrId = $('#mbrId').val();
				var ordName = $('#mbrName').val();
				var ordAddress = $('#mbrAddress').val();
				var ordPhone = $('#mbrPhone').val();

				for (var i = 0; i < count; i++) {
					productCodeList.push($('#prdtr' + i).attr("data-productcode"));
					quantityList.push($('#prdtr' + i).children('#prdQuantity').text());
					prdInstallTime.push($('#prdtr' + i).children('#prdInstallTime').text());
				}

					$.ajaxSettings.traditional = true; // userId[]:aa13 -> userId:aaa
					$.ajax({
						type : 'POST',
						url : 'oms/orderConfirm.action',
						data : {
						'productCodeList' : productCodeList,
						'quantityList' : quantityList,
						'prdInstallTime' : prdInstallTime,
						'mbrId' : mbrId,
						'ordName' : ordName,
						'ordAddress' : ordAddress,
						'ordPhone' : ordPhone,
						'installDate' : installDate
					},
						success : function(data, status, xhr) {
							if (data == 'success') {
									alert("DB입력 완료.")
							} else if (data == 'error') {
									alert("다른 날짜를 선택하세요.")
							}
						},
					})
				})

		$(function() {
			$("#datepicker").datepicker();
		});
	})
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/oHeader.jsp"/>
		<p style="margin-left: 300px">연</p>
		<div id="added">
			<hr noshade>
			<h2>고객정보</h2>
			<h4>주문고객</h4>
			고객명 <input type="text" style="" name="mbrName" id="mbrName"><br>
			주소 <input type="text" style="" name="mbrAddress" id="mbrAddress"><br>
			연락처 <input type="text" style="" name="mbrPhone" id="mbrPhone"><br>
			<input type="hidden" id="mbrId" name="mbrId"> <input
				id="search" name="search" type="button" value="조회"
				onclick="openMbChk()">
			<p>
				<input type="button" value="제품 목록" id="searchProduct"
					name="searchProduct" onclick="openProductList()">
			</p>
		</div>

		<div id="list">
			<table id="myTable">
				<tr>
					<th>제품코드</th>
					<th>제품명</th>
					<th>단가</th>
					<th>수량</th>
					<th>합계</th>
					<hr noshade>
				</tr>
				<tbody id="myBody">

				</tbody>
			</table>
			<hr noshade>
		</div>
		<p>
			시공일 : <input type="text" id="datepicker">
		</p>
		<div id="numOfList">
			<b id="numOfCar"> 총 합계 : 0원</b> <br>
		</div>

		<div id="buttonList">
				<button id="orderConfirm">오더 확정</button>
				<input id="outpark" type="button" class="btt" value="견적저장"></input>
		</div>

</body>

</html>