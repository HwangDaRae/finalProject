package com.link.service.domain;

import java.sql.Date;

public class QandA {
	
	private int qandANo;				//Q&A 번호
	private String qandATitle;			//Q&A 제목
	private String qandAContent;		//Q&A 내용
	private User userId;				//Q&A 이용자
	private Date qandARegDate;		//Q&A 등록날짜
	private String qandAImage1;			//Q&A 이미지1
	private String qandAImage2;			//Q&A 이미지2
	private int qandACondition;			//Q&A 진행상황
	private String qandAAnswerContent;	//Q&A 답변내용
	private Date qandAAnswerRegDate;	//Q&A 답변등록날짜
	private int qandAOpenCondition;		//Q&A 공개여부
	
	
	
	

	public int getQandANo() {
		return qandANo;
	}
	public void setQandANo(int qandANo) {
		this.qandANo = qandANo;
	}
	public String getQandATitle() {
		return qandATitle;
	}
	public void setQandATitle(String qandATitle) {
		this.qandATitle = qandATitle;
	}
	public String getQandAContent() {
		return qandAContent;
	}
	public void setQandAContent(String qandAContent) {
		this.qandAContent = qandAContent;
	}
	public User getUserId() {
		return userId;
	}
	public void setUserId(User userId) {
		this.userId = userId;
	}
	public Date getQandARegDate() {
		return qandARegDate;
	}
	public void setQandARegDate(Date qandARegDate) {
		this.qandARegDate = qandARegDate;
	}
	public String getQandAImage1() {
		return qandAImage1;
	}
	public void setQandAImage1(String qandAImage1) {
		this.qandAImage1 = qandAImage1;
	}
	public String getQandAImage2() {
		return qandAImage2;
	}
	public void setQandAImage2(String qandAImage2) {
		this.qandAImage2 = qandAImage2;
	}
	public int getQandACondition() {
		return qandACondition;
	}
	public void setQandACondition(int qandACondition) {
		this.qandACondition = qandACondition;
	}
	public String getQandAAnswerContent() {
		return qandAAnswerContent;
	}
	public void setQandAAnswerContent(String qandAAnswerContent) {
		this.qandAAnswerContent = qandAAnswerContent;
	}
	public Date getQandAAnswerRegDate() {
		return qandAAnswerRegDate;
	}
	public void setQandAAnswerRegDate(Date qandAAnswerRegDate) {
		this.qandAAnswerRegDate = qandAAnswerRegDate;
	}
	public int getQandAOpenCondition() {
		return qandAOpenCondition;
	}
	public void setQandAOpenCondition(int qandAOpenCondition) {
		this.qandAOpenCondition = qandAOpenCondition;
	}
	
	
	@Override
	public String toString() {
		return "QandA [qandANo=" + qandANo + ", qandATitle=" + qandATitle + ", qandAContent=" + qandAContent + ", userId="
				+ userId + ", qandARegDate=" + qandARegDate + ", qandAImage1=" + qandAImage1 + ", qandAImage2="
				+ qandAImage2 + ", qandACondition=" + qandACondition + ", qandAAnswerContent=" + qandAAnswerContent
				+ ", qandAAnswerRegDate=" + qandAAnswerRegDate + ", qandAOpenCondition=" + qandAOpenCondition
				  + "]";
	}
	
	

}
