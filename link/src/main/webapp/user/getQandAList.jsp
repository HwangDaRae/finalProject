<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>

<html lang="ko">

<head>
<title>Q&A 목록</title>
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

/* .container {
	border: solid 2px rgb(179, 207, 249);
	border-radius: 10px;
	background: #ecf4ff;
} */
</style>
<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
function fncGetList(currentPage) {

	if(${search.order=='2'}){
	$("#currentPage").val(currentPage)
	$("form").attr("method", "GET").attr("action", "/serviceCenter/getUserQandAList")   //전체보기
			.submit();
	}
	else if(${search.order=='3'}){
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/serviceCenter/getUserQandAList")   //나만보기
				.submit();
	}	
}

	$(function() {


		$("td:contains('비밀글입니다.')").bind("click", function() {
			if (${empty user}){
			 alert("관계자만 볼 수 있습니다."); 			
				}
			

		})	
			
/* 
		$("button:contains('등록')").bind("click", function() {
			if(${empty sessionScope.user.userId}){
			alert("로그인 후 이용 가능합니다.");
			self.location="/user/login.jsp";
			}
			
			if(${!empty sessionScope.user.userId }){
				
			self.location = "/user/addQandAView.jsp";
			}
		})
		
		
	
		$("button:contains('뒤로')").bind("click", function() {
			self.location = "/user/serviceCenterHome.jsp";
		})
		 */
		
<%-- 		$("button:contains('검색')").bind("click", function() {
			
			$.ajax({
				
				url : "/serviceCenterRest/json/getQandAList",
				method : "POST",
				data : JSON.stringify ({
					currentPage : ($(".currentPage").val())
				}),
				dataType :"json",
				contentType: "application/json",
				success : function(JSONData, status){
					
					
					alert("성공");
				}
				
			})
			
			
			
		}) --%>
		

	});
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
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container" style="zoom: 1.2; margin-left: 280px; margin-top: 57px;">
			
			
	
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
				<h6 class=" text-info" style="font-weight: bold;">내정보보기 > 내Q&A</h6>
			</div>
		</c:if>
		<c:if test="${user.role == '1'}">
			<div class="page-header text-left">
				<h6 class=" text-info" style="font-weight: bold;">Q&A</h6>
			</div>
		</c:if>
		<div class="row1" style="font-weight: bold;"> 

			<div class=" text-left">
				<p class="text-primary">전체 ${resultPage.totalCount } 건수, 현재
					${resultPage.currentPage} 페이지</p>
			</div>


			<!-- table 위쪽 검색 Start /////////////////////////////////////-->

			<div class="col-md-6 left" style="margin-left: -0px;">
				<form class="form-inline" name="detailForm" style="display: flex;">

					<div class="form-group">
						<select class="form-control" name="searchCondition" style="width: 75px; text-align: center;">
							<option value="0"
								${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>번호</option>
							<option value="1"
								${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>제목</option>
						</select>
					</div>

					<div class="form-group" style="margin-top: 0px; margin-left: 10px;">
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
				<tr class="head" id="head">
					<th align="center" style="text-align: center;">No</th>
					<th align="center" style="text-align: center;">제목</th>
					<th align="center" style="text-align: center;">진행상황</th>
					<th align="center" style="text-align: center;">작성자</th>
					<th align="center" style="text-align: center;">작성 날짜</th>
				</tr>
			</thead>

			<tbody>
				<c:set var="i" value="0" />
				<c:forEach var="getQandAList" items="${getQandAList}">
					<c:set var="i" value="${i + 1}" />
					<tr class="ct_list_pop">
						<td align="center" id="bb">${getQandAList.qandANo}</td>
						<%-- 관리자 --%>
						<c:if test="${ user.role == '1' }">
							<td align="center"><a
								href="/serviceCenter/getQandA?qandANo=${getQandAList.qandANo}">

									${getQandAList.qandATitle} </a> <c:if
									test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
									&nbsp;<img src="/resources/image/uploadFiles/파일.png"
										style="width: 15px; height: 15px; display: inline;">
								</c:if></td>
						</c:if>
						<%--관리자 끝 --%>
						<%-- 비회원--%>
						<c:if test="${ user.role== null }">
							<c:if test="${getQandAList.qandAOpenCondition=='1'}">
								<td align="center"><a
									href="/serviceCenter/getQandA?qandANo=${getQandAList.qandANo}">
										${getQandAList.qandATitle} </a> <c:if
										test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
										&nbsp;<img src="/resources/image/uploadFiles/파일.png"
											style="width: 15px; height: 15px; display: inline;">
									</c:if></td>
							</c:if>

							<c:if test="${getQandAList.qandAOpenCondition=='0'}">
								<td><img src="/resources/image/uploadFiles/자물쇠.jpg"
									style="width: 15px; height: 15px; display: inline;">
									비밀글입니다. <c:if
										test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
									&nbsp;<img src="/resources/image/uploadFiles/파일.png"
											style="width: 15px; height: 15px; display: inline;">
									</c:if></td>
							</c:if>
						</c:if>
						<%--비회원 끝 --%>
						<%--회원--%>
						<c:if test="${ user.role =='0' }">
							<%--세션 아이디 비교 OK --%>
							<td align="center"><c:if
									test="${sessionScope.user.userId == getQandAList.userId.userId}">

									<a
										href="/serviceCenter/getQandA?qandANo=${getQandAList.qandANo}">
										${getQandAList.qandATitle} <c:if
											test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
									&nbsp;<img src="/resources/image/uploadFiles/파일.png"
												style="width: 15px; height: 15px; display: inline;">
										</c:if>
									</a>
								</c:if> <%--세션 아이디비교 OK 끝 --%> <%--세션 아이디비교  NO --%> <c:if
									test="${sessionScope.user.userId != getQandAList.userId.userId}">
									<c:if test="${getQandAList.qandAOpenCondition=='1'}">
										<a
											href="/serviceCenter/getQandA?qandANo=${getQandAList.qandANo}">
											${getQandAList.qandATitle} <c:if
												test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
									&nbsp;<img src="/resources/image/uploadFiles/파일.png"
													style="width: 15px; height: 15px; display: inline;">
											</c:if>
										</a>
									</c:if>

									<c:if test="${getQandAList.qandAOpenCondition=='0'}">
										<img src="/resources/image/uploadFiles/자물쇠.jpg"
											style="width: 15px; height: 15px; display: inline;">
								비밀글입니다.
									</c:if>
									<c:if
										test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
									&nbsp;<img src="/resources/image/uploadFiles/파일.png"
											style="width: 15px; height: 15px; display: inline;">
									</c:if>

								</c:if></td>
						</c:if>

						<%--세션 아이디비교 NO 끝 --%>

						<%--히원  --%>
						<c:if test="${getQandAList.qandACondition=='1'}">
							<td align="center">처리완료</td>
						</c:if>
						<c:if test="${getQandAList.qandACondition=='0'}">
							<td align="center">대기중</td>
						</c:if>
						<td align="center">${getQandAList.userId.nickName}</td>

						<td align="center">${getQandAList.qandARegDate}</td>
						<td><input type="hidden" name="order" id="order"
							value="${search.order}"> <input type="hidden"
							name="userId" id="userId" value="${getQandAList.userId.userId}"></td>
				</c:forEach>

			</tbody>
		</table>
		<!--  table End /////////////////////////////////////-->
		<!-- PageNavigation Start... -->


		<!-- PageNavigation End... -->
		<br /> <br />
	</div>
	<!--  화면구성 div End /////////////////////////////////////-->
	<div style="display: flex; justify-content: center;">
		<jsp:include page="../common/pageNavigator.jsp" />
	</div>
<br/><br/>

</body>

</html>