<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="UTF-8">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>


<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
body {
	padding-top: 50px;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#chack").on("click", function() {
			window.close();
		});
	});
</script>

</head>

<body>

	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container"
		style="background-color: lavenderblush; width: 500px; margin-top: 50px; height: 300px;">

		<h1 class="bg-primary text-center"
			style="color: #333; background-color: #ffffff00; margin-bottom: 40px; margin-top: 70px; font-weight: bold;">아이디찾기</h1>

		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal">

			<div class="form-group">
				<label for="name" class="col-sm-offset-1 col-sm-3 control-label">ID</label>
				<div class="col-sm-4">
					<input disabled="disabled" type="text" class="form-control"
						id="userId" name="userId" value="${ userId.userId }"
						placeholder="아이디">
				</div>
			</div>

			<div class="form-group">
				<div class="col-sm-offset-4  col-sm-4 text-center">
					<button type="button" id="chack" class="btn" style="border-style: hidden; background-color: #5F0080; color: #fffef8;">확
						&nbsp;인</button>
				</div>
			</div>
		</form>
		<!-- form Start /////////////////////////////////////-->

	</div>
	<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>