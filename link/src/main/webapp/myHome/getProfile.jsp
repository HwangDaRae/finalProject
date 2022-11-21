<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>iiii</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>

<script type="text/javascript">
$(function() {
	//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
 	
	$("#ss").on("click" , function() {
		//$(self.location).attr("href","/user/logout");
		self.location = "/myHome/updateProfile"
	}); 

 });

</script>




</head>


<body>




<p class="navbar-text">${user.nickName}</p>
<p class="navbar-text">${user.userId}</p>
<p class="navbar-text">${user.gender}</p>

<button id="ss">update</button>







</body>
</html>