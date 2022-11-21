<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

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
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
<!--    
   jQuery UI toolTip 사용 CSS
  <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">  
  	 	jQuery UI toolTip 사용 JS
  <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
  <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
  <script src="https://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>

 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>		
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
        
        
                    
        element.style {
    	margin-top: 100px !important;
    	margin-left: -87px !important;
		}
		
		
		.h1, .h2, .h3, h1, h2, h3 {
 		   margin-top: 20px;
		   margin-bottom: 50px;
		}
		
		textarea {
		resize: none;
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
	
		$("#apply").on("click", function() {
			fncAddApprovalCondition();
			
			//opener.document.location.reload();
			//window.close();
		});
	
		$("#cancel").bind("click", function() {
			window.close();
		});
	});
	
	function fncAddApprovalCondition() {

		var joinGreeting = $("textarea[name='joinGreeting']").val();
		
		if ( joinGreeting == null || joinGreeting.length < 1 ) {
			Swal.fire({
				icon: 'error',
				title: '가입인사는 필수입니다.' ,
			});
			return;
		}
		$("form").attr("method", "POST").attr("action", "/club/addApprovalCondition")
			.submit();
		
		opener.document.location.reload();
		/* self.close(); */
	}


	

</script>
</head>

<body>
	
	<div class="container">
	
		<h1 class="bg-primary text-center" style="background-color:#ffffff; border-color:#BD76FF; color:#BD76FF; width:700px; margin-left: -87px;">모 임 가 입 신 청</h1>
		
		<form class="form-horizontal">
		
		<!-- 	<div class="form-group">
				<label for="user.userId" class="col-sm-offset-1 col-sm-3 control-label">아 이 디</label>
				<div class="col-sm-4">
					<input type="text" class="form-control" id="user.userId" name="user.userId" placeholder="이름은 필수입니다">
				</div>					
			</div> -->
						
			<div class="form-group">
				<label for="joinGreeting" class="col-sm-offset-1 col-sm-3 control-label"> 가 입 인 사</label>
				<div class="col-sm-4">
					<textarea class="joinGreeting" id="joinGreeting" name="joinGreeting" maxlength="100" style="width: 300px; height: 50px;" placeholder="가입인사는 필수입니다."></textarea>
				</div>		
			</div>
			
			
			
			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
		      		<button type="button" class="plain button red cancel" id="apply">신&nbsp;청</button>
					<button type="button" class="plain button red cancel" id="cancel">취&nbsp;소</button>
		    </div>
			</div>
		</form>	
		</div>
		
</body>
</html>