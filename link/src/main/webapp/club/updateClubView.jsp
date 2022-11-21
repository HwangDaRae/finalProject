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
  
  <!-- addMeetingCss -->
  <link rel="stylesheet" href="/resources/css/addUser.css">
  
  	<!--  	jQuery UI toolTip 사용 JS -->
  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <!-- <script src="https://code.jquery.com/ui/1.10.2/jquery-ui.js"></script> -->
		
	<script src="https://code.jquery.com/jquery.js"></script>
	<script src="/resources/javascript/plugins.js"></script>
	<script src="/resources/javascript/beetle.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>	
		
		
		
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


	function fncUpdateClub() {

		var title = $("textarea[name='clubTitle']").val();
		var content = $("textarea[name='clubDetail']").val();
		var image = $("input[name='file']").val();
		
		if (title == null || title.length < 1) {
			Swal.fire({
				icon: 'error',
				title: '모임이름은 필수입니다.',
			});
			return;
		}
		
		if( content == null || content.length < 1) {
			Swal.fire({
				icon: 'error',
				title: '모임설명은 필수입니다.',
			});
			return;
		}
		
		if( image == null || image.length < 1) {
			Swal.fire({
				icon: 'error',
				title: '모임대표이미지는 필수입니다.',
			});
			return;
		}
		
		$("form").submit();
	}


	$(function() {

		$("#updateClub").on("click", function() {
			//alert($("td.ct_btn01:contains('등록')").html());
			fncUpdateClub();
		});
	});

	// 	 function resetData() {
	// 		document.detailForm.reset();
	// 	} 

	$(function() {

		$("#cancel").bind("click", function() {
			//window.close();
			history.go(-1);
		});
	});
	
	function setThumbnail(event) {
		var fileInput = document.getElementById("clubImage");
		var file = fileInput.files[0];
		var reader = new FileReader();

		reader.onload = function(event) {
			$("#imga").attr("src", event.target.result);
		};
		
		console.log(file);
		reader.readAsDataURL(file);
		
	} 

	$(function() {
		$(".image").on("click", function() {
			$("#clubImage").click();		
		})
	})
	

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

<body style="background: #EBEDF0; position: relative; height: 2400px; padding-bottom: 300px;">



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
	
	
	<form class="form-horizontal" method="post" action="/club/updateClub" enctype="multipart/form-data">
		<div class="wrap wd668">
			<div class="container" style="background: white; height: 2000px; margin-bottom: -400px;">
				
				<div>
					<img src="/resources/image/uploadFiles/${ club.clubImage }" style="width: 1140px; height: 700px; margin-top: 14px;">
				</div>
				
				<div class="form_txtInput">
					<h2 class="sub_tit_txt">모 임 수 정</h2>
					<p class="exTxt">모임을 수정해보세요...</p>
					<div class="join_form">
			
		
		
		
			<div class="form-group">
				<label for="clubTitle" class="col-sm-offset-1 col-sm-3 control-label" style="text-align: left;"></label>
				<div class="col-sm-4">
					<strong>모 임 이 름</strong><textarea class="clubTitle" id="clubTitle" name="clubTitle" value="" maxlength="80" style="width: 500px; height: 50px;">${club.clubTitle }</textarea>
				</div>					
			</div>
			
			
		
			<div class="form-group">
				<label for="clubDetail" class="col-sm-offset-1 col-sm-3 control-label" style="text-align: left;"></label>
				<div class="col-sm-4">
					<strong>모 임 설 명</strong><textarea class="clubDetail" id="clubDetail" name="clubDetail" value="" maxlength="500" style="width: 500px; height: 200px;">${club.clubDetail }</textarea>
				</div>		
			</div>
			
			<div class="form-group">
				<label for="clubCategory" class="col-sm-offset-1 col-sm-3 control-label" style="text-align: left;"></label>
				<div class="col-sm-4">
					<strong>모임카테고리</strong>
					<select class="form-control" id="clubCategory" name="clubCategory" style="text-align: left; width: 350px;">
						<option value="운동">운동</option>
  						<option value="봉사활동">봉사활동</option>
  						<option value="음식">음식</option>
						<option value="여행">여행</option>
						<option value="반려동물">반려동물</option>
						<option value="게임">게임</option>
						<option value="음악/댄스">음악/댄스</option>
						<option value="독서">독서</option>
						<option value="기타">기타</option>
					</select>
				</div>			    
			</div>			
			
			<div class="form-group">
				<label for="clubArea" class="col-sm-offset-1 col-sm-3 control-label" style="text-align: left;"></label>
				<div class="col-sm-4">
					<strong>지 역</strong>
					<select class="form-control" id="clubArea" name="clubArea" style="text-align: left; width: 350px;">
						<option value="강남구">강남구</option>
						<option value="강동구">강동구</option>
						<option value="강북구">강북구</option>
						<option value="강서구">강서구</option>
						<option value="관악구">관악구</option>
						<option value="광진구">광진구</option>
						<option value="구로구">구로구</option>
						<option value="금천구">금천구</option>
						<option value="노원구">노원구</option>
						<option value="도봉구">도봉구</option>
						<option value="동대문구">동대문구</option>
						<option value="동작구">동작구</option>
						<option value="마포구">마포구</option>
						<option value="서대문구">서대문구</option>
						<option value="서초구">서초구</option>
						<option value="성동구">성동구</option>
						<option value="성북구">성북구</option>
						<option value="송파구">송팡구</option>
						<option value="양천구">양천구</option>
						<option value="영등포구">영등포구</option>
						<option value="용산구">용산구</option>
						<option value="은평구">은평구</option>
						<option value="종로구">종로구</option>
						<option value="중구">중구</option>
						<option value="중랑구">중랑구</option>
					</select>
				</div>		
			</div>			
			
			<div class="form-group">
				<label for="clubImage" class="col-sm-offset-1 col-sm-3 control-label" style="text-align: left;"></label>
				<div class="col-sm-4">
				<strong>모임이미지</strong><input type="file" class="file" id="clubImage" name="file" multiple="multiple" onchange="setThumbnail(event);" style="display: none;" class="form-file" />
					<button id="im" type="button" class="image" style="border-style: hidden;"><img id="imga" src="/resources/image/uploadFiles/default.png" style="height: 300px; width: 300px; max-width: 260%;"></button>
				</div>		
			</div>
			
			
			
			<div class="form-group" id="btn_group">
				<div class="col-sm-offset-6  col-sm-6 text-center" style="margin-left: 0px;">
		      		<button type="button" class="plain button red cancel" id="updateClub" >수 &nbsp;정</button>
					<button type="button" class="plain button red cancel" id="cancel">취&nbsp;소</button>
		    </div>
			</div>
			</div>
		</div>
		</div>
		</div>
	</form>	
				
	
	
		
		
		<!-- footer start -->
		<jsp:include page="/footer.jsp" />
		
</body>
</html>