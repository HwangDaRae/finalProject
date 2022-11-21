$(function() {
		$("td:nth-child(2)").on("mouseover", function() {

			console.log($(this).text().trim());

			var userId = $(this).text().trim();

			$.ajax("/userRest/json/getUser", {

				type : "POST",
				data : JSON.stringify({
					userId : userId
				}),
				dataType : "json",
				contentType : "application/json",
				headers : {
					"Accept" : "application/json"
				},
				success : function(Data, status) {

					console.log(Data);

					var nickName = Data.nickName;
					var profileImage = Data.profileImage;
					var profileWriting = Data.profileWriting;

					$("#ajaxImage").text(profileImage)
					$("#ajaxNickName").text(nickName)
					$("#ajaxWriting").text(profileWriting)

					$("#" + userId + "").hover(function() {

						$("#" + nickName).dialog({
							modal : true,
							open : true
						});
						$("#" + nickName).dialog("open");

					}, function() {

						$("#" + nickName).dialog("close");
					});
				}
			});
		})
	})