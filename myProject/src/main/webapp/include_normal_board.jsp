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
	var pageNo = 1;
	var pageNum = 0;
	var state;
	//$(document).ready(normalViewAll());
	$(document).ready(count(1));
	
	function count(pageNo){
		
		console.log(pageNo);
		$.ajax({

			type : "get",
			url : "normal_count",
			dataType : "json",
			data : {pageNo : pageNo},
			success : function(data) {
				pageNum = data.count;
				console.log("count : " + data.count);
			},
			error : function(error) {
				console.log("normal_count err");
			}
		});
		setTimeout( () => {
		normalViewAll(pageNo);
			
		}, 10);
	}
	
	function normalViewAll(pageNo) {
		$("#jsonId").empty();
		

		$.ajax({

			type : "get",
			url : "normal",
			dataType : "json",
			data : {pageNo : pageNo},
			success : function(jsonData) {
				//console.log("data loding success");
				var str = "";
				var list = jsonData.datas;
				//console.log(list.length);
				//$("#jsonId").empty();
				$(list).each(
						function(index, objArr) {
							var splitid = this.n_context.substring(0,3);
							//console.log(splitid);
							
							str += '<tr>';
							str += '<td width="10%">' + this.n_no + '</td>';
							str += '<td width="20%">' + this.n_writer + '</td>';
							str += '<td width="25%">' + this.n_title + '</td>';
							str += '<td width="40%">' + '<a href="#" onclick="selectShow('
									+ this.n_no + ')">' + splitid
									+ '<a>' + '</td>';
							str += '</tr>';
						});
				$("#jsonId").append(str) // 게시물
				// paging
				str = "";
				for (var a = 1; a <= pageNum; a++) {
					if (a  == pageNo) {
						
						str += a + "&nbsp";
					}else{
						str += '<a href="#" onclick="count('+ a + ')">' + a + '</a>' + '&nbsp';
					}
				}
				
				// 중
				$("#jsonId").append(str);

			},
			error : function() {
				console.log("normal_board_error");
			}

		});
	}

	function insertOk() { //작업중  // 
		writer = $("#insertWriter").val();
		title = $("#insertTitle").val();
		context = $("#insertText").val();
		var formData = [ writer, title, context ];
		
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
				normalViewAll("1");
			},
			error : function(error) {
				console.log(error);
			},
		});
		console.log('insert 동작 완료');

	}

	function selectShow(n_no) {
		$
				.ajax({
					url : 'selectNormal',
					dataType : 'json',
					type : 'GET',
					data : {
						n_no : n_no
					},
					success : function(jsonData) {
						nno = n_no;

						title = jsonData.n_title;
						writer = jsonData.n_writer;
						context = jsonData.n_context;
						var y = [ n_no, title, writer, context ];

						var str = "";
						str += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
						
						str += '<div class="col-sm-9">';
						str += '<h4 class="modal-title">' + n_no + '번글</h4>'; // 1번호 작업
						str += '</div>';
						str += '<div class="col-sm-9" id="insertWriter">';
						str += '글쓴이 : ' + jsonData.n_writer;
						str += '</div></div>';
						
						str += '<div class="col-sm-9" id="insertTitle">';
						str += '제목 : ' + jsonData.n_title;
						str += '</div>';

						$("#modalTitle").html(str);
						
						str = "";
						str += '<div id="updateContext">'+jsonData.n_context+'</div>';
						
						$("#modalBody").html(str);

						str = "";

						str += '<button type="button" onclick="updateGo('
								+ n_no + ')"';
						str += 'class="btn btn-default">수정하러 가기</button>';
						str += '<button type="button" onclick="deleteGo('
								+ n_no + ')"';
						str += 'class="btn btn-default" data-dismiss="modal">글삭제</button>';

						str += '<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>';

						$("#modalFooter").html(str);

						//modal을 띄워준다.  

						$("#myModal").modal('show');

					},
					error : function(error) {
						console.log(error);
					},
				});

	}

	function updateGo(n_no) {
		state = 2;
		str = "";
		
		str += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
		str += '<h4 class="modal-title">' + n_no + '번글 수정하기</h4>';
		str += '<div class="col-sm-3">';
		str += '<input class="form-control" id="insertWriter" name="name" type="text" placeholder="'+writer+'" value="'+writer+'" >';
		str += '</div>';
		str += '<div class="col-sm-9"><input type="text" class="form-control" id="insertTitle" placeholder="'+title+'" value="'+title+'"></div>';

		$("#modalTitle").html(str);

		str = "";

		str += '<textarea class="form-control" rows="15" id="insertText">'
				+ context + '</textarea>';

		$("#modalBody").html(str);

		str = '<button type="button" onclick="insertCheck('+state+');" class="btn btn-default" data-dismiss="modal">수정하기</button> <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>';

		$("#modalFooter").html(str);
	}

	function updateOk() {
		title = $("#insertTitle").val();
		writer = $("#insertWriter").val();
		context = $("#insertText").val();
		console.log("title : " + title + ", writer : " + writer + ", context : " + context)

		$.ajax({
			url : 'updateOk',
			dataType : 'json',
			type : 'POST',
			data : {
				n_no : nno,
				title : title,
				writer : writer,
				context : context
			},
			success : function(data) {
				if (data.state == "UpdateCheckOk") {
					console.log("update 완료");
					$("#jsonId").empty();
					normalViewAll(1);
				} else if (data.state == "UpdateCheckNo") {
					console.log("update 실패")
				} else {
					console.log("updateOk() err")
				}
			},
			error : function(error) {

			}
		});

	};

	function deleteGo(n_no) {
		$.ajax({
			url : "deleteGo",
			method : "get",
			data : {
				n_no : n_no
			},
			dataType : "json",
			success : function(data) {
				if (data.state = "DeleteOk") {
					console.log("삭제 완료")
				} else if (data.state = "DeleteNo") {
					console.log("삭제 실패")
				} else {
					console.log("DeleteGo Controller err")
				}
			},
			error : function(error) {
				console.log("deleteGo err : " + error)
			}
		});
		$("#jsonId").empty();
		setTimeout("normalViewAll()", 30);

	}
	
	function getTextLength(str) { // 문자열 길이
        var len = 0;
        for (var i = 0; i < str.length; i++) {
            if (escape(str.charAt(i)).length == 6) {
                len++;
            }
            len++;
        }
        return len;
    }


	function insertCheck(state) { // 여기하는중
		//alert(getTextLength($("#insertWriter").val()));
		if ($.trim($("#insertWriter").val()) == "") {
			str = "";

			str += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
			str += '<h4 class="modal-title">글쓰기</h4>';
			str += '<div class="col-sm-3 has-error">';
			str += '<input class="form-control" id="insertWriter" name="name" type="text" placeholder="글쓴이">';
			str += '<span class="glyphicon glyphicon-remove form-control-feedback"></span>';
			str += '</div>';
			str += '<div class="col-sm-9">';
			str += '<input type="text" class="form-control" id="insertTitle" placeholder="제목">';
			str += '</div>';

			$("#modalTitle").html(str);

			$('#myModal').modal({
				remote : 'modal.html'
			});

		} else if ($.trim($("#insertTitle").val()) == "") {
			var writer = $("#insertWriter").val();

			str = "";

			str += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
			str += '<h4 class="modal-title">글쓰기</h4>';
			str += '<div class="col-sm-3">';
			str += '<input class="form-control" id="insertWriter" name="name" type="text" placeholder="글쓴이" value="'+writer+'">';
			str += '</div>';
			str += '<div class="col-sm-9 has-error">';
			str += '<input type="text" class="form-control" id="insertTitle" placeholder="제목">';
			str += '<span class="glyphicon glyphicon-remove form-control-feedback"></span>';
			str += '</div>';

			$("#modalTitle").html(str);

			//
			$('#myModal').modal({
				remote : 'modal.html'
			});

		} else if ($.trim($("#insertText").val()) == "") {

			str = "";
			str += '<div class="has-error">';
			str += '<span class="glyphicon glyphicon-remove form-control-feedback"></span>';
			str += '<textarea class="form-control " rows="15" id="insertText" placeholder="내용이 있어야 합니다"></textarea>';

			str += '</div>';
			$("#modalBody").html(str);
			$('#myModal').modal({
				remote : 'modal.html'
			});

		} else {
			if (state == 1) {
				insertOk();
				
			}else if (state == 2){
				updateOk();
			}else {
				alert("insert / update Check err")
				return;
			}
			$('#myModal').modal('hide');
		}
	}

	function writeView() {
		state = "1";
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

		str += '<textarea class="form-control " rows="15" id="insertText"></textarea>';

		//
		$("#modalBody").html(str);

		str = "";

		str += '<button type="button" onclick="insertCheck('+state+')" class="btn btn-default" >작성완료</button>';
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
					<th>제목</th>
					<th>내용</th>
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
					<div class="modal-header" id="modalTitle">
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