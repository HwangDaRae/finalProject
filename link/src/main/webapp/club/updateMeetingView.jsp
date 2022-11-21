<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
	
<head>
	<meta charset="UTF-8">
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  
  <!-- addMeetingCss -->
  <link rel="stylesheet" href="/resources/css/addUser.css"> 
  	<!--  	jQuery UI toolTip 사용 JS -->
  <!-- <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script> -->
  <script src="http://code.jquery.com/jquery-3.6.0.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <!-- <script src="https://code.jquery.com/ui/1.10.2/jquery-ui.js"></script> -->
	
	<!-- alert -->
	<script src="/resources/javascript/plugins.js"></script>
	<script src="/resources/javascript/beetle.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

	 <!-- 타임피커 -->
  	<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>	
		
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body>div.container {
			/* border: 3px solid #D6CDB7; */
			margin-top: 50px;
		}

		.plain.button.red.cancel{
	   background-color: white;
	   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	   border-radius: 10px;
	   margin: 1rem;
	   padding: 0px;
	   width: 85px !important;
	   height: 40px;
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
	   padding: 0px;
	   width: 85px !important;
	   height: 40px;
	   color: white !important;
	   font-size: 16px !important;
	}
		
		
		textarea {
		resize: none;
	
		}
		
		.clubTitle {
			width: 500px;
			height: 50px;
		}
		.container{
			width: 1150px;
			height: 2000px;
		}
		.wrap.wd668{
			margin-right: 900px;
		}
        
    </style>
    
<script type="text/javascript">


	function fncUpdateMeeting() {

		var title = $("textarea[name='meetingTitle']").val();
		var content = $("textarea[name='meetingContent']").val();
		var date = $("input[name='meetingDate']").val();
		var time = $("input[name='meetingTime']").val();
		var member = $("textarea[name='meetingMaximumMember']").val();
		var place = $("input[name='meetingPlace']").val();
		
		
		if (title == null || title.length < 1) {
			Swal.fire({
				icon: 'error',
				title: '일정제목은 필수입니다.',
			});
			return;
		}
				
		if( date == null || date.length < 1) {
			Swal.fire({
				icon: 'error',
				title: '일정날짜는 필수입니다.',
			});
			return;
		}
		
		if( time == null || time.length < 1) {
			Swal.fire({
				icon: 'error',
				title: '일정시간은 필수입니다.',
			});
			return;
		}
		
		if( content == null || content.length < 1) {
			Swal.fire({
				icon: 'error',
				title: '일정내용은 필수입니다.',
			});
			return;
		}
		
		if( member == null || member.length < 1) {
			Swal.fire({
				icon: 'error',
				title: '정원은 필수입니다.',
			});
			return;
		}
		
		if( place == null || place.length < 1) {
			Swal.fire({
				icon: 'error',
				title: '모임장소는 필수입니다.',
			});
			return;
		}
		
		


		$("form").attr("method", "POST").attr("action", "/club/updateMeeting")
				.submit();
	}


	$(function() {

		$("#updateMeeting").on("click", function() {
			
			fncUpdateMeeting();
		});
	});	

	$(function() {

		$("#cancel").bind("click", function() {
			history.go(-1);
		});
	});
	
	
	$.datepicker.setDefaults({
		dateFormat : 'yy-mm-dd' ,
		prevText: '이전 달' ,
		nextText: '다음 달',
        monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
        dayNames: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        showMonthAfterYear: true,
        yearSuffix: '년'
	})
	
	$(function(){
		$("#datepicker").datepicker();
	});
	
	
	$(document).ready(function(){
		$("#timepicker").timepicker({
			timeFormat: 'HH:mm' ,
			interval: 30,
			startTime: '00:00' ,
			dynamic: false,
			dropdown: true,
			scrollbar: true
		});
	});
	
/* 	var openWin;
	function popup() {
		var url = "/club/searchPlace.jsp";
		var name = "searchPlace";
		var option = "width = 1000, height = 500, top = 100, left = 200, location = no"
		openWin = window.open(url, name, option);
	}
	
	$(function() {
		$("#searchPlace").on("click", function() {
			popup();
		});
		
	}) */
	
	//자식창에서 부모창으로 값 전달하기
	function openChild()
	{
		window.name = "addMeetingView";
		
		window.open("/club/searchPlace.jsp", "searchPlace", "width = 1000, height = 500, top = 100, left = 200, location = no");
	}
	
	
	

</script>

<style type="text/css">
.nav-inner.row-content.buffer-left.buffer-right.even.clear-after{
	/* background-color: red; */
	width: 1400px;
	margin-left: 500px;
	font-weight: bold;
}
.row-content.buffer, .row-content.buffer-left{
	padding-left: 0px !important;
}
.row-content.buffer, .row-content.buffer-right{
	padding-right: 0px !important;
}
h1.reset{
	margin-left: 0px;
}
.reset, .reset-right{
	margin-right: 90px !important;
}
nav > ul > li{
	font: unset !important;
	font-weight: bold !important;
}
.form_txtInput{
	padding-left: 346px;
}
.container{
	padding-left: 0px !important;
	padding-right: 0px !important;
}
</style>

</head>

<body style="background: whitesmoke; position: relative; height: 1900px;">



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
	
	

	<jsp:include page="/toolbar.jsp"/>
	
	<form>
		<div class="wrap wd668">
			<div class="container" style="background: white; height: 1400px; padding-bottom: 350px;">
	
				<div>
					<img src="/resources/image/uploadFiles/${ club.clubImage }" style="width: 100%; height: 550px; margin-top: 14px;">
				</div>
				
				<div class="form_txtInput">
					<h2 class="sub_tit_txt">모 임 일 정 수 정</h2>
					<p class="exTxt">일정을 수정해보세요...</p>
					<div class="join_form">
					
					<table>
						<colgroup>
							<col width="30%" />
							<col width="auto" />
						</colgroup>
						
						<tbody>
							<tr>
								<th><span>일 정 제 목</span></th>
								<td>
									<textarea class="meetingTitle" id="meetingTitle" name="meetingTitle" maxlength="80" style="width: 280px; height: 50px;">${meeting.meetingTitle }</textarea>
								</td>
							</tr>
							
							<tr>
								<th><span>모 임 날 짜</span></th>
								<td><input type="text" id="datepicker" name="meetingDate" placeholder="모임날짜는 필수입니다." style="height: 40px" autocomplete='off' value="${meeting.meetingDate}"></td>
							</tr>
							
							<tr>
								<th><span>모 임 시 간</span></th>
								<td><input type="text" class="timepicker" id="timepicker" name="meetingTime" placeholder="모임시간은 필수입니다." style="height: 40px" autocomplete='off' value="${meeting.meetingTime}"></td>
							</tr>
							
							<tr>
								<th><span>일 정 내 용</span></th>
								<td>
									<textarea class="meetingContent" id="meetingContent" name="meetingContent" maxlength="500" style="width: 280px; height: 200px;">${meeting.meetingContent}</textarea> 
								</td>
							</tr>
							
							<tr>
								<th><span>정 원</span>
								<td>
									<textarea class="meetingMaximumMember" id="meetingMaximumMember" name="meetingMaximumMember" maxlength="50" style="width:80px; height: 40px;">${meeting.meetingMaximumMember}</textarea>
								</td>
							</tr>
							
							<tr>
								<th><span>모 임 장 소</span></th>
								<td><input type="text" id="meetingPlace" name="meetingPlace" placeholder="모임장소는 필수입니다." autocomplete='off' value="${meeting.meetingPlace}" onclick="openChild()"></td>
							</tr>	
							
								
							
						</tbody>
				
				</table>
				</div>
				</div>
				</div>
				</div>
			</form>
				
			<div class="form-group">
				<div class="col-sm-offset-6  col-sm-6 text-center" style="margin-left: 25%;">
		      		<button type="button" class="plain button red cancel" id="updateMeeting">수 &nbsp;정</button>
					<button type="button" class="plain button red cancel" id="cancel">취&nbsp;소</button>
			    </div>
			</div>
			
			
		<!-- footer start -->
		<jsp:include page="/footer.jsp" />
		<!-- footer end -->

		
	</body>
</html>
		
		
		
		
			<%-- <div class="form-group">
				<label for="meetingTitle" class="col-sm-offset-1 col-sm-3 control-label">모 임 일 정 제 목</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="meetingTitle" name="meetingTitle" value="${meeting.meetingTitle}">
				</div>						
			</div>
			
			
		
			<div class="form-group">
				<label for="meetingDate" class="col-sm-offset-1 col-sm-3 control-label">모 임 날 짜</label>
				<div class="col-sm-4">
					<input type="text" height="150px" class="form-control" id="meetingDate" name="meetingDate" value="${meeting.meetingDate}">
				</div>		
			</div>
			
			<div class="form-group">
				<label for="meetingTime" class="col-sm-offset-1 col-sm-3 control-label">모 임 시 간</label>
				<div class="col-sm-4">
					<input type="text" height="150px" class="form-control" id="meetingTime" name="meetingTime" value="${meeting.meetingTime}">
				</div>		
			</div>
			
			<div class="form-group">
				<label for="meetingPlace" class="col-sm-offset-1 col-sm-3 control-label">모 임 장 소</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="meetingPlace" name="meetingPlace" value="${meeting.meetingPlace}">
				</div>		
			</div>			
			
			<div class="form-group">
				<label for="meetingContent" class="col-sm-offset-1 col-sm-3 control-label">일 정 내 용</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="meetingContent" name="meetingContent" value="${meeting.meetingContent}">
				</div>		
			</div>
			
			<div class="form-group">
				<label for="meetingMaximumMember" class="col-sm-offset-1 col-sm-3 control-label"> 정 원</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="meetingMaximumMember" name="meetingMaximumMember" value="${meeting.meetingMaximumMember}">
				</div>		
			</div> --%>
			
			
			
