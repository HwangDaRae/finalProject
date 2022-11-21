			$(function(){
			
			var naver_id_login = new naver_id_login("Ml9RKhaCexgFbiAJLp0c", "http://localhost:8080/user/loginView.jsp");
		  	var state = naver_id_login.getUniqState();
		  	naver_id_login.setButton("green", 3, 50);
		  	naver_id_login.setDomain("http://localhost:8080/");
		  	naver_id_login.setState(state);
		  	naver_id_login.init_naver_id_login();
		  	console.log(naver_id_login);
	
			naver_id_login.get_naver_userprofile("naverSignInCallback()");
			
			});