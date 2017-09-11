<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<head>
<meta name="google-site-verification"
	content="jmcSA7d-dnNJUWyZJBghach5uXuiSGdvmGkD0cNDRDA" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.2.1.js"></script>
<script src="https://code.angularjs.org/latest/angular.min.js"></script>
</head>
<script src="https://apis.google.com/js/platform.js" async defer></script>
<script src="${pageContext.request.contextPath }/resources/js/bootstrap.min.js"></script>
<meta name="google-signin-client_id"
	content="93374727909-aob5oi922l48hrnkv9pl01tv0jp5rk6h.apps.googleusercontent.com">

<script type="text/javascript">
	$(function(event) {
		countMessage()
		//MessageBox Count
		function countMessage() {
			$.ajax({
				url : "/controller/countbell",
				success : function(data, status, xhr) {
					$('#count').text(data)
					setTimeout(function() {
						countMessage();
					}, 2000);
				},
				error : function(xhr, status, err) {

				}
			})
		}

		//화면의 어느 부분이라도 클릭하면 호출되는 메서드 설정
		$(document).on('click', function(event) {
			$('#divMessage').remove();
		});

		function getTop() {
			var top = document.getElementById("message");
			var topPos = 2 + top.offsetHeight;
			while (top.tagName.toLowerCase() != "body"
					&& top.tagName.toLowerCase() != "html") {
				topPos = topPos + top.offsetTop;//offsetTop : 상위 요소와의 거리
				top = top.offsetParent; //상위 요소를 현재 요소에 대입
			}
			return topPos;
		}
		function getLeft() {
			var left = document.getElementById("message");

			var leftPos = 0;
			while (left.tagName.toLowerCase() != "body"
					&& left.tagName.toLowerCase() != "html") {
				leftPos += left.offsetLeft;//left와 left의 부모 요소 사이의 거리
				left = left.offsetParent;//left의 부모 요소
			}
			return leftPos;

		}

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
								"width" : "auto",
								"height" : 300,
								"overflow" : "scroll",
								"position" : "absolute",
								"left" : getLeft(),
								"top" : getTop(),
								"overflow-x" : "hidden"
							});
							$('body').append(outerBox);
							//내부 박스 만들기
							$.each(data, function(index, id) {
								let outBox = $('<div></div>')
								$('<a href=""></a>').css({
									"padding-left" : 5,
									"padding-top" : 2,
									"padding-bottom" : 2,
									"width" : "97%"
								}).attr('id', 'goBoard').text(
										id + "<NEWS!!!!>").on(
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
								}).append(outBox).appendTo(outerBox);
							});
						},
						error : function(xhr, status, err) {
							alert("실패")
						}
					})
				});
	})
</script>

<script>
	function signOut() {
		var auth2 = gapi.auth2.getAuthInstance();
		auth2.signOut().then(function() {
			console.log('User signed out.');
		});
	}
</script>
<div class="jumbotron">
	<h2>Small Project</h2>
	<ul class="nav nav-pills">
		<li role="presentation"><a href="/controller/home">메인</a></li>
		<li role="presentation"><a href="/controller/list">게시판</a></li>
		<c:if test="${loginmember eq null }">
			<li role="presentation"><a href="/controller/login">로그인</a></li>
			<li role="presentation"><a href="/controller/signup">회원가입</a></li>
		</c:if>
		<li role="presentation"><a href="ordermain.action">효현박</a></li>
		<li role="presentation"><a href="itemList.action">정목각</a></li>
		<li role="presentation"><a href="warehouse/warehouse-status.action">창우하</a></li>
		<c:if test="${loginmember ne null }">
			<li role="presentation"><a href="/controller/logout"
				onClick="googleOut()">로그아웃</a></li>
			<script>
				function googleOut() {
					var auth2 = gapi.auth2.getAuthInstance();
					auth2.signOut().then(function() {
						location.href = "logout";
					});
				}

				function onLoad() {
					gapi.load('auth2', function() {
						gapi.auth2.init();
					});
				}
				
			</script>
			<script src="https://apis.google.com/js/platform.js?onload=onLoad"
				async defer></script>
			<li role="presentation">
			<a href="newbell" id="message"
				style="color: forestgreen; font-size: 1.5em"
				class="glyphicon glyphicon-leaf"></a>
				</li>
			<li role="presentation"><span class="badge" id="count">0</span>
			</li>
		</c:if>
	</ul>
</div>

<!-- BEGIN # BOOTSNIP INFO -->

<script>
/* #####################################################################
#
#   Project       : Modal Login with jQuery Effects
#   Author        : Rodrigo Amarante (rodrigockamarante)
#   Version       : 1.0
#   Created       : 07/29/2015
#   Last Change   : 08/04/2015
#
##################################################################### */

/* $(function() {
 
 var $formLogin = $('#login-form');
 var $formLost = $('#lost-form');
 var $formRegister = $('#register-form');
 var $divForms = $('#div-forms');
 var $modalAnimateTime = 300;
 var $msgAnimateTime = 150;
 var $msgShowTime = 2000;

 $("form").submit(function () {
     switch(this.id) {
         case "login-form":
             var $lg_username=$('#login_username').val();
             var $lg_password=$('#login_password').val();
             if ($lg_username == "ERROR") {
                 msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "error", "glyphicon-remove", "Login error");
             } else {
                 msgChange($('#div-login-msg'), $('#icon-login-msg'), $('#text-login-msg'), "success", "glyphicon-ok", "Login OK");
             }
             return false;
             break;
         case "lost-form":
             var $ls_email=$('#lost_email').val();
             if ($ls_email == "ERROR") {
                 msgChange($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "error", "glyphicon-remove", "Send error");
             } else {
                 msgChange($('#div-lost-msg'), $('#icon-lost-msg'), $('#text-lost-msg'), "success", "glyphicon-ok", "Send OK");
             }
             return false;
             break;
         case "register-form":
             var $rg_username=$('#register_username').val();
             var $rg_email=$('#register_email').val();
             var $rg_password=$('#register_password').val();
             if ($rg_username == "ERROR") {
                 msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "error", "glyphicon-remove", "Register error");
             } else {
                 msgChange($('#div-register-msg'), $('#icon-register-msg'), $('#text-register-msg'), "success", "glyphicon-ok", "Register OK");
             }
             return false;
             break;
         default:
             return false;
     }
     return false;
 });
 
 $('#login_register_btn').click( function () { modalAnimate($formLogin, $formRegister) });
 $('#register_login_btn').click( function () { modalAnimate($formRegister, $formLogin); });
 $('#login_lost_btn').click( function () { modalAnimate($formLogin, $formLost); });
 $('#lost_login_btn').click( function () { modalAnimate($formLost, $formLogin); });
 $('#lost_register_btn').click( function () { modalAnimate($formLost, $formRegister); });
 $('#register_lost_btn').click( function () { modalAnimate($formRegister, $formLost); });
 
 function modalAnimate ($oldForm, $newForm) {
     var $oldH = $oldForm.height();
     var $newH = $newForm.height();
     $divForms.css("height",$oldH);
     $oldForm.fadeToggle($modalAnimateTime, function(){
         $divForms.animate({height: $newH}, $modalAnimateTime, function(){
             $newForm.fadeToggle($modalAnimateTime);
         });
     });
 }
 
 function msgFade ($msgId, $msgText) {
     $msgId.fadeOut($msgAnimateTime, function() {
         $(this).text($msgText).fadeIn($msgAnimateTime);
     });
 }
 
 function msgChange($divTag, $iconTag, $textTag, $divClass, $iconClass, $msgText) {
     var $msgOld = $divTag.text();
     msgFade($textTag, $msgText);
     $divTag.addClass($divClass);
     $iconTag.removeClass("glyphicon-chevron-right");
     $iconTag.addClass($iconClass + " " + $divClass);
     setTimeout(function() {
         msgFade($textTag, $msgOld);
         $divTag.removeClass($divClass);
         $iconTag.addClass("glyphicon-chevron-right");
         $iconTag.removeClass($iconClass + " " + $divClass);
		}, $msgShowTime);
 }
}); */
</script>



<!-- BEGIN # BOOTSNIP INFO -->
<!-- <div class="container">
	<div class="row">
		<h1 class="text-center">Modal Login with jQuery Effects</h1>
        <p class="text-center"><a href="#" class="btn btn-primary btn-lg" role="button" data-toggle="modal" data-target="#login-modal">Open Login Modal</a></p>
	</div>
</div> -->
<!-- END # BOOTSNIP INFO -->

<!-- BEGIN # MODAL LOGIN -->
<!-- <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    	<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header" align="center">
					<img class="img-circle" id="img_logo" src="http://bootsnipp.com/img/logo.jpg">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span class="glyphicon glyphicon-remove" aria-hidden="true"></span>
					</button>
				</div> -->
                
                <!-- Begin # DIV Form -->
                <!-- <div id="div-forms"> -->
                
                    <!-- Begin # Login Form -->
                    <%-- <form id="login-form">
		                <div class="modal-body">
				    		<div id="div-login-msg">
                                <div id="icon-login-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-login-msg">Type your username and password.</span>
                            </div>
				    		<input id="login_username" class="form-control" type="text" placeholder="Username (type ERROR for error effect)" required>
				    		<input id="login_password" class="form-control" type="password" placeholder="Password" required>
                            <div class="checkbox">
                                <label>
                                    <input type="checkbox"> Remember me
                                </label>
                            </div>
        		    	</div>
				        <div class="modal-footer">
                            <div>
                                <button type="submit" class="btn btn-primary btn-lg btn-block">Login</button>
                            </div>
				    	    <div>
                                <button id="login_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                                <button id="login_register_btn" type="button" class="btn btn-link">Register</button>
                            </div>
				        </div>
                    </form> --%>
                    <!-- End # Login Form -->
                    
                    <!-- Begin | Lost Password Form -->
                    <%-- <form id="lost-form" style="display:none;">
    	    		    <div class="modal-body">
		    				<div id="div-lost-msg">
                                <div id="icon-lost-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-lost-msg">Type your e-mail.</span>
                            </div>
		    				<input id="lost_email" class="form-control" type="text" placeholder="E-Mail (type ERROR for error effect)" required>
            			</div>
		    		    <div class="modal-footer">
                            <div>
                                <button type="submit" class="btn btn-primary btn-lg btn-block">Send</button>
                            </div>
                            <div>
                                <button id="lost_login_btn" type="button" class="btn btn-link">Log In</button>
                                <button id="lost_register_btn" type="button" class="btn btn-link">Register</button>
                            </div>
		    		    </div>
                    </form> --%>
                    <!-- End | Lost Password Form -->
                    
                    <!-- Begin | Register Form -->
                    <%-- <form id="register-form" style="display:none;">
            		    <div class="modal-body">
		    				<div id="div-register-msg">
                                <div id="icon-register-msg" class="glyphicon glyphicon-chevron-right"></div>
                                <span id="text-register-msg">Register an account.</span>
                            </div>
                            <input type="radio" id="mbrUserType" value="0"/>일반회원
                            <input type="radio" id="mbrUserType" value="1"/>직원
                            <input type="radio" id="mbrUserType" value="2"/>관리자
                            <input id="mbrId" class="form-control" type="text" placeholder="아이디" required>
                            <input id="mbrPasswd" class="form-control" type="password" placeholder="비번" required>
                            <input id="mbrName" class="form-control" type="text" placeholder="이름" required>
		    				<input id="mbrPhone" class="form-control" type="tel" placeholder="핸폰" required>
                            <input id="mbrAddress" class="form-control" type="text" placeholder="주소" required>
                            <input id="mbrEmail" class="form-control" type="email" placeholder="이멜" required>
            			</div>
		    		    <div class="modal-footer">
                            <div>
                                <button type="submit" class="btn btn-primary btn-lg btn-block">Register</button>
                            </div>
                            <div>
                                <button id="register_login_btn" type="button" class="btn btn-link">Log In</button>
                                <button id="register_lost_btn" type="button" class="btn btn-link">Lost Password?</button>
                            </div>
		    		    </div>
                    </form> --%>
                    <!-- End | Register Form -->
                    
               <!--  </div> -->
                <!-- End # DIV Form -->
                
			<!-- </div>
		</div>
	</div> -->
    <!-- END # MODAL LOGIN -->