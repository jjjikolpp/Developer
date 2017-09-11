<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
$(document).ready( function(){
	

		loginView(),
		alert('cccc');
});

function loginView(){
			$('#loginView').empty();
			var member_id = "<%=(String) session.getAttribute("id")%>"
		str = '';
		str += member_id;
		str += ' 님 어서오세요~';
		str += '&nbsp&nbsp&nbsp&nbsp';
		str += '<button type="button" class="btn btn-default" url="/logOut.do">logout</button>';
		$('#loginView').append(str);

		console.log('loginView err : ' + error)

	}
</script>
<body>
	<div id="loginView" align="center"></div>

</body>
</html>