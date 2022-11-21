<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="description" content="The Page Description">
<style type="text/css">
@
-ms-viewport {
	width: device-width;
}
</style>
<title>LINK</title>

<link rel="stylesheet" href="/resources/css/layers.min.css" media="screen">
<link rel="stylesheet" href="/resources/css/font-awesome.min.css" media="screen">
<link rel="stylesheet" href="/resources/css/style.css" media="screen">

<%-- BOOTSTRAP ICON --%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
<%-- BOOTSTRAP ICON --%>


<!--[if lt IE 9]>
		<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
		<![endif]-->

<%-- alert --%>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<%-- SOCKET IO --%>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.5/sockjs.min.js"></script>
<%-- SOCKET IO --%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

<link href="/resources/summernote/summernote-lite.css" rel="stylesheet">
<script src="/resources/summernote/summernote-lite.js"></script>


<script>
		var sock = null;

		$(document).ready(function () {
			connectWs();
		});

		function connectWs() {

			sock = new SockJS("<c:url value="/echo"/>");
			
			sock.onopen = function () {
				console.log('open');

			};

			sock.onmessage = onMessage;

			sock.onclose = function () {
				console.log('close');
			};

		};

		function getContextPath() {
			var hostIndex = location.href.indexOf(location.host) + location.host.length;

			return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
		};
		
		function onMessage(evt){
			var data = evt.data;
		    
		    const Toast = Swal.mixin({
		    	  toast: true,
		    	  position: 'bottom-end',
		    	  showConfirmButton: false,
		    	  timer: 10000,
		    	  timerProgressBar: true,
		    	  didOpen: (toast) => {
		    	    toast.addEventListener('mouseenter', Swal.stopTimer)
		    	    toast.addEventListener('mouseleave', Swal.resumeTimer)
		    	  }
		    	})

		    	Toast.fire({
					icon: 'info',
					title: data
		    	})
		    
		};	
	
</script>


<script>
			
			$(function () {
				
				$(document).on("click",".clubNav", function() {
					
					Swal.fire({
						title: '로그인 후 이용해주세요' ,
						showCancelButton: false,
						confirmButtonColor: '#3085d6',
						cancelButtonColor: '#d33',
						confirmButtonText: '확인', 
					}).then((result) => {
						if(result.value) {
							return;	
						}
					})
				})
			});


			function getModal() {
				
				$('#modalLogin').modal();
			}

			
			$(function() {
				$('#login').on('click', function(event) {
				//alert("zmfflr");
					event.stopPropagation();
					$('#modalLogin').modal();
				})
				/*  $('#ml').on("click", function(event) {
					event.stopPropagation();
					$('.modal.fade.login').modal('hide');
				})  */
			}); 
			

			
		</script>

</head>

<style>
header {
	display: flex;
	background: linear-gradient(0deg, #958c8cc4, black);
}

/* SCROLL */
body.page {
	overflow-y: scroll !important;
}

body.page::-webkit-scrollbar {
	display: none !important;
}

body.swal2-shown {
	padding-right: 0px !important;
}

/* SCROLL */
header {
	overflow-y: scroll !important;
}

header::-webkit-scrollbar {
	display: none !important;
}

html {
	background-color: whitesmoke !important;
}

#main {
	background-color: whitesmoke !important;
}



/* SCROLL */

/* SCROLL */
</style>


</head>

<body class="page"> 

   <header role="banner" class="transparent light"> 
      <div class="row">
         <div
            class="nav-inner row-content buffer-left buffer-right even clear-after">
            <div id="brand">
               <h1 class="reset">
                  <!--<img src="img/logo.png" alt="logo">-->
                  <a href="/feed/getFeedList"><img src="/resources/image/uploadFiles/link_logo3.png" width=120px; height=48px; alt="logo"></a>
               </h1>
            </div>
            <!-- brand -->
            <a id="menu-toggle" href="#"><i class="fa fa-bars fa-lg"></i></a>
            <nav>
               <ul class="reset" role="navigation">
                  <li class="menu-item"><a href="/feed/getFeedList">Feed</a></li>
                  
                  <c:if test="${! empty sessionScope.user }">
                  	<li class="menu-item"><a href="/club/getClubList">Club</a></li>
                  </c:if>

                  <li class="menu-item"><a href="#" id='live'>LIVE</a></li>
                  
                  <c:if test="${ empty sessionScope.user }">
                  	<li class="menu-item"><a href="#" class="clubNav" onclick="clubNav();">Club</a></li>
                  </c:if>
                  
                  <li class="menu-item"><a
                     href="/myHome/getMyHome?userId=${sessionScope.user.userId}">MyHome</a></li>
                  <li class="menu-item"><a
                     href="/serviceCenter/serviceCenterHome">ServiceCenter</a></li>
                  <c:if test="${ empty sessionScope.user }">
                     <li class="menu-item">
                     <a href="#" id='login'  onClick="getModal()">로그인</a></li>
                  </c:if>
                  <c:if test="${!empty sessionScope.user }">
                     <li class="menu-item"><a
                        href="/user/logout?userId=${sessionScope.user.userId}">로그아웃</a></li>
                     <c:if test="${fn:trim(sessionScope.user.role) == '0' }">
                        <li class="menu-item"><a
                           href="/user/getUser?userId=${sessionScope.user.userId}">내정보보기</a></li>
                           
                     </c:if>
                     <c:if test="${fn:trim(sessionScope.user.role) == '1' }">
                        <li class="menu-item"><a href="/user/getUserList">관리자페이지</a></li>
                     </c:if>
                     
                     
                  </c:if>
                  
               </ul>
               
            </nav>
            <input type="hidden" id='liveJoinId' value="${sessionScope.user.nickName}">
            <input type="hidden" id='liveJoinProfile' value="${sessionScope.user.profileImage}">
         </div>
         <!-- row-content -->
         
        
      </div>
      
      <jsp:include page="/user/login.jsp" />
      <%--

	<header role="banner" class="transparent light">
		<div class="row">
			<div class="nav-inner row-content buffer-left buffer-right even clear-after">
				<div id="brand">
					<h1 class="reset">
						<!--<img src="img/logo.png" alt="logo">-->
						<a href="/main.jsp"><img src="/resources/image/uploadFiles/link_logo3.png" width="120px" height="48px"></a>
					</h1>
				</div>
				<!-- brand -->

				<nav>
					<ul class="reset" role="navigation">
						<li class="menu-item"><a href="/main.jsp">Home</a></li>
						<li class="menu-item"><a href="/feed/getFeedList">Feed</a></li>

						<c:if test="${! empty sessionScope.user }">
							<li class="menu-item"><a href="/club/getClubList">Club</a></li>
						</c:if>

						<c:if test="${ empty sessionScope.user }">
							<li class="menu-item"><a href="#" class="clubNav" onclick="clubNav();">Club</a></li>
						</c:if>

						<li class="menu-item"><a href="/myHome/getMyHome?userId=${sessionScope.user.userId}">MyHome</a></li>
						<li class="menu-item"><a href="/serviceCenter/serviceCenterHome">ServiceCenter</a></li>
						<c:if test="${ empty sessionScope.user }">
							<li class="menu-item"><a href="/user/login">로그인</a></li>
						</c:if>
						<c:if test="${!empty sessionScope.user }">
							<li class="menu-item"><a href="/user/logout?userId=${sessionScope.user.userId}">로그아웃</a></li>
							<c:if test="${fn:trim(sessionScope.user.role) == '0' }">
								<li class="menu-item"><a href="/user/getUser?userId=${sessionScope.user.userId}">내정보보기</a></li>

							</c:if>
							<c:if test="${fn:trim(sessionScope.user.role) == '1' }">
								<li class="menu-item"><a href="/user/getUserList">관리자페이지</a></li>
							</c:if>


						</c:if>

					</ul>

				</nav>

			</div>
			<!-- row-content -->
		</div>
		<%--
		

		<c:if test="${!empty sessionScope.user }">
			<div class="alarmHead" >
							
				<img class="alarmImg" alt="" src="/resources/image/uploadFiles/alarm.png" aria-hidden="true" data-toggle="modal" data-target="#alarmModal"/>
				<span class="badge">
					<c:if test="${empty alarmCount }">
					0
					</c:if>
					<c:if test="${!empty alarmCount }">
					${alarmCount}
					</c:if>
				</span>
			
			</div>
		</c:if>
		
		--%>
		<!-- row -->
	</header>
	<script type="text/javascript">
	$(function() {
				
				//alert("123");
		/* 		var options = {
					"forcNew" : true
				}; */
				var url = "https://192.168.0.183:4000";

				socket = io.connect(url);

				socket.on("connect", function() {
					//alert("소켓연결 완료");
				});
				
				$("#live").on("click", function() {
					
					if(${ empty sessionScope.user}){
						swal.fire('로그인이 필요합니다.');
						return;
					}
					
					var profile = $("#liveJoinProfile").val();
					var nickName = $("#liveJoinId").val();
					var num;
					console.log("profile : "+profile);
					console.log("nickName : "+nickName);
					
					$.ajax("/liveRest/json/getLiveList", {
						type : "POST",
						data : JSON.stringify({
							type : '1',
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accept" : "application/json"
						},
						success : function(Data) {
							console.log(Data);
							var roomName = "";
							$.each (Data, function(index, data) {
								roomName += "<div style='margin-top: 10px;' id='"+data.roomName+"'><span style='font-size: larger; font-weight: bold; color: black;'>"
								+(index+1)+". "+data.viewRoomName+"</span><span style='font-size: larger; font-weight: bold;" 
								+"color: black;'>("+data.member+"/"+data.limit+")</span><button type='button'" 
								+"class='joinLive' style=' margin-left: 20px;'><input type='hidden'"
								+"value='"+data.viewRoomName+"'/>입장</button></div>";
							})
							swal.fire({
								title : "화상채팅방",
								showCancelButton : true,
								cancelButtonText : '취소',
								confirmButtonText : '채팅방개설',
								html: "<div id='roomNameList1' style='text-align-last: left; margin-left: 70px;'></div>",
							}).then((result) => { 
								var viewName;
								if(result.isConfirmed){
								swal.fire({
									title : "채팅방개설",
									html : "<input type='text' id='roomName' class='swal2-input' placeholder='방제목'>" +
									"<input type='text' id='total' class='swal2-input' placeholder='인원수'>",
									showCancelButton : true,
									cancelButtonText : '취소',
									confirmButtonText : '개설',
									preConfirm : () => {
										var total = Swal.getPopup().querySelector('#total').value
										var roomName = Swal.getPopup().querySelector('#roomName').value
									$.ajax("/liveRest/json/addLive", {
								 		type : "POST",
										data : JSON.stringify({
											roomName : nickName+":"+roomName,
											type : '1',
											limit : total,
										}),
										dataType : "json",
										contentType : "application/json",
										headers : {
											"Accept" : "application/json"
										}, 
										success : function(json) {
											console.log(json);
											var name = nickName+":"+roomName;
											socket.emit("info", {
												roomName : name,
												viewName : roomName,
												total : total,
												profile : profile,
												nickName : nickName,
												member : 1
												});
											self.location = "https://192.168.0.183:4040";
										}
									}) 
								}
							})
								}
							})
							$("#roomNameList1").append(roomName);
							
							$("button.joinLive").on("click", function() {
								//alert("asdf");
								var clubNo = $("#no").val();
								var roomName = $(this).parent().attr("id");
								var viewName = $(this).children().val();
								console.log(roomName);
								$.ajax("/liveRest/json/getLive",{
									method : "POST",
									data : JSON.stringify({
										roomName : roomName,
										type : '1',
									}),
									dataType : "json",
									contentType : "application/json",
									headers : {
										"Accept" : "application/json"
									},
									success : function (data) {
										console.log(data);
										socket.emit("info", {
											total : data.limit,
											roomName : roomName,
											viewName : viewName,
											profile : profile,
											nickName : nickName,
											member : data.member
										});
										self.location = "https://192.168.0.183:4040";
									},
									error : function () {
										console.log("error");
											swal.fire('인원초과입니다.');
											return;
									}
								})
							})
						} 
					}) 
				})
				
				socket.on("reRoomName", function(data) {
					var clubNo = $("#no").val();
					console.log("socket서버에서 받은 Data : "+data);
					if(data != null){
					$.ajax("/liveRest/json/exitLive", {
						method : "POST",
						data : JSON.stringify({
							roomName : data,
							type : '1',
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accept" : "application/json"
						},
						success : function(Data) {
							console.log(Data);
						}
					})
					}
				})
			})
			</script>
			<script src="https://192.168.0.183:4000/socket.io/socket.io.js"></script>
	</body>