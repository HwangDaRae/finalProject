package com.link.service.domain;

import java.sql.Date;
import java.sql.Timestamp;

public class Feed {

	private int feedNo;				// 피드 번호
	private User user;				// 회원 아이디
	private int openCondition;		// 공개 여부
	private String content;
	private String image1;
	private String image2;
	private String image3;
	private String image4;
	private String video;
	private String hashtag;
	private int heartCount;
	private int commentCount;
	private Timestamp regDate;
	private Timestamp updateDate;
	private int reportCondition;
	private int deleteCondition;
	private int checkHeart;			// -1 	: 추가,		-2 : 취소
	private int checkMyHome;		// 1	: myHome 호출
	private int checkComment;
	private int currentPage;
	private String searchKeyword;
	private String fullContent;
	
	public Feed() {
		// TODO Auto-generated constructor stub
	}
	
	public int getFeedNo() {
		return feedNo;
	}

	public void setFeedNo(int feedNo) {
		this.feedNo = feedNo;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public int getOpenCondition() {
		return openCondition;
	}

	public void setOpenCondition(int openCondition) {
		this.openCondition = openCondition;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getImage1() {
		return image1;
	}

	public void setImage1(String image1) {
		this.image1 = image1;
	}

	public String getImage2() {
		return image2;
	}

	public void setImage2(String image2) {
		this.image2 = image2;
	}

	public String getImage3() {
		return image3;
	}

	public void setImage3(String image3) {
		this.image3 = image3;
	}

	public String getImage4() {
		return image4;
	}

	public void setImage4(String image4) {
		this.image4 = image4;
	}

	public String getVideo() {
		return video;
	}

	public void setVideo(String video) {
		this.video = video;
	}

	public String getHashtag() {
		return hashtag;
	}

	public void setHashtag(String hashtag) {
		this.hashtag = hashtag;
	}

	public int getHeartCount() {
		return heartCount;
	}

	public void setHeartCount(int heartCount) {
		this.heartCount = heartCount;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	public Timestamp getRegDate() {
		return regDate;
	}

	public void setRegDate(Timestamp regDate) {
		this.regDate = regDate;
	}

	public Timestamp getUpdateDate() {
		return updateDate;
	}

	public void setUpdateDate(Timestamp updateDate) {
		this.updateDate = updateDate;
	}

	public int getReportCondition() {
		return reportCondition;
	}

	public void setReportCondition(int reportCondition) {
		this.reportCondition = reportCondition;
	}

	public int getDeleteCondition() {
		return deleteCondition;
	}

	public void setDeleteCondition(int deleteCondition) {
		this.deleteCondition = deleteCondition;
	}

	public int getCheckHeart() {
		return checkHeart;
	}

	public void setCheckHeart(int checkHeart) {
		this.checkHeart = checkHeart;
	}

	public int getCheckMyHome() {
		return checkMyHome;
	}

	public void setCheckMyHome(int checkMyHome) {
		this.checkMyHome = checkMyHome;
	}

	public int getCheckComment() {
		return checkComment;
	}

	public void setCheckComment(int checkComment) {
		this.checkComment = checkComment;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getSearchKeyword() {
		return searchKeyword;
	}

	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	public String getFullContent() {
		return fullContent;
	}

	public void setFullContent(String fullContent) {
		this.fullContent = fullContent;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Feed [feedNo=");
		builder.append(feedNo);
		builder.append(", user=");
		builder.append(user);
		builder.append(", openCondition=");
		builder.append(openCondition);
		builder.append(", content=");
		builder.append(content);
		builder.append(", image1=");
		builder.append(image1);
		builder.append(", image2=");
		builder.append(image2);
		builder.append(", image3=");
		builder.append(image3);
		builder.append(", image4=");
		builder.append(image4);
		builder.append(", video=");
		builder.append(video);
		builder.append(", hashtag=");
		builder.append(hashtag);
		builder.append(", heartCount=");
		builder.append(heartCount);
		builder.append(", commentCount=");
		builder.append(commentCount);
		builder.append(", regDate=");
		builder.append(regDate);
		builder.append(", updateDate=");
		builder.append(updateDate);
		builder.append(", reportCondition=");
		builder.append(reportCondition);
		builder.append(", deleteCondition=");
		builder.append(deleteCondition);
		builder.append(", checkHeart=");
		builder.append(checkHeart);
		builder.append(", checkMyHome=");
		builder.append(checkMyHome);
		builder.append(", checkComment=");
		builder.append(checkComment);
		builder.append(", currentPage=");
		builder.append(currentPage);
		builder.append(", searchKeyword=");
		builder.append(searchKeyword);
		builder.append(", fullContent=");
		builder.append(fullContent);
		builder.append("]");
		return builder.toString();
	}

}
