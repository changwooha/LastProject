<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
	<table id="clickedProductInfoOut">
		<tbody>
			<c:if test = "${clickedProduct ne null }">
			<tr>
				<td >제품 코드</td>
				<td >${clickedProduct.prdCode}</td>
			</tr>
			<tr>
				<td >제품 이름</td>
				<td >${clickedProduct.prdName}</td>
			</tr>
			<tr>
				<td >제품 가격</td>
				<td >${clickedProduct.prdPrice}</td>
			</tr>
			<tr>
				<td >제품 총 수량</td>
				<td >${clickedProduct.prdQuantity}</td>
			</tr>
			<tr>
				<td >제품 카테고리</td>
				<td >${clickedProduct.prdCategory}</td>
			</tr>
			<tr>
				<td >제품 색상</td>
				<td >${clickedProduct.prdColor}</td>
			</tr>
			<tr>
				<td >제품 사이즈</td>
				<td >${clickedProduct.prdSize}</td>
			</tr>
			<tr>
				<td >제품 안전재고</td>
				<td >${clickedProduct.prdSafeStock}</td>
			</tr>
			<tr>
				<td >제품 설치시간</td>
				<td >${clickedProduct.prdInstallTime}</td>
			</tr>
			</c:if>
		</tbody>
	</table>