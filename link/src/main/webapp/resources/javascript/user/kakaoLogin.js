function kakaoLogin() {

	window.Kakao.init('59386325ca13cdc634dfe162b470c978');

	window.Kakao.Auth.login({
		scope: 'profile_nickname, account_email, gender, age_range, birthday', //동의항목 페이지에 있는 개인정보 보호 테이블의 활성화된 ID값을 넣습니다.
		success: function(response) {
			console.log(response) // 로그인 성공하면 받아오는 데이터
			window.Kakao.API.request({ // 사용자 정보 가져오기 
				url: '/v2/user/me',
				success: (res) => {
					const kakao_account = res.kakao_account;
					console.log(kakao_account)
					console.log(kakao_account.profile.nickname)
					console.log(kakao_account.email)
					var snsUserId = kakao_account.email;
					$(".kakao").val(snsUserId)
					$(".snsType").val(1)
					console.log($(".kakao").val());
					console.log($(".snsType").val());


					$.ajax("/userRest/json/getUser", {
						type: "POST",
						data: JSON.stringify({
							snsUserId: snsUserId+",",
							addType: "1,"
						}),
						dataType: "json",
						contentType: "application/json",
						headers: {
							"Accept": "application/json"
						},
						success: function(Data, status) {
							console.log("서버로 받는 데이타 : " + Data.userId)
							console.log("서버로 받는 데이타 : " + Data.penaltyType)
							console.log("서버로 받는 데이타 : " + Data.stopEndDate)

							if (Data.penaltyType == 2) {
								swal.fire("회원은 영구정지 대상자로 로그인이 제한됩니다.");
								return;
							} else if (Data.penaltyType == 1
								&& Date.now() < Data.stopEndDate) {
								swal.fire("회원은 정지대상자로 [" + Data.stopStartDateString + " ~ "
									+ Data.stopEndDateString + "까지 로그인이 제한됩니다.");
								return;
							}

							$($("form")[0]).attr("method", "POST").attr("action","/user/snsLogin").submit();
						}
					});
					}
					// window.location.href='/ex/kakao_login.html' //리다이렉트 되는 코드
					});
				},
				fail: function(error) {
					console.log(error);
				}
			});

		}