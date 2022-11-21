<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
		
		<!--  ///////////////////////// jQuery CDN////////////////////////// -->
		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
		
		<script type="text/javascript">
			$(function(){
				$(document).on("click", ".button.transparent.aqua", function(){
					location.href = "/clubPost/chatRoom";
				});
				$(".addChatRoom").bind("click", function() {
					alert('a');
					location.href = "/clubPost/chatRoom";
				});
			});
		</script>
</head>
<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->
	<br><br><br><br><br>
						
		<!-- <button class="addChatRoom">채팅방 생성</button> -->
		
		<a class="button transparent aqua">
		<div style="height: 100px; font-size: 2rem;">
		채팅방
		</div></a>
		<!-- <a class="button transparent aqua">
		<div style="height: 100px; font-size: 2rem;">
		두번째 채팅방
		</div></a> -->
	
</body>
</html>