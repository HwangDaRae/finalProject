<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 신고 css -->
<link href="/resources/css/clubPost/clubPostReport.css" rel="stylesheet">
</head>
<body>
<!-- 신고 Modal -->
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<div class="modal-dialog" role="document">
		<div class="modal-content">

			<!-- form Start /////////////////////////////////////-->
			<form class="form-horizontal" enctype="multipart/form-data" id="reportForm">
				
				<div class="reportTitleCover">
					<div class="reportTitleTitle">
						제목
					</div>
					<div class="reportTitle">
					
						<textarea class="title" id="title" name="title" maxlength="66" placeholder="신고 제목을 입력해주세요"></textarea>

					</div>

					<!--  화면구성 div end /////////////////////////////////////-->

				</div>
				
				<div class="reportContentCover">
					<div class="reportContentTitle">
						내용
					</div>
					
					<div class="reportContent">
						<textarea class="content" id="content" name="content" placeholder="신고 내용을 입력해주세요." maxlength="500"></textarea>
					</div>
				</div>
				
				<div class="reportSourceDiv">
					신고받는 ID
					<input type="text" class="reportSourceDivId" id="user2" name="user2" value="" readonly />
					신고 출처
					<input type="text" class="reportSourceDivSource" value="" disabled />
				</div>
				
				<input type="hidden" name="type" id="type" value="1">
				<input type="hidden" name="user1" id="user1" value="${sessionScope.user.userId}">
				<input type="hidden" name="reportSource" id="reportSource" value="">
				<input type="hidden" name="no" id="clubNo" value="" />
				<input type="hidden" name="no" id="clubPostNo" value="" />
				<input type="hidden" name="no" id="clubPostCommentNo" value="" />

				<div class="reportModalReason">

					<input type="checkbox" id="욕설" name="reportReason" value="1" >
						욕설
					<input type="checkbox" id="광고" name="reportReason" value="2" >
						광고
					<input type="checkbox" id="기타" name="reportReason" value="4" >
						기타
					<input type="checkbox" id="성적" name="reportReason" value="8" >
					성적인 발언

				</div>
				
			</form>

			<div class="modal-footer">

				<button type="button" id="club_post_add_report" class="custom-btn btn-13">등록</button>

				<!-- <button type="button" id="club_post_cancle_report" class="custom-btn btn-13" data-dismiss="modal"> -->
				<button type="button" id="club_post_cancle_report" class="custom-btn btn-13">
					취소
				</button>

			</div>
		</div>
	</div>
</div>
</body>
</html>