<%@page import="com.example.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link rel="stylesheet" href="../resources/order.css">
<link rel="stylesheet" href="/controller/resources/button.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript">
</script>
<body>
<jsp:include page="/WEB-INF/views/include/oHeader.jsp"/>
<br><br>
	<table id="orderDetail" class="type10">
		<thead>
			<tr>
				<th>오더번호</th>
				<th>고객ID</th>
				<th>설치고객</th>
				<th>시공지</th>
				<th>연락처</th>
				<th>시공일</th>
				<th>시공기사 남김말</th>
			</tr>
		</thead>
			<tr>
				<td>${order.ordNo}</td>
				<td>${order.mbrId}</td>
				<td>${order.ordName}</td>
				<td>${order.ordAddress}</td>
				<td>${order.ordPhone}</td>
				<td><fmt:formatDate value="${order.ordDeliveryDate}"
						pattern="yyyy-MM-dd" /></td>
				<td>${order.ordMemo}</td>
			</tr>
	</table>
	<hr noshade>
	<br>
	<table class="type10">
		<thead>
			<tr>
				<th>코드번호</th>
				<th>제품명</th>
				<th>수량</th>
			</tr>
		</thead>
		<c:forEach var="orderDetail" items="${orderDetail}">
			<tr>
				<td>${ orderDetail.prdCode }</td>
				<td>${ orderDetail.prdName }</td>
				<td>${ orderDetail.odtQuantity }</td>
				
			</tr>
		</c:forEach>
		
	</table><br><br><br>
	<div align="center">
	<jsp:useBean id="now" class="java.util.Date" />
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="today" />
	<fmt:formatDate value="${order.ordDeliveryDate}"
		pattern="yyyy-MM-dd" var="deliveryDate" />
	<c:choose>
		<c:when test="${today < deliveryDate}">
			<a href="modifyOrder.action?ordNo=${order.ordNo}" class="button">오더수정</a>
		</c:when>
		<c:otherwise>
			<a href="#" class="button">수정불가</a>
		</c:otherwise>
	</c:choose>
	</div>
</body>
</html>