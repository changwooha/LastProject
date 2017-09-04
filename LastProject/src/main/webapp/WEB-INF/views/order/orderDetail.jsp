<%@page import="com.example.dto.Member"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript">
</script>
<style>
</style>
<body>
	<table id="orderDetail">

		<thead>
			<tr>
				<th>고객ID</th>
				<th>설치고객</th>
				<th>시공지</th>
				<th>연락처</th>
				<th>시공일</th>
				<th>시공기사 남김말</th>
			</tr>
		</thead>
		<c:forEach var="order" items="${order}">
		<tr>
			<td>${order.mbrId}</td>
			<td>${order.ordName}</td>
			<td>${order.ordAddress}</td>
			<td>${order.ordPhone}</td>
			<td><fmt:formatDate value="${order.ordDate}" pattern="yyyy-MM-dd" /></td>
			<td>${order.ordMemo}</td>
		</tr>
		</c:forEach>
			</table>
		<hr noshade>
		<hr noshade>
		<tr>
			<th scope="col">번호</th>
			<th scope="col">코드번호</th>
			<th scope="col">제품명</th>
			<th scope="col">수량</th>
		</tr>
		<c:forEach var="orderDetail" items="${orderDetail}">
			<tr>
				<td>1</td>
				<td>${ orderDetail.prdCode }</td>
				<td>${ orderDetail.prdName }</td>
				<td>${ orderDetail.odtQuantity }</td>
			</tr>
		</c:forEach>

</body>

</html>