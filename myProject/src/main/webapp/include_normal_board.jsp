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
	var PageNo = 1;  // 작은 현재 페이지
	var maxPageNum = 0; // 최대 페이지
	var pageSave = 1; //큰 현재 페이지
	var state;
	var countNo;
	var searchValue1 = "n_title";

	//$(document).ready(normalViewAll());
	$(document).ready(
			$(".search input[type=text]").keypress(function(e) { 

			    if (e.keyCode == 13){
			        search()
			    }    
			}),
			normalViewAll(1)
	);
	
	
	function normalViewAll(pageNo) {
		$("#jsonId").empty();
		$("#normal_board_under1").empty();
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
							var splitid = this.n_context.substring(0,30);
							
							//console.log(splitid);
							str += '<tr>';
							str += '<td class="col-sm-1">' + this.n_no + '</td>';
							str += '<td class="col-sm-2">' + this.n_writer + '</td>';
							str += '<td class="col-sm-3">' + this.n_title + '</td>';
							str += '<td class="col-sm-6">' + '<a href="#" onclick="selectShow('
									+ this.n_no + ')">' + splitid;
							if (this.n_context.length > 30) {
								str += '..';
							}
							str += '<a>' + '</td>';
							str += '</tr>';
						});
				
				
				$("#jsonId").append(str);
				countNo = list[0].n_count;
				maxPageNum = list[0].maxPageNum
				console.log(countNo);
				
				
				str = '';
				
				if (maxPageNum <= 10) {
					
					for (var a = 1; a <= maxPageNum; a++) {
						if (a  == pageNo) {
							str += a + "&nbsp";
						}else{
							str += '<a href="#" onclick="normalViewAll('+ a + ')">' + a + '</a>' + '&nbsp';
						}	
					}
				}else if(maxPageNum > 10){
					
					if (pageSave != Math.ceil(pageNo/10)) {
						pageSave = Math.ceil(pageNo/10);
					}
										
					if(pageSave == 1){
					
						for (var a = 1; a <= 10; a++) {
							if (a  == pageNo) {
								str += a + "&nbsp";
							}else{
								str += '<a href="#" onclick="normalViewAll('+ a + ')">' + a + '</a>' + '&nbsp';
							}	
						}
						str += '<a href="#" onclick="normalViewAll('+(pageNo + 1)+')">></a>' ;
					
					}else if(pageSave != 1){
						
						str += '<a href="#" onclick="normalViewAll('+(pageNo - 1)+')"><</a>' ;	
						if (pageSave != Math.ceil((countNo/3) /10)) {   
						
						for (var a = 1; a <= 10; a++) {
							var checkNum = (pageSave-1).toString() + a;
							
							if (checkNum == pageNo) {
								if (a != 10) {
									str += checkNum + "&nbsp";
								}else{
									str += pageSave * 10 + "&nbsp";
								}
							}else{
								if (a != 10) {
									str += '<a href="#" onclick="normalViewAll('+ checkNum + ')">' + checkNum + '</a>' + '&nbsp';
								}else{
									str += '<a href="#" onclick="normalViewAll('+ pageSave * 10 + ')">' + pageSave * 10 + '</a>' + '&nbsp';
								}
							}		
						}	
						}
						
						if (pageSave == Math.ceil((countNo/3)/10)) {
							var ccc =  Math.ceil(countNo/3) - 10 * (pageSave -1);
							for (var a = 1; a < ccc + 1; a++) {
								var checkNum = (pageSave-1).toString() + a;
								
								if (checkNum == pageNo) {
									if (a != 10) {
										str += checkNum + "&nbsp";
									}else{
										str += pageSave * 10 + "&nbsp";
									}
								}else{
									if (a != 10) {
										str += '<a href="#" onclick="normalViewAll('+ checkNum + ')">' + checkNum + '</a>' + '&nbsp';
									}else{
										str += '<a href="#" onclick="normalViewAll('+ pageSave * 10 + ')">' + pageSave * 10 + '</a>' + '&nbsp';
									}		
								}
							}
						}else{
							str += '<a href="#" onclick="normalViewAll('+(pageNo + 1)+')">></a>';							
						}
					}
				}
				str += "</div>";
				// 영돈
				
				$("#normal_board_under1").append(str);
			},
			error : function() {
				console.log("normal_board_error");
			}

		});
	}
	

	function insertOk() {
		writer = $("#insertWriter").val();
		title = $("#insertTitle").val();
		context = $("#insertText").val();
		var formData = [ writer, title, context ];
		
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
				$("#normal_board_under1").empty();
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
						str += '<h4 class="modal-title">' + n_no + '번글</h4>'; 
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

						str += '<button type="button" onclick="updateCheck('
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
	function updateCheck(n_no){
		$.ajax({
			url : 'updateCheck',
			data : {n_no},
			dataType : 'json',
			type : 'get',
			success : function(data){
				if (data.state == 'ok') {
					updateGo(n_no);
				}else if(data.state == 'no'){
					alert('본인 아이디어야 삭제할수 있습니다.');
				}else{
					alert('updateCheck() err');
				}
			}
		});
	}
	function updateGo(n_no) {
		
		state = 2;
		str = "";
		
		str += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
		str += '<h4 class="modal-title">' + n_no + '번글 수정하기</h4>';
		str += '<div class="col-sm-3">';
		str += '<input class="form-control" id="insertWriter" name="name" type="text" placeholder="'+writer+'" value="'+writer+'" readonly>';
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
					$("#normal_board_under1").empty();
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
				n_no : n_no,
			},
			dataType : "json",
			success : function(data) {
				console.log(data.state);
				if (data.state == "DeleteOk") {
					console.log("삭제 완료");
				} else if (data.state == "DeleteNo") {
					console.log("삭제 실패");
				}else if (data.state == 'idIsNull'){	// 여기
					alert("본인 아이디어야 삭제할수 있습니다.")
				}else if(data.state =='idDiscord'){
					alert("dddd");
				} 
				else{
					alert(data.state);
					console.log("delete error");
				}
			},
			error : function(error) {
				console.log("deleteGo err : " + error);
			}
		});
		console.log('pageNo = ' + PageNo);
		$("#jsonId").empty();
		$("#normal_board_under1").empty();
		setTimeout('normalViewAll('+pageSave+')', 30);

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


	function insertCheck(state) { 
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
	function writeLoginCheck(){
		$.ajax({
			url : 'loginCheck',
			dataType : 'json',
			type : 'post',
			success : function(data){
				console.log(data.state);
				if (data.state == 'logout') {
					alert('로그인 하셔야 합니다');
				}else if(data.state == 'login'){
					writeView(data.id);
					console.log('writeLoginCheck() : ' + data.id);
				}else{
					console.log('writerView err');
				}
			},
			error : function(error){
				console.log('writerView err : ' + error);
			}
		});
	}
	
	function writeView(id) {
		
		state = "1";
		var str = "";

		str += '<button type="button" class="close" data-dismiss="modal">&times;</button>';
		str += '<h4 class="modal-title">글쓰기</h4>';
		str += '<div class="col-sm-3">';
		str += '<input class="form-control" id="insertWriter" name="name" type="text" placeholder="글쓴이" value="'+id+'" disabled>';
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
	function selectEvent(selectObj) {
		searchValue1 = selectObj.value;
	}
	//작업중
	function searchOn(pageNo){
		$("#normal_board_under1").empty();
		$("#jsonId").empty();
		var searchValue2 = $("#searchVaule2").val();
		$.ajax({

			url : "search",
			type : "post",
			dataType : "json",
			data : {searchValue1 : searchValue1,
				searchValue2 : searchValue2,
				pageNo : pageNo	
				},
				
				
			success : function(jsonData) {
				console.log(jsonData.dataList + "ddd");
				var list = jsonData.dataList;
				str = '';
				var state = list[0].state;
				
				if (state != 'no') {
				
				$(list).each(
						function(index, objArr) {
							var splitid = this.n_context.substring(0,10);
							
							//console.log(splitid);
							str += '<tr>';
							str += '<td class="col-sm-1">' + this.n_no + '</td>';
							str += '<td class="col-sm-2">' + this.n_writer + '</td>';
							str += '<td class="col-sm-3">' + this.n_title + '</td>';
							str += '<td class="col-sm-6">' + '<a href="#" onclick="selectShow('
									+ this.n_no + ')">' + splitid;
							if (this.n_context > 10) {
								str += '..';
							}
							str += '<a>' + '</td>';
							str += '</tr>';
						});
				$("#jsonId").append(str);
				
				countNo = list[0].n_count;
				maxPageNum = list[0].maxPageNum
				console.log(countNo);
				
				
				str = '';
				
				if (maxPageNum <= 10) {
					console.log("dddd");
					console.log(maxPageNum);
					
					for (var a = 1; a <= maxPageNum; a++) {
						if (a  == pageNo) {
							str += a + "&nbsp";
						}else{
							str += '<a href="#" onclick="searchOn('+ a +')">' + a + '</a>' + '&nbsp';
						}	
					}
				}else if(maxPageNum > 10){
					
					if (pageSave != Math.ceil(pageNo/10)) {
						pageSave = Math.ceil(pageNo/10);
					}
										
					if(pageSave == 1){
					
						for (var a = 1; a <= 10; a++) {
							if (a  == pageNo) {
								str += a + "&nbsp";
							}else{
								str += '<a href="#" onclick="searchOn('+ a + ')">' + a + '</a>' + '&nbsp';
							}	
						}
						str += '<a href="#" onclick="search('+(pageNo + 1)+')">></a>' ;
					
					}else if(pageSave != 1){
						
						str += '<a href="#" onclick="search('+(pageNo - 1)+')"><</a>' ;	
						if (pageSave != Math.ceil((countNo/3) /10)) {   
						
						for (var a = 1; a <= 10; a++) {
							var checkNum = (pageSave-1).toString() + a;
							
							if (checkNum == pageNo) {
								if (a != 10) {
									str += checkNum + "&nbsp";
								}else{
									str += pageSave * 10 + "&nbsp";
								}
							}else{
								if (a != 10) {
									str += '<a href="#" onclick="search('+ checkNum + ')">' + checkNum + '</a>' + '&nbsp';
								}else{
									str += '<a href="#" onclick="search('+ pageSave * 10 + ')">' + pageSave * 10 + '</a>' + '&nbsp';
								}
							}		
						}	
						}
						
						if (pageSave == Math.ceil((countNo/3)/10)) {
							var ccc =  Math.ceil(countNo/3) - 10 * (pageSave -1);
							for (var a = 1; a < ccc + 1; a++) {
								var checkNum = (pageSave-1).toString() + a;
								
								if (checkNum == pageNo) {
									if (a != 10) {
										str += checkNum + "&nbsp";
									}else{
										str += pageSave * 10 + "&nbsp";
									}
								}else{
									if (a != 10) {
										str += '<a href="#" onclick="search('+ checkNum + ')">' + checkNum + '</a>' + '&nbsp';
									}else{
										str += '<a href="#" onclick="search('+ pageSave * 10 + ')">' + pageSave * 10 + '</a>' + '&nbsp';
									}		
								}
							}
						}else{
							str += '<a href="#" onclick="search('+(pageNo + 1)+')">></a>';							
						}
					}
				}
				str += "</div>";
			}else {
				str = '검색된 게시물이 없습니다.';
			}
				
				$("#normal_board_under1").append(str);
			},
			error : function(error){
				console.log("search err")
			}
		});
	}
	

</script>
<body>
	<div class="container bg-3 normal_board">
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

		<div class="row">
			<!-- 검색 작업중   -->
			<div class="col-sm-3">
				<button type="button" class="btn btn-default"
					onclick="writeLoginCheck()">글쓰기</button>
			</div>
			<div class="col-sm-3" id="normal_board_under1"></div>
			<div class="col-sm-2">
				<div class="form-group">
					<select class="form-control input-sm" id="sel1"
						onChange="javascript:selectEvent(this)">
						<option class="small_font" value="n_title">제목</option>
						<option class="small_font" value="n_context">내용</option>
						<option class="small_font" value="n_writer">작성자</option>
						<option class="small_font" value="n_no">글번호</option>
					</select>
				</div>

			</div>
			<div class="col-sm-2">
				<div class="dddd search">
					<input class="form-control" type="text" id="searchVaule2">
				</div>
			</div>
			<div class="col-sm-2">
				<button type="button" class="btn btn-default" onclick="searchOn(1)">검색</button>
			</div>
		</div>

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