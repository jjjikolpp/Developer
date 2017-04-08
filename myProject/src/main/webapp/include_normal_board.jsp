<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
	var title;
	var writer;
	var context;
	var nno;
	$(document).ready(
			normalViewAll()		
	);

	function normalViewAll(){
		$.ajax({

					type : "get",
					url : "normal",
					dataType : "json",
					data : null,
					success : function(jsonData) {
						//console.log("data loding success");
						var str = "";
						var list = jsonData.datas;
						//console.log(list.length);
						//$("#jsonId").empty();
						$(list)
								.each(
										function(index, objArr) {
											str += '<tr>';
											str += '<td size="5">'
													+ this.n_no
													+ '</td>';
											str += '<td size="5">'
													+ this.n_writer
													+ '</td>';
											str += '<td size="10">'
													+ this.n_title
													+ '</td>';
											str += '<td>'
													+ '<a href="#" onclick="updateShow('+this.n_no+')">'
													+ this.n_context
													+ '<a>'
													+ '</td>';
											str += '</tr>';
										});

						$("#jsonId").append(str)
					},
					error : function() {
						console.log("normal_board_error");
					}

				});
	}
	
	

	function updateCheck(){
		if ($("#updateWriter").val() == "") {
			alert("ss")
		
		}else if($("#updateTitle").val() == ""){
			alert("타이틀")
			
		}else if($("#updateText").val() == ""){
			alert("텍스트")
		
		}else{
			updateOk();
			$('#myModal').modal('hide');
		}
	}
	
	function insertCheck(){
		
		
		if ($("#insertWriter").val() == "") {
			alert("ss")
		
		}else if($("#insertTitle").val() == ""){
			alert("타이틀")
			
		}else if($("#insertText").val() == ""){
			alert("텍스트")
		
		}else{
			insertOk();
			$('#myModal').modal('hide');
		}
	}
	function insertOk() { //작업중  // 
		var writer = $("#insertWriter").val();
		var title = $("#insertTitle").val();
		var context = $("#insertText").val();
		var formData = [ writer, title, context ];
		var state = "normal";
		//
		console.log('insert 동작중');
		
		

		$.ajax({
			url : 'insertOk',
			dataType : 'json',
			type : 'POST',
			data : {
				writer : writer,
				title : title,
				context : context
			},
			success : function(stateData) {
				console.log(stateData);	
				$("#jsonId").empty();
				normalViewAll();	
			},
			error : function(error) {
				console.log(error);
			},
		});
		console.log('insert 동작 완료');

	}
	// update modal 
	function updateShow(n_no){
		$.ajax({
			url : 'selectNormal',
			dataType : 'json',
			type : 'GET',
			data : {
				n_no: n_no
			},
			success : function(jsonData) {
				nno = n_no;
				
				title = jsonData.n_title;
				writer = jsonData.n_writer;
				context = jsonData.n_context;
				
				
				var str = "";
				str += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
				str += '<h4 class="modal-title">'+n_no+'번글</h4>'; // 1번호 작업
				str += '<div class="col-sm-3">';
				//str += '<input class="form-control" id="insertWriter" name="name"';
				//str += 'type="text" placeholder="글쓴이" disabled>';
				str += jsonData.n_writer;
				str += '</div>';
				str += '<div class="col-sm-9">';
				str += jsonData.n_title;
				str += '</div>';
					
					
			    $("#modalTitle").html(str);

			    $("#modalBody").html(jsonData.n_context);
			    
			    str = "";
			    
			    str += '<button type="button" onclick="updateGo('+n_no+')"';
			    str += 'class="btn btn-default">수정하러 가기</button>';
			    str += '<button type="button" onclick="deleteGo('+n_no+')"';
			    str += 'class="btn btn-default" data-dismiss="modal">글삭제</button>';
			    
				str += '<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>';
			    
			    
			    $("#modalFooter").html(str);



			    //modal을 띄워준다.  

			    $("#myModal").modal('show');
				
			},
			error : function(error){
				console.log(error);
			},
		});
		
	}
	
	function updateGo(n_no){
		str = "";
		
		str += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
		str += '<h4 class="modal-title">'+n_no+'번글 수정하기</h4>';
		str += '<div class="col-sm-3">';
		str += '<input class="form-control" id="updateWriter" name="name" type="text" placeholder="'+writer+'" value="'+writer+'" >';
		str += '</div>';
		str += '<div class="col-sm-9"><input type="text" class="form-control" id="updateTitle" placeholder="'+title+'" value="'+title+'"></div>';
		// 여기까지 함
		
		$("#modalTitle").html(str);
			
		str = "";
		
		str += '<textarea class="form-control" rows="15" id="updateText">'+context+'</textarea>';
		
		
		$("#modalBody").html(str);
		
		str = '<button type="button" onclick="updateCheck();" class="btn btn-default" data-dismiss="modal">수정하기</button> <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>';
			
		$("#modalFooter").html(str);
	}
	
	function updateOk(){
		title = $("#updateTitle").val();
		writer = $("#updateWriter").val();
		context = $("#updateText").val();
		
		$.ajax({
			url : 'updateOk',
			dataType : 'json',
			type : 'POST',
			data : {
				n_no: nno,
				title : title,
				writer : writer,
				context : context
			},
			success : function(data){
				if (data.state == "UpdateCheckOk") {
					console.log("update 완료");
				}else if(data.state == "UpdateCheckNo"){
					console.log("update 실패")
				}else{
					console.log("updateOk() err")
				}
			},
			error : function(error){
				
			}
		});	
	};
	
	function deleteGo(n_no){
		$.ajax({
			url:"deleteGo",
			method:"get",
			data:{
				n_no : n_no
			},
			dataType:"json",
			success: function(data){
				if (data.state = "DeleteOk") {
					console.log("삭제 완료")
				}else if(data.state = "DeleteNo"){
					console.log("삭제 실패")
				}else{
					console.log("DeleteGo Controller err")
				}
			},
			error: function(error){
				console.log("deleteGo err : " + error)
			}
		});
		$("#jsonId").empty();
		setTimeout("normalViewAll()", 30);
		
	}
	
	function writeView(){
		
		var str = "";
		
		str += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
		str += '<h4 class="modal-title">글쓰기</h4>';
		str += '<div class="col-sm-3">';
		str += '<input class="form-control" id="insertWriter" name="name" type="text" placeholder="글쓴이">';
		str += '</div>';
		str += '<div class="col-sm-9">';			
		str += '<input type="text" class="form-control" id="insertTitle" placeholder="제목">';
		str += '</div>';
		
		
		
		$("#modalTitle").html(str);
		
		str = "";
		
		str += '<div class="has-error">';
		
		str += '<span class="glyphicon glyphicon-remove form-control-feedback"></span>';
		str += '<textarea class="form-control " rows="15" id="insertText"></textarea>';
		str += '</div>';
	
		//
		$("#modalBody").html(str);
		 
		
		str = "";
		
		str += '<button type="button" onclick="insertCheck();" class="btn btn-default" >작성완료</button>';
		str += '<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>';		
		
		str += '</div>';
		
		$("#modalFooter").html(str);
		$("#myModal").modal('show');
		
	}
	
</script>
<body>
	<div class="container bg-3">
		<table class="table">
			<thead>
				<tr>
					<th>글번호</th>
					<th>작성자</th>
					<th width="35%">제목</th>
					<th width="40%">내용</th>
				</tr>
			</thead>
			<tbody id="jsonId">


			</tbody>

		</table>

		<!-- Trigger the modal with a button -->
		<button type="button" class="btn btn-default" onclick="writeView()">글쓰기</button>

		<!-- Modal -->
		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header"  id="modalTitle">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">글쓰기</h4>
						<div class="col-sm-3">
							<input class="form-control" id="insertWriter" name="name"
								type="text" placeholder="글쓴이">
						</div>
						<div class="col-sm-9">
							<input type="text" class="form-control" id="insertTitle"
								placeholder="제목">
						</div>
					</div>
					<div class="modal-body" id="modalBody">
						<textarea class="form-control" rows="15" id="insertText"></textarea>
					</div>
					<div class="modal-footer" id="modalFooter">
						<button type="button" onclick="insertOk();"
							class="btn btn-default" data-dismiss="modal">작성완료</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
					</div>
				</div>

			</div>
		</div>




	</div>
<script type="text/javascript">

</script>
	

</body>
</html>