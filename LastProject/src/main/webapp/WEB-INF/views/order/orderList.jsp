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
					alert("성공")
					$('#orderSearchTable').load('filterOrderList.action', $('#searchOrderForm').serialize());
				} else if (data == "error") {
					alert("조회된 정보가 없습니다.")
					
			}
			}, error : function(){alert("오류발생");}
		});
	});
	
	$("#startDate").datepicker();
	$("#finishDate").datepicker();
	
});
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/oHeader.jsp"/>
		<form id="searchOrderForm">
		고객명<input id="mbrId" name="mbrId" type="text">
		설치 고객명<input id="mbrName" name="mbrName" type="text">
		핸드폰<input id="mbrPhone" name="mbrPhone" type="text">
		시작일<input name="startDate" id="startDate">
		종료일<input name="finishDate" id="finishDate">
		<button id="findOrderList">검색</button></form>
	<table id="orderSearchTable"></table>
	
	<form id="findOrderForm">
	</form>
</body>

</html>