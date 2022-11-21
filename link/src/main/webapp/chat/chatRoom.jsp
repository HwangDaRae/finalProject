<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery.js"></script>
		
		<!-- 사용자 정의 css -->
		<link href="/resources/css/chat/chat.css" rel="stylesheet">
		
		<!-- include libraries(jQuery, bootstrap) -->
		<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		
		<!--  font -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
	
		<!-- 템플릿에 있던 코드 -->
		<script src="/resources/javascript/plugins.js"></script>
		<script src="/resources/javascript/beetle.js"></script>
		
		<style>
		    * { margin: 0; padding: 0; box-sizing: border-box; }
		    body { font: 13px Helvetica, Arial; }
		    form { background: #000; padding: 3px; bottom: 0; width: 100%; }
		    
		    form button { width: 100%; background: rgb(130, 224, 255); border: none; padding: 10px; }
		    #chatLog { list-style-type: none; margin: 0; padding: 0; }
		    #chatLog li { padding: 5px 10px; }
		    /* #chatLog li:nth-child(odd) { background: #eee; } */
		    /* 전제 글씨체 */
			.row{ font-family: 'Single Day', cursive; }
		</style>
	</head>

	<body class="single single-post">
	
	

	
	
	<!-- 모임채팅 -->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script src="http://192.168.0.74:3000/socket.io/socket.io.js"></script>
	<script>
	//소켓서버에 접속시킨다.
	var socket = io.connect("http://192.168.0.74:3000/clubchat", { // clubchat 네임스페이스
		cors: { origin: "*" },
		path: '/socket.io',
		query: {
			userId : '${ user.userId }',
			profileImage : '${ sessionScope.user.profileImage }',
			nickName : '${ sessionScope.user.nickName }',
			roomId : '${ roomId }'
		}
	});
	
	//사용자 참가
	socket.on('join', data => {
	    $('#chatLog').append('<li style="font-size: 25px;">' + data.username + '님이 입장하셨습니다</li>');
	});
	
	//사용자 종료
	socket.on('leave', data => {
	    $('#chatLog').append('<li style="font-size: 25px;">' + data.username + '님이 나가셨습니다</li>');
	});
	
	
	
	//server message 라는 이벤트명으로 대기
	socket.on('server message', function(data){
	    console.log(data);
	    
	    var display = "";
		    
		    if( '${ sessionScope.user.nickName }' != data.username ){
		    	display = "<div style='display: grid; grid-template-columns: 1fr 7fr;'>"
							+"<div>"
								+"<div><img src='/resources/image/uploadFiles/"+data.profileImage+"' style='border-radius: 300px; height: 60px; width: 60px;'></div>"
								+"<div style='padding-left: 10px;'>"+data.username+"</div>"
							+"</div>"
							+"<div style='vertical-align: middle;'><li style='font-size: 25px; padding-top: 20px;'>"+data.message+"</li></div>"
						+"</div>";
		    }else{
		    	display = "<div style='display: grid; grid-template-columns: 7fr 1fr;'>"
							+"<div style='vertical-align: middle;'><li style='font-size: 25px; padding-top: 20px;  text-align: right;'>"+data.message+"</li></div>"
							+"<div>"
								+"<div><img src='/resources/image/uploadFiles/"+data.profileImage+"' style='border-radius: 300px; height: 60px; width: 60px;'></div>"
								+"<div style='padding-left: 10px;'>"+data.username+"</div>"
							+"</div>"
						+"</div>";
		    }
	    					    
	    
	    //소켓서버로부터 수신한 메시지를 화면에 출력한다.
	    //$('#chatLog').append('<li style="font-size: 25px;">' + data.username + '  :  ' + data.message + '</li>');
	    $('#chatLog').append(display);
	    
	});
	
	$(document).ready(function(){
	    $('#sendForm').submit(function(){
	        var message = $('#sendForm input[name=message]');
	        //소켓 서버의 'client message' 라는 이벤트명으로 메세지를 송신한다.
	        socket.emit('client message', { message : message.val()});
	        //input 박스 초기화
	        message.val('');
	        return false;
	    });
	});
	
	
	
	//클럽버튼 펑션입니다.
	
	$(function() {
		$(".homeBtn").on("click", function() {
			self.location="/club/getClub?clubNo=${clubNo}";
		});
	});
	
	$(function() {
		$(".clubPostBtn").on("click", function() {
			self.location="/clubPost/getClubPostList"
		});
	});
	
	$(function() {
		$(".clubMemberBtn").on("click", function() {
			self.location="/club/getClubMemberList"
		});
	});
		
	$(function() {
		$(".clubChatBtn").on("click", function() {
			self.location="/clubPost/chatRoomList?rommId=${club.roomId}&clubTitle=${club.clubTitle}&clubImage=${club.clubImage}";
		});
	});
	
	
	
	
	
	</script>
	<!-- 모임채팅 -->
	
	
	
	

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->		





		<main role="main">

			<div id="main" class="row" style="background-color: #EBEDF0;">
				<div class="row-content buffer-left buffer-right buffer-bottom">
				
				
				<%-- 클럽버튼 --%>
					<div class="homeBtn_group">
						<button type="button" class="homeBtn" style="margin-top: 17px;">
							<span class="glyphicon glyphicon-home" aria-hidden="true"></span> 
						</button>
						
						<button type="button" class="clubPostBtn">
							<span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
						</button>
						
						<button type="button" class="clubMemberBtn">
							<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
						</button>
						
						<button type="button" class="clubChatBtn">
							<span class="glyphicon glyphicon-comment" aria-hidden="true"></span>
						</button>
						
						<button type="button" class="live">
							 <span class="glyphicon glyphicon-facetime-video" aria-hidden="true"></span> 
						</button>
					</div>	
				<%-- 클럽버튼 --%>
					
					
					<%-- #f5ddff --%>
					
					
					<div class="chat-main" style="padding-left: 100px; padding-right: 100px;">
						<div style="background-color: #E1BFFF; height: 800px; box-shadow: rgba(95, 0, 128, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px; border-radius: 100px; padding: 60px; padding-top: 70px;">
							<div style="background-color: #ffeeff; height: 600px; box-shadow:0 5px 20px rgba(95, 0, 128, 0.4) inset; border-radius: 5px; padding: 10px; overflow: auto;"><ul id="chatLog"></ul></div>
							<form action="" id="sendForm">
								<div style="display: grid; grid-template-columns: 5fr 1fr;">
										<div style="font-size: 20px;"><input name="message" autocomplete="off" style="font-size: 20px;"></div>
										<div><button style="width: 80px; height: 45px; box-shadow:0 5px 20px rgba(95, 0, 128, 0.4); border-radius: 10px; font-size: 30px;">전송</button></div>
								</div>
							</form>
						</div>
						
						<%-- <Ul>
							<div style="display: grid; grid-template-columns: 1fr 7fr; background-color: red;">
								<div>
									<div><img src="/resources/image/uploadFiles/${ sessionScope.user.profileImage }" style="border-radius: 300px; height: 60px; width: 60px;"></div>
									<div style="padding-left: 10px;">${ sessionScope.user.nickName }</div>
								</div>
								<div style="vertical-align: middle; background-color: gray;"><li style="font-size: 25px; padding-top: 20px;"></li></div>
							</div>
						</Ul> --%>
						
						<!-- <ul>
							<div style='display: grid; grid-template-columns: 7fr 1fr;'>
								<div style='vertical-align: middle;'><li style='font-size: 25px; padding-top: 20px; text-align: right;'>message</li></div>
								<div>
									<div><img src='/resources/image/uploadFiles/"+data.profileImage+"' style='border-radius: 300px; height: 60px; width: 60px;'></div>
									<div style='padding-left: 10px;'>nickName</div>
								</div>
							</div>
						</ul> -->
					</div>
					
					
					
					
					
				</div><!-- row-content -->
			</div><!-- row -->
		</main><!-- main -->
		
		
		
		

	</body>

</html>
