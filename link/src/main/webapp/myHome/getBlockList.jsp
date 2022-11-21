<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<link rel="preconnect" href="https://fonts.googleapis.com">
<script src="https://code.jquery.com/jquery.js"></script>
<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>
<link href="/resources/css/feed/getFeedList.css" rel="stylesheet">
	 <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
   <link href="https://fonts.googleapis.com/css2?family=Sacramento&display=swap" rel="stylesheet">
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	
<script type="text/javascript">
$(function() {
	
	$("#stopBlock").on("click", function() {
		var userId = $("#userId").val();
		console.log("전달받은 회원 Id : " + userId);

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
						$("#stopBlock").text("차단해제");
						}else if(update.block.fbState == 2){
						$("#stopBlock").text("차단");
						}
					}
				})
			}
		})
	})


});

</script>
<style>
.blockSection{
margin-left : 50px;
margin-bottom : 30px;
}
.yourHome{
font-size:20px;
font-weight: 600;
}
.block{
display:inline-block;
}
.btn{
margin-left : 100px;
}

</style>
</head>
<body>

<div class="blockList" id="blockList1" style="">
        		
        		<br />
		<c:set var = "i" value = "0" />
		<c:forEach var = "blockList" items = "${blockList}">
			<c:set var = "i" value = "${i + 1}" /> 
			<div class="blockSection" >
			<input type="hidden" id="userId" value="${blockList.receiveId.userId}">
			<div><img src="/resources/image/uploadFiles/${blockList.receiveId.profileImage}" width="100" height="100" style="border-radius: 50px;" />&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;<span class="yourHome">${blockList.receiveId.nickName}</span>
		
		
		
										<button type="button" class="btn btn-danger btn-sm"
											id="stopBlock">차단해제</button>
		</div>
				</div>
			</c:forEach>
				</div>

</body>
</html>