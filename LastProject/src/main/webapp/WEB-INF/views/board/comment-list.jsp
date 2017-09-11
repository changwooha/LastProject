<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:forEach items="${comment}" var="comment">
	<div class="form-group form-group-sm form-horizontal">
		<input type="hidden" value="${board.boardNo}" /> <br> <label
			class="col-sm-2 control-label" for="formGroupInputSmall" style="">${comment.writer}</label>
		<div class="col-sm-10" id="commentDiv">
			<input style="height: 3em; resize: none; font-size: 15pt"
				class="form-control" value="${comment.content }" readonly="readonly" />
			<c:if test="${comment.writer eq loginmember.mbrId}">
				<a class="btn btn-primary" id="updateComment" href="#"
					style="margin-top: 5pt; margin-bottom: 3pt">수 정</a>
				<a class="btn btn-danger" id="deleteComment" href="#"
					data-commentNo='${ comment.commentNo }'
					data-boardNo='${ comment.boardNo }'
					style="margin-top: 5pt; margin-bottom: 3pt">삭 제</a>
			</c:if>
		</div>
	</div>
	<br>
	<br>
</c:forEach>

<script type="text/javascript">
	$(function() {
		$('a[id^=deleteComment]').click(function(event) {
			event.preventDefault();
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

		})
	})
</script>