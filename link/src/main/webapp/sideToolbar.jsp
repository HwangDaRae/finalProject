<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<head>

<script type="text/javascript">
	$(function() {
		$("#myPage").on("click", function() {
			self.location = "/user/getUser?userId=${user.userId}";
		});

		$("#updatePage").on("click", function() {
			self.location = "/user/updateUser?userId=${user.userId}";
		}); 

		$("#myReport").on("click", function() {
			$("form").attr("method","post").attr("action","/serviceCenter/getUserReportList/${sessionScope.user.userId}").submit();
		
		});

		$("#myQA").on("click", function() {
			$("form").attr("method","post").attr("action","/serviceCenter/getUserQandAList/${sessionScope.user.userId}").submit();
		 
		});

		$('#userPage').on("click", function() {
			
			self.location = "/user/getUserList";
		});

		$("#report").on("click", function() {
			location.href = "/serviceCenter/getUserReportList";
		});
		
		$("#QA").on("click", function() {
			location.href = "/serviceCenter/getUserQandAList";
			 
		});
		$("#stop2").on("click", function() {
			self.location = "/user/getUserList?searchKeyword=2";
		});

		$("#stop1").on("click", function() {
			self.location = "/user/getUserList?searchKeyword=1";
		});

	});
	
	$(function () {
		
		$(document).on("click",".clubNav", function() {
			
			Swal.fire({
				title: '로그인 후 이용해주세요' ,
				text: "로그인 창으로 이동합니다" ,
				showCancelButton: false,
				confirmButtonColor: '#3085d6',
				cancelButtonColor: '#d33',
				confirmButtonText: '확인', 
			}).then((result) => {
				if(result.value) {
					return;	
				}
			})
		})
	});
	
	$(function() {
		$('#login').on('click', function(event) {
			event.stopPropagation();
			$('#modalLogin').modal();
		})
		/*  $('#ml').on("click", function(event) {
			event.stopPropagation();
			$('.modal.fade.login').modal('hide');
		})  */
	}); 
</script>

<style type="text/css">
.class_user_pointer{
	cursor: pointer;
}
/* 마우스 호버시 글자 아래 흰색 밑줄 생김 */
nav > * a:hover{
	border-bottom: 2px solid whitesmoke !important;
}
.class_user_pointer:hover{
	border-bottom: 2px solid whitesmoke !important;
	width: 60% !important;
	border-bottom: 1px solid whitesmoke !important;
}
nav div div a:hover{
	color: red;
}
</style>

 <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Link</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@latest/dist/style.css" rel="stylesheet" />
        <link href="/resources/css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.1.0/js/all.js" crossorigin="anonymous"></script>
</head>

<body class="sb-nav-fixed">
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark" style="height: 64px; background: linear-gradient(0deg, #958c8cc4, black);">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="/feed/getFeedList" style="font-size: 28px; color: white; font-weight: bold; text-decoration: none; margin-left: 30px;">
            	<img src="/resources/image/uploadFiles/Logo1.png" style="height: 50px; width: 150px;">
            </a>
            <div style="display: flex; margin-left: 439px;">
            <div style="margin-left: 78px;"><a href="/" style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">HOME</a></div>
            <div style="margin-left: 24px;"><a href="/feed/getFeedList" style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">FEED</a></div>
            <c:if test="${! empty sessionScope.user }">
            <div style="margin-left: 24px;"><a href="/club/getClubList" style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">CLUB</a></div>
            </c:if>
            <c:if test="${ empty sessionScope.user }">
            <div style="margin-left: 24px;"><a href="#" class="clubNav" onclick="clubNav();" style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">CLUB</a></div>
            </c:if>
            <div style="margin-left: 24px;"><a href="/" style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">LIVE</a></div>
            <div style="margin-left: 24px;"><a href="/myHome/getMyHome?userId=${sessionScope.user.userId}" style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">MYHOME</a></div>
            <div style="margin-left: 24px;"><a href="/serviceCenter/serviceCenterHome.jsp" style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">SERVICECENTER</a></div>
            <c:if test="${ empty sessionScope.user }">
            <div style="margin-left: 24px;"><a href="#" id='login' style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">로그인</a></div>
            </c:if>
            <c:if test="${!empty sessionScope.user }">
            <div style="margin-left: 24px;"><a href="/user/logout?userId=${sessionScope.user.userId}" style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">로그아웃</a></div>
            </c:if>
            <c:if test="${fn:trim(sessionScope.user.role) == '0' }">
            <div style="margin-left: 24px;"><a href="/user/getUser?userId=${sessionScope.user.userId}" style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">내정보보기</a></div>
            </c:if>
             <c:if test="${fn:trim(sessionScope.user.role) == '1' }">
            <div style="margin-left: 24px;"><a href="/user/getUserList" style="font-size: 16px; color: white; font-weight: bold; text-decoration: none;">관리자페이지</a></div>
            </c:if>
            </div>
            <!-- Sidebar Toggle-->
            <!-- Navbar Search-->
            <!-- Navbar-->
        </nav>
        <div id="layoutSidenav">
            <div id="layoutSidenav_nav">
                <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
                    <div class="sb-sidenav-menu" style="background: linear-gradient(#9d9999 , #2e2e2e 3%); text-align: center; font-size: larger; color: white; font-weight: bold;">
                    <c:if test="${ fn:trim(user.role) == '0' }">
                    <div class="class_user_pointer" id='myPage' style="margin-top: 77px;">내정보보기</div>
                    <div class="class_user_pointer" id='updatePage' style="margin-top: 20px;">내정보수정</div>
                    <div class="class_user_pointer" id='myReport' style="margin-top: 20px;">내신고내역</div>
                    <div class="class_user_pointer" id='myQA' style="margin-top: 20px;">내Q&A</div> 
                    </c:if>
                    <c:if test="${ fn:trim(user.role) == '1' }">
                    <div class="class_user_pointer" id='userPage' style="margin-top: 77px;">회원목록</div>
                    <div class="class_user_pointer" id='report' style="margin-top: 20px;">신고내역</div>
                    <div class="class_user_pointer" id='QA' style="margin-top: 20px;">관리자Q&A</div>
                    <div class="class_user_pointer" id="stop1" style="margin-top: 20px;">정지회원</div>
                    <div class="class_user_pointer" id="stop2" style="margin-top: 20px;">영구정지회원</div>
                    </c:if>
                    </div>
                </nav>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@latest" crossorigin="anonymous"></script>
        <script src="js/datatables-simple-demo.js"></script>
    </body> 
 
<%-- <body class="portfolio">
	<jsp:include page="/toolbar.jsp" />
	
	<!-- main -->
<form>
<br/><br/>
<input type="hidden" class="currentPage" id="currentPage" name="currentPage" value="1" />
	<c:if test="${ fn:trim(user.role) == '0' }">
		<div id="main" class="row"style="background-color: #EBEDF0;">
			<div class="row-content buffer clear-after" style="margin-bottom: -100px;">
				<ul class="inline cats filter-options">
					<li data-group="advertising">내정보보기</li>
					<li data-group="fun">내보정수정</li>
					<li data-group="infographics">내 신고내역</li>
					<li data-group="lightbox">내 Q&A</li>
				</ul>
			</div>
			<!-- row-content -->
		</div>
		<!-- row -->
	</c:if>

	<c:if test="${ fn:trim(user.role) == '1' }">
		<div id="main" class="row" style="background-color: #EBEDF0;">
			<div class="row-content buffer clear-after" style="margin-bottom: -100px;">
				<ul class="inline cats filter-options">
					<li data-group="icons">회원정보수정</li>
					<li data-group="infographics">신고내역조회</li>
					<li data-group="lightbox">관리자 Q&A</li>
					<li data-group="lightbox" id="stop2">영구정지회원</li>
					<li data-group="lightbox" id="stop1">정지회원</li>
				</ul>
			</div>
			<!-- row-content -->
		</div>
		<!-- row -->
	</c:if>
</form>
	<script src="/resources/javascript/plugins.js"></script>
	<script src="/resources/javascript/beetle.js"></script>
</body> --%>

</html>