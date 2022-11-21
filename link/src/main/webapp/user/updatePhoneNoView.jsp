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
	<!-- <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script> -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

	<script type="text/javascript" charset="utf-8" src="/resources/javascript/user/SMSCheck.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
		body {
            padding-top : 50px;
        }
/*         button:hover {
	border-style: hidden;
	background-color: #5F0080;
	color: white;
	border-radius: 10px;
	font-weight: bold;
	border: solid 2px white;
}

button {
	background-color: white;
	border: solid 2px #5F0080;
	border-radius: 20px; 
	color:;
} */
    </style>
    
    <script type="text/javascript">
    
    $(function() {
		$("#chang").on("click", function() {
			fncUpdatePhone();
		});
		
		$("#back").on("click", function() {
			$('#modalPhone').modal('hide');
		});
	})
    
    function fncUpdatePhone() {
    	
    	var regPhone = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/;
    	var phone2 = $("#phone2").val();
    	var phone3 = $("#phone3").val();
    	var checkNo = $("#checkNo").val();	
    	var value = "";
    	if(phone2 != "" && phone3 !=""){
    		value = $("#phone1").val() + "-"
    		+ phone2 + "-" + phone3;
    	}else if(phone2 != "" || phone3 !=""){
    		swal.fire("핸드폰 번호를 입력하셔야 합니다.");
    		return;
    	}
    		$("input:hidden[name='phoneNo']").val(value);
    	
    	if(!regPhone.test($("input:hidden[name='phoneNo']").val())){
    		swal.fire("핸드폰번호를 제대로 입력해주세요.");
    		return;
    	}	

    	if(checkNo != 1){
    		swal.fire("핸드폰인증이 필요합니다.");
    		return;
    	}
    	
   			var phoneNo = $("input:hidden[name='phoneNo']").val();
   			console.log(phoneNo);

 			var userId = $("#userId").val();

  			$.ajax("/userRest/json/updatePhoneNo", {

    		
   			type : "POST",
   			data : JSON.stringify({
   				userId : userId,
   				phoneNo : phoneNo
   			}),
   			dataType : "json",
   			contentType : "application/json",
   			henders : {
   				"Accept" : "application/json"
   			},
   			success : function() {
   				
   				$.ajax("/userRest/json/getUser", {
   					
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
						
   						console.log("JSONData : "+JSONData.phoneNo);
   						$("#phoneNo").val(JSONData.phoneNo);
   						
   						$('#modalPhone').modal('hide');
						} 
   				});
				
			}
    	});
  			
  		$(function() {
			
		})
	}
	
    </script>
    
    </head>

<body>
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class='modal fade' id='modalPhone' style=" width: 850px; height: fit-content; margin-top: 420px; margin-left: 440px;">
	<div class='modal-dialog'>
	<div class='modal-content' style="width: fit-content; border-radius: 30px;"> 
	<div class='modal-header' style="width: 560px; border: none;">
	<div style="width: fit-content; margin-left: -20px;" >
	
	    <!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" >
		
		<input type="hidden" id = "userId" name="userId" value="${ user.userId }">
		  <div class="form-group" style="display: flex; margin-left: 60px; margin-top: 30px;">
				<div >
					<select class="form-control" name="phone1" id="phone1" style="width: 80px; margin-left: 0px; font-size: large;">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="018">018</option>
						<option value="019">019</option>
					</select>
				</div>
			
				<div style="margin-left: 10px;">
					<input type="text" class="form-control" id="phone2" name="phone2" style="margin-left: 0px; width: 110px; height: 41px;"
						autocomplete="off" placeholder="번호">
				</div>
				<div style="margin-left: 10px;">
					<input type="text" class="form-control" id="phone3" name="phone3" style="margin-left: 0px; width: 110px; height: 41px;"
						autocomplete="off" placeholder="번호">
				</div>
				<input type="hidden" id="phoneNo" name="phoneNo" />
				<div style="margin-left: 10px;">
					<button type="button" id="sendPhoneNumber" style="margin-left: 0px; border-radius: 12px; font-weight: bold; height: 38px;">인증번호전송</button>
				</div>
			</div>

			<div class="form-group" style="display: flex; margin-left: 60px; margin-top: 20px;">
					<input type="text" class="form-control" id="inputCertifiedNumber" style=" width: 127px;" autocomplete="off"
						name="inputCertifiedNumber" placeholder="인증번호"> 
					<input type="hidden" id="checkNo">
				<div>
					<button type="button" id="checkBtn" style="margin-left: 10px; border-radius: 12px; font-weight: bold; height: 38px;">인증번호확인</button>
				</div>
			</div>
			
			<div class="form-group">
				<div style="margin-left: 222px;	margin-top: 20px;">
					<button type="button" id="chang" style="border-radius: 12px; font-weight: bold; width: 70px; height: 40px;">확 &nbsp;인</button>
					<button type="button" id="back" style="border-radius: 12px; font-weight: bold; width: 70px; height: 40px;">취&nbsp;소</button>
				</div>
			</div>
		</form>
		<!-- form Start /////////////////////////////////////-->
	    
 	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->
 	</div>
 	</div>
 	</div>
 	</div>
</body>

</html>