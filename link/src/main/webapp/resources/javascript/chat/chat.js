

	
	//소켓서버에 접속시킨다.
	let socket = io("http://192.168.0.74:3000/clubchat", { // clubchat 네임스페이스
		cors: { origin: "*" },
		path: '/socket.io',
		query: {
			userId : $("#session_userId").val(),
			profileImage : $("#session_profileImage").val(),
			nickName : $("#session_nickName").val(),
			roomId : '74a6518c-7620-4f6c-b59d-ec66fa8a4008',
		}
	}); //*/

$(function(){
	/*채팅 아이콘 클릭시 채팅 열기*/
	$("#chat-icon").bind("click", function(){
		// 채팅 아이콘 숨긴다
		$("#chat-icon").attr("style", "display:none");
		// 채팅창 보인다
		$("#allChat").attr("style", "position: fixed; bottom: 0; right: 0; margin-right: 50px; margin-bottom: 50px; border-radius: 40px; padding: 10px; padding-top: 20px; width: 350px; height: 700px; box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;");
	});
	
	/*채팅 X표 클릭시 채팅 닫기*/
	$("#allChat-toolbar-close").bind("click", function (){
		$("#allChat").attr("style", "display: none;");
		$("#chat-icon").attr("style", "position: fixed; bottom: 0; right: 0; margin-right: 50px; margin-bottom: 50px; padding: 0px; width: 60px; height: 60px; border-radius: 50px; box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;");
	});
	
	/*일대다 이미지 클릭시 모임 채팅 리스트 보이기*/
	$(".chat-img-sidebar.people-users").bind("click", function(){
		//alert("일대다");
		// 모임채팅 보이고 1:1채팅 숨긴다
		$("#user-chat-list").attr("style", "display: none");
		$("#club-chat-list").removeAttr("style");
		// 모임채팅 이미지 테두리 이벤트, 1:1채팅 이미지 테두리 이벤트 없애기
		$(this).attr("style", "box-shadow: rgba(102, 051, 102, 0.3) 0px 9px 38px, rgba(95, 0, 128, 0.3) 0px 5px 12px;");
		$(".chat-img-sidebar.people-user").removeAttr("style");
	});

	/*일대일 이미지 클릭시 1:1 채팅 리스트 보이기*/
	$(".chat-img-sidebar.people-user").bind("click", function(){
		//alert("일대일");
		// 1:1채팅 보이고 모임채팅 숨긴다
		$("#user-chat-list").removeAttr("style");
		$("#club-chat-list").attr("style", "display: none");
		// 1:1채팅 이미지 테두리 이벤트, 모임채팅 이미지 테두리 이벤트 없애기
		$(this).attr("style", "box-shadow: rgba(102, 051, 102, 0.3) 0px 9px 38px, rgba(95, 0, 128, 0.3) 0px 5px 12px;");
		$(".chat-img-sidebar.people-users").removeAttr("style");
	});
	
	
	
	
	$(document).on("click", ".chat-content-onechat", function(){
		//alert("하나의 채팅 클릭시");

		socket.disconnect();
		$('#chatLog').empty();
		
		$("#allChat-toobar-title").attr("style", "display: none");
		$("#allChat-toobar-back").removeAttr("style");
		
		$("#chat-list-content").attr("style", "display: none");
		$("#chat-room-content").removeAttr("style");

		
		roomId = $(this).attr("roomId");
		namespace = $(this).attr("namespace");
		//alert(roomId);

		
		//소켓서버에 접속시킨다.
		socket = io.connect("http://192.168.0.74:3000/"+namespace, { // clubchat 네임스페이스
			cors: { origin: "*" },
			path: '/socket.io',
			query: {
				userId : $("#session_userId").val(),
				profileImage : $("#session_profileImage").val(),
				nickName : $("#session_nickName").val(),
				roomId : roomId,
			},
			forceNew: true
		});
		
		
		
		//server message 라는 이벤트명으로 대기
		socket.on('server message', function(data){
		    //console.log(data);
		    
		    var display = "";
			    
			    if( $("#session_nickName").val() != data.username ){
			    	display = "<div style='display: grid; grid-template-columns: 1fr 8fr;'>"
								+"<div><img src='/resources/image/uploadFiles/"+data.profileImage+"' height='50px' width='50px' style='border-radius: 100px;'></div>"
								+"<div>"
									+"<div>"+data.username+"</div>"
									+"<div>"
										+"<div>"+data.message+"</div>"
									+"</div>"
								+"</div>"
							+"</div>";
			    		
			    }else{
			    	display = "<div style='display: grid; grid-template-columns: 8fr 1fr;'>"
								+"<div>"
									+"<div style='float: right;'>"+data.username+"</div>"
									+"<div>"
										+"<div style='float: right;'>"+data.message+"</div>"
									+"</div>"
								+"</div>"
								+"<div><img src='/resources/image/uploadFiles/"+data.profileImage+"' height='50px' width='50px' style='border-radius: 100px;'></div>"
							+"</div>";
			    }
		    					    
		    
		    //소켓서버로부터 수신한 메시지를 화면에 출력한다.
			$('#chatLog').append(display);
		    
		});

		
		
	});
	
	
	
	$(".chat-toolbar-back").bind("click", function(){
		//alert("back 클릭시");
		
		$("#allChat-toobar-back").attr("style", "display: none");
		$("#allChat-toobar-title").removeAttr("style");
		
		$("#chat-room-content").attr("style", "display: none");
		$("#chat-list-content").removeAttr("style");				
		
		//소켓서버를 끊는다.
		socket.disconnect();
		
	});
	

	
	$(document).ready(function(){
	    $('#chat_send_button').bind("click", function(){
	        var message = $('#sendForm input[name=message]');
	        //소켓 서버의 'client message' 라는 이벤트명으로 메세지를 송신한다.
	        socket.emit('client message', { message : message.val()});
	        //input 박스 초기화
	        message.val('');
	        return false;
	    });//end of 전송버튼
	});
	
	
	

	setChat()


	
	
	
	
	
});//end of 채팅 script

function setChat(){

	
	
	
	//사용자 참가
	socket.off('join').on('join', data => {
	    /*$('#chatLog').append('<div style="font-size: 20px;">' + data.username + '님이 입장하셨습니다</div>');*/
	});
	
	
	
	//사용자 종료
	socket.off('leave').on('leave', data => {
	    /*$('#chatLog').append('<div style="font-size: 20px;">' + data.username + '님이 나가셨습니다</div>');*/
	});
	
	
	/*server message 라는 이벤트명으로 대기*/
	socket.off('server message').on('server message', function(data){
	    //console.log(data);
	    
	    var display = "";
		    
		    if( $("#session_nickName").val() != data.username ){
		    	display = "<div style='display: grid; grid-template-columns: 1fr 8fr;'>"
							+"<div><img src='/resources/image/uploadFiles/"+data.profileImage+"' height='50px' width='50px' style='border-radius: 100px;'></div>"
							+"<div>"
								+"<div>"+data.username+"</div>"
								+"<div>"
									+"<div>"+data.message+"</div>"
								+"</div>"
							+"</div>"
						+"</div>";
		    		
		    }else{
		    	display = "<div style='display: grid; grid-template-columns: 8fr 1fr;'>"
							+"<div>"
								+"<div style='float: right;'>"+data.username+"</div>"
								+"<div>"
									+"<div style='float: right;'>"+data.message+"</div>"
								+"</div>"
							+"</div>"
							+"<div><img src='/resources/image/uploadFiles/"+data.profileImage+"' height='50px' width='50px' style='border-radius: 100px;'></div>"
						+"</div>";
		    }
	    					    
	    
	    //소켓서버로부터 수신한 메시지를 화면에 출력한다.
		   $('#chatLog').append(display);
	    
	});
}