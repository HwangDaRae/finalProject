<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<title>공지사항 수정</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery.js"></script>
<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>


<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap"
	rel="stylesheet">


<script type="text/javascript"><%-- javaScript, JQuery 시작 --%>
	//=====기존Code 주석 처리 후  jQuery 변경 ======//
	function fncAddNotice() {

		var title = $("textarea[name='noticeTitle']").val();
		var content = $("textarea[name='noticeContent']").val();
		var image = $("textarea[name='noticeImage']").val();
		var image = $("input[name='noticeImage']").val();

		if (title == null || title.length < 1) {
			alert("제목은 반드시 입력하여야 합니다.");
			return;
		}
		if (content == null || content.length < 1) {
			alert("내용은 반드시 입력하여야 합니다.");
			return;
		}

		$($("#updateNotice")).attr("method", "POST").attr("action",
				"/serviceCenter/updateNotice").submit();
	} //funtion Notice 끝

	$(function() {

		$("button:contains('수정')").bind("click", function() {

			fncAddNotice();
		});

		$("button:contains('이전')").bind("click", function() {

			location.href = "/serviceCenter/getNoticeList";
		})

	});
</script>
<style>

.table {
	box-shadow: rgb(102 51 102/ 30%) 0px 19px 38px, rgb(95 0 128/ 22%) 0px
		15px 12px;
	border-radius: 20px;
	background: #c9c9ff;
	translate: -225px;
}

input[type=file]::file-selector-button {
	font-family: 'Lato', sans-serif;
	font-weight: 500;
	background-color: white;
	cursor: pointer;
	transition: all 0.3s ease;
	position: relative;
	border: solid 2px;
	box-shadow: none !important;
	outline: none;
	box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px,
		rgba(95, 0, 128, 0.22) 0px 15px 12px;
	border-radius: 10px;
	padding: 10px;
	color: #5F0080 !important;
	font-size: 16px !important;
	text-align: center;
}

}
.row {
	background-color: #5F0080;
	box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px,
		rgba(95, 0, 128, 0.22) 0px 15px 12px;
	border-radius: 10px;
	color: white !important;
	font-size: 16px !important;
	text-align: center;
	border: solid 2px;
}

textarea {
	resize: none;
}

.noticeTitle {
	width: 500px;
	height: 50px;
}

.content {
	margin-top: -30px;
}

.btn-13 {
	font-family: 'Lato', sans-serif;
	font-weight: 500;
	background-color: white;
	cursor: pointer;
	transition: all 0.3s ease;
	position: relative;
	border: solid 2px;
	box-shadow: none !important;
	outline: none;
	box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px,
		rgba(95, 0, 128, 0.22) 0px 15px 12px;
	border-radius: 10px;
	padding: 10px;
	color: #5F0080 !important;
	font-size: 16px !important;
	text-align: center;
}

.btn-13:hover {
	background-color: #5F0080;
	box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px,
		rgba(95, 0, 128, 0.22) 0px 15px 12px;
	border-radius: 10px;
	color: white !important;
	font-size: 16px !important;
	text-align: center;
	border: solid 2px;
}
/* 상단 툴바 start */
.nav-inner.row-content.buffer-left.buffer-right.even.clear-after{
	width: 2000px !important;
	padding-left: 152px !important;
	padding-right: 84px !important;
}
#brand{
	margin-left: 16px !important;
}
ul.reset{
	width: 874px !important;
	padding-left: 126px;
}
/* 상단 툴바 end */
</style>

<!-- footer css -->
<style type="text/css">
body{
	position: relative;
}
#club_post_footer{
	left: 0;
}
</style>
</head>

<body style="padding-left: 643px;">

	<jsp:include page="/toolbar.jsp" />
	<!-- form Start /////////////////////////////////////-->
	<div class="page-header" align="center"
		style="transform: translate(-340px, 38px);">
		<h2>공지사항 수정</h2>
	</div>
	<div class="container">
		<div class="table"
			style="width: 880px; box-shadow: rgb(0 0 0/ 30%) 0px 19px 38px, rgb(0 0 0/ 22%) 0px 15px 12px; background-color: aliceblue; margin-top: 50px;">
			<div></div>
			<div class="page-header text-center"></div>

			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal" enctype="multipart/form-data" id="updateNotice">
				<input type="hidden" name="noticeNo" id="noticeNo"
					value="${notice.noticeNo}"> <input type="hidden"
					name="userId" id="userId" value="${user.userId}">

				<div class="form-group" style="margin-left: 161px;">
					<strong>제목</strong> <label for="title"></label>
					<div class="col-sm-4">
						<textarea class="noticeTitle" id="noticeTitle" name="noticeTitle"
							value="${notice.noticeTitle}" maxlength="80" placeholder="제목을 입력해주세요">${notice.noticeTitle}</textarea>


					</div>
				</div>
				<strong style="margin-left: 161px;">내용</strong>
				<div class="form-group">
					<label for="content" class="col-sm-offset-1 col-sm-3 control-label"></label>
					<div class="col-sm-4" style="margin-left: 161px;">
										<textarea class="content" id="noticeContent" name="noticeContent" value="${notice.noticeContent}"
						placeholder="내용을 입력해주세요." maxlength="1000"
						style="width: 500px; height: 500px;">${notice.noticeContent}</textarea>
					</div>
				</div>

				<label for="noticeImage"
					class="col-sm-offset-1 col-sm-3 control-label"
					style="margin-left: 161px;"><strong>첨부파일</strong></label>
				<div class="col-sm-4" style="margin-left: 161px;">
					<input multiple="multiple" type="file" name="image" id="file"
						class="ct_input_g" style="width: 200px; height: 65px" />


				</div>
			</form>
			<span id="helpBlock" class="help-block"> <strong
				class="text-danger" style="margin-left: 161px;">사진은 2장까지
					가능합니다.</strong>
			</span>

		</div>
		<div class="form-group">
			<div class="col-sm-offset-4  col-sm-4 text-center">
				<button class="custom-btn btn-13"
					style="transform: translate(29px, 0px);">수정</button>
				<button class="custom-btn btn-13"
					style="transform: translate(43px, 0px);">이전</button>
			</div>
		</div>




	</div>
			
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br>

	<!-- footer start -->
	<jsp:include page="/footer.jsp" />
	<!-- footer end -->
	<!--  화면구성 div end /////////////////////////////////////-->

</body>

</html>