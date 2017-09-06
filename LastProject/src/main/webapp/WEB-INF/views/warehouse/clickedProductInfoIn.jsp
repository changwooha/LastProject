<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

	<table id="clickedProductInfoIn">
					<c:if test = "${clickedProduct ne null }">
					<thead>
						<tr>
							<th>제품 코드</th>
							<th>제품 이름</th>
							<th>제품 가격</th>
							<th>제품 총 수량</th>
							<th>제품 카테고리</th>
							<th>제품 색상</th>
							<th>제품 사이즈</th>
							<th>제품 안전재고</th>
							<th>제품 설치시간</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>${clickedProduct.prdCode}</td>
							<td>${clickedProduct.prdName}</td>
							<td>${clickedProduct.prdPrice}</td>
							<td>${clickedProduct.prdQuantity}</td>
							<td>${clickedProduct.prdCategory}</td>
							<td>${clickedProduct.prdColor}</td>
							<td>${clickedProduct.prdSize}</td>
							<td>${clickedProduct.prdSafeStock}</td>
							<td>${clickedProduct.prdInstallTime}</td>
						</tr>
					</tbody>
					</c:if>
				</table>