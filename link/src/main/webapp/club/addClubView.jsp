<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


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
  <!-- <link rel="stylesheet" href="/resources/demos/style.css"> -->
  
  <!-- addMeetingCss -->
  <link rel="stylesheet" href="/resources/css/addUser.css">
  
  
  	<!--  	jQuery UI toolTip 사용 JS -->
  <!-- <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script> -->
  
  <script src="http://code.jquery.com/jquery-3.6.0.js"></script>
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


	function fncAddClub() {

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

		$("#addClub").on("click", function() {
			//alert($("td.ct_btn01:contains('등록')").html());
			fncAddClub();
		});
	});

	// 	 function resetData() {
	// 		document.detailForm.reset();
	// 	} 

	$(function() {

		$("#cancel").bind("click", function() {
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
		});
	});
	
	
	/* $.ajax({
			url:'https://dapi.kakao.com/v2/local/search/address.json?query='+encodeURIComponent('서울시 동대문구'),
			type: 'GET' ,
			headers: {'Authorization' : 'KakaoAK 6ee01fc9434961a580560a7920b95e95'} ,
			
			success:function(data) {
				console.log(data);
			},
			error : function(e) {
				console.log(e);
			}	
	}); */
	
	function getLocation() {
		if(navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(getAddressByCoords,redirectLocation, geo_options);
		} else {
			location.href = "/mbl/test/selectAddressList.do";
		}	
	}
	
	function getAddressByCoords(position) {
		var longitude = position.coords.longitude;
		var latitude = position.coords.latitude;
		console.log(longitude);
	    console.log(latitude);
	    //★★위도 경도 정보를 가지고 서버 사이드로 넘어가는 부분
		location.href = "/mbl/test/selectAddressList.do?longitude=" + longitude + "&latitude=" + latitude;
	}

	//에러났을 때
	function redirectLocation(error) {
		location.href = "/mbl/error/selectAddressList.do";
	}

	//타임아웃
	var geo_options = {
		maximumAge        : 5000, 
		timeout           : 3000
	};
	
	
	//파일 드래그 앤 드롭
	
	$('#imageArea')
		.on("dragover", dragOver)
		.on("dragleave", dragOver)
		.on("drop", uploadFiles);
	
		function dragOver(e) {
	    e.stopPropagation();
	    e.preventDefault();
	    if (e.type == "dragover") {
	        $(e.target).css({
	            "background-color": "black",
	            "outline-offset": "-20px"
	        });
	    } else {
	     $(e.target).css({
	            "background-color": "gray",
	            "outline-offset": "-10px"
	        });
	    }
	}

		 
		function uploadFiles(e) {
		    e.stopPropagation();
		    e.preventDefault();
		    dragOver(e); //1
		 
		    e.dataTransfer = e.originalEvent.dataTransfer; //2
		    var files = e.target.files || e.dataTransfer.files;
		 
		    if (files.length > 1) {
		        alert('하나만 올려라.');
		        return;
		    }
		    
		    if (files[0].type.match(/image.*/)) {
                $(e.target).css({
            "background-image": "url(" + window.URL.createObjectURL(files[0]) + ")",
            "outline": "none",
            "background-size": "100% 100%"
		        });
		    }else{
		      alert('이미지가 아닙니다.');
		      return;
		    }
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

<body style="background: #EBEDF0; position: relative; height: 2215px;">

	<jsp:include page="/toolbar.jsp"/>
	
	<form class="form-horizontal" method="post" action="/club/addClub" enctype="multipart/form-data">
		<div class="wrap wd668">
			<div class="container" style="background: white; height: 1820px; margin-bottom: -400px;">
	
				<div>
					<img src="/resources/image/uploadFiles/clubMainImage5.jpg" style="width: 100%; height: 550px; margin-top: 14px;">
				</div>
				
				<div class="form_txtInput">
					<h2 class="sub_tit_txt">모 임 등 록</h2>
					<p class="exTxt">새로운 모임을 등록해보세요...</p>
					<div class="join_form">
		
		<!-- <form class="form-horizontal" method="post" action="/club/addClub" enctype="multipart/form-data"> -->
		
			<div class="form-group">
				<label for="clubTitle" class="col-sm-offset-1 col-sm-3 control-label" style="text-align: left;"></label>
				<!-- <strong>모 임 이 름</strong><label for="clubTitle"></label> -->
				<div class="col-sm-4">
					<strong>모 임 이 름</strong><textarea class="clubTitle" id="clubTitle" name="clubTitle" value="" maxlength="80" placeholder="모임 이름을 입력해주세요"></textarea>
				</div>					
			</div>
			
			
		
			<div class="form-group">
				<label for="clubDetail" class="col-sm-offset-1 col-sm-3 control-label" style="text-align: left;"></label>
				<div class="col-sm-4">
					<strong>모 임 설 명</strong><textarea class="clubDetail" id="clubDetail" name="clubDetail" value="" placeholder="모임설명은 필수입니다. (최대 500자)" maxlength="500" style="width: 500px; height: 200px;"></textarea>
				</div>		
			</div>
			
			<div class="form-group">
				<label for="clubCategory" class="col-sm-offset-1 col-sm-3 control-label" style="text-align: left;"></label>
				<div class="col-sm-4">
					<!-- <select class="form-control"> -->
					<strong>카테고리</strong>
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
					<strong>지역</strong>
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
						<option value="송파구">송파구</option>
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
			
			<div class="form-group" id="imageArea">
				<label for="clubImage" class="col-sm-offset-1 col-sm-3 control-label" style="text-align: left;"></label>
				<div class="col-sm-4">
					<!-- <input type="file" name="file" class="file" id="clubImage" multiple="multiple"> -->
					<strong>모임이미지</strong><input type="file" name="file" class="file" id="clubImage" multiple="multiple" onchange="setThumbnail(event);" style="display: none;" class="form-file"/>
					<button id="im" type="button" class="image" style="border-style: hidden;"><img id="imga" src="/resources/image/uploadFiles/default.png" style="height: 300px; width: 300px; max-width: 260%;"/></button>
				</div>		
			</div>
			
			
			
			<div class="form-group" id="btn_group">
				<div class="col-sm-offset-6  col-sm-6 text-center" style="margin-left: 0px;">
		      		<button type="button" class="plain button red cancel" id="addClub">등 &nbsp;록</button>
					<button type="button" class="plain button red cancel" id="cancel">취&nbsp;소</button>
		    </div>
			</div>
			</div>
		</div>
		</div>
		</div>	
			
		</form>	
				
	
	
		<br><br><br><br><br><br><br><br><br><br><br><br>
		
		<!-- footer start -->
		<jsp:include page="/footer.jsp" />
		<!-- footer end -->
		
		
</body>
</html>