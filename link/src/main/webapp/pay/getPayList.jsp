<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="The Page Description">
	
	<link href="/resources/css/feed/getFeedList.css" rel="stylesheet">
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<script src="/resources/javascript/plugins.js"></script>
	<script src="/resources/javascript/beetle.js"></script>
	
	<%-- SUMMER NOTE --%>
	<script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
	<%-- SUMMER NOTE --%>
	
	<%-- ALERT --%>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<%-- ALERT --%>
	
	<%-- BOOTSTRAP ICON --%>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<%-- BOOTSTRAP ICON --%>
	<style>
	.top{
	height : 100px;
	margin-top : -20px;
	}
	.font{
	 text-align: center;
	 font-size : 40px;
	 font-family:Verdana, Geneva, Arial, sans-serif;
	}
	.pay{
	margin-left : 0px;
	margin-top : 100px;
	background-color: #F5F6F7;
	border: 2px solid #CCD0D5;
	width:500px;
	border-radius : 15px;
	color : black;
	}
	body{
	 background-color : #EBEDF0 !important;
	 
	}
	.ft{
	font-size : 18px;
	
	}
	.ftt{
	font-size:20px;
	font-weight: 600;
	color: #555 !important;
	}
	</style>
</head>
<body>
<div>
<div class="top" style="background-color : #5F0080"></br><H3 class="font" style="color : white">결제&nbsp;&nbsp;내역</H3></div>





<div class="frame" style="display:grid;
	 justify-content : center;">
<c:forEach var = "payList" items = "${payList}">
			<c:set var = "i" value = "${i + 1}" />
			<div class ="pay">
			<br/>
			<div style="margin-left:140px;">
			<div class="ft"><span class="ftt">결제 상품 :</span>&nbsp; &nbsp;<span>${payList.payProduct}</span></div><br/>
			
			<div class="ft"><span class="ftt">아이디 :</span>&nbsp; &nbsp;<span>${payList.user.userId}</span></div><br/>
			<div class="ft"><span class="ftt">결제 금액 :</span>&nbsp; &nbsp;${payList.totalPrice}원</div><br/>
			<div class="ft"><span class="ftt">결제일 :</span>&nbsp; &nbsp;${payList.payRegDate}</div><br/>
		
		    <c:if test="${payList.updateClubMemberCount eq 0}">
			<div class="ft"><span class="ftt">모임 추가 :</span>&nbsp; &nbsp;${payList.updateClubCount}</div><br/>
			</c:if>
			<c:if test="${payList.updateClubCount eq 0}">
			<div class="ft"><span class="ftt">모임원 추가 :</span>&nbsp; &nbsp;${payList.updateClubMemberCount}</div><br/>
			</c:if>
			<div class="ft"><span class="ftt">결제 수단 :</span>&nbsp; &nbsp; ${payList.payOption}</div><br/>
			</div>
			</div>
		
			
					
		
			</c:forEach>
			</div>
			
			
			
			
			
			
			
</div>
</body>
</html>