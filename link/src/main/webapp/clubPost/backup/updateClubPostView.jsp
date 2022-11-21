<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>		
		<script src="js/plugins.js"></script>
		<script src="js/beetle.js"></script>
		
		<!-- 사용자 정의 css -->
		<link rel="stylesheet" href="/resources/css/clubPost/clubPost.css" type="text/css" media="screen" title="no title">
		
		<!-- include libraries(jQuery, bootstrap) -->
		<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		
		<!--  font -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
		
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
		<script type="text/javascript">
			$(function(){
				textEdit();
				
				$("input[value='수정완료']").bind("click", function(){
					$("form").attr("accept-charset", "EUC-KR").submit();
				});
				$("input[value='이전으로']").bind("click", function(){
					location.href = "/clubPost/getClubPost?clubNo="+${ clubNo }+"&clubPostNo="+${ getClubPost.clubPostNo };
				});
			});
		</script>
		<style type="text/css">
			.row{
				font-family: 'Single Day', cursive;
			}
			.club-post-update-view{
				box-shadow: rgba(95, 0, 128, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
				border-radius: 30px;
				padding: 3rem;
				/* background-color: #f2f3ff; */
			}
			.club-post-update-submit{
				box-shadow: rgba(95, 0, 128, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
				border-radius: 10px;
				padding: 1rem;
				width: 110px;
				background-color: #5F0080;
				color: white;
				font-size: 25px;
				border-color: #5F0080;
			}
			.list-navigation{
				box-shadow: rgba(95, 0, 128, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
				border-radius: 10px;
				padding: 1rem;
				background-color: white;
				color: #5F0080;
				font-size: 25px;
				border-color: #5F0080;
			}
		</style>
	</head>

	<body class="single single-post">

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->		

		<main role="main">
			<div id="intro-wrap">				
			</div><!-- intro-wrap -->

			<div id="main" class="row">
				<div class="row-content buffer-left buffer-right buffer-bottom">
				
				
				
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
							<a href="#">모임 채팅</a>
						</li>
						<li data-group="infographics">
							<a href="/clubPost/addPayView?clubNo=${ clubNo }">결제</a>
						</li>
					</ul>
	
					<div class="club-post-update-view">
						<form name="updateClubPost" method="post" action="/clubPost/updateClubPost" enctype="multipart/form-data">
							<input type="hidden" name="clubPostNo" value="${ getClubPost.clubPostNo }"><br>
							<input type="hidden" name="clubNo" value="${ clubNo }"><br>
							<input type="text" name="clubPostTitle" placeholder="제목" value="${ getClubPost.clubPostTitle }"><br>
							<textarea id="summernote" aria-multiline="true" name="clubPostContent">${ getClubPost.clubPostContent }
							</textarea>
							<input type="button" class="plain button red update" value="수정완료">
							<input type="button" class="plain button red cancle" value="이전으로">
						</form>
					</div>
					
				</div><!-- row-content -->
			</div><!-- row -->
		</main><!-- main -->

		<footer role="contentinfo">
			<div class="row">
				<div class="row-content buffer clear-after">
					<section id="top-footer">
						<div class="widget column three">
							<h4>Menu</h4>
							<ul class="plain">
								<li><a href="home-01.html">Home</a></li>
								<li><a href="works-3-columns.html">Portfolio</a></li>
								<li><a href="blog-4-columns-masonry.html">Blog</a></li>
								<li><a href="resume.html">Resume</a></li>
								<li><a href="file:///Users/pasqualevitiello/My%20Folder/Job/Envato/PR%20Themeforest/Flattie/Markup/Beetle/contact.html">Contact</a></li>
							</ul>
						</div>
						<div class="widget column three">
							<h4>Archives</h4>
							<ul class="plain">
								<li><a href="#">March 2014</a></li>
								<li><a href="#">April 2014</a></li>
								<li><a href="#">May 2014</a></li>
								<li><a href="#">June 2014</a></li>
								<li><a href="#">July 2014</a></li>
							</ul>
						</div>								
						<div class="widget column three">
							<h4>Widget</h4>
							<p>Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.</p>
						</div>				
						<div class="widget meta-social column three">
							<h4>Follow Us</h4>
							<ul class="inline">
								<li><a href="#" class="twitter-share border-box"><i class="fa fa-twitter fa-lg"></i></a></li>
								<li><a href="#" class="facebook-share border-box"><i class="fa fa-facebook fa-lg"></i></a></li>
								<li><a href="#" class="pinterest-share border-box"><i class="fa fa-pinterest fa-lg"></i></a></li>
							</ul>
						</div>														
					</section><!-- top-footer -->
					<section id="bottom-footer">
						<p class="keep-left">&copy; 2014 <a href="http://mokaine.com/" alt="Mokaine Lab">Mokaine</a>. All Rights Reserved.</p>
						<p class="keep-right">Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod.</p>
					</section><!-- bottom-footer -->			
				</div><!-- row-content -->	
			</div><!-- row -->	
		</footer>

	</body>

</html>
