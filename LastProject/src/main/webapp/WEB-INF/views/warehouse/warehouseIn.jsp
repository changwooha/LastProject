<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

				<table class="table-fill" id="warehouseIn">
					<thead>
						<tr>
							<th >입고일</th>
							<th >제품코드</th>
							<th >제품이름</th>
							<th >재고수량</th>
							<th >입고수량</th>
						</tr>
					</thead>
					<tbody class="table-hover">
						<c:if test = "${stores ne null }">
						<c:forEach var="i" begin="0" end="${storeSize - 1}" step="1">
						<tr class="storereleasedata">
							<td  prdCode="${storeProducts[i].prdCode}">${stores[i].srDate}</td>
							<td  prdCode="${storeProducts[i].prdCode}">${storeProducts[i].prdCode}</td>
							<td  prdCode="${storeProducts[i].prdCode}">${storeProducts[i].prdName}</td>
							<td  prdCode="${storeProducts[i].prdCode}">${storeProducts[i].prdQuantity}</td>
							<td  prdCode="${storeProducts[i].prdCode}">${storeOrderDetails[i].odtQuantity}</td>
						</tr>
						</c:forEach>
						</c:if>
					</tbody>
				</table>