<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<%-- <meta charset="UTF-8">
<title>회원가입 창</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script type="text/javascript">

</script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" flush="true" />
	<h2>회원가입</h2> --%>

	<!-- member or artist -->


	<!-- 부트스트랩 폼 테스트 -->
	
	<!-- <!DOCTYPE html>
<html lang="en">
  <head> -->
    <meta charset="utf-8">
    <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1"> -->
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>signup</title>

    <!-- Bootstrap -->
    <link href="${pageContext.request.contextPath }/resources/css/bootstrap.min.css" rel="stylesheet">
    <!-- font awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/font-awesome.min.css" media="screen" title="no title" charset="utf-8">
    <!-- Custom style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css" media="screen" title="no title" charset="utf-8">

    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>

	<jsp:include page="/WEB-INF/views/include/header.jsp" flush="true" />

        <div class="col-md-12">
        <div class="page-header">
    	    <h1>회원가입 <small>horizontal form</small></h1>
        </div>
        <form:form class="form-horizontal" action="signup" modelAttribute="member" method="post">
        <div class="form-group">
          <label class="col-sm-3 control-label" for="mbrUserType">사용자구분</label>
        <div class="col-sm-6">
        	<form:radiobutton path="mbrUserType" value="0" />일반회원
			<form:radiobutton path="mbrUserType" value="1" />직원
			<form:radiobutton path="mbrUserType" value="2" />관리자
        </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label" for="mbrId">아이디</label>
        <div class="col-sm-6">
        	<form:input class="form-control" path="mbrId" type="text" placeholder="아이디"/>
       		<p>
			<form:errors path="mbrId" cssClass="error" />
			</p>
        </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label" for="mbrPasswd">비밀번호</label>
        <div class="col-sm-6">
        	<form:password class="form-control" path="mbrPasswd" placeholder="비밀번호"/>
        	<p>
			<form:errors path="mbrPasswd" cssClass="error" />
			</p>
        <p class="help-block">숫자, 특수문자 포함 8자 이상</p>
        </div>
        </div>
        <div class="form-group">
          <label class="col-sm-3 control-label" for="mbrEmail">이메일</label>
        <div class="col-sm-6">
        	<form:input class="form-control" path="mbrEmail" type="email" placeholder="이메일"/>
        	<p>
			<form:errors path="mbrEmail" cssClass="error" />
			</p>
        </div>
        </div>
          <!-- <div class="form-group">
              <label class="col-sm-3 control-label" for="inputPasswordCheck">비밀번호 확인</label>
             <div class="col-sm-6">
              <input class="form-control" id="inputPasswordCheck" type="password" placeholder="비밀번호 확인">
                <p class="help-block">비밀번호를 한번 더 입력해주세요.</p>
             </div>
          </div> -->
        <div class="form-group">
            <label class="col-sm-3 control-label" for="mbrName">이름</label>
          <div class="col-sm-6">
            <form:input class="form-control" path="mbrName" placeholder="이름"/>
          	<p>
			<form:errors path="mbrName" cssClass="error" />
			</p>
          </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label" for="mbrPhone">휴대폰번호</label>
              <div class="col-sm-6">
                <div class="input-group">
                  <form:input class="form-control" path="mbrPhone" placeholder="- 없이 입력해 주세요" />
                  <p>
					<form:errors path="mbrPhone" cssClass="error" />
					</p>                  
                  <!-- <span class="input-group-btn">
                    <button class="btn btn-success">인증번호 전송<i class="fa fa-mail-forward spaceLeft"></i></button>
                  </span> -->
                </div>
              </div>
        </div>
        <div class="form-group">
            <label class="col-sm-3 control-label" for="mbrAddress">주소</label>
          <div class="col-sm-6">
            <form:input class="form-control" path="mbrAddress" placeholder="집이 어디니"/>
          	<p>
			<form:errors path="mbrAddress" cssClass="error" />
			</p>
          </div>
        </div>
        <%-- <div class="form-group">
            <label class="col-sm-3 control-label" for="inputNumberCheck">인증번호 확인</label>
          <div class="col-sm-6">
            <div class="input-group">
              <form:input class="form-control" path="inputNumberCheck" type="text" placeholder="인증번호"/>
              <span class="input-group-btn">
                <button class="btn btn-success" type="button">인증번호 확인<i class="fa fa-edit spaceLeft"></i></button>
              </span>
            </div>
            <p class="help-block">전송된 인증번호를 입력해주세요.</p>
          </div>
        </div> --%>
          <%-- <div class="form-group">
              <label class="col-sm-3 control-label" for="inputAgree">약관 동의</label>
            <div class="col-sm-6" data-toggle="buttons">
              <label class="btn btn-warning active">
                <form:input path="agree" type="checkbox" autocomplete="off" chacked/>
                  <span class="fa fa-check"></span>
              </label>
              <a href="#">이용약관</a> 에 동의 합니다.
            </div>
          </div> --%>
        <div class="form-group">
          <div class="col-sm-12 text-center">
            <button class="btn btn-primary" type="submit">회원가입<i class="fa fa-check spaceLeft"></i></button>
            <button class="btn btn-danger" type="submit">가입취소<i class="fa fa-times spaceLeft"></i></button>
          </div>
        </div>
        </form:form>
          <hr>
        </div>
      </article>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
  </body>
</html>
