<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/resources/css/footer.css" type="text/css" media="screen" title="no title">
<!-- <style type="text/css">
#club_post_footer_int{
top: 60px
}
</style> -->
</head>
<body>
<!-- footer start -->
<div id="club_post_footer">
	
	<!-- footer content start -->
	<div id="club_post_footer_content">
		<!-- footer 배경이미지 -->
		<div id="club_post_footer_img">
			<img src="/resources/image/uploadFiles/footerImage3.jpg">
		</div>
		<!-- 로고 이미지 -->
		<div  id="club_post_logo_img">
			<img src="/resources/image/uploadFiles/Logo1.png">
			<div id="logo_comment">우리들의 연결고리</div>
		</div>
		<!-- footer 소개글 start -->
		<div id="club_post_footer_int">
			
			<!-- MENU -->
			<div>
				<p class="club_post_footer_Tag top_name">Menu</p>
				<div><a class="club_post_footer_Tag" href="home-01.html">HOME</a></div>
				<div><a class="club_post_footer_Tag" href="/feed/getFeedList">FEED</a></div>
				<div>
					<c:if test="${ ! empty sessionScope.user }">
						<div><a class="club_post_footer_Tag" href="/club/getClubList">CLUB</a></div>
					</c:if>
					<c:if test="${ empty sessionScope.user }">
						<div class="menu-item"><a class="club_post_footer_Tag" href="#" class="clubNav" onclick="clubNav();">Club</a></div>
					</c:if>
				</div>
				<div><a class="club_post_footer_Tag" href="/myHome/getMyHome?userId=${sessionScope.user.userId}">MYHOME</a></div>
				<div><a class="club_post_footer_Tag" href="/serviceCenter/serviceCenterHome">SERVICECENTER</a></div>
				<%-- <div><a style="color: gray; font-size: 13px;" href="/user/getUser?userId=${sessionScope.user.userId}">내정보보기</a></div> --%>
			</div>
			<!-- COMPANY -->
			<div>
				<p class="club_post_footer_Tag top_name">Company</p>
				<p class="club_post_footer_Tag">
				(주)링크 대표이사 김정민, 박경수<br>
				사업자등록번호 : 703-88-00878<br>
				통신판매업신고 : 제2014-서울강남-01544호<br>
				고객센터(유료) : 1899-4455 / 02-2007-4545<br>
				팩스 : 02-393-6093<br>
				이메일문의 : gsshop@gsretail.com
				</p>
			</div>
			<!-- 오시는 길 -->
			<div>
				<p class="club_post_footer_Tag top_name">오시는길</p>
				<p class="club_post_footer_Tag">주소: 서울특별시 서초구<br> 서초대로 396, 강남빌딩 20층<br> (스파크플러스 강남2호점)</p>
			</div>
		</div>
		<!-- footer 소개글 end -->
	</div>
	<!-- footer content end -->
</div>
<!-- footer end -->
</body>
</html>