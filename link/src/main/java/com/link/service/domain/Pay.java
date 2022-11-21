package com.link.service.domain;

public class Pay {
	
	private int payNo;						// 결제번호
	private User user;						// 결제한 회원 정보
	private int clubNo;						// 모임번호
	private String payProduct;				// 결제상품 - 0 : 모임 추가, 1 : 모임원 추가
	private String payOption;				// 결제방법 - 0 : 신용카드, 1 : 카카오페이, 2 : 휴대폰결제, 3 : 토스페이, 4 : 실시간계좌이체
	private int totalPrice;					// 총 결제금액
	private String payRegDate;				// 결제날짜
	private int updateClubCount;			// 모임 추가 수
	private int updateClubMemberCount;		// 모임원 추가 수
	private String merchant_uid;			// 주문번호
	private int maxPay;						// 최대결제금액
	private int payNavigation;				// 어디에서 왔는지 - 1 : 모임상세보기

	public Pay() {
	}

	public Pay(int payNo, User user, int clubNo, String payProduct, String payOption, int totalPrice, String payRegDate,
			int updateClubCount, int updateClubMemberCount, String merchant_uid, int maxPay) {
		super();
		this.payNo = payNo;
		this.user = user;
		this.clubNo = clubNo;
		this.payProduct = payProduct;
		this.payOption = payOption;
		this.totalPrice = totalPrice;
		this.payRegDate = payRegDate;
		this.updateClubCount = updateClubCount;
		this.updateClubMemberCount = updateClubMemberCount;
		this.merchant_uid = merchant_uid;
		this.maxPay = maxPay;
	}

	public int getPayNo() {
		return payNo;
	}

	public void setPayNo(int payNo) {
		this.payNo = payNo;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getClubNo() {
		return clubNo;
	}

	public void setClubNo(int clubNo) {
		this.clubNo = clubNo;
	}

	public String getPayProduct() {
		return payProduct;
	}

	public void setPayProduct(String payProduct) {
		this.payProduct = payProduct;
	}

	public String getPayOption() {
		return payOption;
	}

	public void setPayOption(String payOption) {
		this.payOption = payOption;
	}

	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public String getPayRegDate() {
		return payRegDate;
	}

	public void setPayRegDate(String payRegDate) {
		this.payRegDate = payRegDate;
	}

	public int getUpdateClubCount() {
		return updateClubCount;
	}

	public void setUpdateClubCount(int updateClubCount) {
		this.updateClubCount = updateClubCount;
	}

	public int getUpdateClubMemberCount() {
		return updateClubMemberCount;
	}

	public void setUpdateClubMemberCount(int updateClubMemberCount) {
		this.updateClubMemberCount = updateClubMemberCount;
	}

	public String getMerchant_uid() {
		return merchant_uid;
	}

	public void setMerchant_uid(String merchant_uid) {
		this.merchant_uid = merchant_uid;
	}

	public int getMaxPay() {
		return maxPay;
	}

	public void setMaxPay(int maxPay) {
		this.maxPay = maxPay;
	}

	public int getPayNavigation() {
		return payNavigation;
	}

	public void setPayNavigation(int payNavigation) {
		this.payNavigation = payNavigation;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Pay [payNo=");
		builder.append(payNo);
		builder.append(", user=");
		builder.append(user);
		builder.append(", clubNo=");
		builder.append(clubNo);
		builder.append(", payProduct=");
		builder.append(payProduct);
		builder.append(", payOption=");
		builder.append(payOption);
		builder.append(", totalPrice=");
		builder.append(totalPrice);
		builder.append(", payRegDate=");
		builder.append(payRegDate);
		builder.append(", updateClubCount=");
		builder.append(updateClubCount);
		builder.append(", updateClubMemberCount=");
		builder.append(updateClubMemberCount);
		builder.append(", merchant_uid=");
		builder.append(merchant_uid);
		builder.append(", maxPay=");
		builder.append(maxPay);
		builder.append(", payNavigation=");
		builder.append(payNavigation);
		builder.append("]");
		return builder.toString();
	}

}
