<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
	<title>q&a 등록</title>
	
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery.js"></script>
<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">

	
	<script type="text/javascript">
	
	function fncAddQandA(){
		var title = $("textarea[name='qandATitle']").val();
		var content = $("textarea[name='qandAContent']").val();
		var image = $("textarea[name='qandAImage']").val();
		var image = $("input[name='qandAImage']").val();
		
		if (title == null || title.length < 1) {
		 	Swal.fire({
                icon: 'error',
                title: '제목은 필수입니다.',
            });
				return;
			}
		if (content == null || content.length < 1) {
		 	Swal.fire({
                icon: 'error',
                title: '내용은 필수입니다.',
            });
				return;
			}

		
		$($("#addQandA")).attr("method", "POST").attr("action", "/serviceCenter/addQandA").submit();
	} //funtion  끝
	

	$(function(){
				
		$("button:contains('등록')").bind("click", function(){
			
			fncAddQandA();
		});

		$("button:contains('이전')").bind("click", function(){
			
				history.go(-1); 
		})
		
		
		
	});
	
	</script>
<style>
.table{
    box-shadow: rgb(102 51 102 / 30%) 0px 19px 38px, rgb(95 0 128 / 22%) 0px 15px 12px;
    border-radius: 20px;
    background: #c9c9ff;
    translate: -225px;
}
input[type=file]::file-selector-button {
  font-family: 'Lato', sans-serif;
  font-weight: 500;
  background-color: white;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  border: solid 2px;
  box-shadow:none !important;
  outline: none;
  box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
  border-radius: 10px;
  padding: 10px;
  color: #5F0080 !important;
  font-size: 16px !important;
  text-align: center;
  }
}
.row {
	margin-left : 0px !important;
	   display: initial !important;
	
}
textarea {
	resize: none;
}
body{
background-color: #EBEDF0 !important;
padding-left: 400px !important;
}
.qandATitle {
	width: 500px;
	height: 50px;
}

.content {
	margin-top: -30px;
}
.btn-13 {
  font-family: 'Lato', sans-serif;
  font-weight: 500;
  background-color: white;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  border: solid 2px;
  box-shadow:none !important;
  outline: none;
  box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
  border-radius: 10px;
  padding: 10px;
  color: #5F0080 !important;
  font-size: 16px !important;
  text-align: center;
}

.btn-13:hover { 
   background-color: #5F0080;
   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
   border-radius: 10px;
   color: white !important;
   font-size: 16px !important;
   text-align: center;
   border: solid 2px;
}
.btn-13:active {
  top: 2px;
}

/* 상단 툴바 start */
.nav-inner.row-content.buffer-left.buffer-right.even.clear-after{
	width: 2000px !important;
	padding-left: 152px !important;
	padding-right: 84px !important;
}
#brand{
	margin-left: 16px !important;
}
ul.reset{
	width: 874px !important;
	padding-left: 126px;
}
/* 상단 툴바 end */

/* footer css start */
body {
	position: relative;
}
#club_post_footer{
	left: 0;
}
/* footer css end */
</style>
</head>

<body>



	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	<%-- 채팅을 위한 소켓 --%>
	<script src="http://192.168.0.74:3000/socket.io/socket.io.js"></script>
	<%-- 채팅 js --%>
	<script src="/resources/javascript/chat/chat.js"></script>
	<%-- 채팅 css --%>
	<link rel="stylesheet" href="/resources/css/chat/chat.css" type="text/css" media="screen" title="no title">
	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	
	<c:if test="${ sessionScope.user != null }">
	
		<%-- chat.js에서 사용위해서 --%>
		<input type="hidden" id="session_userId" value="${ sessionScope.user.userId }">
		<input type="hidden" id="session_profileImage" value="${ sessionScope.user.profileImage }">
		<input type="hidden" id="session_nickName" value="${ sessionScope.user.nickName }">
		<%-- chat.js에서 사용위해서 --%>
		<%-- 채팅 --%>
		<jsp:include page="/chat/chat.jsp" />
		<%-- 채팅 --%>
	
	</c:if>
	
	

	<jsp:include page="/toolbar.jsp" />
	<!-- form Start /////////////////////////////////////-->
<div class="page-header" align="center" style="margin-left:0 auto; transform: translateX(-220px);">
		<h2>Q&A 등록</h2>
	</div>
	<div class="container">
	<div class ="table" style="width:880px; box-shadow: rgb(0 0 0 / 30%) 0px 19px 38px, rgb(0 0 0 / 22%) 0px 15px 12px;
	    transform: translate(115px, 0px); background-color:aliceblue; margin-top:30px; height:750px;">
		<div></div>
		<div class="page-header text-center"></div>

		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data" id="addQandA">
		
			<input type="hidden" name="userId" id="userId" value="${user.userId}">

			<div class="form-group" style="margin-left: 161px;">
				<strong>제목</strong> <label for="title"></label>
				<div class="col-sm-4">
					<textarea class="qandATitle" id="qandATitle" name="qandATitle" value=""
						maxlength="66" placeholder="제목을 입력해주세요"></textarea>


				</div>
			</div>
			<strong style="margin-left: 161px;">내용</strong>
			<div class="form-group">
				<label for="content" class="col-sm-offset-1 col-sm-3 control-label"></label>
				<div class="col-sm-4">
					<textarea class="content" id="qandAContent" name="qandAContent" value=""
						placeholder="내용을 입력해주세요." maxlength="500"
						style="width: 500px; height: 500px; margin-left: 161px;"></textarea>
				</div>
			</div>

			<div  style= "display:flex; height: 30px; margin-left: 161px;">
				<input multiple="multiple" type="file" name="image" id="file" class="ct_input_g" style="width: 200px; height: 65px " />
				<input type="radio" class="form-control" id="qandAOpenCondition" name="qandAOpenCondition" value ="0" style ="margin-left: 60px; width:auto; height:auto;" checked>나만 보기
			 	<input type="radio" class="form-control" id="qandAOpenCondition" name="qandAOpenCondition" value ="1" style ="margin-left: 20px; width:auto; height:auto;">전체 보기
				</div></form> 
			
			<div id="helpBlock" class="help-block"> 
				<strong class="text-danger" style="margin-left: 161px; display: flex; margin-top: 30px;">사진은 2장까지 가능합니다.</strong>
			</div>
			
			</div>

			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button class="custom-btn btn-13"
						style="transform: translate(153px, 0px);">등록</button>
					<button class="custom-btn btn-13"
						style="transform: translate(153px, 0px);">이전</button>
				</div>
			</div>
			 
			
							
			


	</div>
			
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br>

	<!-- footer start -->
	<jsp:include page="/footer.jsp" />
	<!-- footer end -->
	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>