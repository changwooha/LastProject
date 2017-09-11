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

<!-- 제이쿼리 -->
<script type="text/javascript">
	$(function(event) {
		$('#cancle').click(function(event) {
			location.href = "list.action"
		})
	/* 댓글 등록 절차 */	
		$('#commentwrite').click(function(event) {
			event.preventDefault();
			var boardNo = $('#commentBoardNo').val();
			var commentContent = $('#commentContent').val();
			var commentWriter = $('#commentBoardWriter').val();
			$.ajax({
				url : "writecomment.action",
				data :{
					"boardNo":$('#commentBoardNo').val(),
					"content":$('#commentContent').val(),
					"writer":$('#commentBoardWriter').val()
					},
				method : "POST",
				success : function(data, status, xhr) {
					// 여기서 댓글창만 갱신시키는 작업을 한다.
					$('#commentContent').val("")
					$('#commentlist').load("commentlist.action",{
						"boardNo":$('#commentBoardNo').val(),
						});					
				},
				error : function(xhr, status, err) {
					alert("실패하면 여기서 후처리를 하지.");
				}
			})
		});

	})
</script>

<body>

	<jsp:include page="/WEB-INF/views/include/header.jsp" flush="true" />
	<div class="container">
		<form:form action="boardregister.action" modelAttribute="board"
			ng-submit="submit()" class="form-horizontal" id="writeform"
			method="post">
			<form:hidden path="boardNo" />


			<!-- Board 내용 영역 -->
			<div class="form-group form-group-lg">
				<label class="col-sm-2 control-label" for="formGroupInputLarge">제
					목</label>
				<div class="col-sm-10">
					<form:input path="boardTitle" class="form-control"
						aria-describedby="sizing-addon1" readonly="true" />
				</div>
			</div>
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall">작성자</label>
				<div class="col-sm-10">
					<form:input path="boardWriter" class="form-control"
						value="${board.boardWriter}" readonly="true" />
				</div>
			</div>
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall">내
					용</label>
				<div class="col-sm-10">
					<form:textarea path="boardContent" style="height:50em;resize:none"
						class="form-control" rows="50" cols="50" readonly="true" />
				</div>
			</div>
			<!-- Board 내용 영역 끝 -->

			<!-- Board Event 영역 -->
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall"></label>
				<div class="col-sm-10">
					<c:if test="${loginmember.mbrId eq board.boardWriter }">
						<a class="btn btn-primary"
							href="update.action?boardNo=${board.boardNo }">수 정</a>
					</c:if>
					<a class="btn btn-info" href="list.action">목록보기</a>
				</div>
			</div>
			<!-- Board Event 영역 끝 -->
		</form:form>

		<!-- Comment 영역 -->
	<c:if test="${loginmember ne null }">
		<form action="writecomment.action" method="post"
			class="form-horizontal">
			<div class="form-group form-group-sm">
				<input type="hidden" id="commentBoardNo" value="${board.boardNo}" />
				<input type="hidden" id="commentBoardWriter"
					value="${loginmember.mbrId}" />
				<hr>
				<label class="col-sm-2 control-label" for="formGroupInputSmall"
					style=""></label>
				<div class="col-sm-10" id="commentDiv">
					<textarea style="height: 5em; resize: none" id="commentContent"
						class="form-control" rows="50" cols="50"></textarea>
				</div>
				<label class="col-sm-2 control-label" for="formGroupInputSmall"></label>
				<div class="col-sm-10">
					<a class="btn btn-success" id="commentwrite" href="#"
						style="margin-top: 5pt">댓 글</a>
				</div>
			</div>
		</form>
	</c:if>
		<!-- 댓글 조회하는 영역 -->
		<div id="commentlist">
		<c:forEach items="${comment}" var="comment">
			<div class="form-group form-group-sm form-horizontal">
				<br>
				<label class="col-sm-2 control-label" for="formGroupInputSmall"
					style="">${comment.writer}</label>
				<div class="col-sm-10" id="commentDiv">
					<input style="height: 3em; resize: none;font-size:15pt" class="form-control"
						value="${comment.content}" readonly="readonly" />
				</div>
			</div>
			<br>
			<br>
		</c:forEach>
		</div>
		<br>
		<br>
		<!-- Comment 영역 끝  -->

	</div>
</body>
</html>

