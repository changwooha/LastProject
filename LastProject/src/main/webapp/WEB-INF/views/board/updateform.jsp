<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://code.angularjs.org/latest/angular.min.js"></script>

<!-- Angular -->
<script type="text/javascript">
	angular.module("myApp", []).controller("myCtrl", function($scope) {
		$scope.cancle = function(data){
			location.href="detail.action?boardNo="+data;
		}
		$scope.update = function(){}
/* 		$scope.deleted = function(data){
			location.href="delete.action?boardNo="+data;
		} */
	}); 
</script>
<!-- Jquery -->
<script type="text/javascript">
</script>
<body ng-app="myApp" ng-controller="myCtrl">

	<jsp:include page="/WEB-INF/views/include/header.jsp" flush="true" />
	<form:form action="update.action" modelAttribute="board"
		ng-submit="submit()" class="form-horizontal"
		method="post">
		<form:hidden path="boardNo" />
		<div class="container">
			<div class="form-group form-group-lg">
				<label class="col-sm-2 control-label" for="formGroupInputLarge">제
					목</label>
				<div class="col-sm-10">
					<form:input path="boardTitle" class="form-control"
						aria-describedby="sizing-addon1" />
				</div>
			</div>
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall">작성자</label>
				<div class="col-sm-10">
					<form:input path="boardWriter" class="form-control"
						value="${loginmember.mbrId }" />
				</div>
			</div>
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall">내
					용</label>
				<div class="col-sm-10">
					<form:textarea path="boardContent" style="height:50em;resize:none"
						class="form-control" rows="50" cols="50" />
				</div>
			</div>
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall"></label>
				<div class="col-sm-10">
					<button class="btn btn-primary" type="submit">수 정</button>
					<button class="btn btn-danger" ng-click="cancle(${board.boardNo})" type="button">취 소 by
						Angular</button>
				</div>
			</div>
		</div>
	</form:form>
</body>
</html>
