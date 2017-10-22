<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- Theme Made By www.w3schools.com - No Copyright -->
<title>Bootstrap Theme Simply Me</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat"
	rel="stylesheet">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script type="text/javascript">
	$(document).ready(
		LoginCheck()
	);
	function LoginCheck(){
		$.ajax({
			url : 'loginCheck',
			type : 'POST',
			dataType : 'json',
			success : function(data){
				console.log(data.state);
				if (data.state == 'login') {
					LoginView();
				}else{
					LogOutView();
				}
			},
			error : function(error){
				console.log('LoginCheck err : ' + error);
			}
		});
	}
	
	function LoginFunc(){
		var id = $("#LoginIdTextBox").val();
		var pwd = $("#LoginPwdTextBox").val();
			$.ajax({
				url : 'SignIn',
				data : {
					id : id,
					pwd : pwd
				},
				type : 'POST',
				dataType : 'json',
				success : function(data){
					console.log(data.state);
					if (data.state == 'sign_in_ok') {
						$("#Login_id_error_div").remove();
						$("#Login_pwd_error_div").remove();
						LoginView();
					}else if (data.state == 'id_invalid') {
						str = '존재하지 않는 id 입니다.';
						$("#Login_id_error_div").append(str);
						
					}else if (data.state == 'pwd_invalid'){
						str = '잘못된 비밀번호 입니다.';
						$("#Login_id_error_div").remove();
						$("#Login_pwd_error_div").append(str);
					}else{
						console.log("Sign In error");
					}
				},
				error : function(error){
					console.log("Sign In error : " + error);
				}
				
			});
	}
	function LoginView(){
		$("#First_Container").empty();
		$("#First_Container").load("loginView.jsp");
	}
	function LogOutView(){
		$("#First_Container").empty();
		$("#First_Container").load("logOutView.jsp");
	}
	function SignUpModal() {
		$("#mainModal").modal('show');
	}
	
	function signUpCheck() {
		var id = $("#signUp_id").val();
		var pwd = $("#signUp_pwd").val();
		var pwd2 = $("#signUp_pwd2").val();
		var email = $("#signUp_email").val();
		var pattern = /\s/g; // 공백체크
		
		if ($.trim(id) == "" || $.trim(pwd) == "" || $.trim(pwd2) == ""
				|| $.trim(email) == "" || id == pattern || pwd == pattern
				|| pwd2 == pattern || email == pattern
				|| !email_check($("#signUp_email").val())) {

			if ($.trim($("#signUp_id").val()) == "" || id == pattern) {
				$("#signUpTargetId").addClass("has-error");
				$('#mainModal').modal({
					remote : 'modal.html'
				});
			} else if ($.trim($("#signUp_id").val()) != "" || id != pattern) {
				$("#signUpTargetId").removeClass("has-error");
				$('#mainModal').modal({
					remote : 'modal.html'
				});
			}
			if ($.trim($("#signUp_pwd").val()) == "" || pwd == pattern) {//2
				$("#signUpTargetPwd").addClass("has-error");
				$('#mainModal').modal({
					remote : 'modal.html'
				});
			} else if ($.trim($("#signUp_pwd").val()) != "" || pwd != pattern) {
				$("#signUpTargetPwd").removeClass("has-error");
				$('#mainModal').modal({
					remote : 'modal.html'
				});
			}
			if ($.trim($("#signUp_pwd2").val()) == "" || pwd2 == pattern) {//3
				$("#signUpTargetPwd2").addClass("has-error");
				$('#mainModal').modal({
					remote : 'modal.html'
				});
			} else if ($.trim($("#signUp_pwd2").val()) != "" || pwd2 != pattern) {
				$("#signUpTargetPwd2").removeClass("has-error");
				$('#mainModal').modal({
					remote : 'modal.html'
				});
			}
			if ($.trim($("#signUp_email").val()) == "" || email == pattern
					|| !email_check($("#signUp_email").val())) {//4
				$("#signUpTargetEmail").addClass("has-error");
				$('#mainModal').modal({
					remote : 'modal.html'
				});
			} else if ($.trim($("#signUp_email").val()) != ""
					|| email != pattern
					|| email_check($("#signUp_email").val())) {
				$("#signUpTargetEmail").removeClass("has-error");
				$('#mainModal').modal({
					remote : 'modal.html'
				});
			}
			return;
		} else if (pwd != pwd2) {
			$("#signUpTargetPwd").addClass("has-error");
			$("#signUpTargetPwd2").addClass("has-error");
			$('#mainModal').modal({
				remote : 'modal.html'
			});
			return;
		} else {
			$("#signUpTargetPwd").removeClass("has-error");
			$("#signUpTargetPwd2").removeClass("has-error");
			$('#mainModal').modal({
				remote : 'modal.html'
			});

			$.ajax({
				url : 'signUpCheck',
				dataType : 'json',
				type : 'POST',
				data : {
					id : id,
					email : email
				},
				success : function(state) {
					var idCheckVar = 0;
					var emailCheckVar = 0;
					if (state.idCheck == "SignUpIdCheckOk") {
						console.log("sign Up Check Id ok"); // 작업중  체크확인 가 불 
						idCheckVar = 1;
					} else if (state.idCheck == "SignUpIdCheckNo") {
						console.log("sign Up Check Id No");
						str = "이미 존재하는 아이디 입니다";
						$("#signUp_div_idChange").append(str);

					} else {
						console.log("signUpIdCheck() err");
					}
					if (state.emailCheck == "SignUpEmailCheckOk") {
						console.log("email ok")
						emailCheckVar = 1;
					} else if (state.emailCheck == "SignUpEmailCheckNo") {
						console.log("email no")
						str = "이미 가입된 이메일 입니다";
						$("#signUp_div_idChange").append(str);
					} else {
						console.log(" email check err");
					}
					console.log(idCheckVar + " + " + emailCheckVar); 
					if (idCheckVar == 1 && emailCheckVar == 1) {
						signUpOk(id, pwd, email);
					}

				},
				error : function(error) {
					console.log(error);
				}
			});
		}

	}

	function signUpOk(id, pwd, email) { //여기
		$.ajax({
			url : 'signUpOk',
			type : 'post',
			datatype : 'json',
			data : {
				id : id,
				pwd : pwd,
				email : email,
			},
			success:function(data){
					alert('가입 완료');
			}, error: function(error){
				console.log(error);
			}
		});
		signUpCheckCancel();
	}

	function email_check(email) {
		var regex = /([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
		return (email != '' && email != 'undefined' && regex.test(email));
	}

	function signUpCheckCancel() {
		$("#signUpTargetId").removeClass("has-error");
		$("#signUpTargetPwd").removeClass("has-error");
		$("#signUpTargetPwd2").removeClass("has-error");
		$("#signUpTargetEmail").removeClass("has-error");
		$('#signUp_id').val('');
		$('#signUp_pwd').val('');
		$('#signUp_pwd2').val('');
		$('#signUp_email').val('');
		$('.alertDiv').remove();
		$('#mainModal').modal('hide');
	}

	function normalBoard() {
		$("#First_Container").empty();
		$("#First_Container").load("include_normal_board.jsp");
	}
</script>
<style>
body {
	font: 20px Montserrat, sans-serif;
	line-height: 1.8;
	color: #f5f6f7;
}

.normal_board {
	font-size: 18px;
}

.alertDiv {
	text-align: left;
}

.modal_color {
	color: black;
}

.small_font {
	font-size: 15px;
}

p {
	font-size: 16px;
}

.margin {
	margin-bottom: 45px;
}

.bg-1 {
	background-color: #1abc9c; /* Green */
	color: #ffffff;
}

.bg-2 {
	background-color: #474e5d; /* Dark Blue */
	color: #ffffff;
}

.bg-3 {
	background-color: #ffffff; /* White */
	color: #555555;
}

.bg-4 {
	background-color: #2f2f2f; /* Black Gray */
	color: #fff;
}

.container-fluid {
	padding-top: 70px;
	padding-bottom: 70px;
}

.navbar {
	padding-top: 15px;
	padding-bottom: 15px;
	border: 0;
	border-radius: 0;
	margin-bottom: 0;
	font-size: 12px;
	letter-spacing: 5px;
}

.navbar-nav  li a:hover {
	color: #1abc9c !important;
}
</style>
</head>
<body>

	<!-- Navbar -->
	<nav class="navbar navbar-default">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target="#myNavbar">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="demo.jsp">Kim Yong Don</a>
			</div>
			<div class="collapse navbar-collapse" id="myNavbar">
				<ul class="nav navbar-nav navbar-right">

					<li><a href="#" onClick="normalBoard();">Normal Board</a></li>
					<li><a href="#" onclick="scrollBoard();">Scrolling Board</a></li>
					<li><a href="#" onClick="mediaBoard();">Media</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- First Container -->
	<div class="container-fluid bg-1" id="First_Container"
		style="padding: 10px; height: auto; min-height: 600px;">
	</div>
	<!-- Second Container -->
	<div class="container-fluid bg-2 text-center">
		안녕하세요 저는 작년 6월~11월 까지 acorn 아카데미에서 JAVA 프레임워크기반 프로그래밍 교육을 이수한 김영돈입니다.
		
	</div>

	<!-- Third Container (Grid) -->
	<div class="container-fluid bg-3 text-center">
		<h3 class="margin">상기 게시판들 설명</h3>
		<br>
		<div class="row">
			<div class="col-sm-4">
				<p>Normal Board 는 일반적으로 사용하는 페이징 게시판을 구현하였습니다.</p>

			</div>
			<div class="col-sm-4">
				<p>Scrolling Board 의 경우 sns 형식의 무한 스크롤링 게시판으로 인스타그램 처럼 만들려고 합니다.</p>
			</div>
			<div class="col-sm-4">
				<p>Media 게시판의 경우 동영상 게제 등을 하고 싶은데 free AWS 용량이 허용될지 모르겠습니다 ( 일단
					준비중입니다 )</p>
			</div>
		</div>
	</div>
	<!-- Footer -->
	<footer class="container-fluid bg-4 text-center">
		<p>
			<font color="#ccffff">상기 디자인은 w3school 부트스트렙 모델을 참조하였습니다</font>
		</p>
	</footer>

	<div id="mainModal" class="modal fade" role="dialog">
		<div class="modal-dialog">

			<!-- Modal content-->
			<!-- (메인 모달)  -->
			<div class="modal-content modal_color">
				<div class="modal-header" id="modalTitle">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<div class="modal-title">
						<font color="#blue"> 회원 가입</font>
					</div>
				</div>
				<div class="modal-body" id="modalBody" style="text-align: right">
					<div class="row" id="signUpTargetId">
						<div class="col-sm-3">id :</div>
						<!-- 작업중 -->
						<div class="col-sm-6" id="signUp_div_id">
							<input type="text" class="form-control" id="signUp_id">
						</div>
						<div class="col-sm-3 alertDiv" id="signUp_div_idChange"></div>
					</div>
					<div class="row" id="signUpTargetPwd">
						<div class="col-sm-3">pwd :</div>
						<div class="col-sm-6" id="signUp_div_pwd">
							<input type="text" class="form-control" id="signUp_pwd">
						</div>
					</div>
					<div class="row" id="signUpTargetPwd2">
						<div class="col-sm-3">pwd2 :</div>
						<div class="col-sm-6" id="signUp_div_pwd2">
							<input type="text" class="form-control" id="signUp_pwd2">
						</div>
						<div class="col-sm-3 alertDiv" id="signUp_div_pwd2Change"></div>
					</div>
					<div class="row" id="signUpTargetEmail">
						<div class="col-sm-3">email :</div>
						<div class="col-sm-6" id="signUp_div_email">
							<input type="text" class="form-control" id="signUp_email">
						</div>
						<div class="col-sm-3 alertDiv" id="signUp_div_emailChange"></div>
					</div>

				</div>
				<div class="modal-footer" id="modalFooter">
					<button type="button" onclick="signUpCheck();"
						class="btn btn-default">작성완료</button>
					<button type="button" onclick="signUpCheckCancel();"
						class="btn btn-default">취소</button>
				</div>
			</div>

		</div>
	</div>

</body>
</html>
