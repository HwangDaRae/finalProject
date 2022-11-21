<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="The Page Description">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery.js"></script>
<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<title>신고내용 조회</title>
</head>


<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	$(function() {


		$("button:contains('이전')").bind("click", function() {
			if(${user.role=='1'}){
			self.location = "/serviceCenter/getReportList";
			}else if (${user.role=='0'}){
			$("form").attr("method","post").attr("action","/serviceCenter/getReportList/${sessionScope.user.userId}").submit();	
			}
		})

		$("button:contains('처리')").bind("click", function() {
			
			Swal.fire({
		          title: '신고 처리',
		          html: '<h3>욕설 <input type="checkbox" id="욕설" name="reportReason2" value="1" /></h3><p/>' +
		         		 '<h3>광고 <input type="checkbox" id="광고"  name="reportReason2" value="2"/></h3><p/>' +
		         		 '<h3>기타 <input type="checkbox" id="기타" name="reportReason2" value="4" /></h3><p/>' +
		                '<h3>성적인 발언 <input type="checkbox" id="성적" name="reportReason2" value="8" /></h3>',
		          showCancelButton: true,
		          cancelButtonColor: '#d33',
		          confirmButtonText: '처리하기',
		      
		        }).then((result) => {
		        	if(result.isConfirmed){
		        		var sum = 0;
		        		var length = $("input:checkbox[name=reportReason2]:checked").length;
		        		var checkbox = $("input:checkbox[name=reportReason2]:checked").val();
		        		
		        		for(var i =0 ; i<length; i++){
		        			
		        			var sum2 = parseInt($($("input:checkbox[name=reportReason2]:checked")[i]).val());
		        			
		        			sum += parseInt(sum2);			
		        			
		        		} //for문 끝
		        	
		        		$.ajax({
		        			url  : "/serviceCenterRest/json/updateReport",
		        			contentType: 'application/json',
		        			method : "POST",
		        			dataType: "json",
		        			data : JSON.stringify ({
		        				"title":$("#title").val(),
		        				"content":$("#content").val(),
		        				"user1":$("#user1").val(),
		        				"user2":$("#user2").val(),
		        				"reportSource":$("#reportSource").val(),
		        				"reportReason": sum,
		        				"type": $("#type").val(),
								"no" : $("#no").val(),
		        					
		        			 success: function(){
		        				
		        			 }<!-- success 끝 -->
		        			}), <!-- data -->
		        				
		        			}) <!-- ajax (updateReport) -->
		        			
		        			
		        		
		        	

		        		Swal.fire('신고처리 되었습니다.','','success');<!--if문 -->
		        	}else if(result.isDismissed){
		        	
		        	}
		        })<!-- result 골랐을 때 -->
			
			
		<%--	self.location = "/serviceCenter/updateReport?no="+$('#no').val();   --%>
	

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
body{
background-color: #EBEDF0 !important;
}
textarea {
	resize: none;
	border: none;
    outline: none;
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

.input{
	width:auto;
	height:auto;
	margin-right: 70px;
}

</style>

<!-- footer css -->
<style type="text/css">
body{
	position: relative;
}
#club_post_footer{
	left: 0;
}
</style>
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
<div class="page-header" align="center" style="margin-left: auto;">
  <h2>신고 상세보기</h2>
</div>

		<div class="container" style="margin-top: 37px;">
			<!--  table Start /////////////////////////////////////-->
			<table style="width:880px; box-shadow: rgb(0 0 0 / 30%) 0px 19px 38px, rgb(0 0 0 / 22%) 0px 15px 12px; background-color:aliceblue;   margin-left: 122px;">
				<div class="row2">
				<thead>
				</thead>
				</div>
				</tbody>
					 <tr class = "body" id ="body" >
						<th style="text-align-last: center;"></th>
						<td align="left" style="display:flex; height: 50px;"><strong>${report.no}번 신고</strong>
						<input type="hidden" name="no" id="no" value="${report.no}">
						</td>
					</tr>
					<tr >
						<th style="text-align-last: center;">제목</th>
						<td style="display: flex;  min-height: 40px; max-height:80px; width: 500px; background-color:white; text-align : center; 
						background: white;  border: 1px solid white;  border-radius: 15px;  box-shadow: 0 0 10px rgb(0 0 0 / 20%);">				
						${report.title}
						<input type="hidden" id="title" name="title" value="${report.title}">
						</td> 
					</tr>
					<tr>
						<th></th>
						<td align="left" name ="reportRegDate" id="reportRegDate" style="display: flex; height: 40px;"><strong>${report.regDate }</strong></td>
					</tr>
					<tr >
						<th style="text-align-last: center;">내용</th>
						<td style="display: flex; min-height : 150px; max-height: 800px; width: 500px; background-color:white;    margin-bottom: 30px;
						background: white;  border: 1px solid white;  border-radius: 15px;  box-shadow: 0 0 10px rgb(0 0 0 / 20%);">
						<pre>${report.content}</pre>
						<input type="hidden" id="content" name="content" value="${report.content}">
						</td>
					</tr>
					<tr>
					 	<th style="text-align-last: center;"> 신고 출처</th>
					 	<td align="left" name ="reportRegDate" id="reportRegDate" style="display: flex; height: 70px;">
					 		<c:if test="${report.reportSource== '1'}"> 
					 		<input type="text" class="" value="모임게시물" style="width: 150px;" disabled />
		     				<input type="hidden" id="reportSource" name="reportSource" value="1">
		     				 <a href="/clubPost/getClubPost?clubNo=${report.club.clubNo}&clubPostNo=${report.clubPost.clubPostNo}" 
		     				 style="transform: translate(-150px, 30px); color: red;"> 
		     						${report.clubPost.clubPostNo} 번 </a>	
		     						
		     						
		     				</c:if>
		     				<c:if test="${report.reportSource=='2'}"> 
							<input type="text" class="" value="모임게시물댓글" style="width: 150px;" disabled />
		     		 		<input type="hidden" id="reportSource" name="reportSource" value="2">
		     		 	<a href="/clubPost/getClubPost?clubNo=${report.club.clubNo}&clubPostNo=${report.clubPost.clubPostNo}" 
		     				 style="transform: translate(-150px, 30px); color: red;"> 
		     						${report.clubPost.clubPostNo}번 </a>
		     		 		</c:if>
		     		 		<c:if test="${report.reportSource=='3'}">
							<input type="text" class="" value="피드" style="width: 150px;" disabled />
		     				 <input type="hidden" id="reportSource" name="reportSource" value="3">
		     				 
		     				 <a href="/feed/getFeed?feedNo=${report.feed.feedNo}" style="transform: translate(-150px, 30px);color: red;"> 
		     				 ${report.feed.feedNo}번 </a>
		     				</c:if>
		     				<c:if test="${report.reportSource=='4'}">
							<input type="text" class="" value="피드댓글" style="width: 150px;" disabled />
		     				 <input type="hidden" id="reportSource" name="reportSource" value="4">
		     				  <a href="/feed/getFeed?feedNo= ${report.feedComment.feedNo}" style="transform: translate(-150px, 30px); color: red;"> 
		     				 ${report.feedComment.feedNo}번 </a>
		     				 </c:if>
		     			</td>
		     			<td style="display:flex; margin-left :200px; margin-top : -70px;"><strong>신고받는 닉네임 &nbsp;&nbsp;</strong>
		     			 <input type="text" class="" value="${report.user2.nickName}" style="width:auto; height:35px; display:inline;" disabled />
		     			 <input type="hidden" id="user2" name="user2.userId" value="${report.user2.userId}"/>
		     			  <input type="hidden" id="user1" name="user2.userId" value="${report.user1.userId}"/>
		     			</td>
					</tr>
					<tr >
						<th style="text-align-last: center;">신고 사유</th>
						<td style="display:flex;">
						<c:if test="${report.reportReason == '1'|| report.reportReason == '3' || report.reportReason == '5' || report.reportReason =='7'|| report.reportReason =='9'
		 				   || report.reportReason =='11'|| report.reportReason =='13'|| report.reportReason =='15'}">
		    			  욕설<input type="checkbox" class="input" id="reportReason" name="reportReason" value="1" checked> 
		    			</c:if>
		    			 <c:if test="${report.reportReason == '2'|| report.reportReason == '3' || report.reportReason =='6'|| report.reportReason =='7'|| report.reportReason =='10'
		     			|| report.reportReason =='14'|| report.reportReason =='15'}">
		    				  광고<input type="checkbox" class="input" id="reportReason" name="reportReason" value="2" checked>
		    			</c:if>
		    				<c:if test="${report.reportReason == '4'|| report.reportReason == '5' || report.reportReason == '6' || report.reportReason =='7'|| report.reportReason == '12'
		    			|| report.reportReason =='13'|| report.reportReason =='14'|| report.reportReason =='15'}">
		   				   기타<input type="checkbox" class="input" id="reportReason" name="reportReason" value="4" checked>
		   				  </c:if>
		   				 <c:if test="${report.reportReason == '8'|| report.reportReason == '9' || report.reportReason == '10' || report.reportReason == '11' || report.reportReason == '12'
		    				 || report.reportReason == '11' || report.reportReason == '14' || report.reportReason == '15' }">
		    			  성적인 발언<input type="checkbox" class="input" id="reportReason" name="reportReason" value="8" checked>
		   				</c:if>
						</td>
						
					</tr>
					<tr>
						<th style="text-align-last: center;"></th>
					</tr>
			</table>
			<!--  table End /////////////////////////////////////-->
	

		
						
									<div> 
									<c:if test="${user.role=='1'}">
 									 <button class="custom-btn btn-13" style= "transform: translate(500px,0px); ">
									   처리</button> 

									</c:if>
									<button class="custom-btn btn-13" style= "transform: translate(500px, 0px); ">
									이전</button>
									</div>
				
			</div><form></form>
			
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br>

	<!-- footer start -->
	<jsp:include page="/footer.jsp" />
	<!-- footer end -->


</body>

</html>