<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 모달창 start -->
<div class="modal fade" id="club-post-update-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<button class="close" type="button" data-dismiss="modal" aria-label="Close">
					<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				</button>
				<h3 class="modal-title" id="exampleModalLabel">게시물 수정하기</h5>
			</div>
			<div class="club-post-update-view">
				<form name="summernoteUpdateClubPost">

					<input type="hidden" id="clubNo" value="${ clubPost.getClubPost.clubNo }">
					<input type="hidden" id="clubPostNo" value="${ clubPost.getClubPost.clubPostNo }">
					
					<div class="clubPostTitle">
						<input type="text" name="clubPostTitle" placeholder="제목">
					</div>
					<textarea id="summernote" aria-multiline="true" name="clubPostContent"></textarea>
					<input type="button" id="summernoteUpdate" value="게시물 수정">
					<input type="button" id="summernoteCancle" value="이전으로">
				</form>
			</div>
		</div>
	</div>
</div>
<!-- 모달창 end -->
</body>
</html>