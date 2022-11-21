$(function() {
	$("#nickName").on("keyup", function() {
		
		
		var nickName = $("#nickName").val();
		console.log(nickName);

		$.ajax("/userRest/json/getUser", {
				
			type : "POST",
			data : JSON.stringify({ 
				nickName : nickName
			}),
			dataType : "json",
			contentType : "application/json",
			henders : {
				"Accept" : "application/json" 
				
			},
			success : function(JSONData, status) {
				
				console.log("JSONData : "+JSONData.nickName);
				
				console.log("DB로 받은 nickName : "+JSONData.nickName);
			
			 
				if(JSONData.nickName == ""){
					$("#nickNameCheck").html("사용가능한 닉네임 입니다.");
					$("#checkNickName").val(1);
					console.log($("#checkNickName").val());
				}else{
					$("#nickNameCheck").html("사용중인 닉네임 입니다.");
					$("#checkNickName").val(2);
					console.log($("#checkNickName").val());
				}
			
			}
			});
		}); 
	});