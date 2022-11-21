<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>


<!DOCTYPE html>

<html lang="ko">

<head>
<meta charset="UTF-8">

<!-- 참조 : http://getbootstrap.com/css/   참조 -->
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<!-- Bootstrap Dropdown Hover CSS -->
<!-- <link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet"> -->

<!-- Bootstrap Dropdown Hover JS -->
<!-- <script src="/javascript/bootstrap-dropdownhover.min.js"></script> -->
<!-- calendar.js -->
<script type="text/javascript" src="/javascript/calendar.js"></script>
<!-- import.payment.js -->
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>

<!--  ///////////////////////// JavaScript ////////////////////////// -->
<!-- import를 사용하기 위함 -->

<script type="text/javascript">
	$(function(){
		$("input[value='결제하기']").bind("click", function(){
			requestPayment();
		});
		$("input[value='취소하기']").bind("click", function(){
			history.go(-1);
		});
		
		$(".plus").bind("click", function(){
			
			//var updateClubMemberCount = parseInt( $(".payProduct-member").text() );
			var updateClubMemberCount = $(".payProduct-member").text();
			var updateClubCount = parseInt( $(".payProduct-club").text() );
			var totalPrice = parseInt( $(".totalPrice").text() );
			var clubNo = $("input[name='clubNo']").val();
			var maxPay = $("#maxPay").val();
			
			//alert( maxPay );
			//alert( clubNo );			
			//alert( updateClubMemberCount );
			//alert( updateClubCount );
			//alert( totalPrice );
			
			if( maxPay == totalPrice ){
				alert('if');
				${ pay.clubNo } == 0 ? $(".result").text( "한명당 최대로 가입 할 수 있는 모임은 10개입니다" ): $(".result").text( "하나의 모임당 최대 모임원은 50명입니다" );
			}else{
				alert('else');
				if( clubNo != 0 ){
					// 회원이 모입가입신청 했을때
					alert('if');
					$(".payProduct-club").text( parseInt( updateClubCount ) + 2 );
					$(".return-club-limit").text( parseInt( $(".return-club-limit").text() ) + 2 );
				}else{
					alert('else');
					$(".payProduct-member").text( updateClubMemberCount + 10 );
					$(".return-max-member").text( parseInt( $(".return-max-member").text() ) + 10 );
				}
				$(".totalPrice").text( totalPrice + 5000 );
				$(".result").text( "" );
			}
			
		});//end of plus
		
		$(".minus").bind("click", function(){
			
			var updateClubMemberCount = $(".payProduct-member").text();
			var updateClubCount = $(".payProduct-club").text();
			var totalPrice = $(".totalPrice").text();
			var clubNo = $("input[name='clubNo']").val();
			var max_member = $(".return-max-member").text();
			
			if( totalPrice == 5000 ){
				alert('if');
				$(".result").text( "최소 결제 금액은 5000원입니다" );
			}else{
				alert('else');
				if( clubNo == 0 ){
					alert('if');
					$(".payProduct-club").text( parseInt( updateClubCount - 2 ) );
					$(".return-club-limit").text( parseInt( $(".return-club-limit").text() ) - 2 );
				}else{
					alert('else');
					alert(updateClubMemberCount);
					alert(max_member);
					$(".payProduct-member").text( updateClubMemberCount - 10 );
					$(".return-max-member").text( parseInt( max_member ) - 10 );
				}
				$(".totalPrice").text( totalPrice - 5000 );
				$(".result").text( "" );
			}
			
		});//end of minus
	});
</script>

<script type="text/javascript">
	function requestPayment() {
		//alert('여기로 오나?');
		
		var email = "${ user.email }";
		var phoneNo = "${ user.phoneNo }";
		var totalPrice = $(".totalPrice").text();
		var payProduct = ${ pay.clubNo != 0 && pay.payNavigation != 1 } ? "모임원 추가": "모임 추가";
		var pg = $("input[name='payOption']:checked").attr("pg");
		var pay_method = $("input[name='payOption']:checked").attr("pay_method");
		var name = payProduct===0 ? "최대 모임 수 증가" : "최대 모임원 수 증가";
		var updateClubMemberCount = $(".payProduct-member").text();
		var updateClubCount = $(".payProduct-club").text();
		
		if( !updateClubMemberCount ){
			updateClubMemberCount = 0;
		}
		if( !updateClubCount ){
			updateClubCount = 0;
		}
		
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
				buyer_name : '상디',
				buyer_tel : ${ user.phoneNo }
			    //buyer_addr : '서울특별시 강남구 삼성동',
			    //buyer_postcode : '123-456'

		}, function(rsp) { // callback
			if (rsp.success) {
				msg += '\n고유ID : ' + rsp.imp_uid;
    			msg += '\n상점 거래ID : ' + rsp.merchant_uid;
    			msg += '\n결제 금액 : ' + rsp.paid_amount;
    			msg += '\n카드 승인번호 : ' + rsp.apply_num;
    			alert(msg);
    			$("input[name='merchant_uid']").val( rsp.merchant_uid );
    			$("form").attr("method", "post").attr("action", "/clubPost/addPay").submit();
			} else {
				var msg = '결제에 실패하였습니다.';
				msg += '에러내용 : ' + rsp.error_msg;
				alert(msg);
			}
		});
	}
</script>

</head>

<body>
	<form name="addPayForm" method="post" action="/clubPost/addPay">
	
		<input type="text" name="payProduct" value="">
		<input type="text" name="totalPrice" value="">
		<input type="text" name="merchant_uid" value="">
		<input type="text" name="updateClubMemberCount" value="0">
		<input type="text" name="updateClubCount" value="0">
		<input type="text" name="clubNo" value="${ pay.clubNo }">
		<input type="text" id="maxPay" value="${ pay.maxPay }">
		<input type="text" name="payNavigation" value="${ pay.payNavigation }">
		</br></br></br>
		
		<!--  화면구성 div Start /////////////////////////////////////-->
		<div class="pay-view">
		
			<div class="pay-payOption">				
				결제방법&nbsp;&nbsp;:&nbsp;&nbsp;
				<input type="radio" name="payOption" pg="danal_tpay" pay_method="card" value="신용카드">신용카드
				<input type="radio" name="payOption" pg="kakaopay" pay_method="card" value="카카오페이">카카오페이
				<input type="radio" name="payOption" pg="kcp" pay_method="phone" value="휴대폰결제">휴대폰결제
				<input type="radio" name="payOption" pg="tosspay" pay_method="card" value="토스페이">토스페이
				<input type="radio" name="payOption" pg="kcp" pay_method="trans" value="실시간 계좌이체">실시간 계좌이체
				</br></br>

				<c:choose>
					<c:when test="${ pay.clubNo != 0 && pay.payNavigation != 1  }">결제 후 해당 모임의 총 모임원수는 <b class="return-max-member">${ returnClub.clubMaxMember + 10 }</b>명</c:when><%-- 모임원리스트로 --%>
					<c:when test="${ pay.clubNo == 0 && pay.payNavigation != 1 }">결제 후 해당 회원의 총 모임수는 <b class="return-club-limit">${ returnUser.joinClubLimit + 2 }</b>개방</c:when><%-- 모임리스트로 이동 --%>
					<c:when test="${ pay.clubNo != 0 && pay.payNavigation == 1 }">결제 후 해당 회원의 총 모임수는 <b class="return-club-limit">${ returnUser.joinClubLimit + 2 }</b>개방</c:when><%-- 모임상세보기로 이동 --%>
				</c:choose>
			</div>
			</br>
			
			
			<div class="pay-payProduct">
			&nbsp;&nbsp;<b class="plus">+</b>
				<c:choose>
					<c:when test="${ pay.clubNo != 0 && pay.payNavigation != 1 }">추가할 모임원 수<b class="payProduct-member">10</b>명</c:when><%-- 모임원리스트로 --%>
					<c:when test="${ pay.clubNo == 0 && pay.payNavigation != 1 }">추가할 모임 수<b class="payProduct-club">2</b>개방</c:when><%-- 모임리스트로 이동 --%>
					<c:when test="${ pay.clubNo != 0 && pay.payNavigation == 1 }">추가할 모임 수<b class="payProduct-club">2</b>개방</c:when><%-- 모임상세보기로 이동 --%>
				</c:choose>
			<b class="minus">-</b>
			<b class="result"></b>
			</div>
			</br>
			
			<div class="pay-totalPrice">
				총 결제금액 : <b class="totalPrice">5000</b>원
			</div>
			</br>
			
			<div>
				<input type="button" value="결제하기">
				<input type="button" value="취소하기">
			</div>
		
		</div>
		<!--  화면구성 div Start /////////////////////////////////////-->
	</form>

</body>

</html>


