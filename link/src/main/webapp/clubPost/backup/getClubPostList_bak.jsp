<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<meta name="description" content="The Page Description">
		
		<style type="text/css">@-ms-viewport{width: device-width;}</style>
		
		<title>모임 게시물 리스트</title>
		
		<!-- 사용자 정의 css -->
		<link href="/resources/css/clubPost/clubPost.css" rel="stylesheet">

		<!-- 공통 css는 toolbar.jsp include 받아서 쓰고있다 -->
		
		<link href='http://fonts.googleapis.com/css?family=Montserrat:400,700|Open+Sans:400italic,700italic,400,700' rel='stylesheet' type='text/css'>
		
		<!--  font -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
		
		<!-- Swal 쓰기위한 cdn -->
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
		
		<!--  ///////////////////////// jQuery CDN, bootstrap CDN ////////////////////////// -->
		<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
		<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	
		<!-- 템플릿에 있던 코드 -->
		<!-- <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script> -->
		<script src="/resources/javascript/plugins.js"></script>
		<script src="/resources/javascript/beetle.js"></script>
		
		<script type="text/javascript">
			$(function() {
				// summernote
				textEdit();
				
				$("#club-post-add").bind("click", function(e) {
					// 모달창 열기
					$('#club-post-add-modal').modal("show");
				});
				
				$("input[value='등록완료']").bind("click", function(){
					//alert('등록완료');
					//$(this.form).attr("method", "POST").attr("accept-charset", "EUC-KR").attr("action", "/feed/addFeed").attr("enctype", "multipart/form-data").submit();
					
					if( $.trim($("input[name='clubPostTitle']").val()) == '' ){
						Swal.fire({
							  icon: 'error',
							  title: '제목은 필수입니다'
							})
							return;
					}
					
					if( $("input[name='clubPostTitle']").val().length > 40 ){
						Swal.fire({
							  icon: 'error',
							  title: '제목은 40자까지 가능합니다'
							})
							return;
					}
					
					if( $("#summernote").val().match("img") == null && $("#summernote").val().match("iframe") == null ){
						Swal.fire({
							  icon: 'error',
							  title: '이미지나 동영상 1개 필수입니다'
							})
							return;
					}
					
					if( $("#summernote").val().length > 1000 ){
						Swal.fire({
							  icon: 'error',
							  title: '내용이 너무 깁니다'
							})
							return;
					}
					
					$("form").attr("accept-charset", "EUC-KR").submit();
					
					if(sock) {
						var Msg = "게시물 작성";
						sock.send(Msg);
					}
					
				});
				
				$("input[value='이전으로']").bind("click", function(){
					//alert('이전으로');
					
					// 제목과 내용 초기화
					$("input[name='clubPostTitle']").val("");
					// summernote는 불러오고 나서 F12번으로 textArea 클릭해서 class명 다시 지정해줌
					$(".note-editable").text("");
					$("#summernote").val("");
					
					// 모달창 닫기
					$('#club-post-add-modal').modal("hide");
				});
				
				// 모달창 x 클릭시 이벤트
				$("button[class='close']").bind("click", function(){
					//alert('수정완료 이전으로');
					
					// 제목과 내용 초기화
					$("input[name='clubPostTitle']").val("");
					// summernote는 불러오고 나서 F12번으로 textArea 클릭해서 class명 다시 지정해줌
					$(".note-editable").text("");
					$("#summernote").val("");
					
					// 모달창 닫기
					$('#club-post-add-modal').modal("hide");
				});
				
				$("b:contains('최신순')").bind("click", function() {
					location.href = "/clubPost/getClubPostList?clubNo="+${ clubNo }+"&order=0";
				});
				$("b:contains('오래된순')").bind("click", function() {
					location.href = "/clubPost/getClubPostList?clubNo="+${ clubNo }+"&order=1";
				});
				$("b:contains('좋아요 많은순')").bind("click", function() {
					location.href = "/clubPost/getClubPostList?clubNo="+${ clubNo }+"&order=2";
				});
				$("b:contains('내가 작성한 게시물')").bind("click", function() {
					location.href = "/clubPost/getClubPostList?clubNo="+${ clubNo }+"&order=3";
				});
				$("input[value='검색']").bind("click", function() {
					$("input[name='currentPage']").val("1");
					//$("form").submit();
				});
				$("b:contains('모임등록시 - 모임 추가')").bind("click", function() {
					location.href = "/clubPost/addPayView";
				});
				$("b:contains('모임대표가 가입승인시 - 모임원 추가')").bind("click", function() {
					location.href = "/clubPost/addPayView?clubNo="+${ clubNo };
				});
				$("b:contains('모임신청시 - 모임추가')").bind("click", function() {
					location.href = "/clubPost/addPayView?payNavigation=1";
				});
				
				//무한 페이징
				var currentPage = 1;
				$(window).scroll(function() {
					var maxHeight = $(document).height();
					var currentScroll = Math.ceil($(window).scrollTop() + $(window).height());
					
					if(currentScroll >= maxHeight) {
						
						currentPage++;
						//alert(currentPage);
						$("input[name='currentPage']").val(currentPage);
						
						var clubNo = "2";
						var searchCondition = $("option:selected").val();
						var searchKeyword = $("input[name='searchKeyword']").val();
						var order = $("input[name='order']").val();
						
						//alert(searchCondition);
						//alert(searchKeyword);
						//alert(order);
						
						$.ajax({
							url : "/clubPostRest/json/getClubPostList",
							type : "post",
							dataType : "json",
							data : JSON.stringify({
								pageUnit : clubNo,
								currentPage : currentPage,
								searchCondition : searchCondition,
								searchKeyword : searchKeyword,
								order : order
							}),
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function( JSONData, status ) {
								//alert(status);
								//console.log(JSONData.clubPostList);
								//console.log(JSONData.clubPostList.length);

								$.each( JSONData, function( item, el ) {
									console.log( item );
									console.log( el );
									//var check = (JSONData.clubPostList.clubPostVideo1 == null)? false: true
											
									var display = "";
									
									console.log( display );
									$(".col-md-4").append( display );
								});
								
								$("input[name='order']").val( JSONData.search.order );
								
							}// end of success
						});// end of ajax				
					}// end of if			
				}); // end of scroll
				
				// order
				$(document).ready(function () {
					$(".club-post-list-order").hover(function () {
						$(this).css("color", "#5F0080");
					}, function () {
						$(this).css("color", "black");
					});
				});
								
				
				
			});// end of function()
			
			//썸네일 클릭시 상세상품조회 페이지 or 상품수정 페이지로 이동
			function getClubPostGo(clubNo, clubPostNo){
				location.href = "/clubPost/getClubPost?clubNo="+clubNo+"&clubPostNo="+clubPostNo;
			}
			
			// 닉네임, 프로필사진 클릭시 해당 유저의 마이홈피로 이동
			function getMyHomeGo(userId){
				location.href = "/myHome/getYourHome?userId="+userId;
			}
		</script>
		
		<!-- include summernote css/js -->
		<link href="/resources/summernote/summernote-lite.css" rel="stylesheet">
		<script src="/resources/summernote/summernote-lite.js"></script>
		<script>
			function textEdit(){
			    jsonArray = [];
				$('#summernote').summernote({
	                disableResizeEditor: true,
	                minHeight : 400,
	                maxHeight : 700,
	                focus : true,
	                lang : 'ko-KR',
	                toolbar : [
	  	              ["style", ["style"]],
		              ["font", ["bold", "underline", "clear"]],
		              ["fontname", ["fontname"]],
		              ["para", ["ul", "ol", "paragraph"]],
		              ["table", ["table"]],
		              ["insert", ["link", "picture", "video"]],
		              ["view", ["fullscreen", "codeview"]],
		              ['highlight', ['highlight']]
		            ],
	                //콜백 함수
	                callbacks : {
	                	onImageUpload : function(files, editor, welEditable) {
	               	 		// 파일 업로드(다중업로드를 위해 반복문 사용)
	               	 		for (var i = files.length - 1; i >= 0; i--) {
	                			uploadSummernoteImageFile(files[i], this);
	                		}
	                	}
	                }//end of callbacks
	            });//end of summernote

				function uploadSummernoteImageFile(file, el) {
					var data = new FormData();
					data.append("file",file);
						$.ajax({
							url: '/clubPostRest/json/uploadSummernoteImageFile',
							type: "POST",
							enctype: 'multipart/form-data',
							data: data,
							cache: false,
							contentType : false,
							processData : false,
							success : function(data) {
								//alert(data.responseCode);
								//alert(data.url);
								//alert("업로드 하였습니다");
								$(el).summernote('editor.insertImage', data.url);
								//alert(data.url);
								//jsonArray.push(json["url"]);
								//jsonFn(jsonArray);
							}
						});
				}//end of uploadSummernoteImageFile
				
				function jsonFn(jsonArray){
					//console.log(jsonArray);
				}

			};//end of textEdit
		</script>
		
		<style type="text/css">
		.modal{ 
			position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.2); top:0; left:0; display:none;
		}
		
		.modal_content{
			width:400px; height:200px;
			background:#fff; border-radius:10px;
			position:relative; top:50%; left:50%;
			margin-top:-100px; margin-left:-200px;
			text-align:center;
			box-sizing:border-box; padding:74px 0;
			line-height:23px; cursor:pointer;
		}
		
		.club-post-add-view{
			box-shadow: rgba(95, 0, 128, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
			border-radius: 30px;
			padding: 3rem;
			/* background-color: #f2f3ff; */
		}
		</style>
		
	</head>
<body class="portfolio">

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->
	
	

		<main role="main">

			<div id="main" class="row"><!-- 중간 개별영역 -->
			
				<div class="row-content buffer clear-after" style="padding-right: 0px;">
				
				
				
					<ul class="inline cats filter-options" style="font-size: 40px;">
						<li data-group="advertising">
							<a href="/club/getMeetingList">모임 일정</a>
						</li>
						<li data-group="fun">
							<a href="/clubPost/getClubPostList">모임 게시물</a>
						</li>
						<li data-group="icons">
							<a href="/club/getClubMemberList">모임원</a>
						</li>
						<li data-group="infographics">
							<a href="/clubPost/chatRoomList">모임 채팅</a>
						</li>
					</ul>
					
					
					
					<div class="grid-items preload">
					
					
							<!--  화면구성 div Start /////////////////////////////////////-->
						<div class="column nine">
							    
							    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
							    <div class="contains-search">
							    
								    <div class="contains-order">
								    	<p class="text-primary" style="width: 87%">
								    		전체  <span class="page">${ clubPostListCount }</span> 건수<%-- , 현재 <span class="page">${ search.currentPage }</span> 페이지 --%><br>
											<b class="club-post-list-order">최신순</b>&nbsp;/&nbsp;
											<b class="club-post-list-order">오래된순</b>&nbsp;/&nbsp;
											<b class="club-post-list-order">좋아요 많은순</b>&nbsp;/&nbsp;
											<b class="club-post-list-order">내가 작성한 게시물</b><br>
											<b class="club-post-list-order">모임등록시 - 모임 추가</b><br>
											<b class="club-post-list-order">모임대표가 가입승인시 - 모임원 추가</b><br>
											<b class="club-post-list-order">모임신청시 - 모임추가</b><br>
											<!-- <a href="/clubPost/getClubNoticeList">공지사항</a> -->
											<button type="button" class="plain button red" id="club-post-add">등록하기</button>
								    	</p>
								    </div>
								    
									<div class="contains-search" >
										<form class="form-inline" name="detailForm" action="/clubPost/getClubPostList" method="post">
											
											<!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
											<input type="hidden" name="currentPage" value=""/>
											<input type="hidden" name="order" value="${ search.order }">
										  
										</form>
									</div>
							    	
							    </div>
							    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
							    
							    
							    
							    <!-- 썸네일로 list display start -->
								<div class="row">
									<c:set var="i" value="${ clubPostList }"></c:set>
									<c:if test="${ clubPostListCount > 0}">
									<c:forEach var="i" begin="0" end="${ fn:length(clubPostList) - 1 }" step="1">
										<div class="col-md-12" style="padding-left: 105px;">
											<a style="background-color: red;" href="javascript:getClubPostGo('${ clubPostList[i].clubNo }','${ clubPostList[i].clubPostNo }')">
												<c:if test="${ empty clubPostList[i].clubPostVideo1 }">
													<img src="/resources/image/uploadFiles/${ clubPostList[i].image1 }" height="400" width="600">
												</c:if>
												<c:if test="${ ! empty clubPostList[i].clubPostVideo1 }">
													<img src="https://img.youtube.com/vi/${ clubPostList[i].clubPostVideo1 }/mqdefault.jpg" alt="영상 썸네일입니다." height="400" width="600">
												</c:if>
											</a>
											
											<div class="club-post-list-content" style="display: grid; grid-template-columns: 1fr 1fr 3fr 1fr 1fr;">
												<div>
													<a href="javascript:getMyHomeGo('${ clubPostList[i].user.userId }')">
														<img class="profileImage" src="/resources/image/uploadFiles/${ clubPostList[i].user.profileImage }">
													</a>
												</div>
												<div>
													<a href="javascript:getMyHomeGo('${ clubPostList[i].user.userId }')">
														<p align="center" style="font-size: 30px; color: red;">${ clubPostList[i].user.nickName }</p>
													</a>
												</div>
												<div></div>
												<div style="padding-top: 20px;">
													<!-- heartCondition에 모임 게시물 번호가 있으면 해당 유저가 좋아요했다 / 0이면 좋아요 안했다 -->
													<img style="float: right;" src="/resources/image/uploadFiles/${ clubPostList[i].heartCondition != 0 ? 'heart.jpg' : 'no_heart.jpg' }" height="50" width="50">
												</div>
												<div>
													<p align="center" style="font-size: 30px; float: left;">${ clubPostList[i].clubPostHeartCount }</p>
												</div>
												
											</div>
											<div style="width: 87%;">
												<p align="center" style="font-size: 30px">${ clubPostList[i].clubPostTitle }</p>
											</div>
										</div>
									</c:forEach>
									
									</c:if>
									<c:if test="${ clubPostListCount == 0}">
										<h4>해당되는 게시물이 없습니다.</h4>
									</c:if>
								</div>
								<!-- 썸네일로 list display end -->
							    
							    
							    
							
						
						</div><!-- grid-items -->
						<!--  화면구성 div End /////////////////////////////////////-->
						
						
						
						
						
						<aside role="complementary" class="sidebar column three last">
							<div class="widget widget_search">
								<form role="search">
									<!-- <span class="pre-input" style="background-color: gray;"><i class="icon icon-search"></i></span> -->
									
										<%-- <div style="float: left; width: 65%; background-color: orange;">
											<input type="text"  name="searchKeyword" placeholder="내용을 입력" class="plain buffer" value="${ ! empty search.searchKeyword ? search.searchKeyword : '' }">
										</div>
									
										<div class="form-group" style="flex: 1;">
											<select class="form-control" name="searchCondition" >
												<option value="0"  ${ ! empty search.searchCondition && search.searchCondition == 0 ? "selected" : "" }>아이디</option>
												<option value="1"  ${ ! empty search.searchCondition && search.searchCondition == 1 ? "selected" : "" }>내용</option>
											</select>
										</div>
										
										<div style="display: inline-block;">
											<input type="button" class="club-post-search" value="검색">
										</div> --%>
									
								</form>
							</div>
						</aside>
						
						
						
						
					</div>
				</div><!-- row-content -->
			</div><!-- row -->
		</main><!-- main -->
		
		
		
		
		<!-- 모달창 start -->
		<div class="modal fade" id="club-post-add-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button class="close" type="button" data-dismiss="modal" aria-label="Close">
							<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
						</button>
						<h3 class="modal-title" id="exampleModalLabel">게시물 등록하기</h5>
					</div>
					<div class="club-post-add-view">
						<form name="addClubPost" method="post" action="/clubPost/addClubPost" enctype="multipart/form-data">
							<input type="hidden" name="clubNo" value="${ clubNo }">
							<div class="clubPostTitle">
								<input type="text" name="clubPostTitle" placeholder="제목">
							</div>
							<textarea id="summernote" aria-multiline="true" name="clubPostContent"></textarea>
							<input type="button" class="plain button red" value="등록완료">
							<input type="button" class="plain button red cancle" value="이전으로">
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- 모달창 end -->
		
		

</body>
</html>
