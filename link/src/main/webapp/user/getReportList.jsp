<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!--  ///////////////////////// CSS ////////////////////////// -->

<style>
body {
	padding-top: 50px;
}

/* button:hover {
	border-style: hidden;
	background-color: #5F0080;
	color: white;
	border-radius: 10px;
	font-weight: bold;
	border: solid 2px white;
}

button {
	background-color: white;
	border: solid 2px #5F0080;
	border-radius: 20px; 
	color:;
}	 */
/* .container {
	border: solid 2px rgb(179, 207, 249);
	border-radius: 10px;
	background: #ecf4ff;
} */
</style>

<script type="text/javascript">

function fncGetList(currentPage) {
	
	if(${user.role=='1'}){
		$("#currentPage").val(currentPage)
		$("form").attr("method", "GET").attr("action", "/serviceCenter/getUserReportList")   //전체보기
				.submit();
		
	}else if (${user.role=='0'}){
		$("#currentPage").val(currentPage)
		$("form").attr("method","post").attr("action","/serviceCenter/getUserReportList/${sessionScope.user.userId}").submit();   //나만보기
				
    }
}
$(function() {
	$("td:nth-child(2)").on(
			"click", 
			function() {
				self.location = "/serviceCenter/getReport?no="+ $(this).parent().find($("input[name='no']")).val();
						});
});
	/* $(function() {
		$("td:nth-child(2)").on(
				"click",
				function() {
					self.location = "/serviceCenter/getReport?no="+ $(this).parent().find("td:eq(0)").text()
							});

	}); */
</script>

</head>
<!-- ToolBar Start /////////////////////////////////////-->


<!-- ToolBar End /////////////////////////////////////-->
<body style="background-color: whitesmoke;">



	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	<%-- 채팅을 위한 소켓 --%>
	<script src="http://192.168.0.74:3000/socket.io/socket.io.js"></script>
	<%-- 채팅 js --%>
	<script src="/resources/javascript/chat/chat.js"></script>
	<%-- 채팅 css --%>
	<link rel="stylesheet" href="/resources/css/chat/chat.css" type="text/css" media="screen" title="no title">
	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	
	
	
	<jsp:include page="/sideToolbar.jsp" />
	<div class="container" style="margin-top: 57px; margin-left: 280px; zoom: 1.2;">
			
			
	
		<%-- chat.js에서 사용위해서 --%>
		<input type="hidden" id="session_userId" value="${ sessionScope.user.userId }">
		<input type="hidden" id="session_profileImage" value="${ sessionScope.user.profileImage }">
		<input type="hidden" id="session_nickName" value="${ sessionScope.user.nickName }">
		<%-- chat.js에서 사용위해서 --%>
		<%-- 채팅 --%>
		<jsp:include page="/chat/chat.jsp" />
		<%-- 채팅 --%>
			
			
			
		<c:if test="${user.role == '0'}">
			<div class="page-header text-left">
				<h6 class=" text-info" style="font-weight: bold;">내정보보기 > 신고내역</h6>
			</div>
		</c:if>
		<c:if test="${user.role == '1'}">
			<div class="page-header text-left">
				<h6 class=" text-info" style="font-weight: bold;">신고내역</h6>
			</div>
		</c:if>
		<div class="row1">

			<div class=" text-left">
				<p class="text-primary" style="font-weight: bold;">전체 ${resultPage.totalCount } 건수, 현재
					${resultPage.currentPage} 페이지</p>
			</div>


			<!-- table 위쪽 검색 Start /////////////////////////////////////-->

			<div class="col-md-6 left">
				<form class="form-inline" name="detailForm" style="display: flex;">

					<div class="form-group">
						<select class="form-control" name="searchCondition" style="width: 75px; text-align: center;">
							<option value="0"
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>번호</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>제목</option>
						</select>
					</div>
					<div class="form-group" style="margin-left: 10px;">
						<label class="sr-only" for="searchKeyword">검색어</label> <input
							type="text" class="form-control" id="searchKeyword" autocomplete="off"
							name="searchKeyword" placeholder="검색어"
							value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
					</div>

					<button type="button" class="btn btn-default" style="margin-left: 10px;">검색</button>

					<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					<input type="hidden" id="currentPage" name="currentPage" value="1" />
				</form>
			</div>

		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->


		<!--  table Start /////////////////////////////////////-->
		<table class="table table-hover table-striped"
			style="background-color: #ecf4ff; width: 1200px;">
			<thead>
				<tr>
					<th align="center" style="text-align: center;">No</th>
					<th align="center" style="text-align: center;">제목</th>
					<th align="center" style="text-align: center;">진행상황</th>
					<th align="center" style="text-align: center;">신고받는 ID</th>
					<th align="center" style="text-align: center;">작성 날짜</th>
				</tr>
			</thead>


			<tbody>

				<c:set var="i" value="0" />
				<c:forEach var="getReportList" items="${getReportList}">
					<c:set var="i" value="${i + 1}" />
					<tr>
						<td align="center" id="bb">${i}
							<input type="hidden" id="no" name="no" value="${getReportList.no}">
							</td>
						<td align="center" class="content"><a href='#'>${getReportList.title}</a><c:if
								test="${getReportList.reportImage1 !=null || getReportList.reportImage2 != null}">
								<img src="/resources/image/uploadFiles/파일.png"
									style="width: 15px; height: 15px; display: inline;">
							</c:if>
						</td>
						<c:if test="${getReportList.reportCondition=='1'}">
							<td align="center">처리완료</td>
						</c:if>
						<c:if test="${getReportList.reportCondition=='0'}">
							<td align="center">대기중</td>
						</c:if>
						<td align="center">${getReportList.user2.userId}</td>
						<td align="center">${getReportList.regDate}</td>
						<td><input type="hidden" name="order" id="order"
							value="${search.order}"></td>
				</c:forEach>
			</tbody>
		</table>
		<!--  table End /////////////////////////////////////-->
		<!-- PageNavigation Start... -->
		<!-- PageNavigation End... -->
<br/><br/>
	</div>
	<!--  화면구성 div End /////////////////////////////////////-->
	<div style="display: flex; justify-content: center;">
		<jsp:include page="../common/pageNavigator.jsp" />
	</div>
<br/><br/>

		
		
</body>

</html>