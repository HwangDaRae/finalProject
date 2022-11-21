$(function emailCheck() {
			$("#sendEmail").on("click", function() {
				const email = $("#email").val();	// 이메일 Value 변수 설정
				console.log("이메일 주소 : "+email);	// 이메일 Value값 확인
				const inputCertifiedNumber = $("#inputCertifiedNumber");	//인증번호 입력하는 곳
				
				swal.fire("인증번호 발송 완료!");
				
				$.ajax("/userRest/json/mailCheck/"+email, {
					type : "GET",
					contentType : "application/json",
					henders : {
						"Accept" : "application/json"
					},
					success : function(data) {
						
						console.log("data : "+data);
						
						$("#checkBtn").click(function() {
							if($.trim(data) == $("#inputCertifiedNumber").val()){
								swal.fire("인증성공!",
										"이메일인증이 정상적으로 완료되었습니다.",
										"success"
										)
										$("#checkNo").val(1);
							}else{
								swal.fire({
									icon: "error",
									title: "인증오류",
									text: "인증번호가 올바르지 않습니다."
								});
							}
						});
					}
				});
			});
			
			$("#sendEmail1").on("click", function() {
				const email = $("#email1").val();	// 이메일 Value 변수 설정
				console.log("이메일 주소 : "+email);	// 이메일 Value값 확인
				const inputCertifiedNumber = $("#inputCertifiedNumber1");	//인증번호 입력하는 곳
				
				swal.fire("인증번호 발송 완료!");
				
				$.ajax("/userRest/json/mailCheck/"+email, {
					type : "GET",
					contentType : "application/json",
					henders : {
						"Accept" : "application/json"
					},
					success : function(data) {
						
						console.log("data : "+data);
						
						$("#checkBtn1").click(function() {
							if($.trim(data) == $("#inputCertifiedNumber1").val()){
								swal.fire("인증성공!",
										"이메일인증이 정상적으로 완료되었습니다.",
										"success"
										)
										$("#checkNo1").val(1);
							}else{
								swal.fire({
									icon: "error",
									title: "인증오류",
									text: "인증번호가 올바르지 않습니다."
								});
							}
						});
					}
				});
			});
		});