package com.link.service.domain;

import java.sql.Date;

public class Notice {
	
	private int noticeNo;					//공지사항 번호
	private String noticeTitle;				//공지사항 제목
	private String noticeContent;			//공지사하 내용
	private String noticeImage1;			//공지사항 이미지1
	private String noticeImage2;			//공지사항 이미지2
	private Date noticeRegDate;				//공지사항 등록날짜
	private int noticeCount;				//공지사항 조회수
	private User userId;					//공지사항 작성자
	
	public Notice() {
	}

	public Notice(int noticeNo, String noticeTitle, String noticeContent, String noticeImage1, String noticeImage2,
			Date noticeRegDate, int noticeCount, User userId) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeImage1 = noticeImage1;
		this.noticeImage2 = noticeImage2;
		this.noticeRegDate = noticeRegDate;
		this.noticeCount = noticeCount;
		this.userId = userId;

	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getNoticeImage1() {
		return noticeImage1;
	}

	public void setNoticeImage1(String noticeImage1) {
		this.noticeImage1 = noticeImage1;
	}

	public String getNoticeImage2() {
		return noticeImage2;
	}

	public void setNoticeImage2(String noticeImage2) {
		this.noticeImage2 = noticeImage2;
	}

	public Date getNoticeRegDate() {
		return noticeRegDate;
	}


	public void setNoticeRegDate(Date noticeRegDate) {

		this.noticeRegDate = noticeRegDate;
	}

	public int getNoticeCount() {
		return noticeCount;
	}

	public void setNoticeCount(int noticeCount) {
		this.noticeCount = noticeCount;
	}

	public User getUserId() {
		return userId;
	}

	public void setUserId(User userId) {
		this.userId = userId;
	}


	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Notice [noticeNo=");
		builder.append(noticeNo);
		builder.append(", noticeTitle=");
		builder.append(noticeTitle);
		builder.append(", noticeContent=");
		builder.append(noticeContent);
		builder.append(", noticeImage1=");
		builder.append(noticeImage1);
		builder.append(", noticeImage2=");
		builder.append(noticeImage2);
		builder.append(", noticeRegDate=");
		builder.append(noticeRegDate);
		builder.append(", noticeCount=");
		builder.append(noticeCount);
		builder.append(", userId=");
		builder.append(userId);
		builder.append("]");
		return builder.toString();
	}
	
}