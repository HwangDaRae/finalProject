<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<title>모임원리스트</title>
	<meta charset="UTF-8">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
		
	 <!-- jQuery UI toolTip 사용 CSS-->
	 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	  <!-- jQuery UI toolTip 사용 JS-->
 	 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	 
 	 <!-- alert -->
  	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
 	 
 	 <style>
	body {
		padding-top : 70px;
	}
	
	.plain1.button.red.cancel{
	   background-color: white;
	   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	   border-radius: 10px;
	   margin: 1rem;
	   padding: 10px !important;
	   width: 65px !important;
	   color: #5F0080 !important;
	   font-size: 16px !important;
	   text-align: center;
	   border: solid 2px;
	}
	
	.plain1.button.red.cancel:hover{
	   background-color: #5F0080;
	   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	   border-radius: 10px;
	   margin: 1rem;
	   padding: 10px;
	   width: 65px !important;
	   color: white !important;
	   font-size: 16px !important;
	}   
	
	td {
		text-align: center;
		font-size: medium;
		vertical-align: middle;
		background-color: #f0f2f5 !important;
	}
	
	#main {
		background-color: #EBEDF0 !important;
	}
	
	main {
		background-color: #EBEDF0 !important;
	}
	
	.darkover {
	    position: static;
	    top: 0;
	    right: 0;
	    bottom: 0;
	    left: 0;
	    background: rgba(0,0,0,0.35);
	}
	
	</style>
	
	<!-- ?? -->
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="/resources/javascript/plugins.js"></script>
	<script src="/resources/javascript/beetle.js"></script>
	<script type="text/javascript">
	
	function fncUpdateMemberRole() {
		
		$("form").attr("method", "POST").attr("action", "/club/updateMemberRole")
		alert("모임원 수정 화면")
		.submit();
	}
	
	function refreshMemList(){
		location.reload();
	}
	
	//닉네임, 프로필사진 클릭시 해당 유저의 마이홈피로 이동
	function getMyHomeGo(userId){
		location.href = "/myHome/getYourHome?userId="+userId;
	}

	
	//추방 그냥 컨트롤러
	 $(function() {
		$("#banMember").on("click", function() {
			//alert("모임원을 추방합니다 : ");
			
			$("form").attr("method", "POST").attr("action", "/club/deleteClubMember").submit();
		 });


			//추방 그냥 컨트롤러	
			
		$(function() {	
			$(document).on("click", "#banMember", function(){
			var clubUserNo = $(this).val();
			$.ajax("/clubRest/json/deleteClubMember",
					{
						method : "POST" ,
						data : JSON.stringify({
							clubUserNo : clubUserNo
						}) ,
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						dataType : "json",
						success : function(JSONData, status){
							alert(status);
						} // end of success  
					}); //end of ajax
					refreshMemList();
			}); //모임원 추방 
	 	});
	 
	 
			
			$(function() {
				
				$(".updateApprovalConditionBtn").on("click", function() {
					//alert("모임원을 승인합니다 : ");
					
					var totalClubMemberCount = $("input[name='totalClubMemberCount']").val();
					console.log(totalClubMemberCount)
					var clubMaxMember = $("input[name='clubMaxMember']").val();
					console.log(clubMaxMember)
					
				//	alert(totalClubMemberCount);
				//	alert(clubMaxMember);
					
					if(parseInt(totalClubMemberCount) >= parseInt(clubMaxMember)) {
							
						Swal.fire({
							title: '모임원 한도 초과입니다.' ,
							text: "결제를 통해 모임원 한도를 늘릴 수 있습니다." ,
							icon: 'warning',
							schowCancelButton: false ,
							confirmButtonColor: '#3085d6',
							cancelButtonColor: '#d33',
							confirmButtonText: '확인',
						}).then((result) => {
							if(result.value){
							
								self.location="/clubPost/addPayView?clubNo=${clubNo}"
							}
						})
						
						} /* else{
							
							$("form").attr("method", "POST").attr("action", "/club/updateApprovalCondition").submit();							
						} */
					});
					
			});
				
			$(document).on("click", ".updateApprovalConditionBtn", function(){
				//alert('승인');
				var clubUserNo = $(this).val();
				var approvalCondition = $(this).attr('approvalCondition');
				var userId = $(this).attr('state');
 				//alert(userId);
 				//alert(clubUserNo);
				//alert(approvalCondition);
				$.ajax("/clubRest/json/updateApprovalCondition",
						{
							method : "POST" ,
							data : JSON.stringify({
								clubUserNo : clubUserNo ,
								approvalCondition : approvalCondition
							}) ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							dataType : "json",
							success : function(JSONData, status) {
							//	alert(status);
								/* swal.fire('승인이 완료되었습니다');
								$($(this).parent().parent().children())[6].text("승인완료"); */
							}, // end of success
							error : function() {
								swal.fire('승인이 완료되었습니다');
								//console.log("///"+$("button[state='"+userId+"']").text());
								$($("button[state='"+userId+"']").parent().parent().children()[6]).text("승인완료");
							//	console.log("====="+$($("button[state='"+userId+"']").parent().parent().children()[6]).text());
							}
						}); // end of ajax
					//	refreshMemList();
				}); // end of 승인
			});

	
	
	$(function() {

		$("#cancel").bind("click", function() {
			history.go(-1);
		});
	});
	
	var openWin;
	function popup() {
		var url = "/club/updateMemberRoleView.jsp";
		var name = "updateMemberRoleView";
		var option = "width = 800, height = 300, top = 100, left = 200, location = no"
		openWin= window.open(url, name, option);
	}

	$(function() {
		$("#updateMemberRole").on("click", function() {
			popup();
		});
		
		$("button:contains('전달')").on("click", function() {
			openWin.document.getElementById("clubUserNo").value = $(this).val();
			openWin.document.getElementById("memberRole").value = $(this).attr("memberRole") ;
			openWin.document.getElementById("userId").value = $(this).attr("userId");
		});
	});
	
	
	//홈버튼
	$(function() {
		$(".homeBtn").on("click", function() {
			self.location="/club/getClub?clubNo="+${clubNo};
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
	

	</script>
	
	<style type="text/css">
	.row-content .buffer-left .buffer-right .buffer-bottom{
		margin-top: 130px !important;
		padding-bottom: 20% !important;
	}
	.club-image{
		margin-left: 130px !important;
		margin-top: -45px !important;
		margin-bottom: 35px !important;
	}
	.form_txtInput{
		margin-top: 50px !important;
	}
	.listForm{
		margin-top: 35px !important;
		box-shadow:rgb(0 0 0 / 30%) 0px 7px 9px, rgb(0 0 0 / 22%) 0px 4px 5px !important;
		border-radius: 10px !important;
		/* background-color: white; */
	}
	.row-content.buffer-left.buffer-right.buffer-bottom{
		/* background-color: green !important; */
		margin-left: 405px !important;
		margin-right: 358px !important;
	}
	.club-image{
		padding-left: 8px !important;
		width: 1147px !important;
    	height: 550px !important;
		/* background-color: yellow; */
	}
	.row-content.buffer-left.buffer-right.buffer-bottom > div:first-child{
		margin-left: -290px;
	}
	#clubImage{
	    margin-top: 57px;
	    width: 1140px !important;
	    height: 550px;
	}
	.homeBtn_group{
		width: 500px;
  	  	margin-left: 138px;
  	  	margin-top: 200px;
	}
	.container{
		margin-left: 123px;
	}
	#btn_group{
		margin-top: 25px;
		display: flex;
	}
	.plain1.button.red.cancel{
		padding: 0px;
	}
	tbody{
		background-color: white !important;
	}
	.nav-inner.row-content.buffer-left.buffer-right.even.clear-after{
		margin-left: 347px !important;
	}
	</style>
</head>

	
	<body class="blog masonry-style" style="background: whitesmoke;">



	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	<%-- 채팅을 위한 소켓 --%>
	<script src="http://192.168.0.74:3000/socket.io/socket.io.js"></script>
	<%-- 채팅 js --%>
	<script src="/resources/javascript/chat/chat.js"></script>
	<%-- 채팅 css --%>
	<link rel="stylesheet" href="/resources/css/chat/chat.css" type="text/css" media="screen" title="no title">
	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	
	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	
	<jsp:include page="/toolbar.jsp" />
	
		
			<div id="main" class="row"><!-- 중간 개별영역 -->
			
			
			
				<%-- chat.js에서 사용위해서 --%>
				<input type="hidden" id="session_userId" value="${ sessionScope.user.userId }">
				<input type="hidden" id="session_profileImage" value="${ sessionScope.user.profileImage }">
				<input type="hidden" id="session_nickName" value="${ sessionScope.user.nickName }">
				<%-- chat.js에서 사용위해서 --%>
				<%-- 채팅 --%>
				<jsp:include page="/chat/chat.jsp" />
				<%-- 채팅 --%>
				
				
			
				<div class="row-content buffer-left buffer-right buffer-bottom">
				
					<!-- 이미지랑 합친 div -->
					<div>
					
						<!-- 모임 대표이미지 -->				
						<div class="club-image" style="height: 700px;">
							<a href="/club/getClub?clubNo=${clubNo}">
								<img src="/resources/image/uploadFiles/${club.clubImage}" style="height: 700px; name="file" id="clubImage">
							</a>
						</div>
					
					
					
						<div class="homeBtn_group">
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
		

						<div class="container">
						
							<div class="form_txtInput" style="display: flex;">
								<h2 class="sub_tit_txt" style="width: 900px;">${club.clubTitle}의 모임원 </h2>
								
								<!-- table 위쪽 검색 Start /////////////////////////////////////-->
								<div class="row" style="width: 250px;">
									<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
									<!-- <input type="hidden" id="currentPage" name="currentPage" value=""/> -->
							
									<div class="form-group" id="btn_group">
							
										<!--  <div class="col-sm-offset-4  col-sm-4 text-center"> -->
								
										<c:if test="${ fn:trim(sessionScope.user.userId) == fn:trim(club.user.userId) }">
										<button type="button" class="plain1 button red cancel" id="updateMemberRole">직책수정</button>
										</c:if>
										<button type="button" class="plain1 button red cancel" id="cancel">이&nbsp;전</button>
									</div>
								</div>
								<!-- table 위쪽 검색 Start /////////////////////////////////////-->
						
								<input type="hidden" id="totalClubMemberCount" name="totalClubMemberCount" value="${totalClubMemberCount}">
								<input type="hidden" id="clubMaxMember" name="clubMaxMember" value="${club.clubMaxMember}">
							
							</div>
						    
						    
							
						
							<div class="listForm">	
						      <!--  table Start /////////////////////////////////////-->
						      <table class="table table-hover table-striped" >
						      
						        <thead>
						          <tr>
						            <th align="center">프로필사진</th>	
						            <th align="left" >회원 ID</th>
						            <th align="left">회원 닉네임</th>
						            <th align="left">모임직책</th>
						            <th align="left">마지막 접속시간</th>
						            <th align="left">모임가입날짜</th>
						            <th align="left">승인상태</th>
							            <c:if test="${ fn:trim(sessionScope.user.userId) == fn:trim(club.user.userId) }">
								            <th align="left">직책수정</th>
								            <th align="left">추방</th>
								            <th align="left">승인/거절</th>
								            <th align="left">Max</th>
								        </c:if>
						          	</tr>
						          	
						        </thead>
						       
								<tbody>
								<tr>
								  <c:forEach var="i" items="${clubMemberList}">
									<tr>
									<td align="center">
									<a href="/myHome/getYourHome?userId=${i.user.userId}"><img src="/resources/image/uploadFiles/${i.user.profileImage}" width="100" height="100"></a>
									<%-- <img src="/resources/image/uploadFiles/${i.user.profileImage}" width="100" height="100"> --%>
									
									</td>
									
									  <td >${i.user.userId}</td>
									  <td align="left">${i.user.nickName}</td>
									  <%-- <td align="center">${i.memberRole}</td> --%>
									  <td align="left">${ fn:trim(i.memberRole) == 0 ? "모임원" : ""} ${ fn:trim(i.memberRole) == 1 ? "모임부대표" : ""} ${fn:trim(i.memberRole) == 2 ? "모임대표" : ""}</td>
									  <td align="left">${i.logoutDate}</td>
									  <td align="left">${i.joinRegDate}</td>
									  <td align="left">${ fn:trim(i.approvalCondition) == 0 ? "승인대기" : ""} ${ fn: trim(i.approvalCondition) == 1 ? "승인완료" : ""}</td> 
						<%-- 			  <td align="center">${i.approvalCondition}</td> --%>
										<c:if test="${ fn:trim(sessionScope.user.userId) == fn:trim(club.user.userId) }">
									  		<td align="left"><button value="${i.clubUserNo}" memberRole="${i.memberRole}" userId="${i.user.userId}">전달</button></td>
									  	
									  		<td align="left"><button value="${i.clubUserNo}" id="banMember">추방</button></td>
									  		<td align="left"><button value="${i.clubUserNo}" approvalCondition = "${i.approvalCondition}" id="updateApprovalCondition" class="updateApprovalConditionBtn" state="${i.user.userId}">승인</button></td>
											<td>${i.club.clubMaxMember}</td>
										</c:if>
									</tr>
						          </c:forEach>
						        </tbody>
						      
						      </table>
							  <!--  table End /////////////////////////////////////-->
							  
							</div>
						 	<!--  화면구성 div End /////////////////////////////////////-->
					 	
					 	<!-- 이미지랑 합친 div -->
					 	</div>
				</div>
			</div>
			<br><br><br><br><br><br><br><br><br><br>
		<!-- footer start -->
		<jsp:include page="/footer.jsp" />
		<!-- footer end -->
		
		</div>
	
		
	<!-- </main> -->
</body>

</html>