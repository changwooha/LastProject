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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>

<!-- Jquery -->
<script type="text/javascript">
	$(function(event) {
		var toggle = $('#heart').attr('data-toggle');

		$('#cancle').click(function(event) {
			location.href = "list.action"
		})
		/* 댓글 등록 절차 */
		$('#commentwrite').click(function(event) {
			event.preventDefault();
			//댓글이 4글자 미만이면
			if ($('#commentContent').val().length < 4) {
				alert('댓글은 4글자 이상 적어야합니다.')
				return false;
			}
			var boardNo = $('#commentBoardNo').val();
			var commentContent = $('#commentContent').val();
			var commentWriter = $('#commentBoardWriter').val();
			var boardWriter = $('#writer').val();
			$.ajax({
				url : "/controller/writecomment",
				data : {
					"boardNo" : $('#commentBoardNo').val(),
					"content" : $('#commentContent').val(),
					"writer" : $('#commentBoardWriter').val(),
					"boardWriter" : boardWriter
				},
				method : "POST",
				success : function(data, status, xhr) {
					// 여기서 댓글창만 갱신시키는 작업을 한다.
					$('#commentContent').val("")
					$('#commentlist').load("/controller/commentlist", {
						"boardNo" : $('#commentBoardNo').val(),
					});
				},
				error : function(xhr, status, err) {

				}
			})
		});

		/* 댓글 존재시 글 삭제 불가 경고창 */
		$('#delete').click(function(event) {
			var boardNo = $('#delete').attr('data-boardNo')
			console.log(boardNo);
			var result = confirm("정말 삭제하시겠습니까?")
			if (result) {
				$.ajax({
					url : "/controller/delete",
					data : {
						"boardNo" : boardNo
					},
					method : "POST",
					success : function(data, status, xhr) {
						location.href = "/controller/list"

					},
					error : function(xhr, status, err) {
						alert("댓글이 있는 글은 삭제가 불가능 합니다.")
					}
				})
			} else {
				return false;
			}

			event.preventDefault();
		})

		/*댓글 삭제*/
		$('#deleteComment').click(function(event) {
			var commentNo = $('#deleteComment').attr('data-commentNo')
			var boardNo = $('#deleteComment').attr('data-boardNo')
			var boardWriter = $('#writer').val()
			$.ajax({
				url : "/controller/deletecomment",
				data : {
					"commentNo" : commentNo,
					"boardNo" : boardNo,
					"boardWriter" : boardWriter
				},
				method : "GET",
				success : function(data, stats, xhr) {
					// 여기서 댓글창만 갱신시키는 작업을 한다.
					$('#commentContent').val("")
					$('#commentlist').load("/controller/commentlist", {
						"boardNo" : $('#commentBoardNo').val(),
					});
				},
				error : function(xhr, stats, err) {

				}
			})
			event.preventDefault();
		})

		/*좋아요 등록*/
		$('#heart')
				.click(
						function(event) {
							event.preventDefault();

							if (toggle) {
								$
										.ajax({
											url : "/controller/like",
											data : {
												"boardNo" : $('#heart').attr(
														'data-boardNo'),
												"boardWriter" : $('#heart')
														.attr(
																'data-boardWriter'),
												"mbrId" : $('#heart')
														.attr('data-mbrId')
											},
											method : "POST",
											success : function(data, status,
													xhr) {
												$('#heart')
														.load(
																"/controller/likelist",
																{
																	"boardNo" : $(
																			'#heart')
																			.attr(
																					'data-boardNo'),
																	"boardWriter" : $(
																			'#heart')
																			.attr(
																					'data-boardWriter'),
																	"mbrId" : $(
																			'#heart')
																			.attr(
																					'data-mbrId')
																},
																function(
																		responseTxt,
																		statusTxt,
																		xhr) {
																	if (statusTxt = "success") {
																		$(
																				'#heart')
																				.attr(
																						'class',
																						'glyphicon glyphicon-heart')

																	} else {
																		$(
																				'#heart')
																				.attr(
																						'class',
																						'glyphicon glyphicon-heart-empty')
																	}

																})

											},
											error : function(xhr, status, err) {
												alert("실패")
											}
										})
							} else {
								$
										.ajax({
											url : "/controller/likedelete",
											data : {
												"boardNo" : $('#heart').attr(
														'data-boardNo'),
												"boardWriter" : $('#heart')
														.attr(
																'data-boardWriter'),
												"mbrId" : $('#heart')
														.attr('data-mbrId')
											},
											method : "POST",
											success : function(data, status,
													xhr) {
												$('#heart')
														.attr('class',
																'glyphicon glyphicon-heart-empty')

											},
											error : function(xhr, status, err) {
												alert("삭제 ㅅ길패")
											}
										})

							}
							toggle = !toggle;

						})
		/*좋아요 삭제*/
		$('#deleteheart').click(
				function(event) {
					event.preventDefault();

					$.ajax({
						url : "/controller/likedelete",
						data : {
							"boardNo" : $('#deleteheart').attr('data-boardNo'),
							"boardWriter" : $('#deleteheart').attr(
									'data-boardWriter'),
							"mbrId" : $('#deleteheart').attr(
									'data-mbrId')
						},
						method : "POST",
						success : function(data, status, xhr) {
							$('#deleteheart').attr('class',
									'glyphicon glyphicon-heart-empty')

						},
						error : function(xhr, status, err) {
							alert("삭제 실패")
						}
					})
				})

		/*첨부파일 다운로드*/

		$('#downloadAttach').click(
				function(event) {
					event.preventDefault();
					location.href = "downloadAttach.action?boardNo="
							+ $('#downloadAttach').attr('data-boardNo')

				});

		/*새로운 글 등록 확인*/
		$('#message').click(
				function(event) {
					$('#divMessage').remove();
					event.preventDefault();
					$.ajax({
						url : '/controller/newbell',
						method : 'GET',
						success : function(data, status, xhr) {
							if (data == "error" || data.length == 0) {
								return;
							}

							//외부박스
							var outerBox = $('<div></div>');
							outerBox.attr('id', 'divMessage');
							outerBox.css({
								"border" : 'solid 1px black',
								"background-color" : "white",
								"width" : 230,
								"position" : "absolute"
							});
							$('body').append(outerBox);
							//내부 박스 만들기
							$.each(data, function(index, id) {
								$('<div></div>').css({
									"padding-left" : 5,
									"padding-top" : 2,
									"padding-bottom" : 2,
									"width" : "97%"
								}).text(id + " <New Board>").on(
										'mousedown',
										function(event) {
											$('#message').val($(this).text());
											$('#divMessage').css('display',
													'none');
										}).on(
										'mouseover',
										function(event) {
											$(this).css('background-color',
													'lightgray');
										}).on('mouseout', function(event) {
									$(this).css('background-color', 'white');
								}).appendTo(outerBox);
							});
						},
						error : function(xhr, status, err) {
							alert("실패")
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
					<form:input path="boardWriter" id="writer" class="form-control"
						value="${board.boardWriter}" readonly="true" />
				</div>
			</div>
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall">첨부파일</label>
				<div class="col-sm-10">
					<c:forEach var="attach" items="${attach}">
						<label class="control-label"><a href="#"
							id="downloadAttach" data-boardNo="${attach.boardNo }">
								${attach.userFileName}</a></label>
					</c:forEach>
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
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall">첨부파일</label>
				<div class="col-sm-10">
					<div class="dragAndDrop"></div>
				</div>
			</div>
			<!-- Board 내용 영역 끝 -->

			<!-- Board Event 영역 -->
			<div class="form-group form-group-sm">
				<label class="col-sm-2 control-label" for="formGroupInputSmall"></label>
				<div class="col-sm-10">
					<c:if test="${loginmember.mbrId ne board.boardWriter}">
						<c:if test="${loginmember ne null }">
							<c:choose>
								<c:when test="${likes eq null }">
									<span class="glyphicon glyphicon-heart-empty"
										style="color: red" data-mbrId="${loginmember.mbrId}"
										data-boardWriter="${board.boardWriter}"
										data-boardNo="${board.boardNo}" data-toggle="true" id="heart"
										aria-hidden="true"></span>&nbsp;
							</c:when>
								<c:otherwise>
									<span class="glyphicon glyphicon-heart" style="color: red"
										data-mbrId="${loginmember.mbrId}"
										data-boardWriter="${board.boardWriter}"
										data-boardNo="${board.boardNo}" id="deleteheart"
										aria-hidden="true"></span>&nbsp;
							</c:otherwise>
							</c:choose>
						</c:if>
					</c:if>
					<c:if test="${loginmember.mbrId eq board.boardWriter }">
						<a class="btn btn-primary"
							href="update.action?boardNo=${board.boardNo }">수 정</a>
						<a class="btn btn-danger" id="delete" href="#"
							data-boardNo=${board.boardNo }>삭제</a>
					</c:if>
					<a class="btn btn-info" href="/controller/list">목록보기</a>
				</div>
			</div>
			<!-- Board Event 영역 끝 -->
		</form:form>

		<!-- Comment 영역 -->
		<c:if test="${loginmember ne null }">
			<form action="writecomment.action" method="post"
				class="form-horizontal">
				<div class="form-group form-group-sm">
					<input type="hidden" id="commentBoardNo" value="${board.boardNo }" />
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
				<input type="hidden" id="commentNo" value="${comment.commentNo }">
				<div class="form-group form-group-sm form-horizontal">
					<br> <label class="col-sm-2 control-label"
						for="formGroupInputSmall" style="">${comment.writer}</label>
					<div class="col-sm-10" id="commentDiv">
						<input style="height: 3em; resize: none; font-size: 15pt"
							class="form-control" value="${comment.content}"
							readonly="readonly" />
						<c:if test="${comment.writer eq loginmember.mbrId}">
							<a class="btn btn-primary" id="updateComment" href="#"
								style="margin-top: 5pt; margin-bottom: 3pt">수 정</a>
							<a class="btn btn-danger" id="deleteComment" href="#"
								data-commentNo='${comment.commentNo }'
								data-boardNo='${ board.boardNo }'
								style="margin-top: 5pt; margin-bottom: 3pt">삭 제</a>
						</c:if>
					</div>

				</div>
				<br>
				<br>
			</c:forEach>
		</div>
		<br> <br>
		<!-- Comment 영역 끝  -->

	</div>
</body>
</html>

