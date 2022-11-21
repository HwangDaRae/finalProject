<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8"%>
    
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<!DOCTYPE html>
<html>

<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/jquery.js"></script>
<script src="/resources/javascript/plugins.js"></script>
<script src="/resources/javascript/beetle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

<title>Q&A수정</title>
</head>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">
	
	function fncUpdateQandA(){
		var title = $("textarea[name='qandATitle']").val();
		var content = $("textarea[name='qandAContent']").val();
		var image = $("textarea[name='qandAImage']").val();
		var image = $("input[name='qandAImage']").val();
		
		if (title == null || title.length < 1) {
		 	Swal.fire({
                icon: 'error',
                title: '제목은 필수입니다.',
            });
				return;
			}
		if (content == null || content.length < 1) {
		 	Swal.fire({
                icon: 'error',
                title: '내용은 필수입니다.',
            });
				return;
			}
		
		$($("#updateQandA")).attr("method", "POST").attr("action", "/serviceCenter/updateQandA").submit();
	}
			
	
	
	$(function(){
		$("button:contains('답변')").bind("click", function(){
			fncUpdateQandA();
		});
		
		$("button:contains('수정')").bind("click", function(){
			fncUpdateQandA();
		});
		
		$("#back").bind("click", function(){
			window.history.back(-1);
		});

		
	});

	
</script>
<style>
input[type=file]::file-selector-button {
  font-family: 'Lato', sans-serif;
  font-weight: 500;
  background-color: white;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  border: solid 2px;
  box-shadow:none !important;
  outline: none;
  box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
  border-radius: 10px;
  padding: 10px;
  color: #5F0080 !important;
  font-size: 16px !important;
  text-align: center;
  }
}
table{
    box-shadow: rgb(102 51 102 / 30%) 0px 19px 38px, rgb(95 0 128 / 22%) 0px 15px 12px;
    border-radius: 20px;
    background: #c9c9ff;
}
.row {
	margin-left : 0px !important;
	   display: initial !important;
}
body{
background-color: #EBEDF0 !important;
}
textarea {
	resize: none;
}

.btn-13 {
  font-family: 'Lato', sans-serif;
  font-weight: 500;
  background-color: white;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  border: solid 2px;
  box-shadow:none !important;
  outline: none;
  box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
  border-radius: 10px;
  padding: 10px;
  color: #5F0080 !important;
  font-size: 16px !important;
  text-align: center;
}

.btn-13:hover { 
   background-color: #5F0080;
   box-shadow: rgba(102, 051, 102, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
   border-radius: 10px;
   color: white !important;
   font-size: 16px !important;
   text-align: center;
   border: solid 2px;
}



</style>

<!-- footer css -->
<style type="text/css">
body {
	position: relative;
}
</style>
</head>
<body>



	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	<%-- 채팅을 위한 소켓 --%>
	<script src="http://192.168.0.74:3000/socket.io/socket.io.js"></script>
	<%-- 채팅 js --%>
	<script src="/resources/javascript/chat/chat.js"></script>
	<%-- 채팅 css --%>
	<link rel="stylesheet" href="/resources/css/chat/chat.css" type="text/css" media="screen" title="no title">
	<%-- ///////////////////// 채팅에 필요한 코딩 //////////////////////// --%>
	
	<c:if test="${ sessionScope.user != null }">
	
		<%-- chat.js에서 사용위해서 --%>
		<input type="hidden" id="session_userId" value="${ sessionScope.user.userId }">
		<input type="hidden" id="session_profileImage" value="${ sessionScope.user.profileImage }">
		<input type="hidden" id="session_nickName" value="${ sessionScope.user.nickName }">
		<%-- chat.js에서 사용위해서 --%>
		<%-- 채팅 --%>
		<jsp:include page="/chat/chat.jsp" />
		<%-- 채팅 --%>
	
	</c:if>
	
	

<jsp:include page="/toolbar.jsp" />

<div class="page-header" align="center" style="margin-left:0 auto;">
  <h2>
	<c:if test ="${user.role == '1'}"> 
  Q&A 답변하기
  </c:if>
  <c:if test ="${user.role == '0'}"> 
  Q&A 수정하기
  </c:if>
  </h2>
</div>
	
		<div class="container" style="margin-top: 37px;">
			<form class="form-horizontal" enctype="multipart/form-data" id="updateQandA">
		 <input type="hidden" id="userId" name="qandA.userId" value ="${SessionScope.user.userId}">
			<!--  table Start /////////////////////////////////////-->
			<table style="width:880px; transform: translate(130px, 0px);box-shadow: rgb(102 51 102 / 30%) 0px 19px 38px, rgb(95 0 128 / 22%) 0px 15px 12px;
    border-radius: 20px;
    background: #c9c9ff;background-color:aliceblue;">
				</tbody>
					 <tr class = "body" id ="body" >
					 
						<th style="text-align-last: center;"></th>
						<td align="left">${qandA.qandANo}번째 질문
						<input type="hidden" name="qandANo" id="qandANo" value="${qandA.qandANo}">
						</td>
					</tr>
					<tr class = "title" id ="title">
						<th style="text-align-last: center;">제목</th>
						<td>
						<textarea class="qandATitle" id="qandATitle" name="qandATitle" value="" style="width:900px; min-height: 40px; max-height:80px;"
						maxlength="66" placeholder="제목을 입력해주세요">${qandA.qandATitle}</textarea>
					</tr>
					<tr>
						<th></th>
						<td align="left" name ="qandARegDate" id="qandARegDate"><strong>${qandA.qandARegDate }</strong>
						<strong style="margin-left: 335px;">${qandA.userId.nickName}</strong></td>
						
					</tr>
					<tr >
						<th style="text-align-last: center;">내용</th>
						<td>
						<textarea class="qandAContent" id="qandAContent" name="qandAContent" value="" style="width:900px; min-height : 150px; max-height: 800px;"
						maxlength="500" placeholder="내용을 입력해주세요">${qandA.qandAContent}</textarea></td>
						
					</tr>
					<tr >
						<th style="text-align-last: center;">첨부파일</th>
<%--파일 --%>				<!-- <td><input multiple="multiple" type="file" name="image" id="file" class="ct_input_g" style="width: 200px; height: 50px" />
						</td> -->
						<c:if test="${qandA.qandAImage1 == null && qandA.qandAImage2 ==null }">
							<td>
							<input multiple="multiple" type="file" name="image" id="file" class="ct_input_g" style="width: 200px; height: 60px" />
							
						</c:if>
						<td><c:if test="${qandA.qandAImage1 != null }">
						<input type="hidden" name="qandAImage1" id="qandAImage1" value="${qandA.qandAImage1}">
						<img src="/resources/image/uploadFiles/${qandA.qandAImage1}" 
						style="vertical-align: sub; display: inline-block; width:250px; height:250px; border: 10px solid white; border-radius: 15px;
						cursor:pointer;" onclick="window.open('/resources/image/uploadFiles/${qandA.qandAImage1}','asdfo8or','scrollbars=yes,width=417,height=385,top=10,left=20');">
						</c:if>
						<c:if test="${qandA.qandAImage2 != null }">
						<input type="hidden" name="qandAImage2" id="qandAImage2" value="${qandA.qandAImage2}">
						<img src="/resources/image/uploadFiles/${qandA.qandAImage2}" 
						style="vertical-align: sub; display: inline-block; width:250px; margin-left: 30px; height:250px; border: 10px solid white; border-radius: 15px;
						cursor:pointer;" onclick="window.open('/resources/image/uploadFiles/${qandA.qandAImage2}">
						</c:if>
						</td>
						
						<c:if test ="${user.role == '1'}"> <%--관리자--%>
					<tr>
						<th></th>
						<td align="left" name ="qandAAnswerRegDate" id="qandAAnswerRegDate"></td>
						<td/>
					</tr>
					<tr >
						<th style="text-align-last: center;">답변 내용</th>
						<td>
						<textarea class="text" id="qandAAnswerContent" name="qandAAnswerContent" value=""  
						style="width: 900px; size:400px;" >${qandA.qandAAnswerContent}</textarea>
						</td>
					</tr>
						</c:if>
					</tr>
					<tr >
						<td/>
						<c:if test="${qandA.qandAOpenCondition==0}">
						<td style ="display:flex;"> 
						<input type="radio" class="form-control" id="qandAOpenCondition" name="qandAOpenCondition" value ="0" 
						 style ="width:auto; height:auto;" checked>나만 보기</td> <td/>
						<td style ="display:flex; transform: translateX(-273px);">
						<input type="radio" class="form-control" id="qandAOpenCondition" name="qandAOpenCondition" value ="1"
							 style ="width:auto; height:auto;">전체 보기</td></c:if>
						<c:if test="${qandA.qandAOpenCondition==1}">
						<td style ="display:flex;"> 
						<input type="radio" class="form-control" id="qandAOpenCondition" name="qandAOpenCondition" value ="0" 
						 style ="width:auto; height:auto;" >나만 보기</td> <td/>
						<td style ="display:flex; transform: translateX(-273px);">
						<input type="radio" class="form-control" id="qandAOpenCondition" name="qandAOpenCondition" value ="1"
							 style ="width:auto; height:auto;" checked>전체 보기</td></c:if>
					</tr>
			</table></form>
			<!--  table End /////////////////////////////////////-->
	

 			
		
						
									<div> 

									<c:if test ="${user.role == '0'}"> <%--회원--%>
			 						 <button class="custom-btn btn-13" type="submit" style= "transform: translate(500px,0px); ">
									   수정</button></c:if>
									  <c:if test ="${user.role == '1'}"> <%--관리자--%> 
										 <button class="custom-btn btn-13" type="submit" style= "transform: translate(500px,0px); ">
									   답변</button></c:if>
									<button class="custom-btn btn-13" id="back" style= "transform: translate(500px, 0px); ">
									이전</button>

									
									</div>
				
			</div>
			
	<br><br><br><br><br><br><br><br><br><br><br><br><br><br>

	<!-- footer start -->
	<jsp:include page="/footer.jsp" />
	<!-- footer end -->

</body>

</html>