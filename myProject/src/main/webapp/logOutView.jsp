<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<style type="text/css">
body {
	font: 20px Montserrat, sans-serif;
	line-height: 1.8;
	background-color: #1abc9c;
}

.bg-1 {
	background-color: #1abc9c; /* Green */
	color: #ffffff;
}
</style>
</head>
<body>
<div class="text-center">
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-8">
					<h3 class="margin">로그인</h3>
				</div>
				<div class="col-sm-2"></div>
			</div>
			<div class="row">
				<div class="col-sm-5" style="text-align: right">id :</div>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="LoginIdTextBox">
				</div>
				<div class="col-sm-3" id="Login_id_error_div"></div>
			</div>
			<div class="row">
				<div class="col-sm-5" style="text-align: right">pw :</div>
				<div class="col-sm-2">
					<input type="text" class="form-control" id="LoginPwdTextBox">
				</div>
				<div class="col-sm-3" id="Login_pwd_error_div"></div>
			</div>
			<div class="row">
				<div class="col-sm-5"></div>
				<div class="col-sm-2">
					<button type="button" class="btn btn-default btn-mg"
						onclick="LoginFunc()">Login</button>
					<button type="button" class="btn btn-default btn-mg"
						onclick="SignUpModal()">Sign Up</button>
				</div>
			</div>
		</div>
</body>
</html>