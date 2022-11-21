<%@ page contentType="text/html; charset=EUC-KR"%>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<head>
<script type="text/javascript">
function YesScroll () {
		const pagination = document.querySelector('#paginaiton'); // 페이지네이션 정보획득
		const fullContent = document.querySelector('.row'); // 전체를 둘러싼 컨텐츠 정보획득
		const screenHeight = screen.height; // 화면 크기
		let oneTime = false; // 일회용 글로벌 변수
		document.addEventListener('scroll',OnScroll,{passive:true}) // 스크롤 이벤트함수정의
		 function OnScroll () { //스크롤 이벤트 함수
		   const fullHeight = fullContent.clientHeight; // infinite 클래스의 높이   
		   const scrollPosition = pageYOffset; // 스크롤 위치
		   if (fullHeight-screenHeight/2 <= scrollPosition && !oneTime) { // 만약 전체높이-화면높이/2가 스크롤포지션보다 작아진다면, 그리고 oneTime 변수가 거짓이라면
		     oneTime = true; // oneTime 변수를 true로 변경해주고,
		     madeBox(); // 컨텐츠를 추가하는 함수를 불러온다.
		   }
		 }
		 }
</script>
</head>

<div class="container text-center">

	<nav>
		<!-- 크기조절 :  pagination-lg pagination-sm-->
		<ul class="pagination">

			<!--  <<== 좌측 nav -->
			<c:if test="${ resultPage.currentPage <= resultPage.pageUnit }">
				<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.currentPage > resultPage.pageUnit }">
				<li>
			</c:if>
			<li>
			<a href="javascript:fncGetClubList('${ resultPage.currentPage-1}')" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a>
			
			</li>

			<!--  중앙  -->
			<c:forEach var="i" begin="${resultPage.beginUnitPage}"
				end="${resultPage.endUnitPage}" step="1">

				<c:if test="${ resultPage.currentPage == i }">
					<!--  현재 page 가르킬경우 : active -->
					<li class="active"><a
						href="javascript:fncGetClubList('${ i }');">${ i }<span
							class="sr-only">(current)</span></a></li>
				</c:if>

				<c:if test="${ resultPage.currentPage != i}">
					<li><a href="javascript:fncGetClubList('${ i }');">${ i }</a>
					</li>
				</c:if>
			</c:forEach>

			<!--  우측 nav==>> -->
			<c:if test="${ resultPage.endUnitPage >= resultPage.maxPage }">
				<li class="disabled">
			</c:if>
			<c:if test="${ resultPage.endUnitPage < resultPage.maxPage }">
				<li>
			</c:if>
			<li>
			<a href="javascript:fncGetClubList('${resultPage.endUnitPage+1}')"
				aria-label="Next"> <span aria-hidden="true">&raquo;</span>
			</a>
			</li>
		</ul>
	</nav>

</div>


