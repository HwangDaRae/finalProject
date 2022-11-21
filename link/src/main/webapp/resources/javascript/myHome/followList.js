$(function() {
	$(".tab_item-following").on("click" , function(e) {
		var userId = $("#userId").val();
		console.log(userId);
		$(".tab_item-following").off(e);
	$.ajax({
		url : "/myHomeRest/json/getFollowerList", // 어디로 갈거니? // 갈 때 데이터
		type : "POST", // 타입은 뭘 쓸거니?
		datatype : "json",
		 data		:  JSON.stringify({
			searchKeyword : userId
			
		 }),
		 
		contentType : "application/json",
		success : function(data) { 
       console.log(data.followerList[1]);
       $.each(data.followerList, function(index, item) { // 데이터 =item
    	   console.log(item);
			var value = 
				"<div class='following-section' style='margin-left:50px;' id='"+item.userId+"'>"+
			"<div style='display: inline-block;'>"+"<img src='/resources/image/uploadFiles/"+item.profileImage+"' width='100' height='100' />"+"</div><div style='float: right; margin-right:300px;'>"+
			"<h4 class='yourHome2'>"+item.nickName+"</h4></div>"+
		"</div>";
			
			
			 $("#fl").append(value);     
			
			 $(".yourHome2").on("click" , function() {
					
					self.location = "/myHome/getYourHome?userId="+$(this).parent().parent().attr("id");
				});
				
			
		})
		
		}	
	});
});
window.onload=function() {
		
		console.log(userId);
		
	$.ajax({
		url : "/myHomeRest/json/getFollowList", // 어디로 갈거니? // 갈 때 데이터
		type : "POST", // 타입은 뭘 쓸거니?
		datatype : "json",
		 data		:  JSON.stringify({
		 
			
		 }),
		 
		contentType : "application/json",
		success : function(data) { 
       console.log(data.list[1]);
       $.each(data.list, function(index, item) { // 데이터 =item
    	   console.log(item);
			var value = 
				"<div class='follow-section' style='margin-left:50px;' id='"+item.receiveId.userId+"'>"+
			"<div style='display: inline-block;'>"+"<img src='/resources/image/uploadFiles/"+item.profileImage+"' width='75' height='75' />"+"</div><div'>"+
			"<h4 class='yourHome'>"+item.nickName+"</h4></div>"+
		"</div>";
			
			
			 $("#fll").append(value);     
			
			 $(".yourHome").on("click" , function() {
					
					self.location = "/myHome/getYourHome?userId="+$(this).parent().parent().attr("id");
				});
				
			
		})
		
		}	
	});
};

	
	 
});	