<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
<%@ page import = "java.net.URLEncoder" %>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- <%
	String userId = (String)session.getAttribute("user");

	if(userId == null) {
		String message = "먼저 로그인 하신 후 사용 가능합니다.";
		message = URLEncoder.encode(message, "utf-8");

		response.sendRedirect("/user/login.jsp?message = "+message);
	} else{

	}

%>
 --%>
<!DOCTYPE html>

<html lang="ko">
	
<head>
	<title>모임일정리스트</title>
	<meta charset="EUC-KR">
	
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	 <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	  <!-- jQuery UI toolTip 사용 JS-->
 	 <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 	 
 	 <style>
	 body {
    background-color: #f0f2f5;
    color: #333;
    font-size: 1.125em;
    font-size: 15px !important;
    font-family: 'Open Sans', sans-serif;
    line-height: 0.8 !important;
	}
	
	#main {
		background-color: #f0f2f5 !important;
	}
	
	main {
		background-color: #f0f2f5 !important;
	}
	
	.container {
		background-color: #f0f2f5;
	}
	
	
	element.style {
    background-color: #f0f2f5 !important;
	}
	
	
	.darkover {
	    position: fixed !important;
	    top: 0;
	    right: 0;
	    bottom: 0;
	    left: 0;
	    background: rgba(0,0,0,0.0) !important;
	}
	
	#calendar {
	margin-left: 0px;
	margin-top: 50px;
	width: 90%;
	height: 700px;
	display: flex;
	justify-content: center;
	background-color: #f0f2f5 !important;
	color: #bd76ff !important;
	}
			
	
	.fc-scroller {
		overflow-y : hidden !important;
	}
	
	
	
	</style>

	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="/resources/javascript/plugins.js"></script>
	<script src="/resources/javascript/beetle.js"></script>
	<script type="text/javascript">
	
	$(function(){
		$("button.btn.btn-addMeeting").on("click", function(){
			self.location="/club/addMeetingView.jsp"
		});
	});
	
	
	</script>	
	
</head>

	<body class="blog masonry-style">
	
	<jsp:include page="/toolbar.jsp" />
		
	<main role="main">
		
			<div id="intro-wrap" data-height="20"><!-- 상단 검은색 공통 영역 -->
				<div id="intro" class="preload darken">					
					<div class="intro-item" style="background-image: url(http://placehold.it/1800x600/ddd/fff&text=Beetle%20image);">
						<div class="caption">
							<h2>MEETING LIST</h2>
							<p>the beginning of a meeting...</p>
						</div>
					</div>								
				</div><!-- intro -->
			</div><!-- intro-wrap -->
			
		
			<div id="main" class="row"><!-- 중간 개별영역 -->
			
				<div class="row-content buffer-left buffer-right buffer-bottom">
				

					<ul class="inline cats filter-options" style="font-size: 40px; margin-bottom: 0em; margin-left: 20px;">
						<li data-group="advertising">
							<a href="/club/getMeetingList" style="color: #BD76FF;">모임일정</a>
						</li>
						<li data-group="fun">
							<a href="/clubPost/getClubPostList" style="color: #BD76FF;">모임게시물</a>
						</li>
						<li data-group="icons">
							<a href="/club/getClubMemberList" style="color: #BD76FF;">모임원</a>
						</li>
						<li data-group="infographics">
							<a href="/clubPost/chatRoomList" style="color: #BD76FF;">모임채팅</a>
						</li>
						<%-- <li data-group="infographics">
							<a href="/clubPost/addPayView?clubNo=${ clubPostList[0].clubNo }">결제</a>
						</li> --%>
					</ul>
	
			</div>
		</div>
	
	
	
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<button type="button" class="btn btn-addMeeting" style="float:right; background-color:#f0f2f5; color:#BD76FF; margin-right: 115px; border-color: #BD76FF;">일정등록</button>


	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row" id="calendar" style="">
	    
	    	<jsp:include page="/club/calendar.jsp"/>	    		    
	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
		
      <!--  table Start /////////////////////////////////////-->
     <%--  <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left" >모임일정제목</th>
            <th align="left">모임일정날짜</th>
            <th align="left">모임일정시간</th>
            <th align="left">모임장소</th>
          </tr>
        </thead>
       
		<tbody>
		<tr>
		${clubList}
		  <c:set var="i" value="0" />
		  <c:forEach var="i" items="${meetingList}">
		  <input type="hidden" name="meetingNo" value="${i.meetingNo}">
			<tr>
			<td align="center"><a href="/club/getMeeting?meetingNo=${i.meetingNo}">${i.meetingNo}</a>
			  <td align="left">${i.meetingTitle}</td>
			  <td align="left">${i.meetingDate}</td>
			  <td align="left">${i.meetingTime}</td>
			  <td align="left">${i.meetingPlace}</td>			  
			</tr>
          </c:forEach>
        </tr>
        </tbody>
      
      </table> --%>
	  <!--  table End /////////////////////////////////////-->
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->

	</main>
	
</body>

</html>