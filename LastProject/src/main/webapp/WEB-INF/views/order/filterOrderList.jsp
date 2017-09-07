<%@page import="java.util.List"%>
<%@page import="com.example.dto.Order"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script type="text/javascript">
</script>
<style>
</style>
<body>
	<div class="bodyDiv">
	<form id="findForm">
		<table id="orderSearchTable" width="100%" cellpadding="2" cellspacing="0"
		border="1" style="border-collapse: collapse; border: 1px gray solid;">
			<thead>
				<tr>
					<th>오더번호</th>
					<th>고객ID</th>
					<th>성명</th>
					<th>주소</th>
					<th>연락처</th>
					<th>주문일</th>
					<th>조회</th>
				</tr>
			</thead>
			<c:forEach var="orderList" items="${orderList}">
				<tr>
					<td>${ orderList.ordNo }</td>
					<td>${ orderList.mbrId }</td>
					<td>${ orderList.ordName }</td>
					<td>${ orderList.ordAddress }</td>
					<td>${ orderList.ordPhone }</td>
					<td><fmt:formatDate value="${ orderList.ordDate }"
							pattern="yyyy-MM-dd" /></td>
					<td class="orderDetail" id="${orderList.ordNo}"><a class="miniButton" href="orderDetail.action?ordNo=${orderList.ordNo}">♥</a>
				</tr>
			</c:forEach>
		</table>
	</form></div>
</body>

</html>