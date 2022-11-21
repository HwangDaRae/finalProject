<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="ko">
<head>

<!-- <link rel="stylesheet" href="/css/admin.css" type="text/css"> -->

<title>모임상세조회</title>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!-- alert -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>


<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<!-- ?? -->
<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>
<script type="text/javascript">
	
	/* 새로고침하면 모임 또 생성된다 막자 */
	function NotReload() { 
	    if((event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82)) || (event.keyCode == 116) ) { 
	        event.keyCode = 0; 
	        event.cancelBubble = true;
	        event.returnValue = false; 
	    } 
	} 
	document.onkeydown = NotReload;
	
	$(function () {
		
		$(document).on("click","#deleteClub", function() {
		
			Swal.fire({
				  title: '정말 모임을 삭제하시겠습니까?',
				  text: "삭제한 모임은 복구가 불가능합니다.",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '삭제',
				  cancelButtonText: '취소' ,
				}).then((result) => {
				  if (result.value) {
				    
				    $("form").attr("method", "POST").attr("action", "/club/deleteClub").submit();
				  }
				})
		})
	});
	$(function() {
		
		$("#club-add-approval").bind("click", function() {
			
			var totalApprovalConditionCount = $("input[name='totalApprovalConditionCount']").val();
			var joinClubLimit = $("input[name='joinClubLimit']").val();
			
			//alert(totalApprovalConditionCount);
			//alert(joinClubLimit);
			
			if(totalApprovalConditionCount < joinClubLimit) {
			//모달창 열기
			$('#approvalModal').modal("show");
			} else {
				
				Swal.fire({
					title: '모임 최대 한도 수를 초과하였습니다.' ,
					text: "결제를 통해 모임 한도를 늘릴 수 있습니다." ,
					icon: 'warning',
					showCancelButton: false,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '확인',
				}).then((result) => {
					if(result.value){
					
						self.location="/clubPost/addPayView?payNavigation=1"
					}
				})
			}
		});
		
		$("input[value='신청']").bind("click", function() {
			
			if($.trim($("input[name='joinGreeting']").val()) == '' ){
				Swal.fire({
					icon: 'error' ,
					title: '제목은 필수입니다'
				})
				return;
			}
			
			$("form").attr("accept-charset" , "EUC-KR").submit();
		});
		
		
		$("input[value='취소']").bind("click", function() {
			
			//모달창 닫기
			$('#approvalModal').modal("hide");
		});
		
		$("button[class='close']").bind("click", function() {
			$('#approvalModal').modal("hide");
		});
	});
	
	$(function() {
		$("#addMeeting").on("click", function() {
			self.location="/club/addMeetingView?clubNo=${ clubNo }";
		});
	});
	
/* 	$(function() {
		$("#deleteClub").on("click", function() {
			fncDeleteClub();
		});
	}); */
	
	$(function() {
		$("#cancel").bind("click", function() {
			history.go(-1);
		});
	});
	
	$(function () {
		
		$(document).on("click","#deleteApprovalCondition", function() {
		
			Swal.fire({
				  title: '정말 모임을 탈퇴하시겠습니까?',
				  text: "탈퇴 시 다시 가입 신청을 해야합니다",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '삭제',
				  cancelButtonText: '취소' ,
				}).then((result) => {
				  if (result.value) {
				    
				    $("form").attr("method", "POST").attr("action", "/club/deleteApprovalCondition").submit();	    
				  }
				})
		})
	});
	
	
	
	$(function() {

		$("#updateClub").on("click", function() {
			self.location="/club/updateClubView?clubNo="+${ club.clubNo };

		});
	});
	
	$(function() {
		$(".homeBtn").on("click", function() {
			self.location="/club/getClub?clubNo=${clubNo}";
		});
	});
	
	$(function() {
		$(".clubPostBtn").on("click", function() {
			// 기존 모임원 데이터 가져와서 해당 모임의 모임원인지 확인 후 맞으면 게시물로 네비게이션 아니면 가입신청 하라는 메세지 출력
			var clubNo = '${ clubNo }';
			//alert( clubNo );
			$.ajax( "/clubRest/json/getClubMemberListCheck",
				{
					method : "POST",
					data : JSON.stringify({
								clubNo : clubNo
					}),
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType : "json",
					success : function(JSONData){
						console.log(JSONData.userId);
						
						if( '${ sessionScope.user.userId }' == JSONData.userId || '${ sessionScope.user.role }' == '1' ){
							self.location="/clubPost/getClubPostList"
						}else{
							swal.fire('게시물은 모임원만 볼 수 있습니다 \n 해당 모임에 가입신청해주세요');
						}
						
					}
				});// end of ajax
			
		});
	});
	
	$(function() {
		$(".clubMemberBtn").on("click", function() {
			self.location="/club/getClubMemberList"
		});
	});
		
	
	
	
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
		
		$(".live").on("click", function() {
			var clubNo = $("#no").val();
			var clubTitle = $("#clubTitle").val();
			var profile = $("#session_profileImage").val();
			var nickName = $("#nickName").val();
			var num;
			console.log("profile : "+profile);
			console.log("nickName : "+nickName);
			
			$.ajax("/liveRest/json/getLiveList", {
				type : "POST",
				data : JSON.stringify({
					type : '2',
					clubNo : clubNo
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
						title : clubTitle+"모임의 채팅방",
						showCancelButton : true,
						cancelButtonText : '취소',
						confirmButtonText : '채팅방개설',
						html: "<div id='roomNameList' style='text-align-last: left; margin-left: 70px;'></div>",
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
									roomName : clubNo+"_"+clubTitle+":"+roomName,
									type : '2',
									limit : total,
									clubNo : clubNo
								}),
								dataType : "json",
								contentType : "application/json",
								headers : {
									"Accept" : "application/json"
								}, 
								success : function(json) {
									console.log(json);
									var name = clubNo+"_"+clubTitle+":"+roomName;
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
					$("#roomNameList").append(roomName);
					
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
								type : '2',
								clubNo : clubNo
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
					type : '2',
					clubNo : clubNo
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

	<style>
		body {
			/* padding-top: 70px; */
		}
		
		#main {
			background-color: #f0f2f5 !important;
		}
		
		/* main {
			background-color: #f0f2f5 !important;
		} */
		
		.plain.button.red.cancel{
		   background-color: white;
		   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
		   border-radius: 10px;
		   margin: 1rem;
		   padding: 5px;
		   width: 75px !important;
		   color: #5F0080 !important;
		   font-size: 16px !important;
		   text-align: center;
		   border: solid 2px;
		}
		
		.plain.button.red.cancel:hover{
		   background-color: #5F0080;
		   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
		   border-radius: 10px;
		   margin: 1rem;
		   padding: 5px;
		   width: 75px !important;
		   color: white !important;
		   font-size: 16px !important;
		}
		
		/* .darkover {
			position: sticky;
			top: auto;
			bottom: 0;
			left: 0;
			background: rgba(0, 0, 0, 0.35);
		} */
		
		.club-wrap {
			width: 100%;
			margin: 10px auto;
			position: relative;
		}
		
		.club-wrap img {
			width: 100%;
			vertical-align: middle;
			filter: brightness(1.1);
			/* margin-left: 450px; */
			/* margin-top: -23px;
			height: 0%; */
		}
	
		.row-content.buffer, .row-content.buffer-left {
			padding-left: 0% !important;
		}
		
		.row-content.buffer, .row-content.buffer-right {
			padding-right: 0% !important;
		}
		
		row-content.buffer, .row-content.buffer-bottom {
			padding-bottom: 10% !important;
		}
		
		element.style {
			/* margin-bottom: 100px !important; */
		}
		
		
		.modal { 
			width:100%; height:100%; background: rgba(0,0,0,0.2); top:0; left:0; display:none;
		}
			
		.modal_content{
			width:400px; height:200px;
			background:#fff; border-radius:30px;
			position:relative; top:50%; left:50%;
			margin-top:-100px; margin-left:-200px;
			text-align:center;
			box-sizing:border-box; padding:74px 0;
			line-height:23px; cursor:pointer;
		}
		
		.modal-backdrop {
			position: static !important;
		
		}
		
		a {
			/* color: #333 !important; */
		}
		
		
	</style>

<!-- 상단 툴바 -->
<style type="text/css">
.nav-inner.row-content.buffer-left.buffer-right.even.clear-after{
	width: 954px;
	margin-left: 498px;
}
.col-sm-offset-4.col-sm-4.text-center{
	margin-top: -60px !important;
	margin-left: 510px !important;
	width: 667px !important;
}
.form-horizontal{
	width: 377px;
	height: 678px;
	margin-right: 59px;
	margin-left: 0px;
	margin-top: 70px;
	border-radius: 20px;
	background-color: white;
	padding-top: 13px;
	padding-left: 5px;
	box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	
}
#calendar{
	width: 704px;
}
.fc-header-toolbar.fc-toolbar.fc-toolbar-ltr{
	width: 730px;
	margin-left: -23px;
}
.fc-scroller{
	margin-top: -12px;
	margin-bottom: -24px;
}

.fc-daygrid.fc-dayGridMonth-view.fc-view{
	margin-left: -25px;
	width: 729px;
	border-radius: 0px;
}

.row-content.buffer-left.buffer-right.buffer-bottom{
	width: 1140px;
	margin-left: 405px;
	margin-top: 13px;
	height: 1700px;
}
.mainForm{
	display: inline-flex;
}
#addMeeting{
	margin-top: 21px !important;
	margin-left: 733px !important;
}
.fc-scrollgrid.fc-scrollgrid-liquid{
	background-color: white !important;
	box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
}
/* .fc.fc-view-harness-active > .fc-view {
	top: -63px !important;
	height: 679px !important;
	position: absolute !important;
	right: -20px !important;
	bottom: -120px !important;
	left: 0 !important;
} */
/* #clubImage{
    margin-top: 0px;
    width: 1140px !important;
    height: 550px;
} */
</style>
</head>

<body class="blog masonry-style" style="position: relative; height: 2120px; padding-bottom: 350px;">



	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	<%-- 채팅을 위한 소켓 --%>
	<script src="http://192.168.0.74:3000/socket.io/socket.io.js"></script>
	<%-- 채팅 js --%>
	<script src="/resources/javascript/chat/chat.js"></script>
	<%-- 채팅 css --%>
	<link rel="stylesheet" href="/resources/css/chat/chat.css" type="text/css" media="screen" title="no title">
	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	
	

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<!-- <main role="main"> -->

			<%-- <div id="intro-wrap" data-height="17.35">
				<!-- 상단 검은색 공통 영역 -->
				<div id="intro" class="preload darken">
					<!-- <div class="intro-item" style="background-image: url(http://placehold.it/1800x600/ddd/fff&text=Beetle%20image);"> -->
					<div class="intro-item">
	
						<div class="club-wrap">
	
							<div class="club-image">
								<a href="/club/getClub?clubNo=${clubNo}"><img
									src="/resources/image/uploadFiles/${club.clubImage}"
									width="800" height="300" name="file" id="clubImage"></a>
							</div>
							</div>
						</div>
					</div>
					<!-- intro -->
				</div>
			<!-- intro-wrap --> --%>
		
			<div id="main" class="row"><!-- 중간 개별영역 -->
			
			
			
				<%-- chat.js에서 사용위해서 --%>
				<input type="hidden" id="session_userId" value="${ sessionScope.user.userId }">
				<input type="hidden" id="session_profileImage" value="${ sessionScope.user.profileImage }">
				<input type="hidden" id="session_nickName" value="${ sessionScope.user.nickName }">
				<%-- chat.js에서 사용위해서 --%>
				<%-- 채팅 --%>
				<jsp:include page="/chat/chat.jsp" />
				<%-- 채팅 --%>
				
				
				
				<div class="row-content buffer-left buffer-right buffer-bottom">
				
				
					<!-- 모임 대표이미지 -->				
					<!-- <div class="club-image" style="width: 1140px; height: 550px; overflow: hidden;"> -->
					<div class="club-image" style="height: 700px;">
						<a href="/club/getClub?clubNo=${clubNo}">
							<img src="/resources/image/uploadFiles/${club.clubImage}" style="height: 700px; width: 1140px;" name="file" id="clubImage">
						</a>
					</div>
				
					 <!-- 모임버튼 영역 -->			
					<div class="homeBtn_group">
						<button type="button" class="homeBtn" style="margin-top: 55px;">
							<span class="glyphicon glyphicon-home" aria-hidden="true"></span>
						</button>
						
						<button type="button" class="clubPostBtn">
							<span class="glyphicon glyphicon-list-alt" aria-hidden="true"></span>
						</button>
						
						<button type="button" class="clubMemberBtn">
							<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
						</button>
						
						<button type="button" class="live">
							 <span class="glyphicon glyphicon-facetime-video" aria-hidden="true"></span> 
						</button>
					</div>
					
					
					<div class="form-group" id="btn_group">
						<!-- <button type="button" class="joinLi"></button> -->
						<div class="col-sm-offset-4  col-sm-4 text-center">
						
						<!-- 모임원인지 아닌지 확인 -->
						<c:set var="isItClubMember" value="false" />
						<!-- 모임원인지 아닌지 확인 -->
						
							<c:if test="${ fn:length( clubMemberList ) > 0 }">
								<c:forEach var="k" begin="0" end="${ fn:length(clubMemberList) - 1}" step="1">
									<c:if test="${ fn:trim(clubMemberList[k].approvalCondition) == '1' }">
										<c:if test="${ fn:trim(clubMemberList[k].user.userId) == fn:trim(sessionScope.user.userId)}">
											<c:set var="isItClubMember" value="true" />
				      					</c:if>
				      				</c:if>
				      			</c:forEach>
				      		</c:if>
				      		
				      		<c:if test="${isItClubMember eq false}">
				      			<button type="button" class="plain button red cancel" id="club-add-approval">가입신청</button>
				      		</c:if>
				      						
							<button type="button" class="plain button red cancel" id="cancel">이&nbsp;전</button>
							
							<c:if test="${ fn:length( clubMemberList ) > 0 }">
							<c:forEach var="k" begin="0" end="${ fn:length(clubMemberList) - 1}" step="1">
								<c:if test="${ fn:trim(clubMemberList[k].approvalCondition) == '1' }">
									<c:if test="${ fn:trim(clubMemberList[k].user.userId) == fn:trim(sessionScope.user.userId)}">
										<button type="button" class="plain button red cancel" id="deleteApprovalCondition">탈퇴</button>
									</c:if>
								</c:if>				 	
						 	</c:forEach>
						 	</c:if>
											
						<c:if test="${ fn:trim(sessionScope.user.userId) == fn:trim(club.user.userId) }">
							<button type="button" class="plain button red cancel" id="updateClub">수&nbsp;정</button>
							<button type="button" class="plain button red cancel" id="deleteClub">삭&nbsp;제</button>
						</c:if>
						
						</div>
				    </div>
							
	
					<div class="mainForm">
						<!-- 클럽상세 -->
						<div>
							<form class="form-horizontal" enctype="multipart/form-data">
	
								<div class="col-xs 6 col-md-6" style="display: contents;">
									<div class="row">
										<div class="col-xs-4 col-md-6" style="margin-left: 10px;">
											<strong>모임제목</strong>
										</div>
										<div class="col" style="margin-left: 30px;">${club.clubTitle}</div>
									</div>
	
									<hr />
	
									<div class="row">
										<div class="col-xs-4 col-md-6 " style="margin-left: 10px;">
											<strong>모임설명</strong>
										</div>
										<div class="col" style="margin-left: 30px; height: 100px;">${club.clubDetail}</div>
									</div>
	
									<hr />
	
									<div class="row">
										<div class="col-xs-4 col-md-6 " style="margin-left: 10px;">
											<strong>카테고리</strong>
										</div>
										<div class="col-xs-8 col-md-4" style="margin-left: 15px;">${club.clubCategory}</div>
									</div>
	
									<hr />
	
									<div class="row">
										<div class="col-xs-4 col-md-6 " style="margin-left: 10px;">
											<strong>활동영역</strong>
										</div>
										<div class="col-xs-8 col-md-4" style="margin-left: 15px;">${club.clubArea}</div>
									</div>
	
									<hr />
	
									<div class="row"> 
										<div class="col-s-4 col-md-6 " style="margin-left: 10px;">
											<strong>모임원 수</strong>
										</div>
										<div class="col-xs-8 col-md-4" style="margin-left: 15px;">${clubMemberCount}/${club.clubMaxMember}</div>
									</div>
	
								</div>
	
							</form>
	
						</div>
						<!-- 클럽상세 -->
	
						<!-- 달력영역 -->
						<div class="calendarArea">
	
							<jsp:include page="/club/calendar.jsp" />
	
						</div>
						<!-- 달력 영역 -->
						
						
							<%-- ${clubMemberList[0].approvalCondition} --%>
					 	
					 	<%-- <c:forEach var="k" begin="0" end="${ fn:length(clubMemberList) - 1}" step="1">
					 		<c:if test="${ clubMemberList[k].approvalCondition == 1 }">
					 			${ clubMemberList[k].user.userId == sessionScope.user.userId }
					 			'버튼'
					 		</c:if>				 	
					 	</c:forEach> --%>
						
						
						
					</div>
					
					<c:if test="${ fn:length( clubMemberList ) > 0}">
					<c:forEach var="k" begin="0" end="${ fn:length( clubMemberList ) - 1}" step="1">
						<c:if test="${ fn:trim(clubMemberList[k].approvalCondition) == '1' }">
							<c:if test="${ fn:trim(clubMemberList[k].user.userId) == fn:trim(sessionScope.user.userId)}">
								<button type="button" class="plain button red cancel" id="addMeeting" style="margin-top: 80px; margin-left: 860px;">일정생성</button>
							</c:if>
						</c:if>				 	
				 	</c:forEach>
				 	</c:if>
				</div>
				<!-- 버튼 원래 자리 -->
				<%-- 	<div class="form-group" id="btn_group">
						<!-- <button type="button" class="joinLi"></button> -->
					<div class="col-sm-offset-4  col-sm-4 text-center" style="margin-top: -20px;">
			      		
			      		<button type="button" class="plain button red cancel" id="club-add-approval">가입신청</button>
						<button type="button" class="plain button red cancel" id="cancel">이&nbsp;전</button>
						
					<c:if test="${ fn:trim(sessionScope.user.userId) != fn:trim(club.user.userId) }">	
						<button type="button" class="plain button red cancel" id="deleteApprovalCondition">탈퇴</button>
					</c:if>					
					<c:if test="${ fn:trim(sessionScope.user.userId) == fn:trim(club.user.userId) }">				
						<button type="button" class="plain button red cancel" id="updateClub">수&nbsp;정</button>
						<button type="button" class="plain button red cancel" id="deleteClub">삭&nbsp;제</button>
					</c:if>
					
					</div>
			    </div> --%>
				<!-- 모달영역 -->
				<div class="modal fade" id="approvalModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog" role="document" style="padding-top: 100px; top: 195px;">
						<div class="modal-content" style="height: 300px; width: 440px; margin-left: 130px; border-radius: 30px;">
							<div class="modal-header">
								<button class="close" type="button" data-dismiss="modal" aria-label="Close">
									<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								</button>
								<h3 class="modal-title" id="exampleModalLabel" style="text-align: center; ">가입신청</h3>
							</div>
						<div class="club-add-approval-view">
							<form name="addApprovalCondition" method="post" action="/club/addApprovalCondition" enctype=multipart/form-data>
								<input type="hidden" name="clubNo" value="${ clubNo }">
								<input type="hidden" name="roomId" value="${ club.roomId }">
								<div class="clubJoinGreeting">
									<input type="text" name="joinGreeting" placeholder="가입인사를 작성해주세요" autocomplete="off" style="margin-top: 10px; margin-left: 45px; height: 130px; width: 365px;">
								</div>
								<div class="modalBtn" style="margin-top: -20px; margin-left: 98px;">
								<input type="button" class="plain button red cancel" value="신청">
								<input type="button" class="plain button red cancel" value="취소">
								</div>
							</form>
						</div>
						</div>
					</div>
				
				</div>
				
				<input type="hidden" id="totalApprovalConditionCount" name="totalApprovalConditionCount" value="${totalApprovalConditionCount}">
				<input type="hidden" id="joinClubLimit" name="joinClubLimit" value="${sessionScope.user.joinClubLimit}">
		
		
				<input type="hidden" id="clubTitle" value="${club.clubTitle}">
				<input type="hidden" id="nickName" value="${sessionScope.user.nickName }">
				<input type="hidden" id="profile" value="${sessionScope.user.profileImage }">
				<input type="hidden" id="no" value="${clubNo}">
				<input type="hidden" id="total" value="${clubMemberCount}">
	
			</div>
	<!-- </main> -->
				
	
	
		
		<!-- footer start -->
		<jsp:include page="/footer.jsp" />
		<!-- footer end -->
	
	
	<script src="https://192.168.0.183:4000/socket.io/socket.io.js"></script>
</body>
</html>