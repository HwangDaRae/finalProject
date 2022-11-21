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
<!-- <link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> -->
 

<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
body {
	padding-top: 50px;
}
</style>

<script type="text/javascript">
	$(function() {
		$(".btn.check12").on("click", function() {
			fncGetPassword();
		}); 
		$(".btn.black1").on("click", function() {
			$('#modalPass').modal('hide');
		});
	});
	
	$(function() {
		 $("a[href='#q']").on("click", function() {
			 $("#home1").hide();
			 $("#profile1").show();
		})
		$("a[href='#n']").on("click", function() {
			 $("#profile1").hide();
			 $("#home1").css('display','flex');
		}) 
	})

	function fncGetPassword() {

		var id = $("#userId1").val();
		var name = $("#name1").val();
		var rrn1 = $("#rrn11").val();
		var rrn2 = $("#rrn21").val();
		var rrn = rrn1 + "-" + rrn2;
		var phone2 = $("#phone21").val();
		var phone3 = $("#phone31").val();
		var phoneNo = $("#phone11").val() + "-" + phone2 + "-" + phone3;
		var checkNo = $("#checkNo1").val();
		var email = $("#email1").val();

		$("#rrn1").val(rrn);

		console.log("phone21 : " + phone2 + ", phone31 : " + phone3);
		console.log("email1 : " + email);

		if (id == null || id.length < 1) {
			swal.fire("아이디를 입력해 주세요.");
			return;
		}

		if (name == null || name.length < 1) {
			swal.fire("이름을 입력해 주세요.");
			return;
		}

		if (rrn == null || rrn.length < 1) {
			swal.fire("주민번호를 입력해 주세요.");
			return;
		}

		if (phone2 == "" && phone3 == "" && email == "") {
			swal.fire("핸드폰, 이메일정보중 하나만 적어주세요.")
			return;
		}

		if (checkNo != 1) {
			swal.fire("인증이 필요합니다.");
			return; 
		}

		$.ajax("/userRest/json/getUserId", {

			type : "POST",
			data : JSON.stringify({
				name : name,
				rrn : rrn,
				outUserState : '0'
			}),
			dataType : "json",
			contentType : "application/json",
			henders : {
				"Accept" : "application/json"
			},
			success : function(Data, status) {
				console.log(Data.phoneNo)
				console.log(phoneNo)
				console.log(Data.userId)

				if (Data.userId != id) {
					swal.fire("아이디가 다릅니다.");
					return;
				}

				$.ajax("/userRest/json/updatePassword", {

					type : "POST",
					data : JSON.stringify({
						userId : id,
						email : email
					}),
					contentType : "application/json",
					henders : {
						"Accept" : "application/json"
					},
					success : function(JsonData, status) {
						console.log(JsonData)

						if (email == null || email.length < 1) {
							swal.fire("임시 비밀번호가 핸드폰번호로 전송되었습니다.").then(
									function() {
										$('#modalPass').modal('hide');
									});
						}

						if (phone2.length < 1 || phone3.length < 1) {
							swal.fire("임시 비밀번호가 이메일로 전송되었습니다.").then(
									function() {
										$('#modalPass').modal('hide');
									});
						}
					}
				})
			},
			error : function() {
				console.log("error");
				swal.fire("가입된 정보와 일치하지 않습니다.");
			}
		})
	}
</script>

</head>

<body>
	<div class='modal fade' id='modalPass'
		style='display: none; width: fit-content; height: fit-content; margin-left: 515px; border-radius: 30px; zoom: 1.2;'>
		<div class='madal-dialog'>
			<div class='modal-content' style="background-color: whitesmoke;">
				<div class='modal-header'>
					<!--  화면구성 div Start /////////////////////////////////////-->
					<div class="container" style="width: 500px;">

						<!-- form Start /////////////////////////////////////-->
						<form class="form-horizontal">
							<div class="form-group" style="margin-top: 30px; margin-left: 20px; display: flex; height: 30px">

								<label for="userId" style="margin-left: 0px;">아이디</label>
									<input type="text" class="form-control" id="userId1" autocomplete="off"
										name="uesrId" style="margin-left: 35px;" value=""
						 				placeholder="아이디">

							</div>
							<div class="form-group"
								style="display: flex; margin-top: 20px; margin-left: 20px; height: 30px;">

								<label for="name" style="text-align-last: start;">이 름</label> <input autocomplete="off"
									type="text" class="form-control" id="name1" name="name" value=""
									placeholder="이름" style="margin-left: 50px;">

							</div>

							<div class="form-group"
								style="display: flex; margin-left: 20px; height: 30px; margin-top: 20px;">
								<label for="rrn" style="text-align-last: start;">주민번호</label>
								<div>
									<input type="text" class="form-control" id="rrn11" name="rrn1" autocomplete="off"
										value="" style="margin-left: 20px; width: 100px">
								</div>
								<div>
 								<input type="password" class="form-control" id="rrn21" autocomplete="off"
										name="rrn2" value="" style="margin-left: 10px; width: 100px">
								</div>
								<input type="hidden" id="rrn1" name="rrn">
							</div>

							<ul class="nav nav-tabs" role="tablist"
								style="margin-left: 20px; display: flex; margin-top: 30px;">
								<li role="presentation" class="active"><a href="#n"
									aria-controls="home" role="tab" data-toggle="tab">핸드폰</a></li>
								<li role="presentation"><a href="#q"
									aria-controls="profile" role="tab" data-toggle="tab">이메일</a></li>
							</ul>

							<div class="tab-content" style="margin-top: 15px;">
								<div role="tabpanel" class="tab-pane active" id="home1"
									style="display: flex; margin-left: 20px;">
									<div>
										<select class="form-control" name="phone1" id="phone11"
											style="margin-top: 10px; margin-left: 0px; width: auto; font-size: large;">
											<option value="010">010</option>
											<option value="011">011</option>
											<option value="016">016</option>
											<option value="018">018</option>
											<option value="019">019</option>
										</select>
									</div>

									<div style="margin: 10px">
										<input type="text" class="form-control" id="phone21" autocomplete="off"
											name="phone2" style="width: 75px;">
									</div>

									<div style="margin: 10px"> 
										<input type="text" class="form-control" id="phone31" autocomplete="off"
											name="phone3" style="margin-left: -10px; width: 75px;">
									</div>
									<input type="hidden" name="phoneNo" />

									<div style="margin: 7px;">
										<button type="button" id="sendPhoneNumber1" class="btn"
											style="margin-top: 3px; height: 20px; font-size: large; font-weight: 600; border-color: #5F0080; border-radius: 13px;">인증번호전송</button>
									</div>
								</div>

								<div role="tabpanel" class="tab-pane" id="profile1"
									style="display: none; margin-left: 30px; margin-top: 20px;">
									<div>
										<input type="text" class="form-control" id="email1" autocomplete="off"
											name="email"
											style="margin-top: 0px; margin-left: 0px; width: 300px;"
											placeholder="변경이메일">
									</div>
									<div>
										<button type="button" id="sendEmail1" class="btn "
											style="margin-bottom: 20px; margin-top: -10px; margin-left: 0px; height: 22px; font-size: large; font-weight: 600; border-color: #5F0080; border-radius: 13px;">인증번호전송</button>
									</div>
								</div>
							</div>

							<div class="form-group"
								style="display: flex; margin-left: 20px; width: 100px; height: 40px;">
								<input type="text" class="form-control"
									id="inputCertifiedNumber1" style="width: 100px; height: 40px;" autocomplete="off"
									name="inputCertifiedNumber" placeholder="인증번호">
								<div>
									<button type="button" id="checkBtn1" class="btn "
										style="margin-left: 15px; margin-top: 3px; height: 22px; font-size: large; font-weight: 600; border-color: #5F0080; border-radius: 13px;">인증번호확인</button>
									<input type="hidden" id=checkNo1>
								</div>
							</div>

							<div class="form-group" style="display: flex;">
								<button type="button" id="check12" class="btn check12"
									style="margin-left: 182px; font-size: large; font-weight: 600; border-color: #5F0080; border-radius: 13px; margin-top: 15px;">확
									&nbsp;인</button>
								<button type="button" id="black1" class="btn black1"
									style="margin-left: 10px; font-size: large; font-weight: 600; border-color: #5F0080; border-radius: 13px; margin-top: 15px;">취
									&nbsp;소</button>
							</div>
						</form>
						<!-- form Start /////////////////////////////////////-->

					</div>
				</div>
			</div>
		</div>
	</div>

</body>

</html>