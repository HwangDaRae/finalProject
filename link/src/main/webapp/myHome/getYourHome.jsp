<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="description" content="The Page Description">

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="/resources/css/feed/getFeedListForMyHome.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Sacramento&display=swap" rel="stylesheet">
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">

<script type="text/javascript">
$(function(){
	
	
	<%-- 1:1 채팅 --%>
	$(document).on("click","button:contains('채팅')", function() {
		var user_Id = $(this).parents("div[name='dialog']").attr("id");
		console.log(user_Id + "테스트입니다");
		
		console.log("1:1채팅");
		$("#chat-icon").attr("style", "display:none");
		// 채팅창 보인다
		$("#allChat").attr("style", "position: fixed; bottom: 0; right: 0; margin-right: 50px; margin-bottom: 50px; border-radius: 40px; padding: 10px; padding-top: 20px; width: 350px; height: 700px; box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;");

		// 1:1채팅 보이고 모임채팅 숨긴다
		$("#user-chat-list").removeAttr("style");
		$("#club-chat-list").attr("style", "display: none");
		// 1:1채팅 이미지 테두리 이벤트, 모임채팅 이미지 테두리 이벤트 없애기
		$(this).attr("style", "box-shadow: rgba(102, 051, 102, 0.3) 0px 9px 38px, rgba(95, 0, 128, 0.3) 0px 5px 12px;");
		$(".chat-img-sidebar.people-users").removeAttr("style");
		
		//alert( "1:1 채팅하고하는 상대방 아이디 : " + user_Id );
		var make_roomId = "";
		

		socket.disconnect();
		$('#chatLog').empty();
		
		$("#allChat-toobar-title").attr("style", "display: none");
		$("#allChat-toobar-back").removeAttr("style");
		
		$("#chat-list-content").attr("style", "display: none");
		$("#chat-room-content").removeAttr("style");
		
		// ajax로 roomId 만들어서 DB에 넣고
		$.ajax( "/clubPostRest/json/addChat",
				{
					method : "POST",
					data : JSON.stringify({
						userId2 : user_Id
					}),
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType : "json",
					success : function(JSONData, status){
						//alert(status);
						
						var user_chat_list = "";
						$("#user-chat-list").empty();
						
						for (var i = 0; i < JSONData.length; i++) {
							//alert(JSONData[i].roomId);
							//alert(JSONData[i].user2.nickName);
							//alert(JSONData[i].user2.profileImage);
							//alert(JSONData[i].currentRoomId);
							
							make_roomId = JSONData[i].currentRoomId;
								// 넣은 roomId까지 가져와서 1:1채팅 리스트 돌리고
								user_chat_list = "<div class='chat-content chat-content-onechat' roomId='"+JSONData[i].roomId+"' namespace='userchat'>"
														+"<div>"
															+"<img class='chat-img-main' src='/resources/image/uploadFiles/"+JSONData[i].user2.profileImage+"'>"
														+"</div>"
														+"<div>"+JSONData[i].user2.nickName+"</div>"
													+"</div>";
								
								$("#user-chat-list").append( user_chat_list );
							}
							
							//alert( make_roomId );
							console.log(socket)
							
							// 만든 roomId = '${ sessionScope.user.userId }'+user_Id로 채팅방 접속한다
							//소켓서버에 접속시킨다.
							socket = io("http://192.168.0.74:3000/userchat", { // clubchat 네임스페이스
								cors: { origin: "*" },
								path: '/socket.io',
								query: {
									userId : $("#session_userId").val(),
									profileImage : $("#session_profileImage").val(),
									nickName : $("#session_nickName").val(),
									roomId : make_roomId
								},
								forceNew: true,
								autoConnect:false
							});
							console.log(socket);
							
							setChat();
							
							socket.connect();
							
						}//end of success	
						
				});// end of ajax
					
		});//end of 프로필사진의 채팅 클릭시 1:1 채팅

		
		
	$(document).on("click", ".comment", function(event) {
		event.stopPropagation();
		
		var feedNo = $(this).parents(".lastBar").siblings("input[name='feedNo']").val();
		
		$("#commentModalFeedNo").val(feedNo);
		$("#commentModal").modal();
	});
	
	$(document).on("click", ".addCommentByModal", function(event) {
		event.stopPropagation();
		
		if('${sessionScope.user}' == null) return false;
		
		var sessionUser = '${sessionScope.user.userId}';
		var content = $("#contentModal").val();
		var feedNumber = $("#commentModalFeedNo").val();
		
		$.ajax (
					{
						url : "/feedRest/json/addFeedComment",
						method : "POST",
						data : JSON.stringify ({
							userId : sessionUser,
							commentContent : content,
							feedNo : feedNumber
						}),
						contentType: 'application/json',
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, // header end
						
						success : function(data, status) {
							
							Swal.fire({
								
								  icon: 'success',
								  title: 'Your work has been saved',
								  showConfirmButton: false,
								  timer: 1500
								  
							}) // swal close
							
							$("#commentModal").modal('hide');
							self.location = "/feed/getFeed?feedNo="+feedNo;
						
						} // success close
						
					} // ajax inner close
		
		) // ajax close
	})
	
	$('.dl').on("click",function(){
		
	var user_Id = $(this).parent().parent().attr("id");
	var nickName = $("."+user_Id+"").val();
	var profileImage = $(this).attr("id");
	var sessionId = $("#myId").val();
	
	$.ajax("/myHomeRest/json/getFollow", {

		type : "POST",
		data : JSON.stringify({
			receiveId : user_Id
		}),
		dataType : "json",
		contentType : "application/json",
		headers : {
			"Accept" : "application/json"
		},
		success : function(Data, status) {
		if(Data.follow != null){
			var freceiveId = Data.follow.receiveId.userId;
			var fnickName = Data.follow.receiveId.nickName;
			var fprofileImage = Data.follow.receiveId.profileImage;
			var ffbType = Data.follow.fbType;
			var ffbState = Data.follow.fbState;
		}else{
			var freceiveId = "";
			var fnickName = "";
			var fprofileImage = "";
			var ffbType = "";
			var ffbState = "";
		}
		if(Data.block != null){
			var breceiveId = Data.block.receiveId.userId;
            var bnickName = Data.block.receiveId.nickName;
			var bprofileImage = Data.block.receiveId.profileImage;
			var bfbType = Data.block.fbType;
			var bfbState = Data.block.fbState;
		}else{
			var breceiveId = "";
            var bnickName = "";
			var bprofileImage = "";
			var bfbType = "";
			var bfbState = "";
		}
			
			
			
		
			
			if( freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType.trim() == '2' && bfbState.trim() == '1' ){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='following' class='btn  btn-sm'>"+
					"팔로잉</button><button type='button' id='stopBlock' class='btn  btn-sm'>차단해제</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType.trim() == '2' && bfbState.trim() == '1'){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='updateFollow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='stopBlock' class='btn  btn-sm'>차단해제</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType.trim() == '2' && bfbState.trim() == '2'){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='following' class='btn  btn-sm'>"+
					"팔로잉</button><button type='button' id='updateBlock' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType.trim() == '2' && bfbState.trim() == '2'){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='updateFollow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='updateBlock' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType == ""){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='following' class='btn  btn-sm'>"+
					"팔로잉</button><button type='button' id='block' class='btn  btn-sm'>차단</button></div><button type='button' class='btn  btn-sm'>채팅</button></div>";
			}else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType == "" ){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='updateFollow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='block' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(breceiveId == user_Id && ffbType == ""  && bfbType.trim() == '2' && bfbState.trim() == '1'){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+bprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+bnickName+"</h4></div><div><button type='button' id='follow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='stopBlock' class='btn  btn-sm'>차단해제</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(breceiveId == user_Id && ffbType == ""  && bfbType.trim() == '2' && bfbState.trim() == '2'){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+bprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+bnickName+"</h4></div><div><button type='button' id='follow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='updateBlock' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(ffbType == ""  && bfbType == "" ){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+profileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+nickName+"</h4></div><div><button type='button' id='follow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='block' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}
			
			 $("#"+nickName+"").html(value);
		
			
				$("#"+nickName+"").dialog({
					
					autoOpen: false,
					show: {
						effect: "Pulsate",
				        duration: 1000
					},
					hide: {
				        effect: "Scale",
				        duration: 1000
					},
					position: {
						
						my:"center",
						at:"center",
						of:"#"+user_Id+""
					}
					
				});
	
	         if(sessionId != user_Id){
				 $("#"+nickName+"").dialog("open");
	         }
		},
		error : function(){
			var value =
				"<div name='dialog'><img src='/resources/image/uploadFiles/"+profileImage+"' style='width:100px; height:100px;'><div><h4>"+nickName+"</h4></div><div><button type='button' id='follow' class='btn  btn-sm'>"+
				"팔로우</button><button type='button' id='block' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
				
			 $("#"+nickName+"").html(value);
				alert("dd");
				
				$("#"+nickName+"").dialog({
					
					autoOpen: false,
					show: {
						effect: "Pulsate",
				        duration: 1000
					},
					hide: {
				        effect: "Scale",
				        duration: 1000
					},
					position: {
						
						my:"center",
						at:"center",
						of:"#"+user_Id+""
					}
					
				});
	
	
				 $("#"+nickName+"").dialog("open");
		}
	})

}) 
$(".main").on("click",function(){

	 $("div[name='dialog']").parent().dialog("close");

}) 

$(document).on("click",".dll",function(){
	
	var user_Id = $(this).parent().parent().attr("id");
	var nickName = $("."+user_Id+"").val();
	var profileImage = $(this).attr("id");
	var sessionId = $("#myId").val();
	$.ajax("/myHomeRest/json/getFollow", {

		type : "POST",
		data : JSON.stringify({
			receiveId : user_Id
		}),
		dataType : "json",
		contentType : "application/json",
		headers : {
			"Accept" : "application/json"
		},
		success : function(Data, status) {
		if(Data.follow != null){
			var freceiveId = Data.follow.receiveId.userId;
			var fnickName = Data.follow.receiveId.nickName;
			var fprofileImage = Data.follow.receiveId.profileImage;
			var ffbType = Data.follow.fbType;
			var ffbState = Data.follow.fbState;
		}else{
			var freceiveId = "";
			var fnickName = "";
			var fprofileImage = "";
			var ffbType = "";
			var ffbState = "";
		}
		if(Data.block != null){
			var breceiveId = Data.block.receiveId.userId;
            var bnickName = Data.block.receiveId.nickName;
			var bprofileImage = Data.block.receiveId.profileImage;
			var bfbType = Data.block.fbType;
			var bfbState = Data.block.fbState;
		}else{
			var breceiveId = "";
            var bnickName = "";
			var bprofileImage = "";
			var bfbType = "";
			var bfbState = "";
		}
			
			
		
		
			
			if( freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType.trim() == '2' && bfbState.trim() == '1' ){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='following' class='btn  btn-sm'>"+
					"팔로잉</button><button type='button' id='stopBlock' class='btn  btn-sm'>차단해제</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType.trim() == '2' && bfbState.trim() == '1'){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='updateFollow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='stopBlock' class='btn  btn-sm'>차단해제</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType.trim() == '2' && bfbState.trim() == '2'){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='following' class='btn  btn-sm'>"+
					"팔로잉</button><button type='button' id='updateBlock' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType.trim() == '2' && bfbState.trim() == '2'){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='updateFollow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='updateBlock' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType == ""){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='following' class='btn  btn-sm'>"+
					"팔로잉</button><button type='button' id='block' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType == "" ){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+fnickName+"</h4></div><div><button type='button' id='updateFollow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='block' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(breceiveId == user_Id && ffbType == ""  && bfbType.trim() == '2' && bfbState.trim() == '1'){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+bprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+bnickName+"</h4></div><div><button type='button' id='follow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='stopBlock' class='btn  btn-sm'>차단해제</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(breceiveId == user_Id && ffbType == ""  && bfbType.trim() == '2' && bfbState.trim() == '2'){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+bprofileImage+"' style='width:100px; height:100px;'><div class='goHome'><h4>"+bnickName+"</h4></div><div><button type='button' id='follow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='updateBlock' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}else if(ffbType == ""  && bfbType == "" ){
				var value =
					"<div name='dialog' id='"+user_Id+"'><img class='di' src='/resources/image/uploadFiles/"+profileImage+"' style='width:100px; height:100px;'><div><h4 class='goHome'>"+nickName+"</h4></div><div><button type='button' id='follow' class='btn  btn-sm'>"+
					"팔로우</button><button type='button' id='block' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
			}
			
			 $("#"+nickName+"1").html(value);
		
			
				$("#"+nickName+"1").dialog({
					
					autoOpen: false,
					show: {
						effect: "Pulsate",
				        duration: 1000
					},
					hide: {
				        effect: "Scale",
				        duration: 1000
					},
					position: {
						
						my:"center",
						at:"center",
						of:"div[name='"+nickName+"']"
					}
					
				});
	
	
				if(sessionId != user_Id){
					 $("#"+nickName+"1").dialog("open");
		         }
	
		},
		error : function(){
			var value =
				"<div name='dialog1'><img src='/resources/image/uploadFiles/"+profileImage+"' style='width:100px; height:100px;'><div><h4>"+nickName+"</h4></div><div><button type='button' id='Follow' class='btn  btn-sm'>"+
				"팔로우</button><button type='button' id='block' class='btn  btn-sm'>차단</button><button type='button' class='btn  btn-sm'>채팅</button></div></div>";
				
			 $("#"+nickName+"1").html(value);
				
				
				$("#"+nickName+"1").dialog({
					
					autoOpen: false,
					show: {
						effect: "Pulsate",
				        duration: 1000
					},
					hide: {
				        effect: "Scale",
				        duration: 1000
					},
					position: {
						
						my:"center",
						at:"center",
						of:"div[name='"+nickName+"']"
					}
					
				});
	
	
				 $("#"+nickName+"1").dialog("open");
		}
	})

}) 
$(".main").on("click",function(){

	 $("div[name='dialog1']").parent().dialog("close");

}) 



	
	
});
$(function() {

	$(document).on("click","#follow", function() {
		var userId = $(this).parent().parent().attr("id");
		console.log("전달받은 회원 Id : " + userId);

		$.ajax("/myHomeRest/json/getFollow", {
			type : "POST",
			data : JSON.stringify({
				receiveId : userId,
				fbType : "1"
			}),
			dataType : "json",
			contentType : "application/json",
			headers : {
				"Accept" : "application/json"
			},
			success : function(data, status) {
				console.log(data);
				console.log(data.follow);
			if(data.follow != null ){
				console.log("서버로 받은 데이터 : " + data.follow.userId);
				console.log("서버로 받은 데이터 : " + data.follow.fbState);
				var fbState = "";
				if(data.follow.fbState == 1){
					fbState = "2";
				}else if(data.follow.fbState == 2){
					fbState = "1";
				}
				
				console.log("state 값 : "+fbState);
				$.ajax("/myHomeRest/json/updateFollow", {
					type : "POST",
					data : JSON.stringify({
						receiveId : userId,
						fbType : "1",
						fbState : fbState
					}),
					dataType : "json",
					contentType : "application/json",
					headers : {
						"Accept" : "application/json"
					},
					success : function(update, status) {
						console.log("서버로 받은 데이터(정상) : " + update.follow.userId);
						if(update.follow.fbState == 1){
							$("#follow").text("팔로잉");
							if(sock) {
								   var Msg = "follow," + userId + ",0, 가 나를 팔로우 했습니다."
								   sock.send(Msg);
							}
							}else if(update.follow.fbState == 2){
							$("#follow").text("팔로우");
							}
					}
				})
				}else if(data.follow ==null){
					console.log("서버로 받은 데이터(error) : " + data.follow);

					$.ajax("/myHomeRest/json/addFollow", {
						type : "POST",
						data : JSON.stringify({
							receiveId : userId
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accetp" : "application/json"
						},
						success : function(Data, status) {
							console.log("서버로부터 받은 Data(error) : " + Data);
							$("#follow").text("팔로잉");
							if(sock) {
								   var Msg = "follow," + userId + ",0, 가 나를 팔로우 했습니다."
								   sock.send(Msg);
							}
						}
					})
				} 
			}
			
		})
	})

	 $(document).on("click","#following", function() {
		var userId = $(this).parent().parent().attr("id");
		console.log("전달받은 회원 Id : " + userId);
		var changeText = $(this);
       
		$.ajax("/myHomeRest/json/getFollow", {
			type : "POST",
			data : JSON.stringify({
				receiveId : userId,
				fbType : "1"
			}),
			dataType : "json",
			contentType : "application/json",
			headers : {
				"Accept" : "application/json"
			},
			success : function(data, status) {
				console.log(data);
				console.log("서버로 받은 데이터 : " + data.follow.userId);
				console.log("서버로 받은 데이터 : " + data.follow.fbState);
				var fbState = "";
				if(data.follow.fbState == 1){
					fbState = "2";
				}else if(data.follow.fbState == 2){
					fbState = "1";
				}
				
				console.log("state 값 : "+fbState);
				$.ajax("/myHomeRest/json/updateFollow", {
					type : "POST",
					data : JSON.stringify({
						receiveId : userId,
						fbType : "1",
						fbState : fbState
					}),
					dataType : "json",
					contentType : "application/json",
					headers : {
						"Accept" : "application/json"
					},
					success : function(update, status) {
						console.log("서버로 받은 데이터(정상) : " + update.follow.userId);
						if(update.follow.fbState == 1){
						$(changeText).text("팔로잉");
						if(sock) {
							   var Msg = "follow," + userId + ",0, 가 나를 팔로우 했습니다."
							   sock.send(Msg);
						}
						}else if(update.follow.fbState == 2){
						$(changeText).text("팔로우");
						}
					}
				})
			}
		})
	}) 

	 $(document).on("click","#updateFollow", function() {
		var userId = $(this).parent().parent().attr("id");
		console.log("전달받은 회원 Id : " + userId);
		var changeText = $(this);

		$.ajax("/myHomeRest/json/getFollow", {
			type : "POST",
			data : JSON.stringify({
				receiveId : userId,
				fbType : "1"
			}),
			dataType : "json",
			contentType : "application/json",
			headers : {
				"Accept" : "application/json"
			},
			success : function(data, status) {
				console.log("서버로 받은 데이터 : " + data.follow.userId);
				console.log("서버로 받은 데이터 : " + data.follow.fbState);
				var fbState = "";
				if(data.follow.fbState == 1){
					fbState = "2";
				}else if(data.follow.fbState == 2){
					fbState = "1";
				}
				
				console.log("state 값 : "+fbState);
				$.ajax("/myHomeRest/json/updateFollow", {
					type : "POST",
					data : JSON.stringify({
						receiveId : userId,
						fbType : "1",
						fbState : fbState
					}),
					dataType : "json",
					contentType : "application/json",
					headers : {
						"Accept" : "application/json"
					},
					success : function(update, status) {
						console.log("서버로 받은 데이터(정상) : " + update.follow.userId);
						if(update.follow.fbState == 1){
						$(changeText).text("팔로잉");
						if(sock) {
							   var Msg = "follow," + userId + ",0, 가 나를 팔로우 했습니다."
							   sock.send(Msg);
						}
						}else if(update.follow.fbState == 2){
						$(changeText).text("팔로우");
						}
					}
				})
			}
		})
	})


	$(document).on("click","#block", function() {
		var userId = $(this).parent().parent().attr("id");
		console.log("전달받은 회원 Id : " + userId);
		var changeText = $(this);

		$.ajax("/myHomeRest/json/getFollow", {
			type : "POST",
			data : JSON.stringify({
				receiveId : userId,
				fbType : "2"
			}),
			dataType : "json",
			contentType : "application/json",
			headers : {
				"Accept" : "application/json"
			},
			success : function(data, status) {
				console.log(data);
				console.log(data.block);
				if(data.block != null ){
				console.log("서버로 받은 데이터 : " + data.block.userId);
				console.log("서버로 받은 데이터 : " + data.block.fbState);
				var fbState = "";
				if(data.block.fbState == 1){
					fbState = "2";
				}else if(data.block.fbState == 2){
					fbState = "1";
				}
				
				console.log("state 값 : "+fbState);
				$.ajax("/userRest/json/updateBlock", {
					type : "POST",
					data : JSON.stringify({
						receiveId : userId,
						fbType : "2",
						fbState : fbState
					}),
					dataType : "json",
					contentType : "application/json",
					headers : {
						"Accept" : "application/json"
					},
					success : function(update, status) {
						console.log("서버로 받은 데이터(정상) : " + update.block.userId);
						if(update.block.fbState == 1){
							$(changeText).text("차단해제");
							}else if(update.block.fbState == 2){
							$(changeText).text("차단");
							}
					}
				})
				}else if(data.block ==null){
					console.log("서버로 받은 데이터(error) : " + data.block);

					$.ajax("/userRest/json/addBlock", {
						type : "POST",
						data : JSON.stringify({
							receiveId : userId
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accetp" : "application/json"
						},
						success : function(Data, status) {
							console.log("서버로부터 받은 Data(error) : " + Data);
							$(changeText).text("차단해제");
						}
					})
				}
			}
			
		})
	})

	$(document).on("click","#stopBlock", function() {
		var userId = $(this).parent().parent().attr("id");
		console.log("전달받은 회원 Id : " + userId);
		var changeText = $(this);

		$.ajax("/myHomeRest/json/getFollow", {
			type : "POST",
			data : JSON.stringify({
				receiveId : userId,
				fbType : "2"
			}),
			dataType : "json",
			contentType : "application/json",
			headers : {
				"Accept" : "application/json"
			},
			success : function(data, status) {
				console.log(data);
				console.log("서버로 받은 데이터 : " + data.block.userId);
				console.log("서버로 받은 데이터 : " + data.block.fbState);
				var fbState = "";
				if(data.block.fbState == 1){
					fbState = "2";
				}else if(data.block.fbState == 2){
					fbState = "1";
				}
				
				console.log("state 값 : "+fbState);
				$.ajax("/userRest/json/updateBlock", {
					type : "POST",
					data : JSON.stringify({
						receiveId : userId,
						fbType : "2",
						fbState : fbState
					}),
					dataType : "json",
					contentType : "application/json",
					headers : {
						"Accept" : "application/json"
					},
					success : function(update, status) {
						console.log("서버로 받은 데이터(정상) : " + update.block.userId);
						if(update.block.fbState == 1){
						$(changeText).text("차단해제");
						}else if(update.block.fbState == 2){
						$(changeText).text("차단");
						}
					}
				})
			}
		})
	})

	$(document).on("click","#updateBlock", function() {
		var userId = $(this).parent().parent().attr("id");
		console.log("전달받은 회원 Id : " + userId);
		var changeText = $(this);

		$.ajax("/myHomeRest/json/getFollow", {
			type : "POST",
			data : JSON.stringify({
				receiveId : userId,
				fbType : "2"
			}),
			dataType : "json",
			contentType : "application/json",
			headers : {
				"Accept" : "application/json"
			},
			success : function(data, status) {
				console.log("서버로 받은 데이터 : " + data.block.userId);
				console.log("서버로 받은 데이터 : " + data.block.fbState);
				var fbState = "";
				if(data.block.fbState == 1){
					fbState = "2";
				}else if(data.block.fbState == 2){
					fbState = "1";
				}
				
				console.log("state 값 : "+fbState);
				$.ajax("/userRest/json/updateBlock", {
					type : "POST",
					data : JSON.stringify({
						receiveId : userId,
						fbType : "2",
						fbState : fbState
					}),
					dataType : "json",
					contentType : "application/json",
					headers : {
						"Accept" : "application/json"
					},
					success : function(update, status) {
						console.log("서버로 받은 데이터(정상) : " + update.block.userId);
						if(update.block.fbState == 1){
						$(changeText).text("차단해제");
						}else if(update.block.fbState == 2){
						$(changeText).text("차단");
						}
					}
				})
			}
		})
	})

});

 
	$(function() {

		$("#follow1").on("click", function() {
			var userId = $("#userId2").val();
			console.log("전달받은 회원 Id : " + userId);
			var changeText = $(this);

			$.ajax("/myHomeRest/json/getFollow", {
				type : "POST",
				data : JSON.stringify({
					receiveId : userId,
					fbType : "1"
				}),
				dataType : "json",
				contentType : "application/json",
				headers : {
					"Accept" : "application/json"
				},
				success : function(data, status) {
					console.log(data);
					console.log(data.follow);
				if(data.follow != null ){
					console.log("서버로 받은 데이터 : " + data.follow.userId);
					console.log("서버로 받은 데이터 : " + data.follow.fbState);
					var fbState = "";
					if(data.follow.fbState == 1){
						fbState = "2";
					}else if(data.follow.fbState == 2){
						fbState = "1";
					}
					
					console.log("state 값 : "+fbState);
					$.ajax("/myHomeRest/json/updateFollow", {
						type : "POST",
						data : JSON.stringify({
							receiveId : userId,
							fbType : "1",
							fbState : fbState
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accept" : "application/json"
						},
						success : function(update, status) {
							console.log("서버로 받은 데이터(정상) : " + update.follow.userId);
							if(update.follow.fbState == 1){
								$(changeText).text("팔로잉");
								}else if(update.follow.fbState == 2){
								$(changeText).text("팔로우");
								}
						}
					})
					}else if(data.follow ==null){
						console.log("서버로 받은 데이터(error) : " + data.follow);

						$.ajax("/myHomeRest/json/addFollow", {
							type : "POST",
							data : JSON.stringify({
								receiveId : userId
							}),
							dataType : "json",
							contentType : "application/json",
							headers : {
								"Accetp" : "application/json"
							},
							success : function(Data, status) {
								console.log("서버로부터 받은 Data(error) : " + Data);
								$(changeText).text("팔로잉");
							}
						})
					} 
				}
				
			})
		})

		 $("#following1").on("click", function() {
			var userId = $("#userId2").val();
			console.log("전달받은 회원 Id : " + userId);
			var changeText = $(this);

			$.ajax("/myHomeRest/json/getFollow", {
				type : "POST",
				data : JSON.stringify({
					receiveId : userId,
					fbType : "1"
				}),
				dataType : "json",
				contentType : "application/json",
				headers : {
					"Accept" : "application/json"
				},
				success : function(data, status) {
					console.log(data);
					console.log("서버로 받은 데이터 : " + data.follow.userId);
					console.log("서버로 받은 데이터 : " + data.follow.fbState);
					var fbState = "";
					if(data.follow.fbState == 1){
						fbState = "2";
					}else if(data.follow.fbState == 2){
						fbState = "1";
					}
					
					console.log("state 값 : "+fbState);
					$.ajax("/myHomeRest/json/updateFollow", {
						type : "POST",
						data : JSON.stringify({
							receiveId : userId,
							fbType : "1",
							fbState : fbState
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accept" : "application/json"
						},
						success : function(update, status) {
							console.log("서버로 받은 데이터(정상) : " + update.follow.userId);
							if(update.follow.fbState == 1){
							$(changeText).text("팔로잉");
							}else if(update.follow.fbState == 2){
							$(changeText).text("팔로우");
							}
						}
					})
				}
			})
		}) 

		 $("#updateFollow1").on("click", function() {
			var userId = $("#userId2").val();
			console.log("전달받은 회원 Id : " + userId);
			var changeText = $(this);

			$.ajax("/myHomeRest/json/getFollow", {
				type : "POST",
				data : JSON.stringify({
					receiveId : userId,
					fbType : "1"
				}),
				dataType : "json",
				contentType : "application/json",
				headers : {
					"Accept" : "application/json"
				},
				success : function(data, status) {
					console.log("서버로 받은 데이터 : " + data.follow.userId);
					console.log("서버로 받은 데이터 : " + data.follow.fbState);
					var fbState = "";
					if(data.follow.fbState == 1){
						fbState = "2";
					}else if(data.follow.fbState == 2){
						fbState = "1";
					}
					
					console.log("state 값 : "+fbState);
					$.ajax("/myHomeRest/json/updateFollow", {
						type : "POST",
						data : JSON.stringify({
							receiveId : userId,
							fbType : "1",
							fbState : fbState
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accept" : "application/json"
						},
						success : function(update, status) {
							console.log("서버로 받은 데이터(정상) : " + update.follow.userId);
							if(update.follow.fbState == 1){
							$(changeText).text("팔로잉");
							}else if(update.follow.fbState == 2){
							$(changeText).text("팔로우");
							}
						}
					})
				}
			})
		})


		$("#block1").on("click", function() {
			var userId = $("#userId2").val();
			console.log("전달받은 회원 Id : " + userId);
			var changeText = $(this);

			$.ajax("/myHomeRest/json/getFollow", {
				type : "POST",
				data : JSON.stringify({
					receiveId : userId,
					fbType : "2"
				}),
				dataType : "json",
				contentType : "application/json",
				headers : {
					"Accept" : "application/json"
				},
				success : function(data, status) {
					console.log(data);
					console.log(data.block);
					if(data.block != null ){
					console.log("서버로 받은 데이터 : " + data.block.userId);
					console.log("서버로 받은 데이터 : " + data.block.fbState);
					var fbState = "";
					if(data.block.fbState == 1){
						fbState = "2";
					}else if(data.block.fbState == 2){
						fbState = "1";
					}
					
					console.log("state 값 : "+fbState);
					$.ajax("/userRest/json/updateBlock", {
						type : "POST",
						data : JSON.stringify({
							receiveId : userId,
							fbType : "2",
							fbState : fbState
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accept" : "application/json"
						},
						success : function(update, status) {
							console.log("서버로 받은 데이터(정상) : " + update.block.userId);
							if(update.block.fbState == 1){
								$(changeText).text("차단해제");
								}else if(update.block.fbState == 2){
								$(changeText).text("차단");
								}
						}
					})
					}else if(data.block ==null){
						console.log("서버로 받은 데이터(error) : " + data.block);

						$.ajax("/userRest/json/addBlock", {
							type : "POST",
							data : JSON.stringify({
								receiveId : userId
							}),
							dataType : "json",
							contentType : "application/json",
							headers : {
								"Accetp" : "application/json"
							},
							success : function(Data, status) {
								console.log("서버로부터 받은 Data(error) : " + Data);
								$(changeText).text("차단해제");
							}
						})
					}
				}
				
			})
		})

		$("#stopBlock1").on("click", function() {
			var userId = $("#userId2").val();
			console.log("전달받은 회원 Id : " + userId);
			var changeText = $(this);

			$.ajax("/myHomeRest/json/getFollow", {
				type : "POST",
				data : JSON.stringify({
					receiveId : userId,
					fbType : "2"
				}),
				dataType : "json",
				contentType : "application/json",
				headers : {
					"Accept" : "application/json"
				},
				success : function(data, status) {
					console.log(data);
					console.log("서버로 받은 데이터 : " + data.block.userId);
					console.log("서버로 받은 데이터 : " + data.block.fbState);
					var fbState = "";
					if(data.block.fbState == 1){
						fbState = "2";
					}else if(data.block.fbState == 2){
						fbState = "1";
					}
					
					console.log("state 값 : "+fbState);
					$.ajax("/userRest/json/updateBlock", {
						type : "POST",
						data : JSON.stringify({
							receiveId : userId,
							fbType : "2",
							fbState : fbState
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accept" : "application/json"
						},
						success : function(update, status) {
							console.log("서버로 받은 데이터(정상) : " + update.block.userId);
							if(update.block.fbState == 1){
							$(changeText).text("차단해제");
							}else if(update.block.fbState == 2){
							$(changeText).text("차단");
							}
						}
					})
				}
			})
		})

		$("#updateBlock1").on("click", function() {
			var userId = $("#userId2").val();
			console.log("전달받은 회원 Id : " + userId);
			var changeText = $(this);

			$.ajax("/myHomeRest/json/getFollow", {
				type : "POST",
				data : JSON.stringify({
					receiveId : userId,
					fbType : "2"
				}),
				dataType : "json",
				contentType : "application/json",
				headers : {
					"Accept" : "application/json"
				},
				success : function(data, status) {
					console.log("서버로 받은 데이터 : " + data.block.userId);
					console.log("서버로 받은 데이터 : " + data.block.fbState);
					var fbState = "";
					if(data.block.fbState == 1){
						fbState = "2";
					}else if(data.block.fbState == 2){
						fbState = "1";
					}
					
					console.log("state 값 : "+fbState);
					$.ajax("/userRest/json/updateBlock", {
						type : "POST",
						data : JSON.stringify({
							receiveId : userId,
							fbType : "2",
							fbState : fbState
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accept" : "application/json"
						},
						success : function(update, status) {
							console.log("서버로 받은 데이터(정상) : " + update.block.userId);
							if(update.block.fbState == 1){
							$(changeText).text("차단해제");
							}else if(update.block.fbState == 2){
							$(changeText).text("차단");
							}
						}
					})
				}
			})
		})

	});
	
	function getClubPostGo(clubPostNo){
		location.href = "/clubPost/getClubPost?clubPostNo="+clubPostNo;
	}
	
	// 닉네임, 프로필사진 클릭시 해당 유저의 마이홈피로 이동
	function getMyHomeGo(userId){
		location.href = "/myHome/getYourHome?userId="+userId;
	}


$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className) 
	$(".yourHome").on("click" , function() {
		var userId = $("#sendId").val(); 
		if($(this).parent().parent().attr("id")==userId){
			self.location = "/myHome/getMyHome?userId="+$(this).parent().parent().attr("id");
			
		}else{
			self.location = "/myHome/getYourHome?userId="+$(this).parent().parent().attr("id");
		}
	});
	$(document).on("click" ,".yourHome2", function() {
		var userId = $("#sendId").val(); 
		if($(this).parent().parent().attr("id")==userId){
			self.location = "/myHome/getMyHome?userId="+$(this).parent().parent().attr("id");
			
		}else{
			self.location = "/myHome/getYourHome?userId="+$(this).parent().parent().attr("id");
		}
	});
	
	$(document).on("click" ,".goHome", function() {
		var userId = $("#sendId").val(); 
		if($(this).parent().attr("id")==userId){
			self.location = "/myHome/getMyHome?userId="+$(this).parent().attr("id");
			
		}else{
			self.location = "/myHome/getYourHome?userId="+$(this).parent().attr("id");
		}
	});
	
	
 });
 
 
 

$(function(){
	
	<!-- REST CONTROLLTER TEST -->

	<!-- REST CONTROLLTER TEST -->
	
	<!-- ADD_FEED -->
	$(".addFeed").bind("click", function(){
		alert("피드 추가버튼");
		$(this.form).attr("method", "POST").attr("action", "/feed/addFeed").attr("enctype", "multipart/form-data").submit();
	});
	<!-- ADD_FEED -->
	
	<!-- UPDATE_FEED -->
	$(".btn_update").bind("click", function(){
		alert("피드 수정 버튼");
		$(this.form).attr("method", "GET").attr("action", "/feed/updateFeed").submit();
	});
	<!-- UPDATE_FEED -->
	
	<!-- DELETE_FEED -->
	$(".btn_delete").bind("click", function(){
		alert("피드 삭제 버튼");
		$(this.form).attr("method", "GET").attr("action", "/feed/deleteFeed").submit();
	});
	<!-- DELETE_FEED -->
	
	<!-- GET_FEED -->
	$(".btn_getFeed").bind("click", function(){
		alert("클릭한 글 번호 : " + $(this).parent().find("input[name='feedNo']").val());
		location.href="/feed/getFeed?feedNo=" + $(this).parents(".feedForm").find("input[name='feedNo']").val();
	})
	<!-- GET_FEED -->
	
	<!-- ADD_FEED_HEART -->
	$(".like:contains('좋아요')").bind("click", function(){
		event.stopPropagation();
		alert($(this).parents(".feedForm").children("input[name='feedNo']").val() + "번 글 좋아요");
		
		var html = $(this);
		
		$.ajax(
				{
					url : "/feedRest/json/addFeedHeart",
					method : "POST",
					data : JSON.stringify ({
						feedNo : $(this).parents(".feedForm").children("input[name='feedNo']").val()
					}),
					contentType: 'application/json',
					dataType : "json",
					header : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					}, // header end
					
					success : function(data, status) {
						
						swal.fire("피드 좋아요 성공 : " + data);
						
						$(html).parents(".row").children(".like:contains('좋아요')").hide();
						$(html).parents(".row").children(".dislike:contains('시러요')").show();
						$(html).parents(".row").children(".likeCount").text(data);
						
					} // success close
					
				} // ajax inner close
				
		) // ajax close
	})
	<%-- ADD_FEED_HEART --%>
		$(document).on("click", ".feedLike", function(event){
			event.stopPropagation();
			console.log($(this).parents(".feedForm").children("input[name='feedNo']").val() + "번 글 좋아요");
			
			var html = $(this);
			var sessionUser = $(this).parents(".feedForm").children("input[name='userId']").val();
			var feedNo = $(this).parents(".feedForm").children("input[name='feedNo']").val();
			var content = $(this).parents(".feedForm").children(".feedContent").text().trim();
			
			$.ajax(
					{
						url : "/feedRest/json/addFeedHeart",
						method : "POST",
						data : JSON.stringify ({
							source : 0,
							sourceNo : feedNo,
							userId : sessionUser
						}),
						contentType: 'application/json',
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, // header end
						
						success : function(data, status) {
							
							$(html).parents(".row").children(".likeCount").text(data);
							$(html).parent().html('<img class="feedDislike" src="/resources/image/uploadFiles/heart.jpg" />');
							
							if(sock) {
								var Msg = "feed,follower," + feedNo + ", 좋아요를 눌렀습니다."
								sock.send(Msg);
							}
							
						} // success close
						
					} // ajax inner close
					
			) // ajax close
		})
		<%-- ADD_FEED_HEART --%>
		
		<%-- DELETE_FEED_HEART --%>
		$(document).on("click", ".feedDislike", function(event){
			event.stopPropagation();
			console.log($(this).parents(".feedForm").children("input[name='feedNo']").val() + "번 글 시러요");
			
			var html = $(this);
			var sessionUser = $(this).parents(".feedForm").children("input[name='userId']").val();
			var feedNo = $(this).parents(".feedForm").children("input[name='feedNo']").val();
			var content = $(this).parents(".feedForm").children(".feedContent").text().trim();
			
			$.ajax(
					{
						url : "/feedRest/json/deleteFeedHeart",
						method : "POST",
						data : JSON.stringify ({
							source : 0,
							sourceNo : $(this).parents(".feedForm").children("input[name='feedNo']").val(),
							userId : sessionUser
						}),
						contentType: 'application/json',
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, // header end
						
						success : function(data, status) {
							
							console.log("피드 시러요 성공 : " + data);
							
							$(html).parents(".row").children(".likeCount").text(data);
							$(html).parent().html('<img class="feedLike" src="/resources/image/uploadFiles/no_heart.jpg" />');
							
							if(sock) {
								var Msg = "feed,follower," + feedNo + ", 좋아요를 취소했습니다."

								sock.send(Msg);
							}
							
						} // success close
						
					} // ajax inner close
					
			) // ajax close
		})
		<%-- DELETE_FEED_HEART --%>
	<!-- ADD_FEED_HEART -->
	$(document).on("click", ".carousel-control", function(event) {
		event.stopPropagation();
	})
	<%-- CAROUSEL 침범 방지 --%>
	
	<%-- CALL REPORT --%>
	$(document).on("click", ".report", function(event) {
		event.stopPropagation();
	    
		$(this).parent().parents(".feedForm").attr("method", "POST").attr("action", "/serviceCenter/addReport").submit();
		
	}) // .report evenet close
	<%-- CALL REPORT --%>
	$(".btn_getFeed").bind("click", function(){
		alert("클릭한 글 번호 : " + $(this).parent().find("input[name='feedNo']").val());
		location.href="/feed/getFeed?feedNo=" + $(this).parents(".feedForm").find("input[name='feedNo']").val();
	})
	$(document).on("click", ".feedForm", function(event) {
		event.stopPropagation();
		var feedNumber = $(this).children("input[name='feedNo']").val();
		location.href="/feed/getFeed?feedNo=" + feedNumber;
	})
	
	
	<!-- DELETE_FEED_HEART -->
	$(".dislike:contains('시러요')").bind("click", function(){
		event.stopPropagation();
		alert($(this).parents(".feedForm").children("input[name='feedNo']").val() + "번 글 시러요");
		
		var html = $(this);
		
		$.ajax(
				{
					url : "/feedRest/json/deleteFeedHeart",
					method : "POST",
					data : JSON.stringify ({
						feedNo : $(this).parents(".feedForm").children("input[name='feedNo']").val()
					}),
					contentType: 'application/json',
					dataType : "json",
					header : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					}, // header end
					
					success : function(data, status) {
						
						swal.fire("피드 시러요 성공 : " + data);
						
						$(html).parents(".row").children(".like:contains('좋아요')").show();
						$(html).parents(".row").children(".dislike:contains('시러요')").hide();
						$(html).parents(".row").children(".likeCount").text(data);
						
					} // success close
					
				} // ajax inner close
				
		) // ajax close
	})
	<!-- DELETE_FEED_HEART -->
	
})
	$(function(){
		/* 모임 게시물 좋아요 또는 좋아요취소 */
		$(document).on("click",".heart", function() {

			//alert("모임게시물 좋아요");
			
			var clubNo = $(this).attr("clubNo");
			var clubPostNo = $(this).attr("clubPostNo");
			var hearts = $(this);
			//alert( clubNo );
			//alert( clubPostNo );
			
			$.ajax( "/clubPostRest/json/updateClubPost",
					{
						method : "POST",
						data : JSON.stringify({
									clubNo : clubNo,
									clubPostNo : clubPostNo
								}),
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						dataType : "json",
						success : function(JSONData, status){
							// 기존의 이미지 경로를 지운다
							console.log( JSONData );
							//alert( JSONData.clubPostHeartCount );
							
							
							// 다른 경로를 붙인다
							// heartCondition
							if( $(hearts).parents(".post").attr("heartCondition") == 0 ){
								// 빨간색
								 $(hearts).parents(".post").attr("heartCondition", "1");
								$(hearts).attr("src", "/resources/image/uploadFiles/heart.jpg");
							}else{
								// 하얀색
								 $(hearts).parents(".post").attr("heartCondition", "0");
								$(hearts).attr("src", "/resources/image/uploadFiles/no_heart.jpg");
							}
							$("div[class='post']").find("p[class='clubPostHeartCountAjax"+JSONData.clubPostNo+"']").text( JSONData.clubPostHeartCount );
							
							if(sock) {
								var Msg = "하트 좋아요";
								sock.send(Msg);
							}
						}//end of success
					});
		}); // end of 하트
		

	})
 

	
	
	
	
	
</script>

<style>
.comment2 {
		width:25px !important;
	}

.modal-backdrop.in {
z-index: -1;
}
.my{
margin-right: 450px;
}
a {
    text-decoration: auto !important;
    width: 140px;
}
#main{
background-color : #EBEDF0 !important;
display : grid;
justify-content: center;
}

i{
color : #b276ff !important;

}


h5.meta-post {
    margin-bottom: 13px !important;
    color: black !important;
}

.main{
display:block;
position:relative;

}

#calendar {
	margin-left: 955px;
	margin-top: 15px;
	display: flex;
	justify-content: center;
	float: left;
	width : 675px;
	height : 680px;
	
}

.container {
	float: left;
	margin-left: 455px;
	display: flex;
	position:absolute;
	margin-top: 10px;
	width: 340px;
	background-color:#F5F6F7;
	border-radius: 15px;
}

/* Profile container */
.profile {
	margin: 20px 0;
}

/* Profile sidebar */
.profile-sidebar {
	padding: 20px 0 10px 0;
	width:500px;
	
}

.profile-userpic img {
	float: left;
	margin-left: 30px;
	width: 250px;
	height: 300px;
	-webkit-border-radius: 20% !important;
	-moz-border-radius: 20% !important;
	border-radius: 20% !important;
}

.profile-usertitle {
	text-align: center;
	margin-top: 20px;
	margin-right: 200px;
}

.profile-usertitle-name {
	
	font-size: 20px;
	font-weight: 600;
	margin-bottom: 7px;
}

.profile-usertitle-job {
	text-transform: uppercase;
	
	font-size: 16px;
	font-weight: 600;
	margin-bottom: 15px;
}

.profile-userbuttons {
	float: left;
	text-align: center;
	margin-top: 10px;
	margin-left: 60px;
}

.profile-userbuttons .btn {
	text-transform: uppercase;
	font-size: 15px;
	font-weight: 600;
	padding: 6px 15px;
	margin-right: 5px;
	color:blueviolet;
	border-color: blueviolet !important;
}

.profile-userbuttons .btn:last-child {
	margin-right: 0px;
}

.profile-usermenu {
	margin-top: 30px;

	
}

.profile-usermenu ul li {
	border-bottom: 1px solid #f0f4f7;
}

.profile-usermenu ul li:last-child {
	border-bottom: none;
}

.profile-usermenu ul li a {
	color: #b276ff;
	font-size: 15px;
	font-weight: 600;
}

.profile-usermenu ul li a i {
	margin-right: 8px;
	font-size: 14px;
	
}

.profile-usermenu ul li a:hover {
	background-color:#CCD0D5;
	
}


.profile-usermenu ul li.active {
	border-bottom: none;
}

.profile-usermenu ul li.active a {
	color: #5b9bd1;
	margin-left: -2px;
}

/* Profile Content */
.profile-content {
	padding: 20px;
	min-height: 460px;
}
.follow-section img {
 vertical-align: sub;
    display: inline-block;
    width: 80px;
    height: 80px;
    margin-top: 10px;
    margin-left: 10px;
    border-radius: 15px;
	
}

.follow-section {
	margin: 0px;
    display: flex;
    justify-content: space-between !important;
    align-items: center;
    margin-bottom: 20px;
    margin-left: 10px;
    margin-right: 10px;
}
.following-section img {
  vertical-align: sub;
    display: inline-block;
    width: 80px;
    height: 80px;
    margin-top: 10px;
    margin-left: 10px;
    border-radius: 15px;
	
}
.following-section {
	margin: 0px;
    display: flex;
    justify-content: space-between !important;
    align-items: center;
    margin-bottom: 20px;
    margin-left: 10px;
    margin-right: 10px;
}

.single-comment {
	padding-left: 0;
	margin-left : 80px;
    width : 560px;
    border: none;
    

    }
.ui-widget.ui-widget-content{
		
width:auto !important;    
}

.f {
	margin-left: 300px;
}

.comment-section {
	margin-left: 50px;
	margin-top: 50px;
	width: 700px;
	
	
    
}
.club{
margin-left: 100px;
}
.L {
	margin-left: 400px;
	width:500px;
}
.tab{
display:flex;
margin-left:150px;



}

/* 탭 전체 스타일 */
.tabs1 {
  margin-top: 120px;
  margin-bottom: 100px;
  background-color: #F5F6F7;
  width: 330px;
  display:inline-block;
  margin-left:310px;
  float: left;
  height:800px;
  border-radius: 15px;
  border: 2px solid #CCD0D5;
  }
  .tabs2 {
  margin-top: 120px;
  margin-bottom: 100px;
   background-color: #F5F6F7;
  width: 670px;
  display:inline-block;
  margin-left:170px;
  height:800px;
   border-radius: 15px;
   border: 2px solid #CCD0D5;
  
  
  
  
  }

/* 탭 스타일 */
.tab_item1 {
  width: calc(100%/3);
  height: 50px;
  border-bottom: 3px solid #EBEDF0;;
  background-color: #F5F6F7;
  line-height: 50px;
  font-size: 16px;
  text-align: center;
  color: #333333;
  display: block;
  float: left;
  width:330px;
  text-align: center;
  font-weight: bold;
  transition: all 0.2s ease;
  border-radius: 15px 15px 0px 0px ;
}
.tab_item-following {
  width: calc(100%/3);
  height: 50px;
  background-color: #F5F6F7;
  border-bottom: 3px solid #EBEDF0;
  line-height: 50px;
  font-size: 16px;
  text-align: center;
  color: #333333;
  display: inline-block;
  width:160px;
  text-align: center;
  font-weight: bold;
  transition: all 0.2s ease;
 border-radius: 15px 15px 0px 0px ;
}
.tab_item-follow {
  width: calc(100%/3);
  height: 50px;
  background-color: #F5F6F7;
  border-bottom: 3px solid #EBEDF0;
  line-height: 50px;
  font-size: 16px;
  text-align: center;
  color: #333333;
  display: block;
  float: left;
  width:160px;
  text-align: center;
  font-weight: bold;
  transition: all 0.2s ease;
  border-radius: 15px 15px 0px 0px ;
}

.tab_item2 {
  width: calc(100%/3);
  height: 50px;
  border-bottom: 3px solid #EBEDF0;
  background-color: #F5F6F7;
  line-height: 50px;
  font-size: 16px;
  text-align: center;
  color: #333333;
  display: inline-block;
  width:330px;
  text-align: center;
  font-weight: bold;
  transition: all 0.2s ease;
  border-radius: 15px 15px 0px 0px ;
}

.tab_item1:hover {
  opacity: 0.75;
}
.tab_item2:hover {
  opacity: 0.75;
}
}
.tab_item-follow:hover {
  opacity: 0.75;
}
}
.tab_item-following:hover {
  opacity: 0.75;
}

/* 라디오 버튼 UI삭제*/
input[name="tab_item"] {
  display: none;
}
input[name="tab_item-follow"] {
  display: none;
}

/* 탭 컨텐츠 스타일 */
.tab_content {
  display: none;
  padding: 0px 40px 0;
  clear: both;
  overflow: hidden;
  
}
.tab_content-follow {
  display: none;
  padding: 0px 40px 0;
  clear: both;
  overflow: hidden;

  
}


/* 선택 된 탭 콘텐츠를 표시 */
#all:checked ~ #all_content,
#programming:checked ~ #programming_content,
#design:checked ~ #design_content {
  display: block;
}
#all-follow:checked ~ #all-follow_content,
#programming-follow:checked ~ #programming-follow_content,
#design:checked ~ #design_content {
  display: block;
}

/* 선택된 탭 스타일 */
.tabs input:checked + .tab_item1 {
  background-color: #333333;
  color: #fff;
}
.tabs input:checked + .tab_item2 {
  background-color: #333333;
  color: #fff;
}
::-webkit-scrollbar {
  display: none;
}
.feedForm {
  margin-left:-70px;
  box-shadow: rgba(0, 0, 0, 0.3) 0px 19px 38px, rgba(0, 0, 0, 0.22) 0px 15px 12px;
  border-radius: 15px !important;
}

.feedForm > img {
    vertical-align: sub;
    display: inline-block;
    width: 80px;
    height: 80px;
    margin-top: 10px;
    margin-left: 10px;
    border-radius: 15px;
}
.neon {
  animation: neon 1s ease infinite;
  -moz-animation: neon 1s ease infinite;
  -webkit-animation: neon 1s ease infinite;
  font-family: 'Sacramento';
  
}
.caption h2 {
margin-top:35px !important;
}

@keyframes neon {
  0%,
  18%,
  22%,
  25%,
  53%,
  57%,
  100% {
    text-shadow: 0 0 4px #da00ff, 0 0 11px #da00ff, 0 0 19px #da00ff, 0 0 40px #da00ff,
      0 0 80px #da00ff, 0 0 90px #da00ff, 0 0 100px #da00ff, 0 0 150px #da00ff;
  }
  20%,
  24%,
  55% {
    text-shadow: none;
  }
}
.userbtn{
background-color :#EBEDF0; 
font-size: 15px; 
font-weight: 600;
width :300px;
border-radius: 15px;
margin-bottom: 15px;
text-align: center;
margin-left : 5px;
cursor: pointer;
}
header.transparent {
    background-color: white !important;
    -webkit-box-shadow: none;
    -moz-box-shadow: none;
    box-shadow: none;
}
.post{
width:500px;
margin-left:65px;

}
.btn{

	   background-color: white;
	   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	   border: solid 2px;
	   color:#5F0080;
	   border-color : #5F0080;

}

.btn:hover{
	   background-color: #5F0080 !important;
	   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	   color: white !important;
	   border-color : #5F0080;
	   border: solid 2px;
	}
.ui-dialog-titlebar{
border: hidden;
background-color: white;
display:none;
}
.ui-dialog-titlebar-close{
border: hidden;
background-color: white;
display:none;
}
#following{
color: white !important; 
background-color: #5F0080 !important;
}
#updateFollow{
 background-color: white;
	   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	   border: solid 2px;
	   color:#5F0080;
	   border-color : #5F0080;
}
#follow{
background-color: white;
	   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	   border: solid 2px;
	   color:#5F0080;
	   border-color : #5F0080;
}
.di{
border-radius:15px;

}
.goHome{
margin-left:10px;
}
.ui-widget.ui-widget-content{
		
width:auto !important; 
border-radius: 20px;   
}
.row{
border-radius: 15px !important;
}

nav > ul > li > a {
	color: white !important;
}

.reset a {
	color: white !important;
}

.yourHome {
	cursor: pointer;
}

.yourHome2 {
	cursor: pointer;
}

.dl {
	cursor: pointer;
}

.dll {
	cursor: pointer;
}

.feedContent > h4 {
	white-space: normal;
}

</style>
</head>

<body class="blog masonry-style">



	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	<%-- 채팅을 위한 소켓 --%>
	<script src="http://192.168.0.74:3000/socket.io/socket.io.js"></script>
	<%-- 채팅 js --%>
	<script src="/resources/javascript/chat/chat.js"></script>
	<%-- 채팅 css --%>
	<link rel="stylesheet" href="/resources/css/chat/chat.css" type="text/css" media="screen" title="no title">
	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>



	<main role="main" class="main">
		
			

			<div id="main" class="row">



				<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
				<%-- chat.js에서 사용위해서 --%>
					<input type="hidden" id="session_userId" value="${ sessionScope.user.userId }">
					<input type="hidden" id="session_profileImage" value="${ sessionScope.user.profileImage }">
					<input type="hidden" id="session_nickName" value="${ sessionScope.user.nickName }">
				<%-- chat.js에서 사용위해서 --%>
				<%-- 채팅 --%>
				<jsp:include page="/chat/chat.jsp" />
				<%-- 채팅 --%>
				<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
				
				
				
			<div>
			<jsp:include page="/toolbar.jsp" />
			</div>
			<div class="my" style="margin-top : 100px;">
			<div>
				<div id="calendar">

					<jsp:include page="/myHome/youCalendar.jsp" />
				</div>

				<div class="container">
					<div class="row profile">
						
							<div class="profile-sidebar">
								<!-- SIDEBAR USERPIC -->
								<div class="profile-userpic">
									<img
										src="/resources/image/uploadFiles/${getUser.profileImage}"
										class="img-responsive" width="100" height="100">
								</div>
								
								<!-- END SIDEBAR USERPIC -->
								<!-- SIDEBAR USER TITLE -->
								<div class="profile-usertitle">
								<input type="hidden" name="userId" id="userId2" value="${getUser.userId }">
								<input type="hidden" name="yuserId" id="yuserId" value="${getUser.userId }">
									<br/>
									<div class="profile-usertitle-name">${getUser.nickName }</div>
									<div class="profile-usertitle-job">${getUser.profileWriting }
									</div>
								</div>
								<!-- END SIDEBAR USER TITLE -->
								<!-- SIDEBAR BUTTONS -->
								<div class="profile-userbuttons">
							
								  <c:if test="${followUser.receiveId.userId == getUser.userId and fn:trim(followUser.receiveId.fbType) == '1'}">
									<c:if test="${fn:trim(followUser.receiveId.fbState) == '1'}">
										<button type="button" class="btn btn-sm" 
											id="following1" style="margin-top:50px; color: white !important;
	   background-color: #5F0080 !important;" >팔로잉</button>
									</c:if>
									<c:if test="${fn:trim(followUser.receiveId.fbState) == '2'}">
										<button type="button" class="btn btn-sm" 
											id="updateFollow1" style="margin-top:50px;">팔로우</button>
									</c:if>
								</c:if> 
								<c:if test="${ empty followUser }">
									<button type="button" class="btn btn-sm" id="follow1" style="margin-top:50px;">팔로우</button>
								</c:if>
                                   &nbsp; &nbsp;&nbsp;

								<c:if
									test="${block.receiveId.userId == getUser.userId and fn:trim(block.receiveId.fbType) == '2'}">
									<c:if test="${fn:trim(block.receiveId.fbState) == '1'}">
										<button type="button" class="btn btn-sm"
											id="stopBlock1" style="margin-top:50px; color: white !important;
	   background-color: #5F0080 !important;">차단해제</button>
									</c:if>
									<c:if test="${fn:trim(block.receiveId.fbState) == '2'}">
										<button type="button" class="btn btn-sm"
											id="updateBlock1" style="margin-top:50px;">차단</button>
									</c:if>
								</c:if>
								<c:if test="${ empty block }">
									<button type="button" class="btn btn-sm" id="block1" style="margin-top:50px;">차단</button>
								</c:if>
								<br> <br>

							</div>
							<div>
								<input type="hidden" name="sendId" id="sendId"
									value="${sessionScope.user.userId}"> <input
									type="hidden" name="recvId" id="recvId"
									value="${getUser.userId}">
									<input type="hidden" id="myId" value=${followUser.userId }>
							</div> 
								<!-- END SIDEBAR BUTTONS -->
								<!-- SIDEBAR MENU -->
							
								<!-- END MENU -->
							</div>
							</div>
							</div>
					</div>
				</div>
<div class="tab">
			<div class="tabs1">
			<input id="all-follow" type="radio" name="tab_item-follow" checked>
    <label class="tab_item-follow" for="all-follow"><h4> 팔로우</h4></label>
    <input id="programming-follow" type="radio" name="tab_item-follow">
    <label class="tab_item-following" for="programming-follow"><h4>팔로워</h4></label>
    
    <div class="tab_content-follow" id="all-follow_content" style="white-space:nowrap; overflow-x:hidden; overflow-y:auto; width:300px; height:700px;">
        		
        		<br />
		<c:set var = "i" value = "0" />
		<c:forEach var = "list" items = "${list}">
			<c:set var = "i" value = "${i + 1}" />
			<div class="follow-section" style="margin-left:50px;" id="${list.receiveId.userId }">
			<div style="display: inline-block; margin-left :-50px;"><img class="dl" src="/resources/image/uploadFiles/${list.receiveId.profileImage}" id="${list.receiveId.profileImage}" width="100" height="100" /></div><div style="float: right;"><h4 class="yourHome">${list.receiveId.nickName}</h4>
			</div>
					<div id="${list.receiveId.nickName }" style="display:none;"></div>
					<input type="hidden" class="${list.receiveId.userId }" value="${list.receiveId.nickName }">
				</div>
			</c:forEach>
		
			
		
				</div>
				<div class="tab_content-follow" id="programming-follow_content" style="white-space:nowrap; overflow-x:hidden; overflow-y:auto; width:300px; height:700px;">
     <div id="fl">
					 		<br />
			
								
</div>
</div>
  </div>
			
		
<div class="tabs2">
    <input id="all" type="radio" name="tab_item" checked>
    <label class="tab_item1" for="all"><h4>내가 쓴 피드</h4></label>
    <input id="programming" type="radio" name="tab_item">
    <label class="tab_item2" for="programming"><h4>내 모임 게시물</h4></label>
    
 
    <div class="tab_content" id="all_content" style="white-space:nowrap; overflow-x:hidden; overflow-y:auto; width:660px; height:700px; margin-left:-30px;">
        		<div class="comment-section" style="margin-left:-50px; width:720px; " >
					<br />
					<c:set var="i" value="0"></c:set>
					<c:forEach var="feed" items="${feedList}">
						<c:set var="i" value="${i + 1}"></c:set>

						<c:if test="${fn:trim(feed.deleteCondition) eq '0' and fn:trim(feed.reportCondition) eq '0'}">

							<div class="single-comment">
								<form class="feedForm">
									

										<img src="/resources/image/uploadFiles/${feed.user.profileImage}" /><h4 style="vertical-align: text-bottom;">${feed.user.nickName}</h4>
									 &nbsp; &nbsp;
									<!-- comment-author -->
									<h5 class="meta-post" style="display: inline-block; vertical-align: text-bottom;">
											<c:if test="${!empty feed.updateDate}">${feed.updateDate}</c:if>
											<c:if test="${empty feed.updateDate}">${feed.regDate}</c:if>
										</h5>
									<c:if test="${sessionScope.user.userId eq feed.user.userId}">
											
											<div style="display: inline-block; float: right; margin-top:10px; margin-right:10px;">
												<%-- 수정 버튼 --%>
												<span class="glyphicon glyphicon-paperclip btn_update" aria-hidden="true"></span>
												<%-- 수정 버튼 --%>
											
												<%-- 삭제 버튼 --%>
												<span class="glyphicon glyphicon-trash btn_delete" aria-hidden="true" ></span>
												<%-- 삭제 버튼 --%>
											</div>
										</c:if>
									
									<!-- comment-meta -->
									<div class="feedContent">
											<h4>${feed.content}</h4>
											
											<%-- 이미지 --%>
											<c:if test="${!empty feed.image1}">
											<div id="carousel-example-generic${i}" class="carousel slide" data-ride="carousel">
												<ol class="carousel-indicators">
													<li data-target="#carousel-example-generic${i}" data-slide-to="0" class="active"></li>
													
													<c:if test="${!empty feed.image2}">
														<li data-target="#carousel-example-generic${i}" data-slide-to="1"></li>
													</c:if>
													<c:if test="${!empty feed.image3}">
														<li data-target="#carousel-example-generic${i}" data-slide-to="2"></li>
													</c:if>
													<c:if test="${!empty feed.image4}">
														<li data-target="#carousel-example-generic${i}" data-slide-to="3"></li>
													</c:if>
												</ol>
											
												<!-- Wrapper for slides -->
												<div class="carousel-inner" role="listbox">
													<div class="item active">
														<img src="/resources/image/uploadFiles/${feed.image1}" alt="${feed.image1}">
													</div>
													
													<c:if test="${!empty feed.image2}">
														<div class="item">
															<img src="/resources/image/uploadFiles/${feed.image2}" alt="${feed.image2}">
														</div>
															<c:if test="${!empty feed.image3}">
																<div class="item">
																	<img src="/resources/image/uploadFiles/${feed.image3}" alt="${feed.image3}">
																</div>
																<c:if test="${!empty feed.image4}">
																	<div class="item">
																		<img src="/resources/image/uploadFiles/${feed.image4}" alt="${feed.image4}">
																	</div>
																</c:if>
															</c:if>														
													</c:if>
												</div>
	
												<!-- Controls -->
												<a class="left carousel-control carousel_prev" href="#carousel-example-generic${i}" role="button" data-slide="prev">
													<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
													<span class="sr-only">Previous</span>
												</a>
												<a class="right carousel-control carousel_next" href="#carousel-example-generic${i}" role="button" data-slide="next">
													<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
													<span class="sr-only">Next</span>
												</a>
											</div>
											</c:if>
											<%-- 이미지 --%>
											
										</div>
										<c:if test="${!empty feed.hashtag}">
											<div class="hashtagContent">
												${feed.hashtag}
											</div>
										</c:if>
										<%-- 피드 댓글 신고 --%>
										<input type="hidden" name="reportSource" value="3">
										<input type="hidden" name="sourceNumber" value="${feed.feedNo}">
										<input type="hidden" name="user2" value="${feed.user.userId}">
										<%-- 피드 댓글 신고 --%>
										
										<input type="hidden" name="source" value="0">
										<input type="hidden" name="feedNo" value="${feed.feedNo}">
										<input type="hidden" id="userId" name="userId" value="${sessionScope.user.userId}">
										<input type="hidden" name="openCondition" value="3">
								
								 
									<input type="hidden" name="feedNo" value="${feed.feedNo}">

									<section class="row section lastBar">
											<div class="row">
												<%-- 여백 --%>
												<div class="col-xs-1"></div>
												<%-- 여백 --%>
											
												<c:if test="${feed.checkHeart eq 0}">
													<div class="col-xs-2">
														<img class="feedLike" src="/resources/image/uploadFiles/no_heart.jpg" aria-hidden="true"/>
													</div>
												</c:if>
												<c:if test="${feed.checkHeart ne 0}">
													<div class="col-xs-2">
														<img class="feedDislike" src="/resources/image/uploadFiles/heart.jpg" aria-hidden="true"/>
													</div>
												</c:if>
												
												<div class="col-xs-1 likeCount">
													${feed.heartCount}
												</div>
												
												<div class="col-xs-1">
												</div>
												
												<div class="col-xs-2 comment">
													<img src="/resources/image/uploadFiles/comment2.jpg" aria-hidden="true"/>
												</div>
												
												<div class="col-xs-1 commentCount">
													 ${feed.commentCount}
												</div>
												
												<div class="col-xs-1">
												</div>
													
												<!-- 신고 아이콘 -->
												<div class="col-xs-2 report">
													<img src="/resources/image/uploadFiles/report.jpg" aria-hidden="true"/>
												</div>
												<!-- 신고 아이콘 -->
												
												<%-- 여백 --%>
												<div class="col-xs-1"></div>
												<%-- 여백 --%>
												
											</div>
										</section>
								</form>
							</div>

						</c:if>
					</c:forEach>
					<div class="modal fade" id="commentModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					
					<form class="form-horizontal" id="commentForm">
					
						<div class="commentContentCover">
							<div class="commentContentTitle">
								댓글
							</div>
							
							<div class="commentModalContent">
								<textarea class="content" id="contentModal" name="content" placeholder="댓글을 입력하세요." maxlength="500"></textarea>
							</div>
						</div>
						
					</form>
						
						<div class="modal-footer">
							<button type="button" class="btn btn-default" data-dismiss="modal">
								Close
							</button>
							<button type="button" class="btn btn-default addCommentByModal">등록</button>
						</div>
						
						<input type="hidden" id="commentModalFeedNo" value="">
						
				</div>
			</div>
		</div>
					

				</div>
				<%-- 현재 페이지 --%>
					<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}">
					<input type="hidden" id="pageFlag" value=true>
					<%-- 현재 페이지 --%>
    </div>
    <div class="tab_content" id="programming_content" style="white-space:nowrap; overflow-x:hidden; overflow-y:auto; width:820px; height:700px; margin-left : 10px;">
    
    <br/>
     <div class="col-md-4" id="cp">
		</div>									
</div>

  </div>
			</div>
		</div>
		
	</main>

	 
	<script type="text/javascript">
$(function() {
	$(".tab_item2").on("click" , function(e) {
		var userId = $("#yuserId").val(); 
		$(".tab_item2").off(e);
	$.ajax({
		url : "/myHomeRest/json/getClubPostList", // 어디로 갈거니? // 갈 때 데이터
		type : "POST", // 타입은 뭘 쓸거니?
		datatype : "json",
		 data		:  JSON.stringify({
			userId : userId
		 }),
		 
		contentType : "application/json",
		success : function(data) { 
       console.log(data.ClubPostList[1]);
       
       $.each(data.ClubPostList, function(index, item) { // 데이터 =item
    	   console.log(item.clubPostNo);
    	   console.log( "하트컨디션 : " + item.heartCondition);
    	   var heartImage = item.heartCondition != 0? 'heart.jpg' : 'no_heart.jpg';
    	   console.log( "하트이미지 : " + heartImage ); 
			var date = "";
			if(item.clubPostUpdateDate != null){
				date = item.clubPostUpdateDate+"(수정됨)";
			}else{
				date = item.clubPostRegDate;
			};
			
			
			var value = "";
			if(item.clubPostVideo1 == null){
				value =
					"<div class='post' clubPostNo='"+item.clubPostNo+"' clubNo='"+item.clubNo+"' heartCondition='"+item.heartCondition+"' style='width:500px; margin-left:65px; margin-bottom : 40px;'>"+
					"<h5 style='text-align:right; margin-right:120px; font-size:15px !important; color:black !important;'>"+date+"</h5>"+
				"<a href='javascript:getClubPostGo("+item.clubPostNo+")'>"+
				"<img src='/resources/image/uploadFiles/"+item.image1+"' height='300' width='400' style='border-radius:20px;'>"+
			"</a>"+
			"<div style='width: 87%;'>"+
			"<p align='center' style='font-size: 25px; margin-bottom : -20px;'>"+item.clubPostTitle+"</p>"+
		"</div>"+
			"<div style='display: flex; width: 87%;'>"+
				"<div style='flex:1; margin-top:10px;'>"+
				"<a href='javascript:getMyHomeGo(\"item.user.userId\")'>"+
						"<img src='/resources/image/uploadFiles/"+ item.user.profileImage+ "' height='70' width='70' style='border-radius:50px;'>"+
					"</a>"+
					
				"</div>"+
				"<div style='margin-right:130px; padding-top: 15px;'>"+
					/* "<a href='/myHome/getYourHome?userId="+item.user.userId+">"+ */
					"<a href='javascript:getMyHomeGo(\"item.user.userId\")'>"+
						"<p align='center' style='font-size: 20px;'>"+ item.user.nickName+ "</p>"+
					"</a>"+
				"</div>"+"<div style='margin-left:-50px;'><img style='padding-top:35px;' class='comment2' src='/resources/image/uploadFiles/comment2.jpg'></div><div style='margin-left:15px;'><p style='padding-top:17px;'>"+item.clubPostCommentCount+"</p></div>"+
				"<div style='padding-top: 33px; margin-left:50px;'>"+
                <!-- heartCondition에 모임 게시물 번호가 있으면 해당 유저가 좋아요했다 / 0이면 좋아요 안했다 -->
                "<img class='heart'style='float: right;' clubPostNo='"+item.clubPostNo+"' src='/resources/image/uploadFiles/"+heartImage+"' height='30' width='30'>"+
             "</div>"+
				"<div style='flex:1;  padding-top: 15px;' >"+
					"<p align='center' class='clubPostHeartCountAjax"+item.clubPostNo+"' style='font-size: 20px; margin-right: 35px;'>"+ item.clubPostHeartCount+ "</p>"+
				"</div>"+
			
				
			"</div>"+
			"</div>";

				
			}else{
				value =
					"<div class='post' clubPostNo='"+item.clubPostNo+"' clubNo='"+item.clubNo+"' heartCondition='"+item.heartCondition+"' style='width:500px; margin-left:65px; margin-bottom : 30px;'>"+
					"<h5 style='text-align:right; margin-right:120px; font-size:15px !important; color:black !important;'>"+date+"</h5>"+
				"<a href='javascript:getClubPostGo("+item.clubPostNo+")'>"+
				"<img src='https://img.youtube.com/vi/"+item.clubPostVideo1+"/mqdefault.jpg' height='300' width='400' style='border-radius:20px;'>"+
				
			"</a>"+
			"<div style='width: 87%;'>"+
			"<p align='center' style='font-size: 25px; margin-bottom : -20px;'>"+item.clubPostTitle+"</p>"+
			"</div>"+
			"<div style='display: flex; width: 87%;'>"+
				"<div style='flex:1; margin-top:10px;'>"+
				"<a href='javascript:getMyHomeGo(\"item.user.userId\")'>"+
						"<img src='/resources/image/uploadFiles/"+ item.user.profileImage+ "' height='70' width='70' style='border-radius:50px;'>"+
					"</a>"+
				"</div>"+
				"<div style='flex:1; margin-right:130px; padding-top: 15px;'>"+
					/* "<a href='/myHome/getYourHome?userId="+item.user.userId+">"+ */
					"<a href='javascript:getMyHomeGo(\"item.user.userId\")'>"+
						"<p align='center' style='font-size: 20px;'>"+ item.user.nickName+ "</p>"+
					"</a>"+
				"</div>"+"</div>"+"<div style='margin-left:-50px;'><img style='padding-top:35px;' class='comment2' src='/resources/image/uploadFiles/comment2.jpg'></div><div style='margin-left:15px;'><p style='padding-top:17px;'>"+item.clubPostCommentCount+"</p></div>"+
				"<div style='padding-top: 33px; margin-left:50px;'>"+
                <!-- heartCondition에 모임 게시물 번호가 있으면 해당 유저가 좋아요했다 / 0이면 좋아요 안했다 -->
                "<img style='float: right;' class='heart' clubNo='"+item.clubNo+"' clubPostNo='"+item.clubPostNo+"' src='/resources/image/uploadFiles/"+heartImage+"' height='30' width='30'>"+
             "</div>"+
				"<div style='flex:1; padding-top: 15px;'>"+
					"<p align='center'class='clubPostHeartCountAjax"+item.clubPostNo+"' style='font-size: 20px; margin-right: 35px;'>"+ item.clubPostHeartCount+ "</p>"+
				"</div>"+
			
				
			"</div>"+
			"</div>";
				
			};
			
				
			$("#cp").append(value);
                      
			
		})
		
		}	
	});
});
	
	$(".tab_item-following").on("click" , function(e) {
		var userId = $("#yuserId").val(); 
		$(".tab_item-following").off(e);
	$.ajax({
		url : "/myHomeRest/json/getFollowerList", // 어디로 갈거니? // 갈 때 데이터
		type : "POST", // 타입은 뭘 쓸거니?
		datatype : "json",
		 data		:  JSON.stringify({
			 searchKeyword : userId
		 }),
		 
		contentType : "application/json",
		success : function(data) { 
       console.log(data.followerList[1]);
       $.each(data.followerList, function(index, item) { // 데이터 =item
    	   console.log(item);
			var value = 
				"<div class='following-section' style='margin-left:50px;' id='"+item.userId+"' name='"+item.nickName+"'>"+
			"<div style='display: inline-block; margin-left :-50px;'>"+"<img class='dll' src='/resources/image/uploadFiles/"+item.profileImage+"' id='"+item.profileImage+"' width='100' height='100' />"+"</div><div style='float: right;'>"+
			"<h4 class='yourHome2'>"+item.nickName+"</h4></div><div id='"+item.nickName+"1' style='display:none;'></div>"+"<input type='hidden' class='"+item.userId+"' value='"+item.nickName+"'>"+
		"</div>";
			
			
			$("#fl").append(value);      
			
			
			
		})
		
		}	
	});
});
	
	 
});	

</script>
	

</body>
</html>
