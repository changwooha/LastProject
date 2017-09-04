<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

				<table id="clickedWarehouseInfo">
					<thead>
						<tr>
							<th >제품코드</th>
							<th >이름</th>
							<th >위치 수량 / 총 수량</th>
							<th >가격</th>
							<th >색상</th>
							<th >규격</th>
							<th >안전재고</th>
							<th >설치시간</th>
							<th >발주</th>
						</tr>
					</thead>
					<tbody>
						<c:if test = "${products ne null }">
						<c:forEach var="i" begin="0" end="${size - 1}" step="1">
						<tr>
							<td >${products[i].prdCode}</td>
							<td >${products[i].prdName}</td>
							<td >${warehouselocations[i].wlQuantity} / ${products[i].prdQuantity}</td>
							<td >${products[i].prdPrice}</td>
							<td >${products[i].prdColor}</td>
							<td >${products[i].prdSize}</td>
							<td >${products[i].prdSafeStock}</td>
							<td >${products[i].prdInstallTime}</td>
							<td ><input type="button" class="productorder" value="발주"></td>
						</tr>
						</c:forEach>
						</c:if>
					</tbody>
				</table>
