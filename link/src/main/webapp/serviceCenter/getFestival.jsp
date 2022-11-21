<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<style>
.box{
overflow:scroll;
overflow-x:hidden;
}
.box::-webkit-scrollbar {
    display: none; /* Chrome, Safari, Opera*/
}
.card{
width:210px; 
background:white;
border: 1px solid white;
border-radius: 15px;
box-shadow: 0 0 10px rgb(0 0 0 / 20%);'

}
</style>
<title>Insert title here</title>
</head>
<body>
	<div class="box festival" style="width:230px; height: 470px; border-radius:15px;"> 
	
	</div>
	
	
	
	<script type="text/javascript">
 // 데이터를 aJax로 받기
 
$(function(){

		
		$.ajax({  //화면 나타내기
				url  : "/serviceCenterRest/json/getFestivalList",
				type : "get",
				data : {"contentTypeId" : 15},
				dataType: "json",
				contentType: "application/json; charset=utf-8",
				success:function(msg){
					var myItem =msg.response.body.items.item;
					
			 		var addHtml ="";
			 		
			 		
			$.each(myItem,function(index,item){
					
						const firstimage1 =$.trim(item.firstimage);
						const firstimage2 =$.trim(item.firstimage2);
						
					<%--	document.write(item.title);   --%>
			  if(firstimage1!=""){    //이미지 없는 거 거르기
					addHtml+=	"<div class=card style='margin-bottom:20px;' >"+
						 	 		"<div class=card-header style= 'text-align: center; background-color: #F5F6F7; border-radius: 15px;'>"+
						 	  		 "<strong>"+item.title+"</strong>"+
							 		 "</div>"+
							  "<img src="+item.firstimage+" style= width:230px; height:300px;/>"+
							  "<div class=card-body style='text-align:center;'>"+
						 	   "<h5 class=card-title>"+ item.title+"</h5>"+
						 	   "<input type='hidden' name='contentid' value="+item.contentid+">"
								
										$.ajax({
										url  : "/serviceCenterRest/json/getFestival",
										type : "get",
										data : {"contentid":item.contentid},
										datatype: "json",
										contentType: "application/json; charset=utf-8",
										async: false,
										success:function(msg2){
											const msg2data = JSON.parse(msg2)
											addHtml+= msg2data.response.body.items.item[0].homepage+
												 "</div>"+
												  "</div>";
												
												}//안의 success
									 		
											})//개인 이미지 찾아오기
											}//if문 끝
						}) //each 끝
 
						
						$(".festival").html(addHtml);
					
				} //ssuccess끝		 
					
			 
		 }) //화면 찾아오기 끝

		 
	});//펑션 끝	 
		 
		 
</script>
		
</body>