<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript">
function searchdd(){
	$.ajax({
		url : 'searchGo',
		dataType : 'json',
		type : 'post',
		data : null,
		success : function(){
			console.log("서치 테스트 성공");
		},
		error : function(){
			console.log("서치 테스트 실패");
		}
	});
}
</script>
</head>
<body>
<a href="#" onclick="searchdd()">ddd</a>
</body>
</html>