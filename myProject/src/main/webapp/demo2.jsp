<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="ko">

<head>

  <title>Bootstrap Example</title>

  <meta charset="utf-8">

  <meta name="viewport" content="width=device-width, initial-scale=1">

  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</head>

<body>



<div class="container">

  <h2>Modal Example</h2>

 <!--  버튼이 클릭되면 show 메소드가 호출된다.   show메서드를 호출할때 원하는 값을 넣어 보낸다.  show메서드의 인자로 넘어가는 aaa 는 동적으로 바뀌어야 함.  -->

  <button type="button" class="btn btn-info btn-lg" onclick="show('aaa')">Open Modal</button>



  <!-- Modal -->

  <div class="modal fade" id="myModal" role="dialog">

    <div class="modal-dialog">

    

      <!-- Modal content-->

      <div class="modal-content">

        <div class="modal-header">

          <button type="button" class="close" data-dismiss="modal">&times;</button>

          <h4 class="modal-title" id="title"></h4>

        </div>

        <div class="modal-body">

          <p id="content"></p>

        </div>

        <div class="modal-footer">

          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>

        </div>

      </div>

      

    </div>

  </div>  

</div>

<script type="text/javascript">

	function show(str){

		//show 호출시 넘겨준 값을 이용하여 ajax 등을 통해 modal 을 띄울때 동적으로 바뀌어야 하는 값을 얻어온다.  

		

		//얻어온 값을 이용하여, modal 에서 동적으로 바뀌어야 하는 값을 바꾸어 준다..  

	    $("#title").html('<h4 class="modal-title">글쓰기</h4>');

	    $("#content").html("ajax를 통해 얻어온 id에 해당하는 값");



	    //modal을 띄워준다.  

	    $("#myModal").modal('show');

  

	  

	}

</script>

</body>

</html>

