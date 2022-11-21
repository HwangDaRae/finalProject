<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!-- 가능?? -->

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>

<html lang="ko">
	
<head>
	<title>가입현황리스트</title>
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
 	 
	 	 <meta name="description" content="The Page Description">
		<style type="text/css">@-ms-viewport{width: device-width;}</style>
		<title>Beetle - Home page</title>
		<link rel="stylesheet" href="/resources/css/layers.min.css" media="screen">
		<link rel="stylesheet" href="/resources/css/font-awesome.min.css" media="screen">
		<link rel="stylesheet" href="/resources/css/style.css" media="screen">
 	 
 	 
 	 
 	 <style>
	
	
	body {
		    /* background-color: #333; */
		    /* color: #333; */
		    font-size: 1.125em;
		    font-size: 15px;
		    font-family: 'Open Sans', sans-serif;
		    line-height: 0;
		}
	
	#main {
		    position: relative;
		    z-index: 10;
		    overflow: hidden;
		    margin-top: 50px;
		    /* background-color: #333333; */
		}
	
	header {
	    position: fixed;
	    top: 0;
	    left: 0;
	    z-index: 9;
	    padding: 0.7rem;
	    width: 100%;
	    /* background-color: rgba(255, 255, 255, 0.97);
	    -webkit-box-shadow: 0 1px 0 rgb(0 0 0 / 10%);
	    -moz-box-shadow: 0 1px 0 rgba(0, 0, 0, 0.1);
	    box-shadow: 0 1px 0 rgb(0 0 0 / 10%); */
		}
		
		
		header.transparent {
    		background-color: #23242b;
		    -webkit-box-shadow: none;
		    -moz-box-shadow: none;
 	   		box-shadow: none;
		}
	
	
	.thumbnail {
			    display: block;
			    padding: 0px;
			    margin-bottom: 20px;
			    line-height: 1;
			    background-color: #fbfbfb;
			    border: 1px solid #5F0080;
			    border-radius: 4px;
			    -webkit-transition: border .2s ease-in-out;
			    -o-transition: border .2s ease-in-out;
			    transition: border .2s ease-in-out;
			}
		
		div {
			clear: none;
		}
		
		.thumbnail img { 
			min-height:200px;
			height:150px;
			width: 250px;
		 }
		 
		 .btn {
		 	background-color: #fbfbfb;
		 	color: #BD76FF;
		 	border-color: #BD76FF;
		 }
		 
		 .club-cT {
		 	
		 }
		 
		 
	
	</style>

	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="/resources/javascript/plugins.js"></script>
	<script src="/resources/javascript/beetle.js"></script>
	<script type="text/javascript">
	
	function fncUpdateMemberRole() {
		
		$("form").attr("method", "POST").attr("action", "/club/updateMemberRole")
		alert("모임원 수정 화면")
		.submit();
	}
	
		

	
	
	</script>	
</head>

<body class="page">

   <header role="banner" class="transparent light">
      <div class="row">
         <div
            class="nav-inner row-content buffer-left buffer-right even clear-after">
            <div id="brand">
               <h1 class="reset">
                  <!--<img src="img/logo.png" alt="logo">-->
                  <a href="/main.jsp">Link</a>
               </h1>
            </div>
            <!-- brand -->
            <a id="menu-toggle" href="#"><i class="fa fa-bars fa-lg"></i></a>
            <nav>
               <ul class="reset" role="navigation">
                  <li class="menu-item"><a href="/main.jsp">Home</a></li>
                  <li class="menu-item"><a href="/feed/getFeedList">Feed</a></li>
                  <li class="menu-item"><a href="/">Live</a></li>
                  <li class="menu-item"><a href="/club/getClubList">Club</a></li>
                  <li class="menu-item"><a
                     href="/myHome/getMyHome?userId=${sessionScope.user.userId}">MyHome</a></li>
                  <li class="menu-item"><a
                     href="/serviceCenter/serviceCenterHome.jsp">ServiceCenter</a></li>
                  <c:if test="${ empty sessionScope.user }">
                     <li class="menu-item"><a href="/user/login">로그인</a></li>
                     <li class="menu-item"><a href="/user/addUser">회원가입</a></li>
                  </c:if>
                  <c:if test="${!empty sessionScope.user }">
                     <li class="menu-item"><a
                        href="/user/logout?userId=${user.userId}">로그아웃</a></li>
                     <c:if test="${fn:trim(sessionScope.user.role) == '0' }">
                        <li class="menu-item"><a
                           href="/user/getUser?userId=${user.userId}">내정보보기</a></li>
                     </c:if>
                     <c:if test="${fn:trim(sessionScope.user.role) == '1' }">
                        <li class="menu-item"><a href="/user/getUserList">관리자페이지</a></li>
                     </c:if>
                  </c:if>
               </ul>
            </nav>
         </div>
         <!-- row-content -->
      </div>
      <!-- row -->
   </header>




<body class="blog masonry-style">

	<main role="main">
		
			<div id="intro-wrap" data-height="27.778">
				<div id="intro" class="preload darken">
					<div class="intro-item"
						style="background-image: url(http://placehold.it/1800x600/ddd/fff&text=Beetle%20image);">
						<div class="caption">
							<h2>MY CLUB LIST</h2>
							<p>The meeting is waiting for you.. </p>
						</div>
						<!-- caption -->
					</div>
					<!-- intro -->
				</div>
				<!-- intro -->
			</div>
			<!-- intro-wrap -->


	<!--  화면구성 div Start /////////////////////////////////////-->
	
	<div class="container">
	
		<div id="main" class="row">
		
		  <c:forEach var="i" items="${approvalConditionList}">
		  
			<div class="col-xs-4 col-md-3">
			
			<div class="thumbnail" style="">
			  <img src="/resources/image/uploadFiles/${i.clubImage}" alt=".">
			  	<p class="club-cT"><strong>모임제목 : ${i.clubTitle}</strong></p>
			  	<p>${i.clubArea}</p>
			  	<%-- <p>현재인원 : ${i.currentMember}</p> --%>
			  	<p>최대인원 : ${i.clubMaxMember}</p>
			  	<p>신청현황 : ${ fn:trim(i.approvalCondition) == 0 ? "승인대기" : "" } ${ fn:trim(i.approvalCondition) == 1 ? "승인완료" : ""}
			  	<p><a href="/club/getClub?clubNo=${i.clubNo}" class="btn btn-btn" role="button" style="margin-left: 5px;">모임보기</p></a>			
			</div>
		</div>
   	</c:forEach>
	</div>
	  <!--  table End /////////////////////////////////////-->
	  </div>
 	<!--  화면구성 div End /////////////////////////////////////-->
	</main>
</body>

</html>