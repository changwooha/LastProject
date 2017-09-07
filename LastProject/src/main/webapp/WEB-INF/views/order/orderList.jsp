<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>Home</title>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="/controller/resources/button.css">
<!-- 달력 js -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript">
$(function() {

	$("#findOrderList").click(function(){
		event.preventDefault();
		var mbrId = $("#mbrId").val();
		var mbrName = $("#mbrName").val();
		var mbrPhone = $("#mbrPhone").val();
		var startDate = $("#startDate").val();
		var finishDate = $("#finishDate").val();
		
		$.ajaxSettings.traditional = true; // userId[]:aa13 -> userId:aaa
		$.ajax({
			type : 'POST',
			url : 'findOrderList.action',
			data : {
				'mbrId' : mbrId,
				'mbrName' : mbrName,
				'mbrPhone' : mbrPhone,
				'startDate' : startDate,
				'finishDate' : finishDate
			},
			
			success : function(data, status, xhr){
				if(data=="success"){
					alert("조회성공")
					$('#orderSearchTable').load('filterOrderList.action', $('#searchOrderForm').serialize());
				} else if (data == "error") {
					alert("조회된 정보가 없습니다.")
					
			}
			}, error : function(){alert("계약일을 지정해주세요♥");}
		});
	});
	
	$("#startDate").datepicker();
	$("#finishDate").datepicker();
	
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/oHeader.jsp"/>
	<div class="bodyDiv">
		<form id="searchOrderForm">
		<b>고객명  : </b><input type="text" name="mbrId" id="mbrId" class="text">
		<!-- 고객명<input id="mbrId" name="mbrId" type="text"> -->
		<b>설치 고객명  : </b><input type="text" name="mbrName" id="mbrName" class="text">
		<b>핸드폰 : </b><input type="text" name="mbrPhone" id="mbrPhone" class="text">
		<b>계약일 ->  : </b><input name="startDate" id="startDate" class="text">
		<b><- 계약일  : </b><input name="finishDate" id="finishDate" class="text">
		<!-- <button id="findOrderList">검색</button> -->
		
		<a href="#" class="miniButton" id="findOrderList">검색</a></form>
	<table id="orderSearchTable"></table>
	
	<form id="findOrderForm">
	</form>
	</div>
</body>

</html>