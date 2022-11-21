<%@ page contentType="text/html; charset=utf-8"%>
<%@ page pageEncoding="utf-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="utf-8">

<!-- 참조 : http://getbootsdivap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootsdivap, jQuery CDN ////////////////////////// -->
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"> -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-diveme.min.css">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.12.1/divemes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
body {
	padding-top: 50px;
}

fieldset {
	border: 0;
}

label {
	display: block;
	margin: 30px 0 0 0;
}

.overflow {
	height: 200px;
}

/* .container {
	border: solid 2px rgb(179, 207, 249);
	border-radius: 10px;
	background: #ecf4ff;
	width: 1150px;
} */

.group {
	display: flex;
}

.title {
	width: 140px;
	text-align: center;
	padding: 10px;
	background-color: #e9e9e9; 
	border-radius: 10px;
}

.value {
	width: 280px;
	margin-left: 40px;
}

button:hover {
	border-style: hidden;
	background-color: #5F0080;
	color: white;
	border-radius: 10px;
	font-weight: bold;
	border: solid 2px white;
}

button {
	background-color: white;
	border: solid 2px #5F0080;
	border-radius: 20px; 
	color:;
}
</style>

<script type="text/javascript">
    
	$(function() {
		$("#update").on("click", function() {
			fncUpdateUser();
		});
			
		$("#phoneChange").on("click", function() {
			$('#modalPhone').modal('show');
		});

		$("#cancel").on("click", function() {
			history.back();
		});
	});	
	
    function fncUpdateUser() {
    		
    		var pw = $("#password").val();
    		var pw2 = $("#password2").val();
    		var email = $("#email").val();
    		var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
    		var regExp = /^[a-z0-9_]{4,20}$/;
    		var penalty = $("#penalty").val();
    		var stopEndDate = $("#stopEnd").val();
    		
    		console.log("패널티 값 : "+penalty);
    		//console.log("정지 날짜 : "+stopEnd.datepicker({ dateFormat: 'yy-mm-dd' }));
    		
    		if(${user.role == '0'} && (pw == null || pw.length < 1)){
    			swal.fire("비밀번호를 입력하셔야 합니다.");
    			return;
    		}
    		
    		if(${user.role == '0'}){
    		
    			if(6 > pw.length || pw.length > 12){
    				swal.fire("비밀번호는 영어, 숫자조합 6~12자 입니다.");
    				return;
    			}
    		
    			if(!regExp.test(pw)){
    				swal.fire("비밀번호는 영어, 숫자조합 6~12자 입니다.");
    				return;
    			}
    			
    			if(pw != pw2){
    				swal.fire("비밀번호가 다릅니다.");
    				return;
    			}
    				
    			if(email == null || email.length < 1){
    				swal.fire("이메일을 입력하셔야 합니다.");
    				return;
    			}
    		
    			if(!regEmail.test(email)){
    				swal.fire("이메일을 제대로 입력해주세요.");
    				return;
    			}
    		
    		}
/*
    		$.ajax("/userRest/json/updatePenalty", {
    			type : "POST",
    			data : JSON.sdivingify({
    				penaltyType : penalty,
    				stopEndDate : stopEnd
    			}),
    			dataType : "json",
    			contentType : "application/json",
    			headers : {
    				"Accept" : "application/json"
    			},
    			success : function(Data, status) {
					console.log("update된 패널티 값 : "+Data.penaltyType)
					console.log("update된 정지날짜 : "+Data.stopEndDate)
				}
    		});
    */	    
    		$($("form")[0]).attr("method", "POST").attr("action", "/user/updateUser").submit();
		}
    
    function popup(){
        var url = "/user/updatePhoneNoView.jsp";
        var name = "updatePhoneNoView";
        var option = "width = 800, height = 300, top = 100, left = 200, location = no"
        window.open(url, name, option);
    }
    
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

	$(function() {
		$("#stopEndDateString").datepicker();
	});
    </script>

</head>
<body style="background-color: whitesmoke;">



	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	<%-- 채팅을 위한 소켓 --%>
	<script src="http://192.168.0.74:3000/socket.io/socket.io.js"></script>
	<%-- 채팅 js --%>
	<script src="/resources/javascript/chat/chat.js"></script>
	<%-- 채팅 css --%>
	<link rel="stylesheet" href="/resources/css/chat/chat.css" type="text/css" media="screen" title="no title">
	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	
	
	
	<jsp:include page="/sideToolbar.jsp" />
	<form>
		<div class="wrap wd668" style="zoom: 1.2; margin-top: 57px; margin-left: 80px;">		
			<div class="container" style="margin-left: 0px;">
			
			
	
				<%-- chat.js에서 사용위해서 --%>
				<input type="hidden" id="session_userId" value="${ sessionScope.user.userId }">
				<input type="hidden" id="session_profileImage" value="${ sessionScope.user.profileImage }">
				<input type="hidden" id="session_nickName" value="${ sessionScope.user.nickName }">
				<%-- chat.js에서 사용위해서 --%>
				<%-- 채팅 --%>
				<jsp:include page="/chat/chat.jsp" />
				<%-- 채팅 --%>
			
			
			
				<div class="form_txtInput" style="margin-left: 200px;">
					<c:if test="${fn:trim(user.role) == '0'}">
						<h6 class=" text-info" style="color: #31708f; font-weight: bold;">내정보보기 > 내정보수정</h6>
					</c:if>
					<c:if test="${fn:trim(user.role) == '1'}">
						<h3 class=" text-info" style="color: #31708f; font-weight: bold;">회원정보수정</h3>
					</c:if>
					<div class="join_form">
						<div>
							<div style="margin-top: 40px;">
								<div class="group">
									<strong class="title">아이디</strong>
									<div class="value">
										<input disabled="disabled" class="form-control" id="userId" 
											name="userId" style="background: none; border: none; font-weight: bold; " value="${requestScope.getUser.userId }"> <input
											type="hidden" class="form-control" id="userId" name="userId"
											value="${requestScope.getUser.userId }">
									</div>
								</div>
								<br/>
								<div class="group">
									<strong class="title">이름</strong>
									<div class="value">
										<input disabled="disabled" type="text" class="form-control" style="background: none; border: none; font-weight: bold; "
											id="name" name="name" value="${requestScope.getUser.name}"> <input
											type="hidden" class="form-control" id="name" name="name"
											value="${requestScope.getUser.name }">
									</div>
								</div>
								<br/>
								<div class="group">
									<strong class="title">성별</strong>
									<div class="value">
										<input disabled="disabled" type="text" class="form-control" style="background: none; border: none; font-weight: bold; "
											id="gender" name="gender" value="${requestScope.getUser.gender}">
										<input type="hidden" class="form-control" id="gender"
											name="gender" value="${requestScope.getUser.gender }">
									</div>
								</div>
								<br/>
								<div class="group">
									<strong class="title">주민번호</strong>
									<div class="value">
										<input disabled="disabled" type="text" class="form-control" style="background: none; border: none; font-weight: bold; "
											id="rrn" name="rrn" value="${requestScope.getUser.rrn}"> <input
											type="hidden" class="form-control" id="rrn" name="rrn"
											value="${requestScope.getUser.rrn }">
									</div>
								</div>
								<br/>
								<c:if test="${fn:trim(user.role) == '0'}">
									<div class="group">
										<strong class="title">비밀번호</strong>
										<div class="value">
											<input type="password" class="form-control" id="password" style="font-weight: bold; " autocomplete="off"
												name="password" placeholder="변경비밀번호"> <strong
												id="helpBlock" class="help-block" style="color: red;">
												영어, 숫자 조합 6~12자 </strong>
										</div>
									</div>
								<br/>
								</c:if>
								<c:if test="${fn:trim(user.role) == '0'}">
									<div class="group">
										<strong class="title">비밀번호확인</strong>
										<div class="value">
											<input type="password" class="form-control" id="password2" style="font-weight: bold; " autocomplete="off"
												name="password2" placeholder="변경비밀번호 확인"> <strong
												id="helpBlock" class="help-block" style="color: red;">
												영어, 숫자 조합 6~12자 </strong>
										</div>
									</div>
								<br/>
								</c:if>
								<div class="group">
									<strong class="title">이메일</strong>
									<div class="value">
										<c:if test="${fn:trim(user.role) == '0'}">
											<input type="text" class="form-control" id="email" style="font-weight: bold; " autocomplete="off"
												name="email" value="${requestScope.getUser.email}" placeholder="변경이메일">
										</c:if>
										<c:if test="${fn:trim(user.role) == '1'}">
											<input disabled="disabled" type="text" class="form-control"
												id="email" name="email" value="${requestScope.getUser.email}"
												placeholder="변경이메일">
										</c:if>
									</div>
								</div>
								<br/>
								<div class="group">
									<strong class="title">휴대폰번호</strong>
									<div class="value">
										<div style="display: flex;">
											<input disabled="disabled" type="text" class="form-control" style="background: none; border: none; font-weight: bold; "
												id="phoneNo" name="phoneNo" value="${ requestScope.getUser.phoneNo }">
											<c:if test="${fn:trim(user.role) == '0'}">
												<button type="button"
													style="font-weight: bold; font-size: medium; border-radius: 13px; padding: 4px; padding-left: 15px; padding-right: 15px;
													box-shadow: rgba(102, 051, 102, 0.3) 0px 5px 5px, rgba(95, 0, 128, 0.22) 0px 5px 5px;"
													id="phoneChange">변&nbsp;경</button>
											</c:if>
										</div>
									</div>
								</div>
								<br/>
								<c:if test="${fn:trim(user.role) == '1'}">
									<div class="group">
										<strong class="title">정지상태</strong>
										<div class="value">
											<select name="penaltyType" id="penaltyType"
												style="border-color: #00000038; font-weight: bold; height: 44px; border-radius: 10px; padding: 10px;">
												<option selected="selected">선택해주세요</option>
												<option>ㅡ</option>
												<option>정지</option>
												<option>영구정지</option>
											</select>
										</div>
									</div>
								</c:if>
								<br/>
								<c:if test="${fn:trim(user.role) == '1'}">
									<div class="group">
										<strong class="title">정지기간</strong>
										<div class="value">
											<input class="form-control" id="stopEndDateString" style="font-weight: bold; "
												readonly="readonly" name="stopEndDateString" value="" />
										</div>
									</div>
								</c:if>
							</div>
						</div>
						<div style="margin-left: 480px;">
							<button type="button"  id="update"
								style="font-weight: bold; font-size: medium; border-radius: 13px; padding: 4px; padding-left: 15px; padding-right: 15px;
							box-shadow: rgba(102, 051, 102, 0.3) 0px 5px 5px, rgba(95, 0, 128, 0.22) 0px 5px 5px; margin-right: 15px;">수&nbsp;정</button>
							<button type="button"  id="cancel"
								style="font-weight: bold; font-size: medium; border-radius: 13px; padding: 4px; padding-left: 15px; padding-right: 15px;
							box-shadow: rgba(102, 051, 102, 0.3) 0px 5px 5px, rgba(95, 0, 128, 0.22) 0px 5px 5px;">취&nbsp;소</button>
						</div>
					</div>
				</div>
				<!-- form_txtInput E -->
			</div>
			<!-- content E-->
		</div>
		<!-- container E -->
	</form>
		<jsp:include page="/user/updatePhoneNoView.jsp" />
</body>
</html>