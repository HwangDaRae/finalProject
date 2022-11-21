<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<script src="https://code.jquery.com/jquery.js"></script>
		<script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script>		
		<script src="js/plugins.js"></script>
		<script src="js/beetle.js"></script>
		
		<!-- 사용자 정의 css -->
		<link href="/resources/css/clubPost/clubPost.css" rel="stylesheet">
		
		<!-- include libraries(jQuery, bootstrap) -->
		<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
		<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
		
		<!--  font -->
		<link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Single+Day&display=swap" rel="stylesheet">
		
		<!-- Swal 쓰기위한 cdn -->
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
		
		<!-- import.payment.js -->
		<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
		
		
	
		<!-- 템플릿에 있던 코드 -->
		<!-- <script src="https://maps.googleapis.com/maps/api/js?sensor=false"></script> -->
		<script src="/resources/javascript/plugins.js"></script>
		<script src="/resources/javascript/beetle.js"></script>
		
		
		
		<script type="text/javascript">
		$(function(){
			$("input[value='결제하기']").bind("click", function(){
				requestPayment();
			});
			$("input[value='취소하기']").bind("click", function(){
				history.go(-1);
				//location.href = "/clubPost/getClubPostList?clubNo="+${ clubNo };
			});
			
			var clubOption = ('${ returnClub.clubMaxMember }' == 0) ? true : false;
			
			$(".glyphicon.glyphicon-plus").bind("click", function(){
				
				var updateClubMemberCount = $(".payProduct-member").text();
				var updateClubCount = parseInt( $(".payProduct-club").text() );
				var totalPrice = parseInt( $(".totalPrice").text() );
				var clubNo = parseInt( ${ pay.clubNo } );
				var maxPay = ${ pay.maxPay };
				var afterPayCount = $(".after-pay-count").text();
				var afterMemberCount = $(".after-pay-member-count").text();
				
				//alert( afterMemberCount );
				//alert( maxPay );
				//alert( clubNo );			
				//alert( updateClubMemberCount );
				//alert( updateClubCount );
				//alert( totalPrice );
				
				
				//alert(clubOption);
				
				if( maxPay == totalPrice ){
					//alert(clubOption);
					if( clubOption ){
						Swal.fire({
							  icon: 'error',
							  title: '한명당 최대로 가입 할 수 있는 모임은 10개입니다'
							})
							return;
					}else{
						Swal.fire({
							  icon: 'error',
							  title: '하나의 모임당 최대 모임원은 50명입니다'
							})
							return;
					}
					
				}else{
					//alert('else');
					if( clubOption ){
						// 모임 추가
						//alert('if');
						$(".payProduct-club").text( parseInt( updateClubCount ) + 2 );
						$(".after-pay-count").text( parseInt( afterPayCount ) + 2 );
					}else{
						// 모임원 추가
						//alert('else');
						$(".payProduct-member").text( parseInt( updateClubMemberCount ) + 10 );
						$(".after-pay-member-count").text( parseInt( afterMemberCount ) + 10 );
					}
					$(".totalPrice").text( totalPrice + 5000 );
					
				}
				
			});//end of plus
			
			$(".glyphicon.glyphicon-minus").bind("click", function(){
				
				var updateClubMemberCount = $(".payProduct-member").text();
				var updateClubCount = $(".payProduct-club").text();
				var totalPrice = $(".totalPrice").text();
				var clubNo = $("input[name='clubNo']").val();
				var afterPayCount = $(".after-pay-count").text();
				var afterMemberCount = $(".after-pay-member-count").text();
				
				//alert( afterMemberCount );
				
				if( totalPrice == 5000 ){
					//alert('if');
					Swal.fire({
						  icon: 'error',
						  title: '최소 결제 금액은 5000원입니다'
						})
						return;
				}else{
					//alert('else');
					if( clubOption ){
						//alert('if');
						$(".payProduct-club").text( parseInt( updateClubCount - 2 ) );
						$(".after-pay-count").text( parseInt( afterPayCount ) - 2 );
					}else{
						//alert('else');
						//alert(updateClubMemberCount);
						$(".payProduct-member").text( updateClubMemberCount - 10 );
						$(".after-pay-member-count").text( parseInt( afterMemberCount ) - 10 );
					}
					$(".totalPrice").text( totalPrice - 5000 );
				}
				
			});//end of minus
		});
	</script>
	
	<script type="text/javascript">
		function requestPayment() {
			
			var email = "${ user.email }";
			var phoneNo = "${ user.phoneNo }";
			var totalPrice = $(".totalPrice").text();
			var payProduct = ${ returnClub == null } ? "0": "1";
			var pg = $("input[name='payOption']:checked").attr("pg");
			var pay_method = $("input[name='payOption']:checked").attr("pay_method");
			var name = payProduct===0 ? "최대 모임 수 증가" : "최대 모임원 수 증가";
			var updateClubMemberCount = $(".payProduct-member").text();
			var updateClubCount = $(".payProduct-club").text();
			
			if(pg == null){
				Swal.fire({
					icon: 'error',
					title: '결제방법을 선택해주세요',
				})
				return;
			}
			
			if( !updateClubMemberCount ){
				updateClubMemberCount = 0;
			}
			if( !updateClubCount ){
				updateClubCount = 0;
			}
			
			//alert( ${ returnUser == '' } );
			//alert( payProduct );
			
			$("input[name='payProduct']").val( payProduct );
			$("input[name='totalPrice']").val( totalPrice );
			$("input[name='updateClubMemberCount']").val( updateClubMemberCount );
			$("input[name='updateClubCount']").val( updateClubCount );
			$("input[name='clubNo']").val( ${ pay.clubNo } );		
			
			IMP.init("imp83557107"); // 가맹점 식별코드로 IMP 객체를 초기화한다
			//IMP.init("imp36216644"); // 가맹점 식별코드로 IMP 객체를 초기화한다
			
			IMP.request_pay({
					pg : pg,
					pay_method : pay_method,
					merchant_uid: 'merchant_' + new Date().getTime(), // 상점에서 관리하는 주문 번호
					name : name,
					amount : totalPrice,
					customer_uid : 'your-customer-unique-id', // 필수 입력.
					buyer_email : email,
					buyer_name : '${ user.name }',
					buyer_tel : ${ user.phoneNo }
				    //buyer_addr : '서울특별시 강남구 삼성동',
				    //buyer_postcode : '123-456'
	
			}, function(rsp) { // callback
				if (rsp.success) {
					//msg += '\n고유ID : ' + rsp.imp_uid;
	    			//msg += '\n상점 거래ID : ' + rsp.merchant_uid;
	    			msg = '결제가 성공하였습니다\n결제 금액 : ' + rsp.paid_amount + '원';
	    			//msg += '\n카드 승인번호 : ' + rsp.apply_num;
	    			//alert(msg);
	    			
	    			let timerInterval
					Swal.fire({
						title: msg,
						html: '이전 페이지로 이동합니다',
						timer: 4000,
						timerProgressBar: true,
						didOpen: () => {
							Swal.showLoading()
							const b = Swal.getHtmlContainer().querySelector('b')
							timerInterval = setInterval(() => {
								b.textContent = Swal.getTimerLeft()
							}, 100)
						},
						willClose: () => {
							clearInterval(timerInterval)
						}
					}).then((result) => {
						/* Read more about handling dismissals below */
						if (result.dismiss === Swal.DismissReason.timer) {
							//console.log('I was closed by the timer');
							$("input[name='merchant_uid']").val( rsp.merchant_uid );
			    			$("form").attr("method", "post").attr("action", "/clubPost/addPay").submit();
						}
					})
	    			
				} else {
					var msg = rsp.error_msg;
					/* Swal.fire({
						icon: 'error',
						title: msg,
					}) */
					return;
				}
			});
		}
	</script>
	
	<style type="text/css">
		.pay-main{
			border-radius: 100px;
			font-size: 20px;
			margin-top: 50px;
		}
		.pay-header{
			background-color: #f2e3ff;
			box-shadow: rgba(95, 0, 128, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
			border-radius: 10px;
			padding: 1rem;
			width: 950px;
		}
		.pay-body{
			display: grid;
			grid-template-columns: 2fr 5fr;
			box-shadow: rgba(95, 0, 128, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
			border-radius: 10px;
			padding: 1rem;
			background-color: #f2f3ff;
		}
		.glyphicon.glyphicon-plus{
			font-size: 2rem;
			box-shadow: rgba(95, 0, 128, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
			border-radius: 10px;
			margin: 1rem;
			padding: 1rem;
			width: 70px;
			background-color: white;
			color: #5F0080;
			border-color: #5F0080;
		}
		.glyphicon.glyphicon-minus{
			font-size: 2rem;
			box-shadow: rgba(95, 0, 128, 0.3) 0px 19px 38px, rgba(95, 0, 128, 0.22) 0px 15px 12px;
			border-radius: 10px;
			margin: 1rem;
			padding: 1rem;
			width: 70px;
			background-color: white;
			color: #5F0080;
			border-color: #5F0080;
		}
		.payProduct-member{
			font-size: 4rem;
		}
		.totalPrice{
			font-size: 4rem;
		}
	</style>
		
	</head>

	<body class="single single-post" style="position: relative; padding-bottom: 350px; height: 1530px;">
	
	<!-- 모임채팅 -->
	<script src="http://192.168.0.74:3000/socket.io/socket.io.js"></script>
	<!-- 채팅 javascript -->
	<script src="/resources/javascript/chat/chat.js"></script>
	<!-- 채팅 css -->
	<link rel="stylesheet" href="/resources/css/chat/chat.css" type="text/css" media="screen" title="no title">

		<!-- ToolBar Start /////////////////////////////////////-->
		<jsp:include page="/toolbar.jsp" />
		<!-- ToolBar End /////////////////////////////////////-->

		<main role="main">
			<!-- <div id="intro-wrap">
			</div> --><!-- intro-wrap -->

			<div id="main" class="row">
				
				<%-- chat.js에서 사용위해서 --%>
				<input type="hidden" id="session_userId" value="${ sessionScope.user.userId }">
				<input type="hidden" id="session_profileImage" value="${ sessionScope.user.profileImage }">
				<input type="hidden" id="session_nickName" value="${ sessionScope.user.nickName }">
				<%-- chat.js에서 사용위해서 --%>
			
				<%-- 채팅 --%>
				<jsp:include page="/chat/chat.jsp" />
				<%-- 채팅 --%>
				
				<div class="row-content buffer-left buffer-right buffer-bottom">
				
				
				
					<%-- <ul class="inline cats filter-options" style="font-size: 40px; font-size: 3rem;">
						<li data-group="advertising">
							<a href="/club/getMeetingList">모임 일정</a>
						</li>
						<li data-group="fun">
							<a href="/clubPost/getClubPostList">모임 게시물</a>
						</li>
						<li data-group="icons">
							<a href="/club/getClubMemberList">모임원</a>
						</li>
						<li data-group="infographics">
							<a href="#">모임 채팅</a>
						</li>
						<li data-group="infographics">
							<a href="/clubPost/addPayView?clubNo=${ pay.clubNo }">결제</a>
						</li>
					</ul> --%>
					
					
					
					
					
					
							
					<form name="addPayForm" method="post" action="/clubPost/addPay">
					
					
						<div class="pay-main">
							<div class="pay-header">
								<div>5000원당 결제해택<br>10명의 모임원을 추가 할 수 있다&nbsp;&nbsp;(하나의 모임당 최대 모임원수는 50명)<br>
								2개의 모임에 가입 할 수 있다&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(한명의 회원당 최대 가입 할 수 있는 모임수는 10개)</div>
							</div>
							<br>
							<div class="pay-body">
								<div class="pay-body-text">
									<div>결제방법</div><br><br><br><br><br>
									<div>모임이름</div><br>
									<div>추가 모임원 수</div><br>
									<div>총 결제금액</div>
								</div>
								<div class="pay-body-content">
									<div>
										<div><input type="radio" name="payOption" pg="danal_tpay" pay_method="card" value="0">&nbsp;&nbsp;&nbsp;&nbsp;신용카드</div>
										<div><input type="radio" name="payOption" pg="kakaopay" pay_method="card" value="1">&nbsp;&nbsp;&nbsp;&nbsp;카카오페이</div>
										<div><input type="radio" name="payOption" pg="kcp" pay_method="phone" value="2">&nbsp;&nbsp;&nbsp;&nbsp;휴대폰결제</div>
										<div><input type="radio" name="payOption" pg="tosspay" pay_method="card" value="3">&nbsp;&nbsp;&nbsp;&nbsp;토스페이</div>
										<div><input type="radio" name="payOption" pg="kcp" pay_method="trans" value="4">&nbsp;&nbsp;&nbsp;&nbsp;실시간 계좌이체</div>
									</div>
									<br>
									
									<div>
										

										<c:if test="${ returnClub == null }">
											<span style="font-size: 30px; color: #5F0080;">${ sessionScope.user.nickName }</span> 님의 결제 후 모임 수
											<span class="after-pay-count" style="font-size: 35px; color: #5F0080;"> ${ returnUser.joinClubLimit + 2 }</span>&nbsp;&nbsp;개
										</c:if>
										<c:if test="${ returnUser == null }">
											<span style="font-size: 30px; color: #5F0080;">${ returnClub.clubTitle }</span> 모임의 결제 후 모임원 수
											<span class="after-pay-member-count" style="font-size: 35px; color: #5F0080;"> ${ returnClub.clubMaxMember + 10 }</span>&nbsp;&nbsp;명
										</c:if>
										
									</div>
									<div class="pay-body-updown">
										<span class="glyphicon glyphicon-minus"></span>
										
										<%-- 모임 추가일 떄 --%>
										<c:if test="${ returnClub == null }">
											<span class="payProduct-club" style="font-size: 60px; color: #5F0080;">2</span>
											<span class="glyphicon glyphicon-plus"></span>개
										</c:if>
										
										<%-- 모임원 추가일 떄 --%>
										<c:if test="${ returnUser == null }">
											<span class="payProduct-member" style="font-size: 60px; color: #5F0080;">10</span>
											<span class="glyphicon glyphicon-plus"></span>명
										</c:if>
										
									</div>
									<div>
										<span class="totalPrice">5000</span>원
									</div>
									<div>
										<div><input type="button" class="plain button red pay" value="결제하기">&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="button" class="plain button red cancle" value="취소하기"></div>
									</div>
								</div>							
							</div>
						</div>
						
						
						
	
						<br><br><br>
						<input type="hidden" name="payProduct" value="">
						<input type="hidden" name="totalPrice" value="">
						<input type="hidden" name="merchant_uid" value="">
						<input type="hidden" name="updateClubMemberCount" value="0">
						<input type="hidden" name="updateClubCount" value="0">
						<input type="hidden" name="clubNo" value="${ pay.clubNo }">
						<input type="hidden" id="maxPay" value="${ pay.maxPay }">
						<input type="hidden" name="payNavigation" value="${ pay.payNavigation }">
					
					
					
					</form>
					
					
					
					
					
					
					
				</div><!-- row-content -->
			</div><!-- row -->
		</main><!-- main -->
				
		<!-- footer start -->
		<jsp:include page="/footer.jsp" />
		<!-- footer end -->
		
		

	</body>

</html>
