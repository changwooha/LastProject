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
<body>

	<form id="findForm">
		<table id="orderSearchTable" border="1">
			<colgroup>
				<col width="40">
				<col width="100">
				<col width="110">
				<col width="80">
				<col width="50">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">오더번호</th>
					<th scope="col">고객ID</th>
					<th scope="col">성명</th>
					<th scope="col">주소</th>
					<th scope="col">연락처</th>
					<th scope="col">주문일</th>
					<th scope="col">조회</th>
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
					<td class="orderDetail" id="${orderList.ordNo}"><a href="orderDetail.action?ordNo=${orderList.ordNo}">조회</a>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>

</html>