<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>







<!-- 채팅 이미지 start -->
<div>
	<img id="chat-icon" style="background-color: yellow; height: 60px; width: 60px;" src="/resources/image/uploadFiles/chat_image.jpg">
</div>
<!-- 채팅 이미지 end -->

<!-- 채팅 start -->
<div id="allChat" style="display: none;">
	<!-- 채팅 상단 툴바 start -->
	<div id="allChat-toolbar">
		<div>
			<!-- 로고 -->
			<span id="allChat-toobar-title">LINK</span>
			<!-- 뒤로가기 -->
			<span id="allChat-toobar-back" class="chat-toolbar-back" style="display: none;"><img src="/resources/image/uploadFiles/back5.png" height="60px" width="60px"></span>
		</div>
		<div></div>
		<div>
			<!-- 닫기 -->
			<span id="allChat-toolbar-close" class="chat-toolbar-back">X</span>
		</div>
	</div>
	<!-- 채팅 상단 툴바 end -->
	<!-- 채팅 body start -->
	<div id="chat-body">
		<!-- 채팅 list start -->
		<div id="chat-list-content">
			<!-- 채팅 사이드바 -->
			<div id="chat-body-sidebar">
				<img class="chat-img-sidebar people-users" style="box-shadow: rgba(102, 051, 102, 0.3) 0px 9px 38px, rgba(95, 0, 128, 0.3) 0px 5px 12px;" src="/resources/image/uploadFiles/people.jpg">
				<img class="chat-img-sidebar people-user" src="/resources/image/uploadFiles/one_user.jpg">
			</div>
			<!-- 모임 채팅과 1:1 채팅 리스트 start -->
			<div id="chat-list-one-content">
				<div id="club-chat-list">
					<c:if test="${ fn:length(roomList) > 0 }">
					<c:forEach var="i" begin="0" end="${ fn:length(roomList) - 1 }" step="1">
						<div class="chat-content chat-content-onechat" roomId="${ roomList[i].roomId }" namespace="clubchat">
							<div><img class="chat-img-main" src="/resources/image/uploadFiles/${ roomList[i].clubImage }"></div>
							<div>${ roomList[i].clubTitle }</div>
						</div>
					</c:forEach>
					</c:if>
				</div>
				<div id="user-chat-list" style="display: none;">
					<c:if test="${ fn:length(getChat) > 0 }">
					<c:forEach var="i" begin="0" end="${ fn:length(getChat) - 1 }" step="1">
						<div class="chat-content chat-content-onechat" roomId="${ getChat[i].roomId }" namespace="userchat">
							
							<c:choose>
								<c:when test="${ getChat[i].user.nickName != sessionScope.user.nickName }">
									<div><img class="chat-img-main" src="/resources/image/uploadFiles/${ getChat[i].user.profileImage }"></div>
									<div>${ getChat[i].user.nickName }</div>
								</c:when>
								<c:otherwise>
									<div><img class="chat-img-main" src="/resources/image/uploadFiles/${ getChat[i].user2.profileImage }"></div>
									<div>${ getChat[i].user2.nickName }</div>
								</c:otherwise>
							</c:choose>
							
						</div>
					</c:forEach>
					</c:if>
				</div>
			</div>
			<!-- 모임 채팅과 1:1 채팅 리스트 end -->
		</div>
		<!-- 채팅 list end -->
		
		<!-- 채팅방 start -->
		<div id="chat-room-content" style="display: none;">
			<div id="chat-room">
				<div id="chatLog">
				</div>
			</div>
			<!-- 채팅 메세지 전송 start -->
			<form action="" id="sendForm">
			<div id="input-chatLog">
				<div><input type="text" name="message" autocomplete="off"></div>
				<div><button id="chat_send_button">전송</button></div>
			</div>
			</form>
			<!-- 채팅 메세지 전송 end -->
		</div>
		<!-- 채팅방 end -->
		
	</div>
	<!-- 채팅 body end -->						
</div>
<!-- 채팅 end -->







</body>
</html>