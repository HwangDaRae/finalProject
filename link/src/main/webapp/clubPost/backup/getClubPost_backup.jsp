<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script type="text/javascript">
$(function(){
	$("input[value='수정']").bind("click", function(){
		$("form").attr("method", "post").attr("action", "/clubPost/updateClubPostView?clubPostNo="+${ clubPost.getClubPost.clubPostNo }).submit();
	});
	$("input[value='삭제']").bind("click", function(){
		alert("모임 게시물 번호 : " + ${ clubPost.getClubPost.clubPostNo });
		$("form").attr("method", "post").attr("action", "/clubPost/deleteClubPost?clubNo=2&clubPostNo="+${ clubPost.getClubPost.clubPostNo }).submit();
	});
	$("input[value='리스트로이동']").bind("click", function(){
		location.href = "/clubPost/getClubPostList?clubNo=2&order=0";
	});
	$("a:contains('하트')").bind("click", function(){
		alert('하트');
		$.ajax( "/clubPostRest/json/updateClubPost",
				{
					method : "POST",
					data : JSON.stringify({
								clubPostNo : ${ clubPost.getClubPost.clubPostNo },
								userId : "${ clubPost.getClubPost.user.userId }"
							}),
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType : "json",
					success : function(JSONData, status){
						//alert(status);
						//alert(JSONData);
						$("a[href='#']").text(JSONData);
					}
				});
	}); // end of 하트
	$(document).on("click", "b:contains('댓글 수')", function(){
		alert("댓글 수");
		var clubPostCommentNo = $(this).attr("clubPostCommentNo");
		var clubPostNo = $(this).attr("clubPostNo");
		$.ajax( "/clubPostRest/json/getClubPostCommentList",
				{
					method : "POST",
					data : JSON.stringify({
								clubPostCommentNo : clubPostCommentNo,
								clubPostNo : clubPostNo
							}),
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType : "json",
					success : function(JSONData, status){
						alert(status);
						$.each( JSONData, function( index, el ){
							var display = "<nav>"
											+"댓글 내용 : <div class='" + el.clubPostCommentNo + "'>" + el.commentContent + "</div>"
											+"<button class='" + el.clubPostCommentNo + "'>수정</button>"
											+"<input type='button' class='" + el.clubPostCommentNo + "' value='삭제'>"
											+"<b style='color : blue;'>댓글번호 : " + el.clubPostCommentNo + "</b></br>"
											+"댓글등록날짜 : " + el.commentRegDate + "</br>"
											+"댓글수정날짜 : " + el.commentUpdateDate + "</br>"
											+"댓글 좋아요 수 : " + el.commentHeartCount + "</br>"
											+"댓글 신고여부 : " + el.reportCondition + "</br>"
											+"댓글 삭제여부 : " + el.deleteCondition + "</br>"
											+"댓글 부모번호 : " + el.parent + "</br>"
											+"댓글 깊이 : " + el.depth + "</br>"
											+"댓글 순서 : " + el.sequence + "</br>"
											//+"<div class='"+el.clubPostCommentNo+"'>"
											//+"<b style='color : green;' clubPostNo="+el.clubPostNo+" clubPostCommentNo="
													//+el.clubPostCommentNo+">댓글 수 " + el.commentCount + "</b></br>"
											//+"</div>"
											+"</nav>";
							alert(display);

							$("nav[class='"+clubPostCommentNo+"']").append(display);
						});
					} // end of success
				}); // end of ajax
	}); // end of 댓글 수
	$(document).on("click", "button", function(){
		alert("button");
		var text = $(this).prev().html();
		var inputText = "<input type='text' value='"+text+"'><input type='button' value='수정완료'>";
		$(this).parent().prepend(inputText);
	});
	$(document).on("click", "input[value='수정완료']", function(){
		alert("수정완료");
		var commentContent = $("input[type='text']").val();
		$.ajax( "/clubPostRest/json/updateClubPostComment",
				{
					method : "POST",
					data : JSON.stringify({
								clubPostCommentNo : 3,
								commentContent : commentContent
							}),
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType : "json",
					success : function(JSONData, status){
						alert(status);
					} // end of success
				}); // end of ajax
	}); // end of 수정완료
	$(document).on("click", "input[value='삭제']", function(){
		alert("삭제");
		var clubPostCommentNo = $(this).attr("class");
		alert(clubPostCommentNo);
		$.ajax( "/clubPostRest/json/deleteClubPostComment",
				{
					method : "POST",
					data : JSON.stringify({
								clubPostCommentNo : clubPostCommentNo
							}),
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType : "json",
					success : function(JSONData, status){
						alert(status);
					} // end of success
				}); // end of ajax
	}); // end of 삭제
	$(document).on("click", "input[value='등록']", function(){
		alert("등록");
		var inputText = "<input type='text' value=''><input type='button' value='등록완료'>";
		$(this).parent().prepend(inputText);
	}); // end of 등록
	$(document).on("click", "input[value='등록완료']", function(){
		alert("등록완료");
		var commentContent = $("input[type='text']").val();
		alert(commentContent);
		$.ajax( "/clubPostRest/json/addClubPostComment",
				{
					method : "POST",
					data : JSON.stringify({
								clubPostCommentNo : 0,
								clubPostNo : 64,
								commentContent : commentContent
							}),
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType : "json",
					success : function(JSONData, status){
						alert(status);
						alert(JSONData);
					} // end of success
				}); // end of ajax
	}); // end of 등록완료
	$(document).on("click", "a:contains('댓글좋아요')", function(){
		alert('댓글좋아요');
		$.ajax( "/clubPostRest/json/updateClubPostComment",
				{
					method : "POST",
					data : JSON.stringify({
								clubPostCommentNo : 9,
								heartCondition : 1,
								userId : "user03"
							}),
					headers : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					},
					dataType : "json",
					success : function(JSONData, status){
						//alert(status);
						//alert(JSONData);
						$("a[href='###']").text(JSONData);
					}
				});
	}); // end of 댓글좋아요
	//검색버튼 클릭시 검색 내용에 맞는 상품리스트를 display
	function fncGetProductList() {
		document.detailForm.searchCondition.value = document.detailForm.searchCondition.value;
		document.forms[0].elements[1].value = document.forms[0].elements[1].value;
		$("#currentPage").val("1");
		$("form").attr("method","post").attr("action","/product/listProduct").submit();
	}
});
</script>
</head>
<body>
<form>
<input type="button" value="수정">
<input type="button" value="삭제">
<input type="button" value="리스트로이동">
<a href="#"><img alt="" src="abcd.jpg">하트</a></br>
<%-- 모임 게시물 등록 회원 정보 : ${ clubPost.getClubPost.user }</br> --%>
모임 게시물 등록 회원 아이디 : ${ clubPost.getClubPost.user.userId }</br>
<%-- 모임 게시물 등록 회원 닉네임 : ${ clubPost.getClubPost.user.nickName }</br> --%>
모임 번호 : ${ clubPost.getClubPost.clubNo }</br>
모임 게시물 번호 : ${ clubPost.getClubPost.clubPostNo }</br>
모임 게시물 제목 : ${ clubPost.getClubPost.clubPostTitle }</br>
모임 게시물 내용 : ${ clubPost.getClubPost.clubPostContent }</br>
모임 게시물 영상1 : <%-- <iframe width="1280" height="716" src="https://www.youtube.com/embed/${  clubPost.getClubPost.clubPostVideo1 }"
frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe> --%></br>
모임 게시물 영상2 : ${ clubPost.getClubPost.clubPostVideo2 }</br>
모임 게시물 영상3 : ${ clubPost.getClubPost.clubPostVideo3 }</br>
모임 게시물 이미지1 : ${ clubPost.getClubPost.image1 }</br>
모임 게시물 이미지2 : ${ clubPost.getClubPost.image2 }</br>
모임 게시물 이미지3 : ${ clubPost.getClubPost.image3 }</br>
모임 게시물 이미지4 : ${ clubPost.getClubPost.image4 }</br>
모임 게시물 이미지5 : ${ clubPost.getClubPost.image5 }</br>
모임 게시물 이미지6 : ${ clubPost.getClubPost.image6 }</br>
모임 게시물 이미지7 : ${ clubPost.getClubPost.image7 }</br>
모임 게시물 이미지8 : ${ clubPost.getClubPost.image8 }</br>
모임 게시물 이미지9 : ${ clubPost.getClubPost.image9 }</br>
모임 게시물 이미지10 : ${ clubPost.getClubPost.image10 }</br>
모임 게시물 등록날짜 : ${ clubPost.getClubPost.clubPostRegDate }</br>
모임 게시물 수정날짜 : ${ clubPost.getClubPost.clubPostUpdateDate }</br>
모임 게시물 좋아요 수 : ${ clubPost.getClubPost.clubPostHeartCount }</br>
모임 게시물 댓글 개수 : ${ clubPost.getClubPost.clubPostCommentCount }</br>
<c:if test="${ clubPost.getClubPost.clubPostCommentCount > 0 }">
//////////////////////////////////////////////////////////////////////</br>
//////////////////////////////////////////////////////////////////////</br>
//////////////////////////////////////////////////////////////////////</br>
모임 게시물 댓글 리스트</br>
<div add="add" clubPostNo="${ clubPost.getClubPost.clubPostNo }">
<input type="button" value="등록">
<a href="###"><img alt="" src="abcd.jpg">댓글좋아요</a></br>
</div>
//////////////////////////////////////////////////////////////////////</br>
//////////////////////////////////////////////////////////////////////</br>
//////////////////////////////////////////////////////////////////////</br>
<c:forEach var="i" begin="0" end="${ clubPost.getClubPost.clubPostCommentCount - 1 }" step="1">
<c:if test="${ clubPost.getClubPostCommentList[i].parent == clubPost.getClubPost.clubPostNo }">
<nav class="${ clubPost.getClubPostCommentList[i].clubPostCommentNo }">
댓글 내용 : <div class="${ clubPost.getClubPostCommentList[i].clubPostCommentNo }">
${ clubPost.getClubPostCommentList[i].commentContent }</div>
<c:if test="${ user.userId == clubPost.getClubPostCommentList[i].user.userId }">
<button class="${ clubPost.getClubPostCommentList[i].clubPostCommentNo }">수정</button>
</c:if></br>
모임 게시물 번호 : ${ clubPost.getClubPostCommentList[i].clubPostNo }</br>
모임 게시물 댓글 번호 : ${ clubPost.getClubPostCommentList[i].clubPostCommentNo }</br>
모임 게시물 댓글 등록 회원 아이디 : ${ clubPost.getClubPostCommentList[i].user.userId }</br>
모임 게시물 댓글 등록 회원 닉네임 : ${ clubPost.getClubPostCommentList[i].user.nickName }</br>
댓글 등록날짜 : ${ clubPost.getClubPostCommentList[i].commentRegDate }</br>
댓글 수정날짜 : ${ clubPost.getClubPostCommentList[i].commentUpdateDate }</br>
댓글 좋아요 수 : ${ clubPost.getClubPostCommentList[i].commentHeartCount }</br>
신고여부 : ${ clubPost.getClubPostCommentList[i].reportCondition }</br>
삭제여부 : ${ clubPost.getClubPostCommentList[i].deleteCondition }</br>
댓글 부모번호 : ${ clubPost.getClubPostCommentList[i].parent }</br>
댓글 깊이 : ${ clubPost.getClubPostCommentList[i].depth }</br>
댓글 순서 : ${ clubPost.getClubPostCommentList[i].sequence }</br>
<%-- <a href="/clubPostRest/getClubPostCommentList?clubPostCommentNo=${ clubPost.getClubPostCommentList[i].clubPostCommentNo }&depth=0">댓글 수 : ${ clubPost.getClubPostCommentList[i].commentCount }</a></br> --%>
<div class="${ clubPost.getClubPostCommentList[i].clubPostCommentNo }">
	<b style="color : red;" clubPostCommentNo="${ clubPost.getClubPostCommentList[i].clubPostCommentNo }"
	clubPostNo="${ clubPost.getClubPostCommentList[i].clubPostNo }">
	댓글 수 ${ clubPost.getClubPostCommentList[i].commentCount }</b></br>
</div>
</nav>
//////////////////////////////////////////////////////////////////////</br>
</c:if>
</c:forEach>
</c:if>
</form>
</body>
</html>




