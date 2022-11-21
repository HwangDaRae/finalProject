<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>

<html lang="ko">

<head>
<title>공지사항 조회</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery.js"></script>
<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<script type="text/javascript"> <%-- 자바스크립트 시작 --%>
	$(function() {

		$("button:contains('이전')").bind("click", function() {
			self.location = "/serviceCenter/getNoticeList";
		})

		$("button:contains('수정')").bind("click", function() {
			self.location = "/serviceCenter/updateNotice?noticeNo="+$('#noticeNo').val();
		})

		$("button:contains('삭제')").bind("click", function() {
			 Swal.fire({
		          title: '정말로 삭제하시겠습니까?',
		          text: "다시 되돌릴 수 없습니다. 신중하세요.",
		          icon: 'warning',
		          showCancelButton: true,
		          confirmButtonColor: '#3085d6',
		          cancelButtonColor: '#d33',
		          confirmButtonText: '삭제',
		          cancelButtonText: '취소'
		      }).then((result) => {
		          if (result.isConfirmed) {
		        	  self.location = "../serviceCenter/deleteNotice?noticeNo="+$('#noticeNo').val(); 
		          }
		      })	
			
			
		 	
		})

	});
</script>
<style> 
table{
    box-shadow: rgb(102 51 102 / 30%) 0px 19px 38px, rgb(95 0 128 / 22%) 0px 15px 12px;
    border-radius: 20px;
    background: #c9c9ff;
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

</style>

<!-- footer css -->
<style type="text/css">
body {
	position: relative;
}
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
	
	
	
<%-- 테이블 시작 --%>
<jsp:include page="/toolbar.jsp" />
<div class="page-header" align="center" style="margin-left: auto; margin-bottom: 20px; margin-top: 80px;">
  <h2>공지사항 상세보기</h2>
</div>
	
		<div class="container" style=" transform: translate(92px, 10px);">
	
	
	
			<!--  table Start /////////////////////////////////////-->
			<table style="width:880px; box-shadow: rgb(0 0 0 / 30%) 0px 19px 38px, rgb(0 0 0 / 22%) 0px 15px 12px; background-color:aliceblue;">
				<div class="row2">
				<thead>
				</thead>
				</div>
				</tbody>
					<tr>
						<th>
						<input type="hidden" name="noticeNo" id="noticeNo" value="${notice.noticeNo}">
						<input type="hidden" id="noticeTitle" name="noticeTitle" value="${notice.noticeTitle}">
						</th>
						
						<td align="left" name ="noticeRegDate" id="noticeRegDate" style="transform: translate(0px, -9px);display: flex; height: 40px;"><strong>${notice.noticeRegDate }</strong>
						<strong style="margin-left: 468px;">${notice.userId.nickName}</strong></td>
						
					</tr>
					<tr >
						<th style="text-align-last: center;">내용</th>
						<td style="display: flex; min-height : 150px; max-height: 800px; width: 700px; background-color:white; margin-bottom: 30px;
						background: white;  border: 1px solid white;  border-radius: 15px;  box-shadow: 0 0 10px rgb(0 0 0 / 20%);">
						<pre>${notice.noticeContent}</pre>
						<input type="hidden" id="noticeContent" name="noticeContent" value="${notice.noticeContent}">
						</td>
					</tr>
					<tr >
						<th style="text-align-last: center;">첨부파일</th>
						<c:if test="${notice.noticeImage1 == null && notice.noticeImage2 ==null }">
							<td>첨부파일 없음</td>
						</c:if>
						<td><c:if test="${notice.noticeImage1 != null }">
						<img src="/resources/image/uploadFiles/${notice.noticeImage1}" 
						style="vertical-align: sub; display: inline-block; width:250px; height:250px; border: 10px solid white; border-radius: 15px;
						cursor:pointer;    margin-left: 40px;" onclick="window.open('/resources/image/uploadFiles/${notice.noticeImage1}','asdfo8or','scrollbars=yes,width=417,height=385,top=10,left=20');">
						
						</c:if>
						<c:if test="${notice.noticeImage2 != null }">
						<img src="/resources/image/uploadFiles/${notice.noticeImage2}" 
						style="vertical-align: sub; display: inline-block; width:250px; height:250px; margin-left: 70px; border: 10px solid white;border-radius: 15px;
						cursor:pointer;" onclick="window.open('/resources/image/uploadFiles/${notice.noticeImage2}','asdfo8or','scrollbars=yes,width=417,height=385,top=10,left=20');">
						
						</c:if>
						</td>
						
						
					</tr>
					<tr >
						<th style="text-align-last: center;"></th>
					</tr>
			</table>
			<!--  table End /////////////////////////////////////-->
	

		
						
									<div> 
									<c:if test="${user.role=='1'}">
 									 <button class="custom-btn btn-13" style= "transform: translate(370px,0px); ">
									   수정</button> 
									 <button class="custom-btn btn-13" style= "transform: translate(370px,0px); ">
									   삭제</button> 
									</c:if>
									<button class="custom-btn btn-13" style= "transform: translate(370px, 0px); ">
									이전</button>
									</div>
				
			</div>
			
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br>

			<!-- footer start -->
			<jsp:include page="/footer.jsp" />
			<!-- footer end -->


</body>

</html>