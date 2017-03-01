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
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
  	function normalBoard(){
  		alert("dd");
  		$("div#First_Container").empty();
  		var str = 'ss';
  		alert(str);
  		
  		 
  	}
  </script>
  <style>
  body {
      font: 20px Montserrat, sans-serif;
      line-height: 1.8;
      color: #f5f6f7;
  }
  p {font-size: 16px;}
  .margin {margin-bottom: 45px;}
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
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">Kim Yong Don</a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-right">
      
        <li><a href="#" onClick="normalBoard();">Normal Board</a></li>
        <li><a href="#">Scrolling Board</a></li>
        <li><a href="#">Media</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- First Container -->
<div class="container-fluid bg-1 text-center" id="First_Container"  style=" padding: 10px; height: auto; min-height: 600px; overflow: auto;">
  <h3 class="margin">Who Am I?</h3>
  <h3></h3>
</div>

<!-- Second Container -->
<div class="container-fluid bg-2 text-center">
  안녕하세요 저는 작년 6월~11월 까지 acorn 아카데미에서 JAVA 프레임워크기반 프로그래밍 교육을 이수한 김영돈입니다.
  
</div>

<!-- Third Container (Grid) -->
<div class="container-fluid bg-3 text-center">    
  <h3 class="margin">상기 게시판들 설명</h3><br>
  <div class="row">
    <div class="col-sm-4">
      <p>Normal Board 는 일반적으로 사용하는 페이징 게시판을 구현하였습니다</p>
      
    </div>
    <div class="col-sm-4"> 
      <p>Scrolling Board 의 경우 sns 형식의 무한 스크롤링 게시판으로 인스타그램 처럼 만들시 DB작업등으로 시간이 많이 소모됩니다 (지금은 스크롤링만 구현하였습니다)</p>
      
    </div>
    <div class="col-sm-4"> 
      <p>Media 게시판의 경우 동영상 게제 등을 하고 싶은데 free AWS 용량이 허용될지 모르겠습니다 ( 일단 준비중입니다 )</p>
      
    </div>
  </div>
</div>

<!-- Footer -->
<footer class="container-fluid bg-4 text-center">
  <p><font color="#ccffff">상기 디자인은 w3school 부트스트렙 모델을 참조하였습니다</font></p> 
</footer>

</body>
</html>