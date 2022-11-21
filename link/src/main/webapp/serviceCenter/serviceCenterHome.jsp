<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<html>

<head>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="description" content="The Page Description">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



<title>고객센터</title>


<style>
.modal {
	margin-top: 100px !important;
}

body{
background-color: whitesmoke !important;
}
.row {
display: initial !important;
margin-left: 0px !important;
}

.card{
border-color: BD76FF;
}

.button1  {
   background-color: white;
   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
   border-radius: 10px;
   margin: 1rem;
   padding: 10px;
   width: 130px !important;
   color: #5F0080 !important;
   font-size: 16px !important;
   text-align: center;
   border: solid 2px;
}

.button3{
   background-color: white;
   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
   border-radius: 10px;
   width: 92px !important;
   color: #5F0080 !important;
   font-size: 16px !important;
   text-align: center;
    border: solid 2px;
     padding: 10px;
   
}
.button4{
   background-color: white;
   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
   border-radius: 10px;
   margin: 1rem;
   padding: 10px;
   width: 92px !important;
   color: #5F0080 !important;
   font-size: 16px !important;
   text-align: center;
   border: solid 2px;
}

.button1:hover{
   background-color: #5F0080;
   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
   border-radius: 10px;
   margin: 1rem;
   width: 130px !important;
   color: white !important;
   font-size: 16px !important;
   text-align: center;
   border: solid 2px;
}
.button3:hover{
   background-color: #5F0080;
   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
   border-radius: 10px;

   width: 92px !important;
   color: white !important;
   font-size: 16px !important;
   text-align: center;
   border: solid 2px;

}
.button4:hover{
   background-color: #5F0080;
   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
   border-radius: 10px;
   margin: 1rem;
    width: 92px !important;
   color: white !important;
   font-size: 16px !important;
   text-align: center;
   border: solid 2px;
}

div {
	clear: initial !important;
}

.thumbnail>img {
	height: 220px !important;
}

div.caption {
	width: 350px !important;
}
</style>


<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script type="text/javascript">
function fncGetReport(){
	if(${user.role==null}){
		 	Swal.fire({
                icon: 'error',
                title: '로그인 후 가능합니다.',
            });
				return;
			
	}
	$("form").attr("method","post").attr("action","/serviceCenter/getReportList/${sessionScope.user.userId}").submit();
}
function fncGetQandA(){
	if(${user.role==null}){
	 	Swal.fire({
            icon: 'error',
            title: '로그인 후 가능합니다.',
        });
			return;
		
	}
	$("form").attr("method","post").attr("action","/serviceCenter/getQandAList/${sessionScope.user.userId}").submit();
}
$(function() {
	$("button:contains('공지사항 보기')").bind("click", function() {
		location.href = "/serviceCenter/getNoticeList";
	});

	$("button:contains('Q&A보기')").bind("click", function() {
		location.href = "/serviceCenter/getQandAList";
		
	});

	$("button:contains('신고 목록')").bind("click", function() {
		location.href = "/serviceCenter/getReportList";
	});
	
	$("button:contains('관리자 질문')").bind("click", function() {
		
		location.href = "/serviceCenter/getQandAList";
	});
	
});	
</script>

<style type="text/css">
/* footer css */
#service_content_body{
	/* background-color: red; */
	height: 900px;
	position: relative;
}
#club_post_footer{
	padding-top: 90px !important;
}
</style>

</head>


	<jsp:include page="/toolbar.jsp" />


<body style="overflow-x: hidden;">



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
	
	
	
	<%--검은색 화면 --%>
	<%-- --%>
	<div style="text-align: center; margin-top: 100px;">
	<h1 >고  객  센  터</h1>
	<h4>
		고객센터를 통해 궁금증을 해결하세요
	<h4>
	</div>	

	<div id="service_content_body">
				
		<div class="container">
			<div class="row">
			
		  		<div class="col-sm-6 col-md-4">
			   		<div class="thumbnail">
			      		<img src="/resources/image/uploadFiles/공지사항.png" class="image1" height="220px !important"/>
			      		<div class="caption">
			        		<h3>공지사항</h3>
			        		<p>사이트 내 공지사항을<br/> 조회 할 수 있습니다.</p>
			        		<button type="submit" class="button1 button1">공지사항 보기</button>
			      		</div>
			    	</div>
		  		</div>
			
		  		<div class="col-sm-6 col-md-4">
			   		<div class="thumbnail">
			      		<img src="/resources/image/uploadFiles/q&a.jpg" class="image2" height="220px !important" />
			      		<div class="caption">
			        		<h3>Q&A</h3>
			        		<p>사이트 내에 궁금하신 점이나<br/> 의견을 남길 수 있습니다.</p>
			        		<button type="submit" class="button1 button2">Q&A보기</button>
			      		</div>
			    	</div>
		  		</div>
			
		  		<div class="col-sm-6 col-md-4">
			   		<div class="thumbnail">
			      		<img src="/resources/image/uploadFiles/물음표.jpg" class="image3" height="220px !important" />
			      		<div class="caption">
			        		<h3>내 신고 및 Q&A 보기</h3>
			        		<p>내 신고 및 Q&A 내역을 <br/>확인할 수 있습니다.</p>
			        		<c:if test="${ user.role == '0' || user.role== null }">
			              	<form>
				              	<input type="button" class="button3" value="내 신고보기" onClick="fncGetReport()" style="transform:translate(15px,0px);">
								<input type="button" class="button4" value="내 질문보기" onClick="fncGetQandA()" style=" transform: translate(27px, 0px);" >
							</form>
							</c:if>
							<c:if test="${ user.role == '1'  }">
								<button class="button3" style="transform: translate(15px, 0px);">신고 목록</button>
								<button class="button4" style="transform: translate(40px, 0px);">관리자 질문</button>
							</c:if>
			      		</div>
			    	</div>
		  		</div>
			
			</div>
			
		</div>

		<!-- footer start -->
		<jsp:include page="/footer.jsp" />
		<!-- footer end -->
		
	</div>
  </body>
</html>


