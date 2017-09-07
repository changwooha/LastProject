<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<html>
<head>
<title>Home</title>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style type="text/css">
.bodyDiv {
    border: 1px solid gray;
    margin-top: 10px;
    margin-bottom: 20px;
    margin-right: 70px;
    margin-left: 70px;
}
.text {
	border: none;
	border-bottom: solid 1px;
	background-color: #eaf0f2;

}
</style>
<!-- 달력 js -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link rel="stylesheet" href="/controller/resources/button.css">
<script type="text/javascript">
	// 멤버검색	
	function openMbChk() {
		window.name = "parentForm";
		window.open("searchMember.action", "chkForm",
				"width=500, height=300, resizable = no, scrollbars = no");
	}
	// 제품목록
	function openProductList() {
		//window.name = "parentForm";
		window.open("productList.action", "pdList",
				"width=1100, height=700, resizable=no, scrollbars = no");
	}
	
	function deleteLine(obj) {
	    var tr = $(obj).parent().parent();
	 	var count = $('tr[id^=prdtr]').length
	 	
	 	var i = 2;
	 	
	    //라인 삭제
	    tr.remove();
	 	--count
	 	alert("선택행이 삭제되었습니다.");

	}
	//
	$(function() {
		$(document).ready(function() { // 로딩시 alert
			alert("안녕 효현이라능");
		});
		
		$('#deleteOrder').click(function() { 
			alert("삭제");
			var ordNo = $('#ordNo').val();
			alert(ordNo);
			$.ajaxSettings.traditional = true; // userId[]:aa13 -> userId:aaa
			$.ajax({
				type : 'POST',
				url : 'deleteOrder.action',
				data : {
				'ordNo' : ordNo
			},
				success : function(data, status, xhr) {
					if (data == 'success') {
							alert("삭제완료.")
					} else if (data == 'error') {
							alert("이미 삭제된 데이터 입니다.")
					}
				},
			})
		});

		$('#modifyConfirm').click(
			function() { 
				
				for (var i = 0; i < $('#myBody').children('tr[id^=prdtr]').length; i++) {
					var j = i+1;
				 $('#myBody tr:nth-child('+j+')').attr('id','prdtr'+i);
				}
				
				var count = $('tr[id^=prdtr]').length;
				var productCodeList = [];
				var quantityList = [];
				var prdInstallTime = [];
				var installDate = $("#datepicker").val();
				var mbrId = $('#mbrId').val();
				var ordName = $('#mbrName').val();
				var ordAddress = $('#mbrAddress').val();
				var ordPhone = $('#mbrPhone').val();
				var orderMemo = $('#orderMemo').val();
				var ordNo = $('#ordNo').val();
				alert(ordNo);
				for (var i = 0; i < count; i++) {
					productCodeList.push($('#prdtr' + i).attr("data-productcode"));
					quantityList.push($('#prdtr' + i).children('#prdQuantity').text());
					prdInstallTime.push($('#prdtr' + i).children('#prdInstallTime').text());
				}

					$.ajaxSettings.traditional = true; // userId[]:aa13 -> userId:aaa
					$.ajax({
						type : 'POST',
						url : 'modifyConfirm.action',
						data : {
						'productCodeList' : productCodeList,
						'quantityList' : quantityList,
						'prdInstallTime' : prdInstallTime,
						'mbrId' : mbrId,
						'ordName' : ordName,
						'ordAddress' : ordAddress,
						'ordPhone' : ordPhone,
						'installDate' : installDate,
						'ordMemo' : orderMemo,
						'count' : count,
						'ordNo' : ordNo
					},
						success : function(data, status, xhr) {
							if (data == 'success') {
									alert("DB입력 완료.")
							} else if (data == 'error') {
									alert("다른 날짜를 선택하세요.")
							}
						},
					})
				});

		$(function() {
			$("#datepicker").datepicker();
		});
	})
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/oHeader.jsp"/>
		<p style="margin-left: 300px">수정</p>
		<div id="added">
			<hr noshade>
			<h3>오더번호 : <input type="text" style="" name="ordNo" id="ordNo" value="${order.ordNo}" class="text"></h3>
			<h3>고객정보</h3>
			<b>고객명 : </b> <input type="text" style="" name="mbrName" id="mbrName" value="${order.ordName}" class="text"><br>
			<b>주&nbsp;&nbsp;&nbsp;소  : </b> <input type="text" style="" name="mbrAddress" id="mbrAddress" value="${order.ordAddress}" class="text"><br>
			<b>연락처  : </b><input type="text" style="" name="mbrPhone" id="mbrPhone" value="${order.ordPhone}" class="text"><br>
			<input type="hidden" id="mbrId" name="mbrId" value="${order.mbrId }" class="text"> 			
			<a href="#" class="miniButton" id="search" name="search" onclick="openMbChk()">조회</a>
			<p>
				<a href="#" class="miniButton" id="searchProduct" onclick="openProductList()">제품목록</a>
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
					<th>시공시간</th>
					<hr noshade>
				</tr>
				<tbody id="myBody">
		<c:forEach var="orderDetail" items="${orderDetail}">
		<tr id=prdtr data-productcode="${orderDetail.prdCode}">
		<td id="prdCode" name="prdCode">${orderDetail.prdCode}</td>
		<td id="prdName" name="prdName">${orderDetail.prdName}</td>
		<td id="prdPrice" name="prdPrice">${orderDetail.prdPrice}</td>
		<td id="prdQuantity" name="prdQuantity">${orderDetail.odtQuantity}</td>
		<td id="prdSum" name="prdSum">${orderDetail.prdPrice * orderDetail.odtQuantity}</td>
		<td id="prdInstallTime" name="prdInstallTime">${orderDetail.prdInstallTime} 시간</td>
		<td><input id="delete" name="delete" type="button" value="x" class="miniminiButton" onclick="deleteLine(this);"></td>
		</tr>
					</c:forEach>
				</tbody>
			</table>
			<hr noshade>
		</div>
		<p>
			<b>시공일 : </b><input type="text" id="datepicker">
		</p>
		<p> <b>시공기사 남김 말 : </b><input type="text" id="orderMemo" value="${order.ordMemo}" size="30">
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="#" class="button" id="modifyConfirm">오더확정</a>
		&nbsp;&nbsp;<a href="#" class="button" id="deleteOrder">오더삭제</a></p>
		<div id="numOfList">
			<b id="numOfCar"> 총 합계 : 0원</b> <br>
		</div>

</body>
</html>