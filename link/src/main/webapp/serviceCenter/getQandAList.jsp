<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">

<head>
<title>Q&A 목록</title>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="The Page Description">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> <%--페이지 네비게이션 css --%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery.js"></script>
<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
.row {
	margin-left : 0px !important;
	   display: initial !important;
}
body {
	margin-top: 76px;
	padding-top: -75px;
	background-color: #EBEDF0 !important;
    margin-top: -54px !important;
}

.head {
	background-color: #5F0080;
    background-image: linear-gradient(315deg, #5F0080  30%, #BD76FF 74%);
	border: 1px solid #bcbcbc;
	align = center;
}
.page-header{
	border-bottom:0px !important;
}

.content {

	width: 500px;
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

.waviy {
  position: relative;
}
.waviy span {
  position: relative;
  display: inline-block;
  font-size: 5px;
  color: #5F0080;
  text-transform: uppercase;
  animation: flip 1s infinite;
  animation-delay: calc(.2s * var(--i))
}
@keyframes flip {
  0%,80% {
    transform: rotateY(360deg) 
  }
}



</style>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<script type="text/javascript">
function fncGetList(currentPage) {

	if(${search.order=='2'}){
	$("#currentPage").val(currentPage)
	$("form").attr("method", "GET").attr("action", "/serviceCenter/getQandAList")   //전체보기
			.submit();
	}
	else if(${search.order=='3'}){
		$("#currentPage").val(currentPage)
		$("form").attr("method", "POST").attr("action", "/serviceCenter/getQandAList/${sessionScope.user.userId}")   //나만보기
				.submit();
	}	
}

	$(function() {


		$("td:contains('비밀글입니다.')").bind("click", function() {
			if (${empty user}){
			 alert("관계자만 볼 수 있습니다."); 			
				}	

		})
		
		$("button:contains('검색')").bind("click", function() {	
		  fncGetList(1);
		})
		
		$("button:contains('등록')").bind("click", function() {
			if(${empty sessionScope.user.userId}){
			alert("로그인 후 이용 가능합니다.");
			self.location="/user/login.jsp";
			}
			
			if(${!empty sessionScope.user.userId }){
				
			self.location = "/serviceCenter/addQandAView";
			}
		})
		
		
	
		$("button:contains('이전')").bind("click", function() {
			self.location = "/serviceCenter/serviceCenterHome.jsp";
		})

	});
</script>
<!-- footer css -->
<style type="text/css">
body{
	position: relative;
}
</style>

</head>
	<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="/toolbar.jsp" />
	
	<!-- ToolBar End /////////////////////////////////////-->
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



<div class="page-header" align="center" style="transform: translate(-395px, 149px);">
  <h1 >Q&A 리스트</h1>
</div>

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
			
		<div class="row1">

			<div class=" text-left">
				<div class="col-md-3 col-sm-3 col-xs-6"> 
									</div>
				<p class="text" style="text-align-last:end; transform: translate(-44px, 22px);">전체 ${resultPage.totalCount } 건수, 현재
					${resultPage.currentPage} 페이지</p>
			</div>


			<!-- table 위쪽 검색 Start /////////////////////////////////////-->

			<div class="col-md-6 text-right" style= "transform: translate(600px, 0px);">
					<form class="form-inline" name="detailForm">
						
						<div class="form-group">
							<select class="form-control" name="searchCondition" style="vertical-align: top;">
								<option value="1"
									${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>제목</option>
							</select>

							<label class="sr-only" for="searchKeyword" style="color:#BD76FF;">검색어</label> <input
								type="text" class="form-control" id="searchKeyword" width="200px"
								name="searchKeyword" placeholder="검색어" style="transform: translate(10px, 8px); width:300px; "
								value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
						</div>

							<button type="button" class="custom-btn btn-13" style="transform: translate(20px, 0px); width: 70px; height :26px;">검색</button>

						<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						<input type="hidden" id="currentPage" name="currentPage" value="1" />
					</form>
				</div>


		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->


		<!--  table Start /////////////////////////////////////-->
		<table   style="text-align-last: center; background-color:white;">
			<div class="row2">
				<thead class="bg-primary text-white">
					<tr class = "head" id ="head" >
						<th align="center">No</th>
						<td />
						<th align="center" class="content">제목</th>
						<td />
						<th align="center">진행상황</th>
						<td />
						<th align="center">작성자</th>
						<td />
						<th align="center" width="140">작성 날짜</th>
					</tr>
				</thead>

				<c:set var="i" value="0" />
				<c:forEach var="getQandAList" items="${getQandAList}">
					<c:set var="i" value="${i + 1}" />
					<tr class="ct_list_pop">
						<td align="left" id="bb" style="vertical-align: middle;">${i}
						<input type="hidden" id="qandANo" name="qandANo" value="${getQandAList.qandANo }">
						</td>
						<td></td>
						<%-- 관리자 --%>
						<c:if test="${ user.role == '1' }">
							<td align="left"><a
								href="/serviceCenter/getQandA?qandANo=${getQandAList.qandANo}" style="color: black;">
								
									${getQandAList.qandATitle} </a>
									<c:if test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
									&nbsp;<img src="/resources/image/uploadFiles/파일.png" style="width:15px; height:15px; display: inline;">
									</c:if>	
									
									</td>
						</c:if>
						<%--관리자 끝 --%>
						<%-- 비회원--%>
						<c:if test="${ user.role== null }">
							<c:if test="${getQandAList.qandAOpenCondition=='1'}">
								<td align="left"><a
									href="/serviceCenter/getQandA?qandANo=${getQandAList.qandANo}" style="color: black;">
										${getQandAList.qandATitle} </a>
										<c:if test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
										&nbsp;<img src="/resources/image/uploadFiles/파일.png" style="width:15px; height:15px; display: inline;">
										</c:if>	
										</td>
							</c:if>

							<c:if test="${getQandAList.qandAOpenCondition=='0'}">
								<td >
								<img src="/resources/image/uploadFiles/자물쇠.jpg" style="width:15px; height:15px; display: inline;">
								비밀글입니다.
								<c:if test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
									&nbsp;<img src="/resources/image/uploadFiles/파일.png" style="width:15px; height:15px; display: inline;">
									</c:if>	
								
								</td>
							</c:if>
						</c:if>
						<%--비회원 끝 --%>
						<%--회원--%>
						<c:if test="${ user.role =='0' }">
							<%--세션 아이디 비교 OK --%>
							<td align="left">
							<c:if test="${sessionScope.user.userId == getQandAList.userId.userId}">
									
									<a href="/serviceCenter/getQandA?qandANo=${getQandAList.qandANo}" style="color: black;">
										${getQandAList.qandATitle} <c:if test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
									&nbsp;<img src="/resources/image/uploadFiles/파일.png" style="width:15px; height:15px; display: inline;">
									</c:if>	</a>	
							</c:if>
							<%--세션 아이디비교 OK 끝 --%>
							<%--세션 아이디비교  NO --%>
							<c:if test="${sessionScope.user.userId != getQandAList.userId.userId}">
									<c:if test="${getQandAList.qandAOpenCondition=='1'}">
								<a href="/serviceCenter/getQandA?qandANo=${getQandAList.qandANo}" style="color: black;">
										${getQandAList.qandATitle} 
										<c:if test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
									&nbsp;
									</c:if>	</a>
							</c:if>
							
									<c:if test="${getQandAList.qandAOpenCondition=='0'}">
									<img src="/resources/image/uploadFiles/자물쇠.jpg" style="width:15px; height:15px; display: inline;">
								비밀글입니다.
									</c:if>
									<c:if test="${getQandAList.qandAImage1 !=null || getQandAList.qandAImage2 != null}">
									&nbsp;
									</c:if>								
								
							</c:if></c:if>
							
							</td>
							<%--세션 아이디비교 NO 끝 --%>
						
						<%--히원  --%>
						<td></td>
						<c:if test="${getQandAList.qandACondition=='1'}">
							<td align="left" style="vertical-align: middle;">처리완료</td>
						</c:if>
						<c:if test="${getQandAList.qandACondition=='0'}">
							<td align="left" style="vertical-align: middle;">대기중</td>
						</c:if>
						<td></td>
						<td align="left" style="vertical-align: middle;">${getQandAList.userId.nickName}</td>
							
						<td><input type="hidden" name="order" id="order"
							value="${search.order}">
							<input type="hidden" name="userId" id="userId"
							value="${getQandAList.userId.userId}"></td>
						<td align="left" style="vertical-align: middle;">${getQandAList.qandARegDate}</td>
					
				</c:forEach>

				</tbody>
		</table>
		<!--  table End /////////////////////////////////////-->
		<!-- PageNavigation Start... -->

		<jsp:include page="../common/pageNavigator_n.jsp" />

		<!-- PageNavigation End... -->

		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			style="margin-top: 10px;">
			<tr>
				<td width="53%"></td>
				<td align="right">

					<table border="0" cellspacing="0" cellpadding="0">
						<tr>


							<table border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td class="ct_write01"><input type="hidden" id="Quantity"
										name="Quantity" value="1" /></td>
								</tr>
							</table>
							<td width="30"></td>

							<div class="col-md-3 col-sm-3 col-xs-6">
							<c:if test="${ user.role == 0 || user.role == 1 }">
								    <button class="custom-btn btn-13" style= "transform: translate(950px, -90px); ">
									   등록</button> 
									</c:if>
											<button class="custom-btn btn-13" style= "transform: translate(970px, -90px); margin-left::20px; ">
									이전</button>
							</div>


						</tr>
					</table>

				</td>
			</tr>
		</table>
	</div>
			
	<br><br><br><br><br><br><br><br><br><br><br><br>
	

	<!-- footer start -->
	<jsp:include page="/footer.jsp" />
	<!-- footer end -->
	<!--  화면구성 div End /////////////////////////////////////-->



</body>

</html>