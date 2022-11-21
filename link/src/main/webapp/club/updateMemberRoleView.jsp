<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	<!-- addMeetingCss -->
  	<link rel="stylesheet" href="/resources/css/addUser.css">
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
            padding-top : 10px;
        }
        
        .form-control {
        	width: 160%;
        	height: 34px;
        }
        
        .plain.button.red.cancel{
	   background-color: white;
	   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
	   border-radius: 10px;
	   margin: 1rem;
	   padding: 0px;
	   width: 65px !important;
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
	   width: 65px !important;
	   color: white !important;
	   font-size: 16px !important;
	} 
        
        
        
    </style>
    
    <script type="text/javascript">
    
    $(function() {
		$("#change").on("click", function() {
			fncUpdateMemberRole();
			
			opener.document.location.reload();
			self.close();
			
			//window.close();
		});
		
		$("#cancel").on("click", function() {
			window.close();
		});
	});
    
    function refreshMemList(){
    	location.reload();
    }
    
    function fncUpdateMemberRole() {
    	
    	var userId = $("#userId").val();
    	var memberRole = $("#memberRole").val();
    	var clubUserNo = $("#clubUserNo").val();
    	var value = "";
 

 			var userId = $("#userId").val();
  			//alert("유저 아이디 :"+userId);
  			//alert("유저넘버는? :"+clubUserNo);
  			
  			/* var memberRole = #("#memberRole").val();
  			alert(memberRole); */

  			$.ajax("/clubRest/json/updateMemberRole", {

    		
   			type : "POST",
   			data : JSON.stringify({
   				userId : userId,
   				clubUserNo : clubUserNo,
   				memberRole : memberRole
   			}),
   			dataType : "json",
   			contentType : "application/json",
   			henders : {
   				"Accept" : "application/json"
   			},
   			success : function() {
   				
   				$.ajax("/clubRest/json/getClubMemberList", {
   					
   					type : "POST",
   					data : JSON.stringify({
   						userId : userId
   					}),
   					dataType : "json",
   					contentType : "application/json",
   					henders : {
   						"Accept" : "application/json"	
   					},
   					success : function(JSONData, status) {
						alert('수정완료');
   						console.log("수정완료");

   						window.close();
						}
   				});
			}
    	});
  			refreshMemList();
	}
	
    </script>
    
    </head>

<body>
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="wrap wd668">
		<div class="container">
			<div class="form_txtInput">
				<h2 class="sub_tit_txt">직 책 수 정</h2>
				<p class="exTxt">모임원의 직책을 수정해보세요...</p>
			
			</div>
			
	    
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">
		
		<%-- <input type="hidden" id = "userId" name="userId" value="${ user.userId }"> --%>
		
		<input type="hidden" id="clubUserNo" value="">
		<!-- <input type="text" id="memberRole" value=""> -->
		
			<div class="form-group">
				<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">모임원 아이디</label>
				<div class="col-sm-2">
					<input type="text" id="userId" value="" autocomplete="off" style="height:34px; width: 160%; border-color:#BD76FF; border-width: thin;">
				</div>
			</div>
			
			<div class="form-group">
				<label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">직책</label>
				<div class="col-sm-2">
					<select class="form-control" name="memberRole" id="memberRole" style="border-color:#BD76FF;">
						<option value="1">모임부대표</option>
						<option value="0" selected>모임원</option>
					</select>
				</div>
			</div>
			
			<div class="form-group" id="btn_group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button type="button" id="change" class="plain button red cancel">수 &nbsp;정</button>
					<button type="button" class="plain button red cancel" id="cancel">취&nbsp;소</button>
				</div>
			</div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->
	</div>
 	
</body>

</html>