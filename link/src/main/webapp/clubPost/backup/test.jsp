<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</head>
<body>
  <button id="testBtn" class="btn">모달 테스트</button>
  
  <!-- 회원가입 확인 Modal-->
	<div class="modal fade" id="testModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button class="close" type="button" data-dismiss="modal" aria-label="Close">
						<button type="button" class="close" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					</button>
					<h3 class="modal-title" id="exampleModalLabel">모달테스트</h5>
				</div>
				<div class="modal-body">내용 입력 !!</div>
				<div class="modal-footer">
					<a class="btn" id="modalY" href="#">예</a>
					<button class="btn" type="button" data-dismiss="modal">아니요</button>
				</div>
			</div>
		</div>
	</div>
	


	
	<script>
		$('#testBtn').click(function(e){
			e.preventDefault();
			$('#testModal').modal("show");
		});
	</script>
</body>
</html>