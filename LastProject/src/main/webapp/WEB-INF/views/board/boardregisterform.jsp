<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta name="google-site-verification"
	content="jmcSA7d-dnNJUWyZJBghach5uXuiSGdvmGkD0cNDRDA" />
</head>
<title>Write Board</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<body>

	<jsp:include page="/WEB-INF/views/include/header.jsp" flush="true" />

	<form:form action="write" modelAttribute="board" ng-submit="submit()"
		class="form-horizontal" id="writeform" method="post"
		enctype="multipart/form-data">
		<form:hidden path="boardNo" />
		<div class="container">
			<div class="form-group form-group-lg">
				<label class="col-sm-2 control-label" for="formGroupInputLarge">제
					목</label>
				<div class="col-sm-10">
					<form:input id="title" path="boardTitle" class="form-control"
						aria-describedby="sizing-addon1" autofocus="autofocus" />
					<div class="alert alert-danger" id="title-alert"
						style="display: none" role="alert">제목은 최소 5글자 이상입니다.</div>
				</div>
			</div>

			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall">작성자</label>
				<div class="col-sm-10">
					<form:input path="boardWriter" class="form-control"
						value="${loginmember.mbrId }" readonly="true" />
				</div>
			</div>
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall">
					<span class="glyphicon glyphicon-file" style="font-size: 1.5em"></span>
				</label>
				<div class="col-sm-10">
					<input type="file" name="file">
				</div>
			</div>

			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall">내
					용</label>
				<div class="col-sm-10">
					<form:textarea id="content" path="boardContent"
						style="height:50em;resize:none" class="form-control" rows="50"
						cols="50" />
					<div class="alert alert-danger" id="content-alert"
						style="display: none" role="alert">내용은 최소 20글자 이상입니다.</div>
				</div>
			</div>
			<div class="alert alert-danger" id="content-alert"
				style="display: none" role="alert">내용은 최소 20글자 이상입니다.</div>
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall"></label>
				<div class="col-sm-10">
					<c:if test="${loginmember ne null }">
						<button class="btn btn-success" id="write" type="button">등
							록</button>
						<!-- <button class="btn btn-success" type="submit">등 록 By Angular</button> -->
						<button class="btn btn-danger" id="cancle" type="button">취
							소</button>
					</c:if>
				</div>
			</div>
		</div>
	</form:form>

</body>
<!-- Jquery -->
<script type="text/javascript">
	$(function(event) {

		$('#title').on('keyup', function(event) {
			if ($(this).val().length < 2) {
				$('#title-alert').css({
					"display" : "block",
					"margin-top" : "5pt"
				})
				return false;
			}
			if ($(this).val().length > 4) {
				$('#title-alert').css({
					"display" : "none",
					"margin-top" : "5pt"
				})

			}
		})

		$('#content').on('keyup', function(event) {

			if ($('#content').val().length < 20) {
				$('#content-alert').css({
					"display" : "block",
					"margin-top" : "5pt"
				})
				return false;
			}
			if ($('#content').val().length > 20) {
				$('#content-alert').css({
					"display" : "none",
					"margin-top" : "5pt"
				})

			}
		});

		//글쓰기
		$('#write').click(
				function(event) {
					if ($('#content').val().length < 20
							|| $('#title').val().length < 5) {
						return false;
					} else {
						$('#writeform').submit();
					}

				});

		//취소 버튼
		$('#cancle').click(function(event) {
			location.href = "/controller/list"
		})

	});
</script>
</html>
