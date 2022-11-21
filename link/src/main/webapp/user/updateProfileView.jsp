<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="UTF-8">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="description" content="The Page Description">

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->

<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<script type="text/javascript" charset="utf-8"
	src="/resources/javascript/user/nickNameCheck.js"></script>
<script type="text/javascript" charset="utf-8"
	src="/resources/javascript/user/category.js"></script>
<script type="text/javascript" charset="utf-8"
	src="/resources/javascript/user/image.js"></script>
<link rel="stylesheet" href="/resources/css/layers.min.css"
	media="screen">
<link rel="stylesheet" href="/resources/css/font-awesome.min.css"
	media="screen">
<link rel="stylesheet" href="/resources/css/style.css" media="screen">

<script src="https://code.jquery.com/jquery.js"></script>
<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>
<!--  ///////////////////////// CSS ////////////////////////// -->
<style>
body>div.container {
	border: 3px solid #D6CDB7;
	margin-top: 10px;
}
</style>

<script type="text/javascript">
	$(function() {
		$("#update").on("click", function() {
			fncUpdateProfile();
		});
	});
	
	function fncUpdateProfile() {
		
		var regExp2 = /\s/g;
		var nickName = $("#nickName").val();
		var gender = $(".gender").is(":checked");
		var checkNickName = $("#checkNickName").val();
		//alert(gender);
		
		if(nickName == null || nickName.length < 1){
			swal.fire("닉네임을 입력해 주세요.");
			return;
		}
		
		if(gender == false){
			swal.fire("성별 체크를 해주세요.");
			return;
		}
		
		if(nickName == null || nickName.length <1){
			swal.fire("닉네임을 입력하셔야 합니다.");
			return;
		}
		
		if(regExp2.test(nickName)){
			swal.fire("공백은 사용할 수 없습니다.");
			return;
		}
		
		if(checkNickName == 2){
			swal.fire("사용중인 닉네임 입니다");
			return;
		}
		
		if(${ empty getUser.nickName}){
			$("form").attr("method", "POST").attr("action", "/user/addProfile").attr("encType", "multipart/form-data").submit();
		}else{
			$("form").attr("method", "POST").attr("action", "/user/updateProfile").attr("encType", "multipart/form-data").submit();
			setTimeout(function() {   
	             window.close();

	        }, 50);
		}
	}
</script>
</head>

<body style="background-color: #EBEDF0;">
	<!-- ToolBar End /////////////////////////////////////-->

	<!--  화면구성 div Start /////////////////////////////////////-->

	<form>
		<div class="wrap wd668">
			<div class="container"
				style="background: #ecf4ff; border-radius: 20px; zoom: 0.8;">
				<br /> <br />
				<div>
					<div class="form_txtInput">
						<h2 class="sub_tit_txt">프로필작성</h2>
						<div class="join_form">
							<table>
								<colgroup>
									<col width="30%" />
									<col width="auto" />
								</colgroup>
								<tbody>
									<tr>
										<td><input type="hidden" class="form-control" id="userId"
											name="userId" value="${ getUser.userId }"></td>
									</tr>
									<tr>
										<th><span>닉네임</span></th>
										<td><input type="text" class="form-control" id="nickName" autocomplete="off"
											name="nickName" placeholder="중복확인하세요"
											value="${getUser.nickName }"><span id="helpBlock"
											class="help-block"> <strong class="text-danger"
												id="nickNameCheck">특수문자&nbsp;사용&nbsp;불가,&nbsp;1~10자</strong>
												<input type="hidden" id="checkNickName"></span></td>
									</tr>
									<tr>
									<tr>
										<th><span>성별</span></th>
										<td><input type="radio" class="gender" id="gender"
											name="gender" placeholder="성별" value="남자">&nbsp;남자 <input
											type="radio" class="gender" id="gender" name="gender"
											placeholder="성별" value="여자">&nbsp;여자</td>
									</tr>
									<tr>
										<th><span>활동영역</span></th>
										<td><div style="display: flex;">
												<select class="form-control" id="areaSelcet"
													style="height: 40px; width: 200px; margin-right: 20px; border: 1px solid #2c2b2b17; font-size: inherit;">
													<option selected="selected">선택해주세요</option>
													<option value="강남구">강남구</option>
													<option value="강동구">강동구</option>
													<option value="강북구">강북구</option>
													<option value="강서구">강서구</option>
													<option value="관악구">관악구</option>
													<option value="광진구">광진구</option>
													<option value="구로구">구로구</option>
													<option value="금천구">금천구</option>
													<option value="노원구">노원구</option>
													<option value="도봉구">도봉구</option>
													<option value="동대문구">동대문구</option>
													<option value="동작구">동작구</option>
													<option value="마포구">마포구</option>
													<option value="서대문구">서대문구</option>
													<option value="서초구">서초구</option>
													<option value="성동구">성동구</option>
													<option value="성북구">성북구</option>
													<option value="송파구">송팡구</option>
													<option value="양천구">양천구</option>
													<option value="영등포구">영등포구</option>
													<option value="용산구">용산구</option>
													<option value="은평구">은평구</option>
													<option value="종로구">종로구</option>
													<option value="중구">중구</option>
													<option value="중랑구">중랑구</option>
												</select>
												<button type="button"
													style="width: 60px; background-color: #E1BFFF; border-style: hidden;"
													id="areaClick">추가</button>
											</div></td>
									</tr>

									<tr>
										<th></th>
										<td>
											<div id="ar"></div> <input type="hidden" name="area1"
											id="area1"> <input type="hidden" name="area2"
											id="area2"> <input type="hidden" name="area3"
											id="area3">
									</tr>

									<tr>
										<th><span>관심카테고리</span></th>
										<td><div style="display: flex;">
												<select class="form-control"
													style="height: 40px; width: 200px; margin-right: 20px; border: 1px solid #2c2b2b17; font-size: inherit;"
													name="categorySelect" id="categorySelcet">
													<option value="운동">운동</option>
													<option value="봉사활동">봉사활동</option>
													<option value="음식">음식</option>
													<option value="여행">여행</option>
													<option value="반려동물">반려동물</option>
													<option value="게임">게임</option>
													<option value="음악/댄스">음악/댄스</option>
													<option value="독서">독서</option>
													<option value="기타">기타</option>
												</select>
												<button type="button"
													style="width: 60px; background-color: #E1BFFF; border-style: hidden;"
													id="categryClick">추가</button>
											</div></td>
									</tr>

									<tr>
										<th></th>
										<td>
											<div id="ca"></div> <input type="hidden" name="category1"
											id="category1"> <input type="hidden" name="category2"
											id="category2"> <input type="hidden" name="category3"
											id="category3">
									</tr>


									<tr>
										<th><span>프로필글</span></th>
										<td><input type="text" class="form-control" autocomplete="off"
											id="profileWriting" name="profileWriting" placeholder="프로필글"
											value="${getUser.profileWriting}"></td>
									</tr>
									<tr>
										<th><span>프로필사진</span></th>
										<td><input type="file" class="form-file"
											id="profileImageFile" style="display: none;"
											name="profileImageFile" onchange="setThumbnail(event);"
											value="${getUser.profileImage}" />
											<button id="im" type="button" class="image"
												style="border-style: hidden;">
												<img id="imga"
													src="/resources/image/uploadFiles/${getUser.profileImage}"
													style="height: 300px; width: 300px;" />
											</button></td>
									</tr>
									<tr>
										<th><span></span></th>
										<td align="center">
											<button type="button" class="btn btn-primary" id="update">등
												&nbsp;록</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				<!-- form_txtInput E -->
			</div>
			<!-- content E-->
		</div>
		<!-- container E -->
	</form>

</body>
</html>