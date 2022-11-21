<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<title>모임일정 참여자 리스트</title>
	<meta charset="UTF-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	  <!-- jQuery UI toolTip 사용 JS-->
 	 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	 
 	 <!-- alert -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
 	 
 	 
 	 <style>
 	 
	.club-wrap {
			width : 100%;
			margin: 10px auto;
			position: relative;
	}
	
	.club-wrap img {
			width: 100%;
			vertical-align: middle;
			filter: brightness(1.1);
	}
	
	.club-text {
			
			position: absolute;
			top: 50%;
			left: 50%;
			width: 100%;
			transform: translate(-50%, -50%);
			font-size: 20px;
			text-align: center;
			
	}
	
	.plain.button.red.cancel{
	   background-color: white;
	   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	   border-radius: 10px;
	   margin: 1rem;
	   padding: 0px;
	   width: 65px !important;
	   color: #5F0080 !important;
	   font-size: 16px !important;
	   text-align: center;
	   border: solid 2px;
	}
	
	.plain.button.red.cancel:hover{
	   background-color: #5F0080;
	   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	   border-radius: 10px;
	   margin: 1rem;
	   padding: 0px;
	   width: 65px !important;
	   color: white !important;
	   font-size: 16px !important;
	}
	
	main {
		background-color: #f0f2f5 !important;
	}
	
	#main {
		background-color: #f0f2f5 !important;
		padding-bottom: 0% !important;
		margin-right: 0px !important;
    	margin-left: 0px;
	}
	
	.h2-color {
		color: yellow;
	}
	
	.p-color {
		color: yellow;
	}
	
	.buffer-bottom {
		padding-bottom: 0px !important;
	}
	
	</style>

	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="/resources/javascript/plugins.js"></script>
	<script src="/resources/javascript/beetle.js"></script>
	<script type="text/javascript">
	
	

	$(function() {
		
		$(document).on("click","#deleteParticipant", function() {

			Swal.fire({
				title: '일정 참여를 취소하시겠습니까?' ,
				text: "취소 후에도 다시 신청이 가능합니다.",
				icon: 'warning' ,
				showCancelButton: true,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '삭제',
				cancelButtonText: '취소' ,
			}).then((result) => {
				if (result.value) {	
			
					$("form").attr("method", "POST").attr("action", "/club/deleteMeetingMember").submit();
			
				}
			})
		})

		$("#cancel").bind("click", function() {
			history.go(-1);
		});
	});
	
	//홈버튼
	$(function() {
		$(".homeBtn").on("click", function() {
			self.location="/club/getClub?clubNo=${clubNo}"
		});
	});
	
	$(function() {
		$(".clubPostBtn").on("click", function() {
			self.location="/clubPost/getClubPostList"
		});
	});
	
	$(function() {
		$(".clubMemberBtn").on("click", function() {
			self.location="/club/getClubMemberList"
		});
	});
	
	$(function() {
		$(".clubChatBtn").on("click", function() {
			self.location="/clubPost/chatRoomList?rommId=${club.roomId}&clubTitle=${club.clubTitle}&clubImage=${club.clubImage}";
		});
	});
	
	
	
	
	</script>	
	
</head>

<body style="position: relative; height: 2070px; padding-bottom: 350px;">
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->


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
	
	
	
	<div class="container" style="background-color: #f0f2f5 !important;">
				
		<div style="height: 712px; width: 1135px; margin-bottom: 40px;">
			<img src="/resources/image/uploadFiles/${club.clubImage}" style="width: 100%; height: 100%;">
		</div>
	
		<div class="homeBtn_group" style="margin-top: 100px;">
						<button type="button" class="homeBtn" style="margin-top: 17px;">
							<span class="glyphicon glyphicon-home" aria-hidden="true"></span> 
						</button>
						
						<button type="button" class="clubPostBtn">
							<span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
						</button>
						
						<button type="button" class="clubMemberBtn">
							<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
						</button>
						
						<button type="button" class="live">
							 <span class="glyphicon glyphicon-facetime-video" aria-hidden="true"></span> 
						</button>
				</div>
				
		<div class="form_txtInput" style="margin-top: 100px;">
			<h2 class="sub_tit_txt">일정 참여자</h2>
		</div>
			<!-- 중간 개별영역 -->
			<div id="main" class="row">
			
				<div class="listForm" style="margin-top: 20px; box-shadow:rgb(0 0 0 / 30%) 0px 7px 9px, rgb(0 0 0 / 22%) 0px 4px 5px; border-radius: 10px;" >
			
					<div class="row-content buffer-left buffer-right buffer-bottom" >
	
				  <form class="form-horizontal" style="margin-top:150px;">  
			      <!--  table Start /////////////////////////////////////-->
			      <table class="table table-hover table-striped" >
			      
			        <thead>
			          <tr>
			          	<th align="left">회원 프로필사진</th>
			            <th align="left" >회원 아이디</th>
			            <th align="left">회원 닉네임</th>
			          </tr>
			        </thead>
		       
		<tbody>
		<tr>
		  <c:forEach var="i" items="${meetingMemberList}">
		  <input type="hidden" name="participantNo" value="${i.participantNo}">
			<tr>
			<td align="left">
			<a href="/myHome/getYourHome?userId=${i.user.userId}"><img src="/resources/image/uploadFiles/${i.user.profileImage}" width="100" height="100"></a>
			</td>
			  <td align="left">${i.user.userId}</td>
			  <td align="left">${i.user.nickName}</td>
			  
			  
			</tr>
          </c:forEach>
        </tr>
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
		<div class="form-group">
			<div class="col-sm-offset-6  col-sm-6 text-center" style="margin-left: 30%;">
				
					<c:if test="${ fn:length(meetingMemberList) > 0 }">
						<c:forEach var="k" begin="0" end="${ fn:length(meetingMemberList) - 1}" step="1">
							<c:if test="${ fn:trim(meetingMemberList[k].user.userId) == fn:trim(sessionScope.user.userId)}">
								<button type="button" class="plain button red cancel" id="deleteParticipant">신청취소</button>
							</c:if>
					 	</c:forEach>
				 	</c:if>		

				
					
					<button type="button" class="plain button red cancel" id="cancel">닫&nbsp;기</button>					
		    </div>
		</div>		
	  
	  </form>
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	</div>
 	</div>
 	</div>
	<!-- </div> -->
	<!-- </main> -->
		
		<!-- footer start -->
		<jsp:include page="/footer.jsp" />
		<!-- footer end -->
		
</body>
	<style>
		#club_post_footer {
			margin-top: 100px !important;
			position: relative !important;
		}
	</style>

</html>