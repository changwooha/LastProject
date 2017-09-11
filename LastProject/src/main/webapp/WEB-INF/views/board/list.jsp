<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" flush="true" />
	<div class="container" style="width: 70%">
		<div class="panel panel-default">
			<!-- Default panel contents -->
			<div class="panel-body">
				<h3>Board</h3>
				<c:if test="${loginmember ne null }">
					<div>
						<button id="writebtn" class="btn btn-danger">Write</button>
						<!-- <button class="btn btn-danger" ng-click="write()">Write By Angular</button> -->
					</div>
				</c:if>
			</div>

			<!-- Table -->
			<table class="table table-hover">
				<tr>
					<th>N o</th>
					<th>제 목</th>
					<th>작성자</th>
					<th>날 짜</th>
					<th>조회수</th>
				</tr>
				<tr>
					<c:forEach var="board" items="${board}">
						<tr>
							<td>${board.boardNo }</td>
							<td><a
								href="detail/${board.boardNo}&${board.boardWriter}">${board.boardTitle }</a></td>
							<td>${board.boardWriter }</td>
							<td><fmt:formatDate value="${board.boardDate }" pattern="yyyy년MM월dd일 HH시mm분" /></td>
							<td>${board.boardReadCount }</td>
						</tr>
					</c:forEach>
				</tr>
			</table>
		
		</div>
		<div>
			<form id="searchform"action="searchboard.action" method="POST">
				<input id="searchkey" name="key" class="">
				<button id="searchbtn" class="btn btn-primary">검색</button>
				<div class="alert alert-danger" id="search-alert" 
				style="display:none" role="alert">검색어는 최소 2글자 이상입니다.</div>				
			</form>
			
		</div>					
	</div>
</body>

<!-- Jquery -->
<script type="text/javascript">
	$(function(event){

		$('#writebtn').click(function(event){
			location.href="write"
		})
		$('#searchbtn').click(function(event){

 			if($('#searchkey').val().length < 2){
 				$('#searchform').find('div').css({"display":"block","margin-top":"5pt"}) 	
 				return false;
 			}
			$('#searchform').submit();
		})

	});
</script>
</html>
