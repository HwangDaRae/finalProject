<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
<title>신고 등록</title>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script type="text/javascript">
	
	function fncAddReport(){
		
		var title = $("textarea[name=title]").val();		
		var content =$("textarea[name=content]").val();			
		var checkbox = $("input:checkbox[name=reportReason]:checked").length;
		
		if(title == null || title.length <1){
          	Swal.fire({
                icon: 'error',
                title: '신고 제목은 필수입니다.',
            });
				return;
			}
		if(content == null || content.length <1){
			Swal.fire({
                icon: 'error',
                title: '신고 내용은 필수입니다.',
                text: '가능한 상세히 적어주세요.',
            });
				return;
			}
				
		if(checkbox==0){
			Swal.fire({
                icon: 'error',
                title: '신고 사유는 필수입니다.',
                text: '1개 이상 클릭해주세요.',
            });
			return;
		}
		
						
	  Swal.fire({
          title: '정말로 신고하시겠습니까?',
          text: "다시 되돌릴 수 없습니다. 신중하세요.",
          icon: 'warning',
          showCancelButton: true,
          confirmButtonColor: '#3085d6',
          cancelButtonColor: '#d33',
          confirmButtonText: '신고',
          cancelButtonText: '취소'
      }).then((result) => {
          if (result.isConfirmed) {
             AddReport()
          }
      })
 }
 
	function AddReport(){	

		var sum = 0;
		var checkbox = $("input:checkbox[name=reportReason]:checked").length;
				
		for(var i =0 ; i<checkbox; i++){
			var sum2 = parseInt($("input:checkbox[name=reportReason]:checked").val());
			sum += sum+parseInt(sum2);			
		}

			
		var no = 0;	
			
		 if( $("#clubPostNo").val()!=null){
			 no = $("#clubPostNo").val();
		}else if($("#clubPostCommentNo").val()!=null){
			 no = $("#clubPostCommentNo").val();
		}else if($("#feedNo").val()!=null){
			 no = $("#feedNo").val();
		}else if($("#feedCommentNo").val()!=null){
			  no = $("#feedCommentNo").val();
		}
		
		var clubNo = 0;
		
		if( $("#clubNo2").val()!=null ){
			clubNo = $("#clubNo2").val();
		}else if( $("#clubNo3").val()!=null){
			clubNo = $("#clubNo3").val();
		}
		
		var clubPostNo = 0;
		
		
		if ( $("#clubPostNo2").val()!=0){
			
			clubPostNo = $("#clubPostNo2").val();
			if(clubPostNo == undefined){
				clubPostNo = 0;
			}
			
		}
		
	 	$.ajax({
		url  : "/serviceCenterRest/json/addReport?clubNo="+clubNo+"&clubPostNo="+clubPostNo,
 		//url  : "/serviceCenterRest/json/addReport?clubNo="+clubNo,
		contentType: 'application/json',
		method : "POST",
		dataType: "json",
		data : JSON.stringify ({
			"title":$("#title").val(),
			"content":$("#content").val(),
		<%--	"file": image, --%>
			"user1":$("#user1").val(),
			"user2":$("#user2").val(),
			"reportSource":$("#reportSource").val(),
			"reportReason": sum,
			"type": $("#type").val(),
			"no" :no,
				
		 success: function(){
			 window.close();
		 }
		}),
			
		})<!-- ajax ( ReportAdd) 끝 --> 
		

	} //funtion 끝
	

	$(function(){
		
  		
		$("button:contains('등록')").bind("click", function(){
			fncAddReport()
			
		})

		
		$("button:contains('뒤로')").bind("click", function(){
			
			self.close();
			<%-- self.close() 하고 window.close() 둘 다 크롬에서 되는지 확인해보기.
			부모창 없어서 나 혼자로는 못 끔 --%>
		})
		
		var reportSource = opener.$("input[name='reportSource']").val();
		var user2 = opener.$("input[name='user2']").val();
	<%--	var image = $("input:multiple[name=image]").val(); --%>
		var userId = opener.$("input[name='reportedId']").val();
		$("#reportSource").val(reportSource);
		$("#user2").val(user2);
		$("#user2").val(userId);
		
	});
	
	</script>
<style>
.row {
	margin-left : 0px !important;
	   display: initial !important;
}
textarea {
	resize: none;
}
body{
background-color: #EBEDF0 !important;
}
.title {
	width: 400px;
}
.add {
  background-color: #4CAF50; /* Green */
  border: none;
  color: white;
  padding: 10px 30px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 11px;
  margin: 4px 2px;
  -webkit-transition-duration: 0.4s; /* Safari */
  transition-duration: 0.4s;
  cursor: pointer;
}
.add5 {
    background-color: white; 
  	color: black; 
  	border: 2px solid #f44336;
  	border-radius : 13px;
}
.add5:hover {
   background-color: #f44336;
  color: white;
}
.add6 {
    background-color: white; 
  	color: black; 
  	border: 2px solid #0a6bdf;
  	border-radius : 13px;
}
.add6:hover {
   background-color: #0a6bdf;
  color: white;
}
</style>
</head>

<body>


	<!-- form Start /////////////////////////////////////-->
	<div class="container">
		<div></div>
		<div class="page-header text-center">
			<h2><strong>신고 등록</strong></h2>
		</div>

		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data">
			<input type="hidden" name="type" id="type" value="1">
			
			<input type="hidden" name="user1" id="user1" value="${sessionScope.user.userId}">
			<div class="form-group">
				<label for="title" class="col-sm-offset-1 col-sm-3 control-label">제목</label>
				<div class="col-sm-4">
					<textarea class="title" id="title" name="title" value=""
						maxlength="66" placeholder="신고 제목을 입력해주세요"
						style="position: fixed;"></textarea>

				</div>

 	
	<!--  화면구성 div end /////////////////////////////////////-->

			</div>
			</br>
			<div class="form-group">
				<label for="content" class="col-sm-offset-1 col-sm-3 control-label">내용</label>
				<div class="context">
					<textarea class="content" id="content" name="content" value="" placeholder="신고 내용을 입력해주세요." maxlength="500"
						style="width: 400px; height: 250px; margin-left: 15px;"></textarea>
				</div>
			</div>
			</br>
			<div class="form-group">

					<label for="text" class="col-sm-offset-1 col-sm-3 control-label">신고받는
						ID </label> 
						<input type="text" class="" id="user2"
						name="user2" value="${user02}" readonly style="width: 150px;" readonly />
				
					<label for="text"
						class="col-sm-offset-1 col-sm-offset-1  control-label">신고
						출처 </label>
					
					<c:if test="${reportSource== '1'}"> 
						<input type="text" class="" value="모임게시물" style="width: 150px;" disabled />
		     		 <input type="hidden" id="reportSource" name="reportSource" value="1">
		     		 <input type="hidden" name="no" id="clubPostNo" value="${report.clubPost.clubPostNo}"/>
		     		 <input type="hidden" name="clubNo" id="clubNo2" value="${report.clubPost.clubNo}"/>
					</c:if> 
					<c:if test="${reportSource=='2'}"> 
					<input type="text" class="" value="모임게시물댓글" style="width: 150px;" disabled />
		     		 <input type="hidden" id="reportSource" name="reportSource" value="2">  			
		     		 <input type="hidden" name="no" id="clubPostCommentNo" value="${report.clubPostComment.clubPostCommentNo}"/>
		     		 <input type="hidden" name="clubPostNo" id="clubPostNo2" value="${report.clubPostComment.clubPostNo}"/>
		     	     <input type="hidden" name="clubNo" id="clubNo3" value="${report.clubPostComment.clubNo}"/>
					</c:if>
					<c:if test="${reportSource=='3'}">
						<input type="text" class="" value="피드" style="width: 150px;" disabled />
		     		 <input type="hidden" id="reportSource" name="reportSource" value="3">
		     		 <input type="hidden" name="no" id="feedNo" value="${report.feed.feedNo}"/>
					</c:if>
					<c:if test="${reportSource=='4'}">
					<input type="text" class="" value="피드댓글" style="width: 150px;" disabled />
		     		 <input type="hidden" id="reportSource" name="reportSource" value="4">    	
		     		 <input type="hidden" name="no" id="feedCommentNo" value="${report.feedComment.feedCommentNo}"/>
					</c:if>
					
					
				
			</div>


			<div class="form-group">
				<label for="Reason" class="col-sm-offset-1 col-sm-3 control-label">신고
					사유</label>
				<div class="col-sm-4" id="Reason" style="width: 400px;">

					<input type="checkbox" id="욕설" name="reportReason" value="1" style="margin-left:55px">욕설
					<input type="checkbox" id="광고" name="reportReason" value="2" style="margin-left:30px">광고
					<input type="checkbox" id="기타" name="reportReason" value="4" style="margin-left:30px">기타
					<input type="checkbox" id="성적" name="reportReason" value="8" style="margin-left:30px">성적인 발언

				</div>
			</div>


			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center" style="left:30px;">
					<button type="button" class="add add5">등록</button>
					<button type="button" class="add add6">뒤로</button>
				</div>
			</div>

		</form>
	</div>
	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>