<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="description" content="The Page Description">

<title>Feed</title>

<!-- include summernote css/js -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="/resources/summernote/summernote-lite.css" rel="stylesheet">
<script src="/resources/summernote/summernote-lite.js"></script>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<link href="/resources/css/feed/getFeedList.css" rel="stylesheet">

<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">

<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>

<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>



<script type="text/javascript">

	function dateFormat(str) {
		
		alert(str);
		str = str.replace('-', '년');
		str = str.replace('-', '월');
		str = str.replace(' ', '일');
		
		str = str.replace(':', '시');
		str = str.replace(':', '분');
		
		str = str.substring(0, 17);
		
		str = str.replace('년', '년 ');
		str = str.replace('월', '월 ');
		str = str.replace('일', '일 ');
		
		
	    return str;
	}
	
	function formatDate(date) {
	    
	    var d = new Date(date),
	    
	    month = '' + (d.getMonth() + 1) , 
	    day = '' + d.getDate(), 
	    year = d.getFullYear();
	    hour = d.getHours();
	    minute = d.getMinutes();
	    
	    if (month.length < 2) month = '0' + month; 
	    if (day.length < 2) day = '0' + day; 
	    
	    var date = month + "월 " + day + "일 " + hour + "시 " + minute + "분";
	    
	    return date;
	    
	}
	
	function uploadSummernoteImageFile(file, el) {
		data = new FormData();
		data.append("file", file);
		
		console.log(data.file);
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
	
	function updateUploadSummernoteImageFile(file, el) {
		data = new FormData();
		data.append("file", file);
		
		console.log(data.file);
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
	
	function fncAddReport(){
			
			var title = $("textarea[name=title]").val();		
			var content =$("textarea.reportContent").val();			
			var checkbox = $("input:checkbox[name=reportReason]:checked").length;
			
			if(title == null || title.length <1){
	          	Swal.fire({
	                icon: 'error',
	                title: '신고 제목은 필수입니다.',
	            });
					return;
				}
			if(content == null || content.length <1){
				Swal.fire({
	                icon: 'error',
	                title: '신고 내용은 필수입니다.',
	                text: '가능한 상세히 적어주세요.',
	            });
					return;
				}
					
			if(checkbox==0){
				Swal.fire({
	                icon: 'error',
	                title: '신고 사유는 필수입니다.',
	                text: '1개 이상 클릭해주세요.',
	            });
				return;
			}
			
							
		  Swal.fire({
	          title: '정말로 신고하시겠습니까?',
	          text: "다시 되돌릴 수 없습니다. 신중하세요.",
	          icon: 'warning',
	          showCancelButton: true,
	          confirmButtonColor: '#3085d6',
	          cancelButtonColor: '#d33',
	          confirmButtonText: '신고',
	          cancelButtonText: '취소'
	      }).then((result) => {
	          if (result.isConfirmed) {
	        	  
	             AddReport()
	        	 $('#reportModal').modal('hide');
	          }
	      })
	 }
	 
	function AddReport(){	

		var sum = 0;
		var checkbox = $("input:checkbox[name=reportReason]:checked").length;
				
		for(var i =0 ; i<checkbox; i++){
			var sum2 = parseInt($("input:checkbox[name=reportReason]:checked").val());
			sum += sum+parseInt(sum2);			
		}
			
		var no = $("#No").val();
		var clubNo = 0;		
		var clubPostNo = 0;
		
	 	$.ajax({
			url  : "/serviceCenterRest/json/addReport?clubNo="+clubNo+"&clubPostNo="+clubPostNo,
	 		//url  : "/serviceCenterRest/json/addReport?clubNo="+clubNo,
			contentType: 'application/json',
			method : "POST",
			dataType: "json",
			data : JSON.stringify ({
				"title":$("#title").val(),
				"content":$("#content").val(),
			<%--	"file": image, --%>
				"user1":$("#user1").val(),
				"user2":$("#user2").val(),
				"reportSource":$("#reportSource").val(),
				"reportReason": sum,
				"type": $("#type").val(),
				"no" :no,
			}),
			success: function(){
				Swal.fire({
						
					icon: 'success',
					title: 'Your work has been saved',
					showConfirmButton: false,
					timer: 1500
					  
				}) // swal close
			}
			
			
		})<!-- ajax ( ReportAdd) 끝 --> 
		

	} //funtion 끝
	
		
	
	$(function(){
		
	    <%-- 사이드 바 팔로우에서 이미지 클릭시 코드 --%>

		var user_Id = "";
	
		$(document).on("click", ".dl", function(event){
				event.stopPropagation();
			
				user_Id = $(this).parent().parent().attr("id");
				var nickName = $("."+user_Id+"").val();
				var profileImage = $(this).attr("alt");
				
				console.log(user_Id);
				console.log(nickName);
				console.log(profileImage);
				
				if(user_Id == null) {
					user_Id = $(this).parents(".feedHeader").siblings("input[name='user2']").val();
					nickName = $(this).parent().next().text().trim();
				}
				
				//alert(followUser.receiveId.userId);
				$.ajax("/myHomeRest/json/getFollow", {
	
			      type : "POST",
			      data : JSON.stringify({
			         receiveId : user_Id
			      }),
			      dataType : "json",
			      contentType : "application/json",
			      headers : {
			         "Accept" : "application/json"
			      },
			      success : function(Data, status) {
			      if(Data.follow != null){
			         var freceiveId = Data.follow.receiveId.userId;
			         var fnickName = Data.follow.receiveId.nickName;
			         var fprofileImage = Data.follow.receiveId.profileImage;
			         var ffbType = Data.follow.fbType;
			         var ffbState = Data.follow.fbState;
			      }else{
			         var freceiveId = "";
			         var fnickName = "";
			         var fprofileImage = "";
			         var ffbType = "";
			         var ffbState = "";
			      }
			      if(Data.block != null){
			         var breceiveId = Data.block.receiveId.userId;
			         var bnickName = Data.block.receiveId.nickName;
			         var bprofileImage = Data.block.receiveId.profileImage;
			         var bfbType = Data.block.fbType;
			         var bfbState = Data.block.fbState;
			      }else{
			         var breceiveId = "";
			         var bnickName = "";
			         var bprofileImage = "";
			         var bfbType = "";
			         var bfbState = "";
			      }
		         
		         if( freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType.trim() == '2' && bfbState.trim() == '1' ){
		            var value =
		               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='following' class='btn btnSimpleProfileIng btn-sm'>"+
		               "팔로잉</div><div type='button' id='stopBlock' class='btn btnSimpleProfile btn-sm'>차단해제</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
		         }else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType.trim() == '2' && bfbState.trim() == '1'){
		            var value =
		               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='updateFollow' class='btn btnSimpleProfile btn-sm'>"+
		               "팔로우</div><div type='button' id='stopBlock' class='btn btnSimpleProfile btn-sm'>차단해제</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
		         }else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType.trim() == '2' && bfbState.trim() == '2'){
		            var value =
		               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='following' class='btn btnSimpleProfileIng btn-sm'>"+
		               "팔로잉</div><div type='button' id='updateBlock' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
		         }else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType.trim() == '2' && bfbState.trim() == '2'){
		            var value =
		               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='updateFollow' class='btn btnSimpleProfile btn-sm'>"+
		               "팔로우</div><div type='button' id='updateBlock' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
		         }else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType == ""){
		            var value =
		               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='following' class='btn btnSimpleProfileIng btn-sm'>"+
		               "팔로잉</div><div type='button' id='block' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
		         }else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType == "" ){
		            var value =
		               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='updateFollow' class='btn btnSimpleProfile btn-sm'>"+
		               "팔로우</div><div type='button' id='block' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
		         }else if(breceiveId == user_Id && ffbType == ""  && bfbType.trim() == '2' && bfbState.trim() == '1'){
		            var value =
		               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+bprofileImage+"' style='width:100px; height:100px;'><div><h4>"+bnickName+"</h4></div><div><div type='button' id='follow' class='btn btnSimpleProfileIng btn-sm'>"+
		               "팔로우</div><div type='button' id='stopBlock' class='btn btnSimpleProfile btn-sm'>차단해제</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
		         }else if(breceiveId == user_Id && ffbType == ""  && bfbType.trim() == '2' && bfbState.trim() == '2'){
		            var value =
		               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+bprofileImage+"' style='width:100px; height:100px;'><div><h4>"+bnickName+"</h4></div><div><div type='button' id='follow' class='btn btnSimpleProfile btn-sm'>"+
		               "팔로우</div><div type='button' id='updateBlock' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
		         }else if(ffbType == ""  && bfbType == "" ){
		            var value =
		               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+profileImage+"' style='width:100px; height:100px;'><div><h4>"+nickName+"</h4></div><div><div type='button' id='follow' class='btn btnSimpleProfileIng btn-sm'>"+
		               "팔로우</div><div type='button' id='block' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
		         }
		         
		         
		         	$("#"+nickName+"").html(value);
		         	
					$("#"+nickName+"").dialog({
		               
		               autoOpen: false,
		               show: {
		                  effect: "Pulsate",
		                    duration: 1000
		               },
		               hide: {
		                    effect: "Scale",
		                    duration: 1000
		               },
		               position: {
		            	   my: 'left',
		            	   at: 'right',
		            	   of: event
		               }
		               
		            });
		   
		   
		             $("#"+nickName+"").dialog("open");
		             
		      },
		      error : function(){
		         var value =
		            "<div name='dialog'><img src='/resources/image/uploadFiles/"+profileImage+"' style='width:100px; height:100px;'><div><h4>"+nickName+"</h4></div><div><div type='button' id='follow' class='btn btnSimpleProfile btn-sm'>"+
		            "팔로우</div><div type='button' id='block' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
		            
		          $("#"+nickName+"").html(value);
		            
		            
		            $("#"+nickName+"").dialog({
		               
		               autoOpen: false,
		               show: {
		                  effect: "Pulsate",
		                    duration: 1000
		               },
		               hide: {
		                    effect: "Scale",
		                    duration: 1000
		               },
		               position: {
		            	   my: 'left',
		            	   at: 'right',
		            	   of: event
		               }
		               
		            });
		   
		   
		             $("#"+nickName+"").dialog("open");
		             
		      }
		   })
 
		   $(".row").on("click", function(e){
			   $("#"+nickName+"").dialog('close');
			});


		})//end of class="dl" 클릭시
		
		$(document).on("click",".dll",function(event){
		
				user_Id = $(this).parent().parent().attr("id");
			   	var nickName = $("."+user_Id+"").val();
			   	var profileImage = $(this).attr("alt");
			   
			  	console.log(user_Id);
				console.log(nickName);
				console.log(profileImage);
				
				if(user_Id == null) {
					user_Id = $(this).parents(".feedHeader").siblings("input[name='user2']").val();
					nickName = $(this).parent().next().text().trim();
				}
			   
			   $.ajax("/myHomeRest/json/getFollow", {
		
			      type : "POST",
			      data : JSON.stringify({
			         receiveId : user_Id
			      }),
			      dataType : "json",
			      contentType : "application/json",
			      headers : {
			         "Accept" : "application/json"
			      },
			      success : function(Data, status) {
			      if(Data.follow != null){
			         var freceiveId = Data.follow.receiveId.userId;
			         var fnickName = Data.follow.receiveId.nickName;
			         var fprofileImage = Data.follow.receiveId.profileImage;
			         var ffbType = Data.follow.fbType;
			         var ffbState = Data.follow.fbState;
			      }else{
			         var freceiveId = "";
			         var fnickName = "";
			         var fprofileImage = "";
			         var ffbType = "";
			         var ffbState = "";
			      }
			      if(Data.block != null){
			         var breceiveId = Data.block.receiveId.userId;
			            var bnickName = Data.block.receiveId.nickName;
			         var bprofileImage = Data.block.receiveId.profileImage;
			         var bfbType = Data.block.fbType;
			         var bfbState = Data.block.fbState;
			      }else{
			         var breceiveId = "";
			            var bnickName = "";
			         var bprofileImage = "";
			         var bfbType = "";
			         var bfbState = "";
			      }
			      
			         
			         if( freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType.trim() == '2' && bfbState.trim() == '1' ){
			            var value =
			               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='following' class='btn btnSimpleProfile btn-sm'>"+
			               "팔로잉</div><div type='button' id='stopBlock' class='btn btnSimpleProfile btn-sm'>차단해제</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
			         }else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType.trim() == '2' && bfbState.trim() == '1'){
			            var value =
			               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='updateFollow' class='btn btnSimpleProfile btn-sm'>"+
			               "팔로우</div><div type='button' id='stopBlock' class='btn btnSimpleProfile btn-sm'>차단해제</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
			         }else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType.trim() == '2' && bfbState.trim() == '2'){
			            var value =
			               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='following' class='btn btnSimpleProfile btn-sm'>"+
			               "팔로잉</div><div type='button' id='updateBlock' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
			         }else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType.trim() == '2' && bfbState.trim() == '2'){
			            var value =
			               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='updateFollow' class='btn btnSimpleProfile btn-sm'>"+
			               "팔로우</div><div type='button' id='updateBlock' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
			         }else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '1' && bfbType == ""){
			            var value =
			               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='following' class='btn btnSimpleProfile btn-sm'>"+
			               "팔로잉</div><div type='button' id='block' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
			         }else if(freceiveId == user_Id && ffbType.trim() == '1' && ffbState.trim() == '2' && bfbType == "" ){
			            var value =
			               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+fprofileImage+"' style='width:100px; height:100px;'><div><h4>"+fnickName+"</h4></div><div><div type='button' id='updateFollow' class='btn btnSimpleProfile btn-sm'>"+
			               "팔로우</div><div type='button' id='block' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
			         }else if(breceiveId == user_Id && ffbType == ""  && bfbType.trim() == '2' && bfbState.trim() == '1'){
			            var value =
			               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+bprofileImage+"' style='width:100px; height:100px;'><div><h4>"+bnickName+"</h4></div><div><div type='button' id='follow' class='btn btnSimpleProfile btn-sm'>"+
			               "팔로우</div><div type='button' id='stopBlock' class='btn btnSimpleProfile btn-sm'>차단해제</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
			         }else if(breceiveId == user_Id && ffbType == ""  && bfbType.trim() == '2' && bfbState.trim() == '2'){
			            var value =
			               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+bprofileImage+"' style='width:100px; height:100px;'><div><h4>"+bnickName+"</h4></div><div><div type='button' id='follow' class='btn btnSimpleProfile btn-sm'>"+
			               "팔로우</div><div type='button' id='updateBlock' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
			         }else if(ffbType == ""  && bfbType == "" ){
			            var value =
			               "<div name='dialog' id='"+user_Id+"'><img src='/resources/image/uploadFiles/"+profileImage+"' style='width:100px; height:100px;'><div><h4>"+nickName+"</h4></div><div><div type='button' id='follow' class='btn btnSimpleProfile btn-sm'>"+
			               "팔로우</div><div type='button' id='block' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
			         }
			         
			          $("#"+nickName+"1").html(value);
			      
			         
			            $("#"+nickName+"1").dialog({
			               
			               autoOpen: false,
			               show: {
			                  effect: "Pulsate",
			                    duration: 1000
			               },
			               hide: {
			                    effect: "Scale",
			                    duration: 1000
			               },
			               position: {
			            	   my: 'left',
			            	   at: 'right',
			            	   of: event
			               }
			               
			            });
			   
			   
			             $("#"+nickName+"1").dialog("open");
			   
			      },
			      error : function(){
			         var value =
			            "<div name='dialog1'><img src='/resources/image/uploadFiles/"+profileImage+"' style='width:100px; height:100px;'><div><h4>"+nickName+"</h4></div><div><div type='button' id='Follow' class='btn btnSimpleProfile btn-sm'>"+
			            "팔로우</div><div type='button' id='block' class='btn btnSimpleProfile btn-sm'>차단</div><div type='button' class='btn btnSimpleProfile btn-sm'>채팅</div></div></div>";
			            
			          $("#"+nickName+"1").html(value);
			            
			            
			            $("#"+nickName+"1").dialog({
			               
			               autoOpen: false,
			               show: {
			                  effect: "Pulsate",
			                    duration: 1000
			               },
			               hide: {
			                    effect: "Scale",
			                    duration: 1000
			               },
			               position: {
			                  
			                  my:"left",
			                  at:"right",
			                  of:event
			               }
			               
			            });
			   
			   
			             $("#"+nickName+"1").dialog("open");
			      }
			})
			
			 $(".row").on("click", function(e){
				   $("#"+nickName+"1").dialog('close');
				});
		
		});//end of class="dll" 클릭시
			
			
		//다이얼로그 창의 차단버튼과 팔로우 활성화
		
		$(document).on("click","#follow", function() {
			var userId = $(this).parent().parent().attr("id");
			console.log("전달받은 회원 Id : " + userId);
			var changeText = $(this);
			console.log("버튼 :: " + $(changeText));

			$.ajax("/myHomeRest/json/getFollow", {
				type : "POST",
				data : JSON.stringify({
					receiveId : userId,
					fbType : "1"
				}),
				dataType : "json",
				contentType : "application/json",
				headers : {
					"Accept" : "application/json"
				},
				success : function(data, status) {
					console.log(data);
					console.log(data.follow);
				if(data.follow != null ){
					console.log("서버로 받은 데이터 : " + data.follow.userId);
					console.log("서버로 받은 데이터 : " + data.follow.fbState);
					var fbState = "";
					if(data.follow.fbState == 1){
						fbState = "2";
					}else if(data.follow.fbState == 2){
						fbState = "1";
					}
					
					console.log("state 값 : "+fbState);
					$.ajax("/myHomeRest/json/updateFollow", {
						type : "POST",
						data : JSON.stringify({
							receiveId : userId,
							fbType : "1",
							fbState : fbState
						}),
						dataType : "json",
						contentType : "application/json",
						headers : {
							"Accept" : "application/json"
						},
						success : function(update, status) {
							console.log("서버로 받은 데이터(정상) : " + update.follow.userId);
							if(update.follow.fbState == 1){
								$(changeText).text("팔로잉");
								$(changeText).css("background-color", "#5F0080");
					            $(changeText).css("color", "#fff");
								 
									if(sock) {
										   var Msg = "follow," + userId + ",0, 가 나를 팔로우 했습니다."
										   sock.send(Msg);
									}
								}else if(update.follow.fbState == 2){
									$(changeText).text("팔로우");
									$(changeText).css("background-color", "#fff");
									$(changeText).css("color", "#5F0080");
								}
						}
					})
					}else if(data.follow ==null){
						console.log("서버로 받은 데이터(error) : " + data.follow);

						$.ajax("/myHomeRest/json/addFollow", {
							type : "POST",
							data : JSON.stringify({
								receiveId : userId
							}),
							dataType : "json",
							contentType : "application/json",
							headers : {
								"Accetp" : "application/json"
							},
							success : function(Data, status) {
								console.log("서버로부터 받은 Data(error) : " + Data);
								$(changeText).text("팔로잉");
								$(changeText).css("background-color", "#5F0080");
					            $(changeText).css("color", "#fff");
								
								if(sock) {
									   var Msg = "follow," + userId + ",0, 가 나를 팔로우 했습니다."
									   sock.send(Msg);
								}
							}
						})
					} 
				}
				
			})
		})


		 $(document).on("click","#following", function() {
		   var userId = $(this).parent().parent().attr("id");
		   console.log("전달받은 회원 Id : " + userId);
		   var changeText = $(this);
		   console.log("버튼 :: " + $(changeText));
		   
		   $.ajax("/myHomeRest/json/getFollow", {
		      type : "POST",
		      data : JSON.stringify({
		         receiveId : userId,
		         fbType : "1"
		      }),
		      dataType : "json",
		      contentType : "application/json",
		      headers : {
		         "Accept" : "application/json"
		      },
		      success : function(data, status) {
		         console.log(data);
		         console.log("서버로 받은 데이터 : " + data.follow.userId);
		         console.log("서버로 받은 데이터 : " + data.follow.fbState);
		         var fbState = "";
		         if(data.follow.fbState == 1){
		            fbState = "2";
		         }else if(data.follow.fbState == 2){
		            fbState = "1";
		         }
		         
		         console.log("state 값 : "+fbState);
		         $.ajax("/myHomeRest/json/updateFollow", {
		            type : "POST",
		            data : JSON.stringify({
		               receiveId : userId,
		               fbType : "1",
		               fbState : fbState
		            }),
		            dataType : "json",
		            contentType : "application/json",
		            headers : {
		               "Accept" : "application/json"
		            },
		            success : function(update, status) {
		               console.log("서버로 받은 데이터(정상) : " + update.follow.userId);
		               if(update.follow.fbState == 1){
			               $(changeText).text("팔로잉");
			               $(changeText).css("background-color", "#5F0080");
			               $(changeText).css("color", "#fff");
		               if(sock) {
		                     var Msg = "follow," + userId + ",0, 가 나를 팔로우 했습니다."
		                     sock.send(Msg);
		               }
		               }else if(update.follow.fbState == 2){
							$(changeText).text("팔로우");
							$(changeText).css("background-color", "#fff");
							$(changeText).css("color", "#5F0080");
		               }
		            }
		         })
		      }
		   })
		}) 

		 $(document).on("click","#updateFollow", function() {
		   var userId = $(this).parent().parent().attr("id");
		   console.log("전달받은 회원 Id : " + userId);
		   var changeText = $(this);
		   
		   $.ajax("/myHomeRest/json/getFollow", {
		      type : "POST",
		      data : JSON.stringify({
		         receiveId : userId,
		         fbType : "1"
		      }),
		      dataType : "json",
		      contentType : "application/json",
		      headers : {
		         "Accept" : "application/json"
		      },
		      success : function(data, status) {
		         console.log("서버로 받은 데이터 : " + data.follow.userId);
		         console.log("서버로 받은 데이터 : " + data.follow.fbState);
		         var fbState = "";
		         if(data.follow.fbState == 1){
		            fbState = "2";
		         }else if(data.follow.fbState == 2){
		            fbState = "1";
		         }
		         
		         console.log("state 값 : "+fbState);
		         $.ajax("/myHomeRest/json/updateFollow", {
		            type : "POST",
		            data : JSON.stringify({
		               receiveId : userId,
		               fbType : "1",
		               fbState : fbState
		            }),
		            dataType : "json",
		            contentType : "application/json",
		            headers : {
		               "Accept" : "application/json"
		            },
		            success : function(update, status) {
		               console.log("서버로 받은 데이터(정상) : " + update.follow.userId);
		               if(update.follow.fbState == 1){
							$(changeText).text("팔로잉");
							$(changeText).css("background-color", "#5F0080");
							$(changeText).css("color", "#fff");
		               if(sock) {
		                     var Msg = "follow," + userId + ",0, 가 나를 팔로우 했습니다."
		                     sock.send(Msg);
		               }
		               }else if(update.follow.fbState == 2){
							$(changeText).text("팔로우");
							$(changeText).css("background-color", "#fff");
							$(changeText).css("color", "#5F0080");
		               }
		            }
		         })
		      }
		   })
		})


		$(document).on("click","#block", function() {
		   var userId = $(this).parent().parent().attr("id");
		   console.log("전달받은 회원 Id : " + userId);
		   var changeText = $(this);
		   
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
		         console.log(data.block);
		         if(data.block != null ){
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
		                  $(changeText).text("차단해제");
		               }else if(update.block.fbState == 2){
		                  $(changeText).text("차단");
		               }
		            }
		         })
		         }else if(data.block ==null){
		            console.log("서버로 받은 데이터(error) : " + data.block);
		
		            $.ajax("/userRest/json/addBlock", {
		               type : "POST",
		               data : JSON.stringify({
		                  receiveId : userId
		               }),
		               dataType : "json",
		               contentType : "application/json",
		               headers : {
		                  "Accetp" : "application/json"
		               },
		               success : function(Data, status) {
		                  console.log("서버로부터 받은 Data(error) : " + Data);
		                  $(changeText).text("차단해제");
		               }
		            })
		         }
		      }
		      
		   })
		})

		$(document).on("click","#stopBlock", function() {
		   var userId = $(this).parent().parent().attr("id");
		   console.log("전달받은 회원 Id : " + userId);
		   var changeText = $(this);
		   
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
		               $(changeText).text("차단해제");
		               }else if(update.block.fbState == 2){
		               $(changeText).text("차단");
		               }
		            }
		         })
		      }
		   })
		})

		$(document).on("click","#updateBlock", function() {
		   var userId = $(this).parent().parent().attr("id");
		   console.log("전달받은 회원 Id : " + userId);
		   var changeText = $(this);
		
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
		               $(changeText).text("차단해제");
		               }else if(update.block.fbState == 2){
		               $(changeText).text("차단");
		               }
		            }
		         })
		      }
		   })
		})

	      
	      
	    <%-- 1:1 채팅 --%>
		$(document).on("click",".btnSimpleProfile:contains('채팅')", function() {
			console.log("1:1채팅");
			$("#chat-icon").attr("style", "display:none");
			// 채팅창 보인다
			$("#allChat").attr("style", "position: fixed; bottom: 0; right: 0; margin-right: 50px; margin-bottom: 50px; border-radius: 40px; padding: 10px; padding-top: 20px; width: 350px; height: 700px; box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;");

			// 1:1채팅 보이고 모임채팅 숨긴다
			$("#user-chat-list").removeAttr("style");
			$("#club-chat-list").attr("style", "display: none");
			// 1:1채팅 이미지 테두리 이벤트, 모임채팅 이미지 테두리 이벤트 없애기
			$(this).attr("style", "box-shadow: rgba(102, 051, 102, 0.3) 0px 9px 38px, rgba(95, 0, 128, 0.3) 0px 5px 12px;");
			$(".chat-img-sidebar.people-users").removeAttr("style");
			
			//alert( "1:1 채팅하고하는 상대방 아이디 : " + user_Id );
			var make_roomId = "";
			

			socket.disconnect();
			$('#chatLog').empty();
			
			$("#allChat-toobar-title").attr("style", "display: none");
			$("#allChat-toobar-back").removeAttr("style");
			
			$("#chat-list-content").attr("style", "display: none");
			$("#chat-room-content").removeAttr("style");
			
			// ajax로 roomId 만들어서 DB에 넣고
			$.ajax( "/clubPostRest/json/addChat",
					{
						method : "POST",
						data : JSON.stringify({
							userId2 : user_Id
						}),
						headers : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						},
						dataType : "json",
						success : function(JSONData, status){
							//alert(status);
							
							var user_chat_list = "";
							$("#user-chat-list").empty();
							
							for (var i = 0; i < JSONData.length; i++) {
								//alert(JSONData[i].roomId);
								//alert(JSONData[i].user2.nickName);
								//alert(JSONData[i].user2.profileImage);
								//alert(JSONData[i].currentRoomId);
								
								make_roomId = JSONData[i].currentRoomId;
									// 넣은 roomId까지 가져와서 1:1채팅 리스트 돌리고
									user_chat_list = "<div class='chat-content chat-content-onechat' roomId='"+JSONData[i].roomId+"' namespace='userchat'>"
															+"<div>"
																+"<img class='chat-img-main' src='/resources/image/uploadFiles/"+JSONData[i].user2.profileImage+"'>"
															+"</div>"
															+"<div>"+JSONData[i].user2.nickName+"</div>"
														+"</div>";
									
									$("#user-chat-list").append( user_chat_list );
								}
								
								//alert( make_roomId );
								console.log(socket)
								
								// 만든 roomId = '${ sessionScope.user.userId }'+user_Id로 채팅방 접속한다
								//소켓서버에 접속시킨다.
								socket = io("http://192.168.0.74:3000/userchat", { // clubchat 네임스페이스
									cors: { origin: "*" },
									path: '/socket.io',
									query: {
										userId : $("#session_userId").val(),
										profileImage : $("#session_profileImage").val(),
										nickName : $("#session_nickName").val(),
										roomId : make_roomId
									},
									forceNew: true,
									autoConnect:false
								});
								console.log(socket);
								
								setChat();
								
								socket.connect();
								
							}//end of success	
							
					});// end of ajax
						
			});//end of 프로필사진의 채팅 클릭시 1:1 채팅
		
		
		<%-- 사이드 바 팔로우에서 이미지 클릭시 반장님 코드 --%>
		
		
	
		<%-- 피드 폼에서 아이디에 호버시 --%>
		
		$(document).on("click", ".feedProfileImage", function(event) {
			
			if('${sessionScope.user}' == null) {
				return false;
			}
			
			$.ajax (
						{
							url : "/userRest/json/getUser",
							method : "POST",
							data : JSON.stringify ({
								nickName : $(this).parents(".feedCover").siblings(".feedName").text().trim()
							}),
							contentType: 'application/json',
							dataType : "json",
							header : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							}, // header end
							
							success : function(data, status) {
								
								if(data.userId == '${sessionScope.user.userId}'){
									location.href = "/myHome/getMyHome?userId=" + data.userId;
								} else {
									location.href = "/myHome/getYourHome?userId=" + data.userId;
								}
								
							}
						}
					
					)
			
		}) 
		
		$(document).on("click", ".feedName", function(event) {
			
			if('${sessionScope.user}' == null) {
				return false;
			}
			
			$.ajax (
						{
							url : "/userRest/json/getUser",
							method : "POST",
							data : JSON.stringify ({
								nickName : $(this).text().trim()
							}),
							contentType: 'application/json',
							dataType : "json",
							header : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							}, // header end
							
							success : function(data, status) {
								
								if(data.userId == '${sessionScope.user.userId}'){
									location.href = "/myHome/getMyHome?userId=" + data.userId;
								} else {
									location.href = "/myHome/getYourHome?userId=" + data.userId;
								}
								
							}
						}
					
					)
			
		})
		
		<%-- 피드 폼에서 아이디에 호버시 --%>
		
		<%-- 작성자 아이디에 호버시 --%>
		
		$(document).on("click", ".sessionProfileImage", function(event) {
			
			if('${sessionScope.user}' == null) {
				return false;
			}
			
			$.ajax (
						{
							url : "/userRest/json/getUser",
							method : "POST",
							data : JSON.stringify ({
								nickName : $(this).parents(".addFormImage").siblings(".addFormName").text().trim()
							}),
							contentType: 'application/json',
							dataType : "json",
							header : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							}, // header end
							
							success : function(data, status) {
								
								if(data.userId == '${sessionScope.user.userId}'){
									location.href = "/myHome/getMyHome?userId=" + data.userId;
								} else {
									location.href = "/myHome/getYourHome?userId=" + data.userId;
								}
								
							}
						}
					
					)
			
		})
		
		$(document).on("click", ".addFormName", function(event) {
			
			if('${sessionScope.user}' == null) {
				return false;
			}
			
			$.ajax (
						{
							url : "/userRest/json/getUser",
							method : "POST",
							data : JSON.stringify ({
								nickName : $(this).text().trim()
							}),
							contentType: 'application/json',
							dataType : "json",
							header : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							}, // header end
							
							success : function(data, status) {
								
								if(data.userId == '${sessionScope.user.userId}'){
									location.href = "/myHome/getMyHome?userId=" + data.userId;
								} else {
									location.href = "/myHome/getYourHome?userId=" + data.userId;
								}
								
							}
						}
					
					)
			
		})
		
		<%-- 작성자 아이디에 호버시 --%>
		
		<%-- 알람 모달창 MODAL --%>
		
		$(document).on("click", ".alarmImg", function(event) {
			var sessionUser = '${sessionScope.user.userId}';

			$.ajax(
					{
						url : "/serviceCenterRest/json/getPushList",
						method : "POST",
						data : JSON.stringify ({
							userId : sessionUser
						}),
						contentType: 'application/json',
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, // header end
						
						success : function(data, status) {
							
							var alarm = data.alarm;
							var alarmCount = data.alarmCount;
							var addHtml = "";
							
							$("#myModalAlarmLabel").html("알림 개수 : " + alarmCount);
							console.log(data)
							$.each(alarm, function(index, item){
								
								if(item.feed != null) {
									addHtml += 	"<div style='display: flex; justify-content: space-between;'>" + 
										"<div>알림 내용</div>" + 
										"<div><a href='/feed/getFeed?feedNo=" + item.feed.feedNo + "' />" + item.content + "</a></div>" + 
									"</div>"
								} else if(item.clubPost != null) {
									addHtml += 	"<div style='display: flex; justify-content: space-between;'>" + 
										"<div>알림 내용</div>" + 
										"<div><a href='/clubPost/getClubPost?clubPostNo=" + item.clubPost.clubPostNo + "' />" + item.content + "</a></div>" + 
									"</div>"
								} 
								
								
							}) // each close
							
							$(".alarmModalBody").html(addHtml);
							
						}
					}	
					
			) // ajax close
			
		})
		
		<%-- 알람 모달창 MODAL --%>
		
		
		
		<%-- 댓글 모달창 MODAL --%>
		
		$(document).on("click", ".comment", function(event) {
			event.stopPropagation();
			
			if('${sessionScope.user}' == null || '${sessionScope.user}' == "") {
				
				Swal.fire({
					title: '로그인 후 이용해주세요' ,
					showCancelButton: false,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '확인', 
				})
				
				return false;
			} 
				
			var feedNo = $(this).parents(".lastBar").siblings("input[name='feedNo']").val();
			
			$("#commentModalFeedNo").val(feedNo);
			$("#commentModal").modal();
			
		});
		
		$(document).on("click", ".addCommentByModal", function(event) {
			event.stopPropagation();
			
			if('${sessionScope.user}' == null || '${sessionScope.user}' == "") {
				Swal.fire({
					title: '로그인 후 이용해주세요' ,
					showCancelButton: false,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '확인', 
				})
				
				return false;
			} 
			
			var sessionUser = '${sessionScope.user.userId}';
			var content = $("#contentModal").val();
			var feedNumber = $("#commentModalFeedNo").val();
			
			$.ajax (
						{
							url : "/feedRest/json/addFeedComment",
							method : "POST",
							data : JSON.stringify ({
								userId : sessionUser,
								commentContent : content,
								feedNo : feedNumber
							}),
							contentType: 'application/json',
							dataType : "json",
							header : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							}, // header end
							
							success : function(data, status) {
								
								Swal.fire({
									
									  icon: 'success',
									  title: 'Your work has been saved',
									  showConfirmButton: false,
									  timer: 1500
									  
								}) // swal close
								
								setTimeout(function() {
									self.location = "/feed/getFeed?feedNo=" + feedNumber;
								}, 3000);
								
							
							} // success close
							
						} // ajax inner close
			
			) // ajax close
		})
		
		
		<%-- 댓글 모달창 MODAL --%>
		
		
				
		<%-- SEARCH BY HASHTAG --%>
		
		$(document).on("click", ".searchByHashtag", function(event){
			event.stopPropagation();
			
			var searchKeyword = $(this).text().trim();
			$("#searchKeyword").val(searchKeyword);
			
			console.log($("#searchKeyword").val());
			$("#searchForm").attr("method", "POST").attr("action","/feed/getFeedList").submit();
		})
		
		
		<%-- 무한 스크롤 --%>
		
		$(window).scroll(function(event) {
			console.log(($("#pageFlag").val()));
			
			if($("#pageFlag").val() == "true") {
			
				if((Math.ceil($(window).scrollTop() + $(window).height())) >= ( $(document).height() )) {
					
					console.log("무한 스크롤");
					
					var maxHeight = $(document).height();
					var currentScroll = Math.ceil($(window).scrollTop() + $(window).height());
					
					var sessionUser = $("#userId").val();
					
					console.log("서치키워드 : " + $("#searchKeyword").val());
					
					$.ajax(
							{
								url : "/feedRest/json/getFeedList",
								method : "POST",
								data : JSON.stringify ({
									userId : sessionUser,
									currentPage : parseInt($("#currentPage").val()) + 1,
									searchKeyword : $("#searchKeyword").val()
								}),
								contentType: 'application/json',
								dataType : "json",
								header : {
									"Accept" : "application/json",
									"Content-Type" : "application/json"
								}, // header end
								
								success : function(data, status) {
									

									var addHtml = "";
									
									$.each(data, function(index, item) {
										

										console.log("무한 스크롤 정보 성공" + item.content + "\n");
										
										addHtml +=
										'<div class="showFeedForm">' +
										'<form class="feedForm">' +
										'<div class="feedHeader">' +
										'<div class="feedLeft">' + 
										'<div class="feedInner">' + 
										'<div class="feedCover">' +
										'<img class="feedProfileImage dl" src="/resources/image/uploadFiles/' + item.user.profileImage + '" alt="' + item.user.profileImage + '">' + 
										'<div class="' + item.user.nickName + '"></div>' +
										'</div>' +
										'<div class="feedName">' +
										item.user.nickName +
										'</div>' +
										'</div>' + 
										'<div class="feedDate">'
										
										if(item.updateDate != null) {
											addHtml += formatDate(item.updateDate) + '</div></div>';
										} else {
											addHtml += formatDate(item.regDate) + '</div></div>';
										}
										
										if(sessionUser == item.user.userId) {
											addHtml += '<div class="udIcon">' +
														'<span class="glyphicon glyphicon-trash btn_delete" aria-hidden="true" ></span>' +
														'<span class="glyphicon glyphicon-paperclip btn_update" aria-hidden="true"></span>' +
														'</div>'
										}
										
										addHtml += '</div>';
										
										if(item.content != null) {
											addHtml += '<div class="feedContent">' + 
														'<div class="feedLetter">' + 
														item.content +
														'</div>'
										}
										
										if(item.video != null) {
											addHtml += '<div class="feedVideo">' +
														'<iframe width="560" height="315" src="http://' + item.video + '"></iframe>' +
														'</div>'
										}
										
										
										if(item.image1 != null) {
											addHtml += '<div class="feedImage">' +
													'<div id="carousel-example-generic' + index + 1 + (parseInt($("#currentPage").val()) * 10) + '" class="carousel slide" data-ride="carousel">' +
													'<ol class="carousel-indicators">' +
														'<li data-target="#carousel-example-generic' + index + 1 + (parseInt($("#currentPage").val()) * 10) + '" data-slide-to="0" class="active"></li>'
														
											if(item.image2 != null) {
												addHtml += '<li data-target="#carousel-example-generic' + index + 1 + (parseInt($("#currentPage").val()) * 10) + '" data-slide-to="1"></li>';
											}
														
											if(item.image3 != null) {
												addHtml += '<li data-target="#carousel-example-generic' + index + 1 + (parseInt($("#currentPage").val()) * 10) + '" data-slide-to="2"></li>';
											}
											
											if(item.image4 != null) {
												addHtml += '<li data-target="#carousel-example-generic' + index + 1 + (parseInt($("#currentPage").val()) * 10) + '" data-slide-to="3"></li>';
											}		
														
											addHtml += '</ol>' +
												'<div class="carousel-inner" role="listbox">' +
												'<div class="item active">' +
												'<img src="/resources/image/uploadFiles/' + item.image1 + '" alt="' + item.image1 + '">' +
												'</div>'
												
											if(item.image2 != null) {
												addHtml += '<div class="item">' +
															'<img src="/resources/image/uploadFiles/' + item.image2 + '" alt="' + item.image2 + '">' +
															'</div>'
											}
														
											if(item.image3 != null) {
												addHtml += '<div class="item">' +
															'<img src="/resources/image/uploadFiles/' + item.image3 + '" alt="' + item.image3 + '">' +
															'</div>'
											}
											
											if(item.image4 != null) {
												addHtml += '<div class="item">' +
															'<img src="/resources/image/uploadFiles/' + item.image4 + '" alt="' + item.image4 + '">' +
															'</div>'
											}
																
											addHtml += '</div>' +
														'<a class="left carousel-control carousel_prev" href="#carousel-example-generic' + index + 1 + (parseInt($("#currentPage").val()) * 10) + '" role="button" data-slide="prev">' +
														'	<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>' +
														'	<span class="sr-only">Previous</span>' +
														'</a>' +
														'<a class="right carousel-control carousel_next" href="#carousel-example-generic' + index + 1 + (parseInt($("#currentPage").val()) * 10) + '" role="button" data-slide="next">' +
														'	<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>' +
														'	<span class="sr-only">Next</span>' +
														'</a>' +
													'</div></div>'
										}
											
										addHtml += '</div>';
										
										if(item.hashtag != null) {
											addHtml += '<div class="hashtagContent">' +
													item.hashtag +
													'</div>'
										}
											
										addHtml += '<input type="hidden" name="reportSource" value="3">' +
											'<input type="hidden" name="sourceNumber" value="' + item.feedNo + '">' +
											'<input type="hidden" name="user2" value="' + item.user.userId + '">' +
											'<input type="hidden" name="source" value="0">' +
											'<input type="hidden" name="feedNo" value="' + item.feedNo + '"> ' +
											'<input type="hidden" id="userId" name="userId" value="' + sessionUser + '">' +
											'<input type="hidden" name="openCondition" value="3">' +
											'<section class="row section lastBar">' +
											'	<div class="row">' +
											'		<div class="col-xs-2"></div>'
										
										if(item.checkHeart == 0) {
											addHtml += '<div class="col-xs-2">' +
															'<img class="feedLike" src="/resources/image/uploadFiles/no_heart.jpg" aria-hidden="true"/>' +
														'</div>'
										} else {
											addHtml += '<div class="col-xs-2">' +
															'<img class="feedDislike" src="/resources/image/uploadFiles/heart.jpg" aria-hidden="true"/>' +
														'</div>'
										}
											
										addHtml += '<div class="col-xs-1 likeCount">' +
														item.heartCount +
													'</div>' +
													'<div class="col-xs-2 comment">' +
													'	<img src="/resources/image/uploadFiles/comment2.jpg" aria-hidden="true"/>' +
													'</div>' +
													'<div class="col-xs-1 commentCount">' +
														item.commentCount +
													'</div>' +
													'<div class="col-xs-2 report">' +
													'	<img src="/resources/image/uploadFiles/report.jpg" aria-hidden="true"/>' +
													'</div>' +
													'<div class="col-xs-2"></div>' +
													'</div>' +
												'</section>' +
											'</form>' +
										'</div>'
										
									}) // each close
									
									console.log(addHtml);
									$(addHtml).appendTo($("div.six:last"));
									$("#currentPage").val( parseInt($("#currentPage").val()) + 1 );
									
									if(addHtml == "") {
										$("#pageFlag").val(false);
										
									}
									
								} // success close
								
							} // ajax inner close
							
					) // ajax close
					
				} // scroll if close
			
			} else { // 여기에 스크롤 이벤트 종료
				event.preventDefault();
			}// pageFlag close;
		
		}); // window scroll event close
		
		<%-- 무한 스크롤 --%>
		
		
		
		<%-- SUMMER NOTE WEB LOADING --%>
		$('#summernote').summernote({
			toolbar: [
                // [groupName, [list of button]]
                ['Insert', ['picture', 'video']],
            ],
            
            disableResizeEditor: true,
			height: 200,                 	// 에디터 높이
			minHeight: null,             	// 최소 높이
			maxHeight: null,             	// 최대 높이
			focus: true,                 	// 에디터 로딩후 포커스를 맞출지 여부
			placeholder: '오늘 하루는 어떤가요?',			
			
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
		
		<%-- SUMMER NOTE WEB LOADING --%>
		$('#summernoteUpdate').summernote({
			toolbar: [
                // [groupName, [list of button]]
                ['Insert', ['picture', 'video']],
            ],
            
            disableResizeEditor: true,
			height: 200,                 	// 에디터 높이
			minHeight: null,             	// 최소 높이
			maxHeight: null,             	// 최대 높이
			focus: true,                 	// 에디터 로딩후 포커스를 맞출지 여부
			
			callbacks : { 
            	onImageUpload : function(files, editor, welEditable) {
           			// 파일 업로드(다중업로드를 위해 반복문 사용)
					for (var i = files.length - 1; i >= 0; i--) {
						updateUploadSummernoteImageFile(files[i],
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
			
			if($(event.target).hasClass("comment") || $(event.target).hasClass("commentImg")) {
				
				return false;
			}
			
			location.href="/feed/getFeed?feedNo=" + feedNumber;
		})
		<%-- GET_FEED --%>
		
		<%-- ADD_FEED --%>
		$(document).on("click", ".addFeed", function(event){
			event.stopPropagation();
			
			console.log($(".addBody .note-editable").html());
			console.log($(".addBody .note-editable").html().split("<img").length-1);
			console.log($(".addBody .note-editable").html().split("<iframe").length-1);
			
			var imgCount = $(".addBody .note-editable").html().split("<img").length-1;
			var videoCount = $(".addBody .note-editable").html().split("<iframe").length-1;
			
			
			if($(".addBody .note-editable").html() == "<p><br></p>") {
				Swal.fire({
					  title: '내용을 입력하세요',
					  width: 400,
					  icon: 'warning',
					  timer : 1000,
					  showConfirmButton : false,
				})
			} else if(imgCount > 4 || videoCount > 1) {
				Swal.fire({
					  title: '이미지는 4개, 동영상은 1개 까지 가능합니다.',
					  width: 400,
					  icon: 'warning',
					  timer : 1000,
					  showConfirmButton : false,
				})
			} else {
				$(this.form).attr("method", "POST").attr("action", "/feed/addFeed").attr("enctype", "multipart/form-data").submit();
				
				$.ajax (
						{
							url : "/feedRest/json/getFeedLastNo",
							method : "POST",
							data : JSON.stringify ({
							}),
							contentType: 'application/json',
							dataType : "json",
							header : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							}, // header end
							
							success : function(data, status) {
								
								if(sock) {
									var Msg = "feed,follower," + parseInt(data + 1) + ",피드를 작성했습니다.";
									// alert(Msg);
									sock.send(Msg);
								}
							}
						}		
				)
				
			}
		});
		<%-- ADD_FEED --%>
		
		<%-- UPDATE_FEED --%>
		$(document).on("click", ".btn_update", function(event){
			event.stopPropagation();
			
			$(".updateCover").html($(this).parents(".udIcon").siblings(".feedLeft").find(".feedCover").html().trim())
			$(".updateFormName").html($(this).parents(".udIcon").siblings(".feedLeft").find(".feedName").html().trim())
			$(".updateFeedDate").html($(this).parents(".udIcon").siblings(".feedLeft").find(".feedDate").html().trim())
			$("#updateFeedForm").find("input[name='feedNo']").val($(this).parents(".feedHeader").siblings("input[name='feedNo']").val());
			$("#summernoteUpdate").next().find(".note-editable").html($(this).parents(".feedHeader").siblings("input[name='forUpdateFullContent']").val())
			
			$('#updateModal').modal();
		});
		
		$(document).on("click", ".btn_updateFeed", function(event) {
			console.log("수정하기");
			
			console.log($(".updateModalHeader").parent().find(".note-editable").html());
			console.log($(".updateModalHeader").parent().find(".note-editable").html().split("<img").length-1);
			console.log($(".updateModalHeader").parent().find(".note-editable").html().split("<iframe").length-1);
			
			var imgCount = $(".updateModalHeader").parent().find(".note-editable").html().split("<img").length-1;
			var videoCount = $(".updateModalHeader").parent().find(".note-editable").html().split("<iframe").length-1;
			
			if($(".updateModalHeader").parent().find(".note-editable").html() == "<p><br></p>") {
				Swal.fire({
					  title: '내용을 입력하세요',
					  width: 400,
					  icon: 'warning',
					  timer : 1000,
					  showConfirmButton : false,
				})
			} else if(imgCount > 4 || videoCount > 1) {
				Swal.fire({
					  title: '이미지는 4개, 동영상은 1개 까지 가능합니다.',
					  width: 400,
					  icon: 'warning',
					  timer : 1000,
					  showConfirmButton : false,
				})
			} else {
				$("#updateFeedForm").attr("method", "POST").attr("action", "/feed/updateFeed").submit();
			}
			
		})
		<%-- UPDATE_FEED --%>
		
		<%-- DELETE_FEED --%>
		$(document).on("click", ".btn_delete", function(event){
			event.stopPropagation();
			console.log("피드 삭제 버튼");
			console.log( $(this).parent().parents(".feedForm").html());
			
			Swal.fire({
				  title: '글을 삭제하시겠습니까?',
				  text: "삭제하시면 다시 복구시킬 수 없습니다.",
				  width: 500,
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
					
					if(sock) {
						var Msg = "가 피드를 삭제했습니다.";
						
						sock.send(Msg);
					}
				}
			})
		});
		<%-- DELETE_FEED --%>
		
		<%-- ADD_FEED_HEART --%>
		$(document).on("click", ".feedLike", function(event){
			event.stopPropagation();
			
			if('${sessionScope.user}' == null || '${sessionScope.user}' == "") {
				
				Swal.fire({
					title: '로그인 후 이용해주세요' ,
					showCancelButton: false,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '확인', 
				})
				
				return false;
			} 
			
			console.log($(this).parents(".feedForm").children("input[name='feedNo']").val() + "번 글 좋아요");
			console.log("작성자 :: " + $(this).parents(".feedForm").children("input[name='user2']").val());
			var html = $(this);
			var sessionUser = $(this).parents(".feedForm").children("input[name='userId']").val();
			var feedNo = $(this).parents(".feedForm").children("input[name='feedNo']").val();
			var content = $(this).parents(".feedForm").children(".feedContent").text().trim();
			var writer = $(this).parents(".feedForm").children("input[name='user2']").val();
			
			$.ajax(
					{
						url : "/feedRest/json/addFeedHeart",
						method : "POST",
						data : JSON.stringify ({
							source : 0,
							sourceNo : feedNo,
							userId : sessionUser
						}),
						contentType: 'application/json',
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, // header end
						
						success : function(data, status) {
							
							$(html).parents(".row").children(".likeCount").text(data);
							$(html).parent().html('<img class="feedDislike" src="/resources/image/uploadFiles/heart.jpg" />');
							
							if(sock) {
								var Msg = "feed," + writer + "," + feedNo + ",이 좋아요를 눌렀습니다."
								sock.send(Msg);
							}
							
						} // success close
						
					} // ajax inner close
					
			) // ajax close
		})
		<%-- ADD_FEED_HEART --%>
		
		<%-- DELETE_FEED_HEART --%>
		$(document).on("click", ".feedDislike", function(event){
			event.stopPropagation();
			console.log($(this).parents(".feedForm").children("input[name='feedNo']").val() + "번 글 시러요");
			
			var html = $(this);
			var sessionUser = $(this).parents(".feedForm").children("input[name='userId']").val();
			var feedNo = $(this).parents(".feedForm").children("input[name='feedNo']").val();
			var content = $(this).parents(".feedForm").children(".feedContent").text().trim();
			
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
							
							console.log("피드 시러요 성공 : " + data);
							
							$(html).parents(".row").children(".likeCount").text(data);
							$(html).parent().html('<img class="feedLike" src="/resources/image/uploadFiles/no_heart.jpg" />');
							
							if(sock) {
								var Msg = "feed,follower," + feedNo + ", 좋아요를 취소했습니다."

								sock.send(Msg);
							}
							
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
		
		<%-- CALL REPORT 모달 --%>
		$(document).on("click", ".report", function(event) {
			event.stopPropagation();
			
			var sessionUser = '${sessionScope.user}';
			
			if(sessionUser == "" || sessionUser == null) {
				Swal.fire({
					title: '로그인 후 이용해주세요' ,
					showCancelButton: false,
					confirmButtonColor: '#3085d6',
					cancelButtonColor: '#d33',
					confirmButtonText: '확인', 
				})
			} else {
			
				// $(this).parent().parents(".feedForm").attr("method", "POST").attr("action", "/serviceCenter/addReport").submit();
				// $(".modal-content").load("/loginModal");
				var reportedUser = $(this).parents(".lastBar").siblings("input[name='user2']").val();
				var feedNo = $(this).parents(".lastBar").siblings("input[name='feedNo']").val();
				
				// $('#reportModal .modal-content').load("/serviceCenter/addReport?reportSource=3&user2=" + reportedUser + "&sourceNumber=" + feedNo);
				
				$("#user2").val(reportedUser);
				$("#No").val(feedNo);
				
				$('#reportModal').modal();
			}
			//	window.open('/serviceCenter/addReportView.jsp',  '_blank', 'width=200,height=200,resizeable,scrollbars');
		})	// .report evenet close
		
		
		$(document).on("click", ".addReportByModal", function(event) {
			event.stopPropagation();
			
			fncAddReport();
		})
		
		<%-- CALL REPORT 모달 --%>
		

	
	
	<%-- 추천 모임 보이기 --%>
	
	$(window).on("load", function() {
		
		$.ajax(
				{
					url : "/clubRest/json/getClubList",
					method : "POST",
					data : JSON.stringify ({
						currentPage: 1
					}),
					contentType: 'application/json',
					dataType : "json",
					header : {
						"Accept" : "application/json",
						"Content-Type" : "application/json"
					}, // header end
					
					success : function(data, status) {
						
						var addHtml = "";
						var addImg = "";
						var count = 0;
						
						$.each(data.clubList, function(index, item){

							if(item.clubImage != null) {
								
								if(index > 4) {
									
									return false;
									
								} else if(index == 0 ){
									addHtml += '<li data-target="#carousel-club" data-slide-to="' + index + '" ></li>';
									addImg += 	'<div class="item active">' +
													'<a href="/club/getClub?clubNo=' + item.clubNo + '" >' +
														'<img src="/resources/image/uploadFiles/' + item.clubImage + '" alt="">' +
													'</a>' +
													'<div class="carousel-caption">' +
													'</div>' +
											    '</div>'
								} else {
									addHtml += '<li data-target="#carousel-club" data-slide-to="' + index + '" class="active"></li>';
									addImg += 	'<div class="item">' +
													'<a href="/club/getClub?clubNo=' + item.clubNo + '" >' +
														'<img src="/resources/image/uploadFiles/' + item.clubImage + '" alt="">' +
													'</a>' +
													'<div class="carousel-caption">' +
													'</div>' +
											    '</div>'
								}
							}
							
						}) // each close
						
						// $(".carousel-club-indicators").html(addHtml);
						$(".carousel-club-inner").html(addImg);
						
					} // success close
					
				}) // ajax inner close

		$(".tab_item-following").on("click" , function(e) {
			var userId = '${sessionScope.user.userId}';
			console.log(userId);
			$(".tab_item-following").off(e);
		$.ajax({
			url : "/myHomeRest/json/getFollowerList", // 어디로 갈거니? // 갈 때 데이터
			type : "POST", // 타입은 뭘 쓸거니?
			datatype : "json",
			 data		:  JSON.stringify({
				searchKeyword : userId

				
			 }),
			 
			contentType : "application/json",
			success : function(data) { 
	       console.log(data.followerList[1]);
	       $.each(data.followerList, function(index, item) { // 데이터 =item
	    	   console.log(item);
				var value = 
					"<div class='following-section' id='"+item.userId+"'>"+
				"<div style='display: inline-block;'>"+"<img class='dll' src='/resources/image/uploadFiles/"+item.profileImage+"' width='60' height='60' alt='" + item.profileImage + "'/>"+"</div><div>"+
				"<h4 class='yourHome2'>"+item.nickName+"</h4></div>"+
				"<div id='" + item.nickName + "1' name='dialog' style='display:none !important;'></div>" +
				"<input type='hidden' class='" + item.userId + "' value='" + item.nickName + "'>" +
			"</div>";
				
				
				 $("#fl").append(value);     
				
				 $(".yourHome2").on("click" , function() {
						
						self.location = "/myHome/getYourHome?userId="+$(this).parent().parent().attr("id");
					});
					
				
				})
				
				}	
			});
		});
		window.onload=function() {
				
			console.log(userId);
				
			$.ajax({
				url : "/myHomeRest/json/getFollowList", // 어디로 갈거니? // 갈 때 데이터
				type : "POST", // 타입은 뭘 쓸거니?
				datatype : "json",
				 data		:  JSON.stringify({
				 
					
				 }),
				 
				contentType : "application/json",
				success : function(data) { 

					$.each(data.list, function(index, item) { // 데이터 =item
		    	   	console.log(item);
					var value = 
						"<div class='follow-section' id='"+item.receiveId.userId+"'>"+
					"<div style='display: inline-block;'>"+"<img class='dl' src='/resources/image/uploadFiles/"+item.profileImage+"' width='60' height='60' alt='" + item.profileImage + "'/>"+"</div><div>"+
					"<h4 class='yourHome'>"+item.nickName+"</h4></div>"+
					"<div id='" + item.nickName + "' name='dialog' style='display:none !important;'></div>" +
					"<input type='hidden' class='" + item.receiveId.userId + "' value='" + item.nickName + "'>" +
				"</div>";
					
					
					 $("#fll").append(value);     
					
					 $(".yourHome").on("click" , function() {
							
							self.location = "/myHome/getYourHome?userId="+$(this).parent().parent().attr("id");
						});
						
					
				})
				
				}	
			});
			
			$.ajax(
					{
						url : "/clubRest/json/getClubList",
						method : "POST",
						data : JSON.stringify ({
							currentPage: 1
						}),
						contentType: 'application/json',
						dataType : "json",
						header : {
							"Accept" : "application/json",
							"Content-Type" : "application/json"
						}, // header end
						
						success : function(data, status) {
							
							var addHtml = "";
							var addImg = "";
							var count = 0;
							
							$.each(data.clubList, function(index, item){

								if(item.clubImage != null) {
									
									if(index > 4) {
										
										return false;
										
									} else if(index == 0 ){
										addHtml += '<li data-target="#carousel-club" data-slide-to="' + index + '" ></li>';
										addImg += 	'<div class="item active">' +
														'<a href="/club/getClub?clubNo=' + item.clubNo + '" >' +
															'<img src="/resources/image/uploadFiles/' + item.clubImage + '" alt="">' +
														'</a>' +
														'<div class="carousel-caption">' +
														'</div>' +
												    '</div>'
									} else {
										addHtml += '<li data-target="#carousel-club" data-slide-to="' + index + '" class="active"></li>';
										addImg += 	'<div class="item">' +
														'<a href="/club/getClub?clubNo=' + item.clubNo + '" >' +
															'<img src="/resources/image/uploadFiles/' + item.clubImage + '" alt="">' +
														'</a>' +
														'<div class="carousel-caption">' +
														'</div>' +
												    '</div>'
									}
								}
								
							}) // each close
							
							// $(".carousel-club-indicators").html(addHtml);
							$(".carousel-club-inner").html(addImg);
							
						} // success close
						
					} // ajax inner close
					
				)} // ajax close
		});
	<%-- 추천 모임 보이기 --%>

	}); // jQuery end

	
	
	</script>

<!------------------------------ CSS ------------------------------>

<style type="text/css">
	
	.btn-13 {
 	 font-family: 'Lato', sans-serif;
 	 font-weight: 500;
 	 background-color: white;
 	 cursor: pointer;
 	 transition: all 0.3s ease;
 	 position: relative;
 	 border: solid 2px;
 	 box-shadow:none !important;
 	 outline: none;
 	 box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
 	 border-radius: 10px;
   	 color: #5F0080 !important;
	 font-size: 16px !important;
	 text-align: center;
	}

	.btn-13:hover { 
  	 background-color: #5F0080;
   	box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
   	border-radius: 10px;
   	color: white !important;
   	font-size: 16px !important;
   	text-align: center;
   	border: solid 2px;
	}
	
	<%--신고처리 --%>
	



	h3{
		text-align:center;
		text-transform: uppercase;
		color: #F1FAEE; 
		font-size: 4rem;
		margin-top: 15px !important;
		margin-bottom: 15px !important;
	}

	.roller{
		height: 3.125rem;
    	line-height: 3.9rem;
		position: relative;
		overflow: hidden; 
		width: 100%;
		display: flex;
		justify-content: center;
		align-items: center;
		color: #1D3557;
	}

	#spare-time{
		font-size: 1rem;
		letter-spacing: 1rem;
		margin-top: 0;
		color: #A8DADC;
	}

	.roller #rolltext {
		position: absolute;
		top: 0;
		animation: slide 10s infinite;  
	}

	@keyframes slide {
		0%{
			top:0;
		}
		25%{
			top: -4rem;    
		}
		50%{
			top: -8rem;
		}
		72.5%{
			top: -12.25rem;
		}
	}

@media screen and (max-width: 600px){
	h3{
		text-align:center;
		text-transform: uppercase;
		color: #F1FAEE; 
		font-size: 1.125rem !important;
	}
  
	.roller{
		height: 2.6rem; 
		line-height: 2.125rem;  
	}
  
	.roller #rolltext {  
		animation: slide-mob 10s infinite;  
	}

	@keyframes slide-mob {
		0%{
			top:0;
		}
		25%{
			top: -2.125rem;    
		}
		50%{
			top: -4.25rem;
		}
		72.5%{
			top: -6.375rem;
		}
	}
}


</style>

<!------------------------------ CSS ------------------------------>



</head>

<body>
		
	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	<%-- 채팅을 위한 소켓 --%>
	<script src="http://192.168.0.74:3000/socket.io/socket.io.js"></script>
	<%-- 채팅 js --%>
	<script src="/resources/javascript/chat/chat.js"></script>
	<%-- 채팅 css --%>
	<link rel="stylesheet" href="/resources/css/chat/chat.css" type="text/css" media="screen" title="no title">
	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>

	<jsp:include page="/toolbar.jsp" />
	
	
	<main role="main" class="main">


		<div id="main" class="main">
		
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

			<section class="row section">
				<div class="container">

					<div class="row-content buffer even clear-after">
						<div class="column three">
							<div>
								<button class="btn btn-primary searchPlace" type="button"
									onclick="window.open('http://192.168.0.21:5005/', '_blank', 'width=800, height=600, location =no,status=no, toolbar=no, scrollbars=no'); return false;">주변검색</button>
	
								<%-- 검색 --%>
								<form id="searchForm" method="POST" action="/feed/getFeedList">
	
									<input type="text" id="searchKeyword" placeholder="검색"
										name="searchKeyword" value="${search.searchKeyword}">
	
								</form>
								<%-- 검색 --%>
							</div>
							
							
							
							<h3>오늘은:
								<div class="roller">
								<span id="rolltext">내가<br/>
													너와<br/>
													만나다<br/>
													LINK<br/>
							</div>
							</h3>
					


							<jsp:include page="/serviceCenter/getFestival.jsp" />

							
							
						</div>

						<div class="column six">
							<div class="post-area clear-after addFeedForm">
								<form id="addForm">

									<c:if test="${!empty sessionScope.user}">

										<article role="main">

											<div class="addHeader">
												<div class="addHeaderInner">
													<div class="addFormImage">
														<img class="sessionProfileImage"
															src="/resources/image/uploadFiles/${sessionScope.user.profileImage}" />
													</div>

													<div class="addFormName">
														${sessionScope.user.nickName}</div>
												</div>

												<div>
													<button class="btn btn-primary addFeed" type="button">등록</button>
												</div>

											</div>

											<div class="addBody">

												<textarea id="summernote" name="fullContent"></textarea>
											</div>

										</article>

									</c:if>

									<input type="hidden" name="openCondition" value="3">

								</form>
							</div>

							<c:set var="i" value="0"></c:set>
							<c:forEach var="feed" items="${feedList}">
								<c:set var="i" value="${i + 1}"></c:set>

								<c:if
									test="${fn:trim(feed.deleteCondition) eq '0' and fn:trim(feed.reportCondition) eq '0'}">

									<div class="showFeedForm">
										<form class="feedForm">
											<div class="feedHeader">
												<div class="feedLeft">
													<div class="feedInner">
														<div class="feedCover">
															<img class="feedProfileImage" src="/resources/image/uploadFiles/${feed.user.profileImage}" alt="${feed.user.profileImage}"/>
															
														</div>
														<div class="feedName dlFeednickName">${feed.user.nickName}</div>
													</div>

													<div class="feedDate">
													
														<c:if test="${!empty feed.updateDate}">
															<fmt:formatDate value="${feed.updateDate}" pattern="MM월 dd일 HH시mm분"></fmt:formatDate> (수정)
														</c:if>
														
														<c:if test="${empty feed.updateDate}">
															<fmt:formatDate value="${feed.regDate}" pattern="MM월 dd일 HH시mm분"></fmt:formatDate>
															
														</c:if>

													</div>
												</div>

												<c:if test="${sessionScope.user.userId eq feed.user.userId}">

													<div class="udIcon">
														<%-- 수정 버튼 --%>
														<span class="glyphicon glyphicon-paperclip btn_update" aria-hidden="true"></span>
														<%-- 수정 버튼 --%>

														<%-- 삭제 버튼 --%>
														<span class="glyphicon glyphicon-trash btn_delete"
															aria-hidden="true"></span>
														<%-- 삭제 버튼 --%>
													</div>

												</c:if>
											</div>
											<div class="feedContent">
												<div class="feedLetter">${feed.content}</div>

												<c:if test="${!empty feed.video}">
													<div class="feedVideo">
														<iframe width="560" height="315"
															src="http://${feed.video}"></iframe>
													</div>
												</c:if>

												<%-- 이미지 --%>

												<c:if test="${!empty feed.image1}">
													<div class="feedImage">
														<div id="carousel-example-generic${i}"
															class="carousel slide" data-ride="carousel">
															<ol class="carousel-indicators">
																<li data-target="#carousel-example-generic${i}"
																	data-slide-to="0" class="active"></li>

																<c:if test="${!empty feed.image2}">
																	<li data-target="#carousel-example-generic${i}"
																		data-slide-to="1"></li>
																</c:if>
																<c:if test="${!empty feed.image3}">
																	<li data-target="#carousel-example-generic${i}"
																		data-slide-to="2"></li>
																</c:if>
																<c:if test="${!empty feed.image4}">
																	<li data-target="#carousel-example-generic${i}"
																		data-slide-to="3"></li>
																</c:if>
															</ol>

															<!-- Wrapper for slides -->
															<div class="carousel-inner" role="listbox">
																<div class="item active">
																	<img src="/resources/image/uploadFiles/${feed.image1}"
																		alt="${feed.image1}">
																</div>

																<c:if test="${!empty feed.image2}">
																	<div class="item">
																		<img src="/resources/image/uploadFiles/${feed.image2}"
																			alt="${feed.image2}">
																	</div>
																	<c:if test="${!empty feed.image3}">
																		<div class="item">
																			<img
																				src="/resources/image/uploadFiles/${feed.image3}"
																				alt="${feed.image3}">
																		</div>
																		<c:if test="${!empty feed.image4}">
																			<div class="item">
																				<img
																					src="/resources/image/uploadFiles/${feed.image4}"
																					alt="${feed.image4}">
																			</div>
																		</c:if>
																	</c:if>
																</c:if>
															</div>

															<!-- Controls -->
															<a class="left carousel-control carousel_prev"
																href="#carousel-example-generic${i}" role="button"
																data-slide="prev"> <span
																class="glyphicon glyphicon-chevron-left"
																aria-hidden="true"></span> <span class="sr-only">Previous</span>
															</a> <a class="right carousel-control carousel_next"
																href="#carousel-example-generic${i}" role="button"
																data-slide="next"> <span
																class="glyphicon glyphicon-chevron-right"
																aria-hidden="true"></span> <span class="sr-only">Next</span>
															</a>
														</div>
													</div>
												</c:if>

												<%-- 이미지 --%>

											</div>

											<c:if test="${!empty feed.hashtag}">
												<div class="hashtagContent">

													<c:set var="text" value="${fn:split(feed.hashtag, '#')}" />
													
													<c:forEach var="textValue" items="${text}"
														varStatus="varStatus">
														<span class="searchByHashtag"> #${textValue} </span>
													</c:forEach>

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
											
											<input type="hidden" name="forUpdateFullContent" value='${feed.fullContent}'>

											<!-- 피드 좋아요 댓글수 신고 -->
											<section class="row section lastBar">
												<div class="row">
													<%-- 여백 --%>
													<div class="col-xs-2"></div>
													<%-- 여백 --%>

													<c:if test="${feed.checkHeart eq 0}">
														<div class="col-xs-2">
															<img class="feedLike"
																src="/resources/image/uploadFiles/no_heart.jpg"
																aria-hidden="true" />
														</div>
													</c:if>
													<c:if test="${feed.checkHeart ne 0}">
														<div class="col-xs-2">
															<img class="feedDislike"
																src="/resources/image/uploadFiles/heart.jpg"
																aria-hidden="true" />
														</div>
													</c:if>

													<div class="col-xs-1 likeCount">${feed.heartCount}</div>

													<div class="col-xs-2 comment">
														<img src="/resources/image/uploadFiles/comment2.jpg"
															class="commentImg" aria-hidden="true"/>
													</div>

													<div class="col-xs-1 commentCount">
														${feed.commentCount}</div>

													<!-- 신고 아이콘 -->
													<div class="col-xs-2 report">
														<img src="/resources/image/uploadFiles/report.jpg"
															aria-hidden="true" />
													</div>
													<!-- 신고 아이콘 -->

													<%-- 여백 --%>
													<div class="col-xs-2"></div>
													<%-- 여백 --%>

												</div>
											</section>
											<!-- 피드 좋아요 댓글수 신고 -->

										</form>

									</div>

								</c:if>

							</c:forEach>

						</div>

						<div class="column three">
						
						<script type="text/javascript" charset="utf-8" src="/resources/javascript/myHome/followListForFeed.js"></script>

							<div class="tabs1">
								<input id="all-follow" type="radio" name="tab_item-follow" checked>
								<label class="tab_item-follow" for="all-follow">팔로우</label>
								
								<input id="programming-follow" type="radio" name="tab_item-follow">
								<label class="tab_item-following" for="programming-follow">팔로워</label>

								<div class="tab_content-follow" id="all-follow_content">
									<div class="col-md-4" id="fll">
										<br />
									</div>
								</div>
								<div class="tab_content-follow" id="programming-follow_content">
									<div class="col-md-4" id="fl">
										<br />
									</div>
								</div>
								<div class="clubRandomCover" >
								
									<div class="clubRandom">
									
										<div class="clubRandomTitle">
											최신 모임
										</div>

										<div id="carousel-club" class="carousel slide" data-ride="carousel">
											<!-- Indicators -->
											<ol class="carousel-indicators carousel-club-indicators">

											</ol>

											<!-- Wrapper for slides -->
											<div class="carousel-inner carousel-club-inner" role="listbox">
												
											</div>

											<!-- Controls -->
											<a class="left carousel-control" href="#carousel-club" role="button" data-slide="prev">
												<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
												<span class="sr-only">Previous</span>
											</a> <a class="right carousel-control" href="#carousel-club" role="button" data-slide="next">
												<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
												<span class="sr-only">Next</span>
											</a>
										</div>
									</div>
								</div>
								
							</div>
							
								
							
						</div>

						<%-- 현재 페이지 --%>
						<input type="hidden" id="currentPage" name="currentPage"
							value="${resultPage.currentPage}"> <input type="hidden"
							id="pageFlag" value=true>
						<%-- 현재 페이지 --%>

					</div>

				</div>
			</section>

		</div>

		<!-- COMMENT Modal -->
		<div class="modal fade" id="commentModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					
					<form class="form-horizontal" id="commentForm">
					
						<div class="commentContentCover">
							<div class="commentContentTitle">
								간편 댓글 달기
							</div>
							
							<div class="commentModalContent">
								<textarea class="content" id="contentModal" name="content" placeholder="댓글을 입력하세요." maxlength="500"></textarea>
							</div>
						</div>
						
					</form>
						
						<div class="modal-footer">
							<button type="button" class="btn btn-default addCommentByModal">등록</button>
							
							<button type="button" class="btn btn-default cancelCommentByModal" data-dismiss="modal">
								취소
							</button>
						</div>
						
						<input type="hidden" id="commentModalFeedNo" value="">
						
				</div>
			</div>
		</div>


		<!-- 알림 Modal -->
		<div class="modal fade" id="alarmModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalAlarmLabel">알림</h4>
					</div>
					<div class="modal-body alarmModalBody">여기는 알람모달</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">
							Close</button>
					</div>
				</div>
			</div>
		</div>

		<!-- 신고 Modal -->
		<div class="modal fade" id="reportModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
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
								<textarea class="reportContent" id="content" name="content" placeholder="신고 내용을 입력해주세요." maxlength="500"></textarea>
							</div>
						</div>
						
						<div class="reportSourceDiv">
							신고받는 ID
							<input type="text" class="reportSourceDivId" id="user2" name="user2" value="" readonly />
							신고 출처
							<input type="text" class="reportSourceDivSource" value="피드" disabled />
						</div>
						
						<input type="hidden" name="type" id="type" value="1">
						<input type="hidden" name="user1" id="user1" value="${sessionScope.user.userId}">
						<input type="hidden" id="reportSource" name="reportSource" value="3">
						<input type="hidden" name="no" id="No" value="" />

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

						<button type="button" class="custom-btn btn-13 addReportByModal">등록</button>
						
						<button type="button" class="custom-btn btn-13" data-dismiss="modal">
							취소
						</button>

					</div>
				</div>
			</div>
		</div>
		
		<!-- 수정 Modal -->
	<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">

				<form id="updateFeedForm">

					<!-- 피드 내용 -->
					<div class="post-area clear-after">

						<article role="main">
							<div class="updateModalHeader">
								<div class="updateModalLeft">
									<div class="updateModalInner">
										<div class="updateCover">
											<img class="updateFeedProfileImage" src="/resources/image/uploadFiles/${feed.user.profileImage}" />
										</div>

										<div class="updateFormName">${feed.user.nickName}</div>
									</div>

									<div class="updateFeedDate">
									</div>
								</div>
							</div>

							<textarea id="summernoteUpdate" name="fullContent"></textarea>

						</article>

					</div>

					<!-- 댓글 관련 hidden -->
					<input type="hidden" name="source" value="0">
					<input type="hidden" name="openCondition" value="3">
					<input type="hidden" name="userId" value="${sessionScope.user.userId}">
					<input type="hidden" name="feedNo" value="">

					<!-- 댓글 관련 hidden -->
				</form>

				<div class="modal-footer">
					
					<button type="button" class="btn btn-default btn_updateFeedCancel" data-dismiss="modal">이전</button>
					<button class="btn btn-primary btn_updateFeed" type="button">수정</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 수정 Modal -->
	
	
	</main>
</body>
</html>
