<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="The Page Description">
	
	<title>Feed</title>
	
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
	<script src="/resources/javascript/plugins.js"></script>
	<script src="/resources/javascript/beetle.js"></script>
	
	<%-- SUMMER NOTE --%>
	<script src="/resources/summernote/summernote-lite.js"></script>
	<script src="/resources/summernote/lang/summernote-ko-KR.js"></script>
	<link rel="stylesheet" href="/resources/summernote/summernote-lite.css">
	<%-- SUMMER NOTE --%>
	
	<%-- ALERT --%>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<%-- ALERT --%>
	
	<%-- BOOTSTRAP ICON --%>
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.1/font/bootstrap-icons.css">
	<%-- BOOTSTRAP ICON --%>
	
	<script type="text/javascript">
	
	
	
	function uploadSummernoteImageFile(file, el) {
		data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "/feedRest/json/uploadImage",
			contentType : false,
			enctype : 'multipart/form-data',
			processData : false,
			success : function(data) {
				$(el).summernote('editor.insertImage', data.url);
			}
		});
	}
	
	$(function(){
		
		<%-- 무한 스크롤 --%>
		
		$(window).scroll(function() {
			console.log(($("#pageFlag").val()));
			if($("#pageFlag").val() == "true") {
			
				if((Math.ceil($(window).scrollTop() + $(window).height())) >= ( $(document).height() )) {
					
					console.log("무한 스크롤");
					
					var maxHeight = $(document).height();
					var currentScroll = Math.ceil($(window).scrollTop() + $(window).height());
					
					var sessionUser = $("#userId").val();
					
					$.ajax(
							{
								url : "/feedRest/json/getFeedList",
								method : "POST",
								data : JSON.stringify ({
									userId : sessionUser,
									currentPage : parseInt($("#currentPage").val()) + 1
								}),
								contentType: 'application/json',
								dataType : "json",
								header : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								}, // header end
								
								success : function(data, status) {
									
									var addHtml = "<p>";
									
									$.each(data, function(index, item) {
										
										console.log("무한 스크롤 정보 성공" + item.content + "\n");
										
										addHtml += item.content + "\n"
										
									}) // each close
									
									addHtml += "</p>"
									$(addHtml).appendTo($("div.six:last"));
									$("#currentPage").val( parseInt($("#currentPage").val()) + 1 );
									
									if(addHtml == "<p></p>") {
										$("#pageFlag").val(false);
									}
									
								} // success close
								
							} // ajax inner close
							
					) // ajax close
					
				} // scroll if close
			
			} // pageFlag close;
		
		}); // window scroll event close
		
		<%-- 무한 스크롤 --%>
		
		
		
		<%-- SUMMER NOTE WEB LOADING --%>
		$('#summernote').summernote({
			toolbar: [
                // [groupName, [list of button]]
                ['Insert', ['picture', 'video']],
            ],
            
            disableResizeEditor: true,
			height: 300,                 	// 에디터 높이
			minHeight: null,             	// 최소 높이
			maxHeight: null,             	// 최대 높이
			focus: true,                 	// 에디터 로딩후 포커스를 맞출지 여부
			placeholder: '오늘 하루는 어떤가요?',
			lang:'ko-KR',
			
			
			callbacks : { 
            	onImageUpload : function(files, editor, welEditable) {
           			// 파일 업로드(다중업로드를 위해 반복문 사용)
					for (var i = files.length - 1; i >= 0; i--) {
			            uploadSummernoteImageFile(files[i],
			            this);
		            		
					}
          		}
            }
		
		});
		
		<%-- SUMMER NOTE WEB LOADING --%>
		
		<%-- GET_FEED --%>
		$(document).on("click", ".feedForm", function(event) {
			event.stopPropagation();
			var feedNumber = $(this).children("input[name='feedNo']").val();
			location.href="/feed/getFeed?feedNo=" + feedNumber;
		})
		<%-- GET_FEED --%>
		
		<%-- ADD_FEED --%>
		$(document).on("click", ".addFeed", function(event){
			event.stopPropagation();
			alert("피드 추가버튼");
			$(this.form).attr("method", "POST").attr("accept-charset", "EUC-KR").attr("action", "/feed/addFeed").attr("enctype", "multipart/form-data").submit();
		});
		<%-- ADD_FEED --%>
		
		<%-- UPDATE_FEED --%>
		$(document).on("click", ".btn_update", function(event){
			event.stopPropagation();
			console.log("피드 수정 버튼");
			console.log($(this).parent().parents(".feedForm").html())
			
			$(this).parent().parents(".feedForm").attr("method", "GET").attr("action", "/feed/updateFeed").submit();
		});
		<%-- UPDATE_FEED --%>
		
		<%-- DELETE_FEED --%>
		$(document).on("click", ".btn_delete", function(event){
			event.stopPropagation();
			console.log("피드 삭제 버튼");
			console.log( $(this).parent().parents(".feedForm").html());
			
			Swal.fire({
				  title: '글을 삭제하시겠습니까???',
				  text: "삭제하시면 다시 복구시킬 수 없습니다.",
				  icon: 'warning',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: '삭제',
				  cancelButtonText: '취소'
			}).then((result) => {
				if (result.value) {
		       		//"삭제" 버튼을 눌렀을 때 작업할 내용을 이곳에 넣어주면 된다. 
					// $(".feedForm").attr("method", "GET").attr("action", "/feed/deleteFeed").submit();
					$(this).parent().parents(".feedForm").attr("method", "GET").attr("action", "/feed/deleteFeed").submit();
				}
			})
		});
		<%-- DELETE_FEED --%>
		
		<%-- ADD_FEED_HEART --%>
		$(document).on("click", ".feedLike", function(event){
			event.stopPropagation();
			alert($(this).parents(".feedForm").children("input[name='feedNo']").val() + "번 글 좋아요");
			
			var html = $(this);
			var sessionUser = $(this).parents(".feedForm").children("input[name='userId']").val();
			
			$.ajax(
					{
						url : "/feedRest/json/addFeedHeart",
						method : "POST",
						data : JSON.stringify ({
							source : 0,
							sourceNo : $(this).parents(".feedForm").children("input[name='feedNo']").val(),
							userId : sessionUser
						}),
						contentType: 'application/json',
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, // header end
						
						success : function(data, status) {
							
							alert("피드 좋아요 성공 : " + data);

							$(html).parents(".row").children(".likeCount").text(data);
							$(html).parent().html('<img class="feedDislike" src="/resources/image/uploadFiles/black_heart.jpg" width="30" height="30" style="margin-top : 0px;" />');
							
						} // success close
						
					} // ajax inner close
					
			) // ajax close
		})
		<%-- ADD_FEED_HEART --%>
		
		<%-- DELETE_FEED_HEART --%>
		$(document).on("click", ".feedDislike", function(event){
			event.stopPropagation();
			alert($(this).parents(".feedForm").children("input[name='feedNo']").val() + "번 글 시러요");
			
			var html = $(this);
			var sessionUser = $(this).parents(".feedForm").children("input[name='userId']").val();
			
			$.ajax(
					{
						url : "/feedRest/json/deleteFeedHeart",
						method : "POST",
						data : JSON.stringify ({
							source : 0,
							sourceNo : $(this).parents(".feedForm").children("input[name='feedNo']").val(),
							userId : sessionUser
						}),
						contentType: 'application/json',
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, // header end
						
						success : function(data, status) {
							
							alert("피드 시러요 성공 : " + data);
							
							$(html).parents(".row").children(".likeCount").text(data);
							$(html).parent().html('<img class="feedLike" src="/resources/image/uploadFiles/black_no_heart.jpg" width="30" height="30" style="margin-top : 0px;" />');
							
						} // success close
						
					} // ajax inner close
					
			) // ajax close
		})
		<%-- DELETE_FEED_HEART --%>
		
		<%-- CAROUSEL 침범 방지 --%>
		$(document).on("click", ".carousel-control", function(event) {
			event.stopPropagation();
		})
		<%-- CAROUSEL 침범 방지 --%>
		
		<%-- CALL REPORT --%>
		$(document).on("click", ".report", function(event) {
			event.stopPropagation();
		    
			$(this).parent().parents(".feedForm").attr("method", "POST").attr("action", "/serviceCenter/addReport").submit();
			
		}) // .report evenet close
		<%-- CALL REPORT --%>
		
	})
	
	
	
	</script>

<!------------------------------ CSS ------------------------------>

<style type="text/css">

	/* FONT */



	/* FONT */
	

	/* SUMMERNOTE */
	
	.note-toolbar {
		border: 2px solid rgba(171,148,233,1);
		color: rgba(171,148,233,1) !important;
	}
		
	.note-btn {
		border: 2px solid rgba(171,148,233,1);
		color: rgba(171,148,233,1) !important;
	}
	
	.note-editing-area {
		border: 2px solid rgba(171,148,233,1);
		color: rgba(171,148,233,1) !important;
	}

	/* SUMMERNOTE */

	/* FEED BORDER */
	.showFeedForm {
		border: 2px solid rgba(171,148,233,1);
		color: rgba(171,148,233,1) !important;
	}
	
	/* FEED BORDER */




	
	h4 {
		margin-top:5px;
		margin-left:5px;
		display: inline-block;
	}
	
	h5.meta-post {
		margin-bottom:13px !important;
		color:rgba(171,148,233,1) !important;
	}
		
	@
	-ms-viewport {
		width: device-width;
	}
	
	.row {
		margin-top: 0px;
		margin-right: 0px;
		margin-left: 0px;
	}
	
	
	
	article {
		border-style:solid !important;
		border-color:#241B12 !important;
		border-width:2 !important;
	}
	
	.carousel-inner > .item > img {
		top: 0;
		left: 0;
		width: 100%;
		height: 350px;
	} 
	
	.carousel-control.left, .carousel-control.right {
    	background-image: none
	}
	
	input.button.purple.addFeed {
		display: inline-block;
		width:75px;
		height:35px;
		float:right;
		margin-top:18px;
		margin-right:0px;
		font-size: 0.5em !important;
	}
	
	div.feedContent {
		margin-left: 60px;
		color: white !important;
	}
	
	.glyphicon-exclamation-sign:before {
	
		margin-left: 0px;
	}
	
	/* 하트 아이콘 CSS */
	div.column.two {
		margin-left: 30px;
		margin-right: 0px;
	}
	/* 하트 아이콘 CSS */
	
	/* 신고 아이콘 CSS */
	div.column.four.last.report {
		width: 40px;
		margin-left: 20px;
	}
	/* 신고 아이콘 CSS */
	
	
	
	.hashtagContent {
		margin-right: 5px;
		margin-bottom: 25px;
		margin-left: 5px;
	}

	.carousel {
		margin-bottom: 25px;
	}
	
	.feedContent {
		margin-bottom: 25px;
	}
	
	.sessionProfileImage {
		vertical-align: sub !important; 
		display: inline-block !important; 
		width:50px; 
		height:50px;
		margin-top:10px; 
		margin-bottom:10px; 
		margin-left:10px;
	}
	
</style>

<!------------------------------ CSS ------------------------------>


	
</head>

<body class="single single-post">

	<jsp:include page="/toolbar.jsp" />

	<main role="main">
	
		<div id="intro-wrap" data-height="15">
				<div id="intro" class="preload darken">					
					<div class="intro-item" style="background-image: url(http://placehold.it/1800x600/);">
						<div class="caption">
							<h2>Feed</h2>
							<p>If you’re any good at all, you know you can be better.</p>
						</div><!-- caption -->					
					</div>								
				</div><!-- intro -->
			</div><!-- intro-wrap -->
		
		<div id="main">
		
			<section class="row section">
			
				<div class="row-content buffer even clear-after">
					<div class="column three">
						<a href="http://localhost:5005/" onclick="window.open(this.href, '_blank', 'width=600, height=600, location =no,status=no, toolbar=no, scrollbars=no'); return false;">길찾기</a>
						
						<%-- 검색 --%>
						<form id="searchForm" method="POST" action="/feed/getFeedList" accept-charset="euc-kr">
							
							<input type="text" style="width:200px" placeholder="검색" name="searchKeyword" value="">
							
						</form>
						<%-- 검색 --%>
						
					</div>
					
					<div class="column six">
						<div class="post-area clear-after addFeedForm">
							<form id="addForm">
							
							<c:if test="${!empty sessionScope.user}">
							
								<article role="main">
									<img class="sessionProfileImage" src="/resources/image/uploadFiles/${sessionScope.user.profileImage}" /><h4 style="vertical-align: top;">${sessionScope.user.nickName}</h4>
									
									<input class="plain button purple addFeed" value="Submit">
									
									<textarea id="summernote" name="content"></textarea>
								</article>
								
							</c:if>
		
							<input type="hidden" name="openCondition" value="3">
							
							</form>
						</div>

						<c:set var="i" value="0"></c:set>
						<c:forEach var="feed" items="${feedList}">
							<c:set var="i" value="${i + 1}"></c:set>

							<c:if test="${fn:trim(feed.deleteCondition) eq '0' and fn:trim(feed.reportCondition) eq '0'}">

								<div class="showFeedForm">
									<form class="feedForm">

										<img src="/resources/image/uploadFiles/${feed.user.profileImage}" style="vertical-align: sub; display: inline-block; width:50px; height:50px; margin-top:20px; margin-left:10px" /><h4 style="vertical-align: text-bottom;">${feed.user.nickName}</h4>
										
										<h5 class="meta-post" style="display: inline-block; vertical-align: text-bottom;">
											<c:if test="${!empty feed.updateDate}">${feed.updateDate}</c:if>
											<c:if test="${empty feed.updateDate}">${feed.regDate}</c:if>
										</h5>
										
										<c:if test="${sessionScope.user.userId eq feed.user.userId}">
											
											<div style="display: inline-block; float: right; margin-top:10px; margin-right:10px;">
												<%-- 수정 버튼 --%>
												<span class="glyphicon glyphicon-paperclip btn_update" aria-hidden="true"></span>
												<%-- 수정 버튼 --%>
											
												<%-- 삭제 버튼 --%>
												<span class="glyphicon glyphicon-trash btn_delete" aria-hidden="true" ></span>
												<%-- 삭제 버튼 --%>
											</div>
										</c:if>
									
										<div class="feedContent">
											${feed.content}
										</div>
										
										<%-- 이미지 --%>
										<c:if test="${!empty feed.image1}">
										<div id="carousel-example-generic${i}" class="carousel slide" data-ride="carousel">
											<ol class="carousel-indicators">
												<li data-target="#carousel-example-generic${i}" data-slide-to="0" class="active"></li>
												
												<c:if test="${!empty feed.image2}">
													<li data-target="#carousel-example-generic${i}" data-slide-to="1"></li>
												</c:if>
												<c:if test="${!empty feed.image3}">
													<li data-target="#carousel-example-generic${i}" data-slide-to="2"></li>
												</c:if>
												<c:if test="${!empty feed.image4}">
													<li data-target="#carousel-example-generic${i}" data-slide-to="3"></li>
												</c:if>
											</ol>
										
											<!-- Wrapper for slides -->
											<div class="carousel-inner" role="listbox">
												<div class="item active">
													<img src="/resources/image/uploadFiles/${feed.image1}" alt="${feed.image1}">
												</div>
												
												<c:if test="${!empty feed.image2}">
													<div class="item">
														<img src="/resources/image/uploadFiles/${feed.image2}" alt="${feed.image2}">
													</div>
														<c:if test="${!empty feed.image3}">
															<div class="item">
																<img src="/resources/image/uploadFiles/${feed.image3}" alt="${feed.image3}">
															</div>
															<c:if test="${!empty feed.image4}">
																<div class="item">
																	<img src="/resources/image/uploadFiles/${feed.image4}" alt="${feed.image4}">
																</div>
															</c:if>
														</c:if>														
												</c:if>
											</div>

											<!-- Controls -->
											<a class="left carousel-control carousel_prev" href="#carousel-example-generic${i}" role="button" data-slide="prev">
												<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
												<span class="sr-only">Previous</span>
											</a>
											<a class="right carousel-control carousel_next" href="#carousel-example-generic${i}" role="button" data-slide="next">
												<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
												<span class="sr-only">Next</span>
											</a>
										</div>
										</c:if>
										<%-- 이미지 --%>
										
										<c:if test="${!empty feed.hashtag}">
											<div class="hashtagContent">
												${feed.hashtag}
											</div>
										</c:if>
										
										<%-- 피드 댓글 신고 --%>
										<input type="hidden" name="reportSource" value="3">
										<input type="hidden" name="sourceNumber" value="${feed.feedNo}">
										<input type="hidden" name="user2" value="${feed.user.userId}">
										<%-- 피드 댓글 신고 --%>
										
										<input type="hidden" name="source" value="0">
										<input type="hidden" name="feedNo" value="${feed.feedNo}">
										<input type="hidden" id="userId" name="userId" value="${sessionScope.user.userId}">
										<input type="hidden" name="openCondition" value="3">

										<!-- 피드 좋아요 댓글수 신고 -->
										<section class="row section lastBar">
											<div class="row">
												<c:if test="${feed.checkHeart eq 0}">
													<div class="column two">
														<img class="feedLike" src="/resources/image/uploadFiles/no_heart.jpg" width="30" height="30" style="margin-top : 0px;" aria-hidden="true"/>
													</div>
												</c:if>
												<c:if test="${feed.checkHeart ne 0}">
													<div class="column two">
														<img class="feedDislike" src="/resources/image/uploadFiles/heart.jpg" width="30" height="30" style="margin-top : 0px;" aria-hidden="true"/>
													</div>
												</c:if>
												
												<div class="column two likeCount">
													${feed.heartCount}
												</div>
												
												<div class="column two comment">
													<img src="/resources/image/uploadFiles/comments.jpg" width="25" height="25" style="margin-top : 4px;" aria-hidden="true"/>
												</div>
												
												<div class="column two commentCount">
													 ${feed.commentCount}
												</div>
													
												<!-- 신고 아이콘 -->
												<div class="column four last report">
													<span class="glyphicon glyphicon-exclamation-sign" style="font-size:1.5rem; margin-top:3px;" aria-hidden="true" ></span>
												</div>
												<!-- 신고 아이콘 -->
												
											</div>
										</section>
										<!-- 피드 좋아요 댓글수 신고 -->

									</form>

								</div>

							</c:if>
						</c:forEach>


					</div>

					<div class="column three"></div>
					
					<%-- 현재 페이지 --%>
					<input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}">
					<input type="hidden" id="pageFlag" value=true>
					<%-- 현재 페이지 --%>
					
				</div>

			</section>

		</div>

	</main>

</body>
</html>
