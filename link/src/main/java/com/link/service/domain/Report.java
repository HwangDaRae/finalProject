package com.link.service.domain;

import java.sql.Date;

public class Report{
	

	private int no;						// 번호
	private String title;				// 제목
	private String content;				// 내용
	private int reportSource;			// 신고 출처
	private User user1;					// 한 사람
	private User user2;					// 받은 사람
	private int reportReason;			// 신고 사유
	private int reportCondition;		// 신고 진행상황
	private Date regDate;				// 등록 날짜
	private String reportImage1;		// 신고 이미지1
	private String reportImage2;		// 신고 이미지2
	private int type;					// 신고/알림 타입
	private Club club;					// 모임
	private ClubPost clubPost;			// 모임 게시물
	private Comment comment;            // 모임 게시물 댓글
	private Feed feed;					// 피드
	private Comment feedComment; 		// 피드 댓글	
	private Live live;	  				// 라이브
	private int readingStatus;			// 읽음 여부
	
	
	/* private Chatting chatiing; */    //채팅은 안 들어감

	public Club getClub() {
		return club;
	}

	public void setClub(Club club) {
		this.club = club;
	}

	public Comment getComment() {
		return comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	public Report() {
	}

	// clubPost에서 게시물 등록시 사용
	public Report(String content, int reportSource, User user1, User user2, int type, ClubPost clubPost) {
		super();
		this.content = content;
		this.reportSource = reportSource;
		this.user1 = user1;
		this.user2 = user2;
		this.type = type;
		this.clubPost = clubPost;
	}
	
	// clubPost에서 댓글 등록시 사용
	public Report(String content, int reportSource, User user1, User user2, int type, ClubPost clubPost, Comment comment) {
		super();
		this.content = content;
		this.reportSource = reportSource;
		this.user1 = user1;
		this.user2 = user2;
		this.type = type;
		this.clubPost = clubPost;
		this.comment = comment;
	}

	public Report(String content, int reportSource, User user1, User user2, int type,
			Comment clubPostComment) {
		super();
		this.content = content;
		this.reportSource = reportSource;
		this.user1 = user1;
		this.user2 = user2;
		this.type = type;
		this.comment = clubPostComment;
	}

	public Report(int no, String title, String content, int reportSource, User user1, User user2, int reportReason,
			int reportCondition, Date regDate, String handleDate, String reportImage1, String reportImage2, int type,
			ClubPost clubPost, Comment clubPostComment, Feed feed, Comment feedComment, Live live) {
		super();
		this.no = no;
		this.title = title;
		this.content = content;
		this.reportSource = reportSource;
		this.user1 = user1;
		this.user2 = user2;
		this.reportReason = reportReason;
		this.reportCondition = reportCondition;
		this.regDate = regDate;
		this.reportImage1 = reportImage1;
		this.reportImage2 = reportImage2;
		this.type = type;
		this.clubPost = clubPost;
		this.comment = clubPostComment;
		this.feed = feed;
		this.feedComment = feedComment;
		this.live = live;
	}


	public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}


	public String getContent() {
		return content;
	}


	public void setContent(String content) {
		this.content = content;
	}


	public int getReportSource() {
		return reportSource;
	}


	public void setReportSource(int reportSource) {
		this.reportSource = reportSource;
	}


	public User getUser1() {
		return user1;
	}


	public void setUser1(User user1) {
		this.user1 = user1;
	}


	public User getUser2() {
		return user2;
	}


	public void setUser2(User user2) {
		this.user2 = user2;
	}


	public int getReportReason() {
		return reportReason;
	}


	public void setReportReason(int reportReason) {
		this.reportReason = reportReason;
	}


	public int getReportCondition() {
		return reportCondition;
	}


	public void setReportCondition(int reportCondition) {
		this.reportCondition = reportCondition;
	}


	public Date getRegDate() {
		return regDate;
	}


	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}





	public String getReportImage1() {
		return reportImage1;
	}


	public void setReportImage1(String reportImage1) {
		this.reportImage1 = reportImage1;
	}


	public String getReportImage2() {
		return reportImage2;
	}


	public void setReportImage2(String reportImage2) {
		this.reportImage2 = reportImage2;
	}


	public int getType() {
		return type;
	}


	public void setType(int type) {
		this.type = type;
	}


	public ClubPost getClubPost() {
		return clubPost;
	}


	public void setClubPost(ClubPost clubPost) {
		this.clubPost = clubPost;
	}


	public Comment getClubPostComment() {
		return comment;
	}


	public void setClubPostComment(Comment clubPostComment) {
		this.comment = clubPostComment;
	}


	public Feed getFeed() {
		return feed;
	}


	public void setFeed(Feed feed) {
		this.feed = feed;
	}


	public Comment getFeedComment() {
		return feedComment;
	}


	public void setFeedComment(Comment feedComment) {
		this.feedComment = feedComment;
	}


	public Live getLive() {
		return live;
	}


	public void setLive(Live live) {
		this.live = live;
	}


	public int getReadingStatus() {
		return readingStatus;
	}

	public void setReadingStatus(int readingStatus) {
		this.readingStatus = readingStatus;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Report [no=");
		builder.append(no);
		builder.append(", title=");
		builder.append(title);
		builder.append(", content=");
		builder.append(content);
		builder.append(", reportSource=");
		builder.append(reportSource);
		builder.append(", user1=");
		builder.append(user1);
		builder.append(", user2=");
		builder.append(user2);
		builder.append(", reportReason=");
		builder.append(reportReason);
		builder.append(", reportCondition=");
		builder.append(reportCondition);
		builder.append(", regDate=");
		builder.append(regDate);
		builder.append(", reportImage1=");
		builder.append(reportImage1);
		builder.append(", reportImage2=");
		builder.append(reportImage2);
		builder.append(", type=");
		builder.append(type);
		builder.append(", club=");
		builder.append(club);
		builder.append(", clubPost=");
		builder.append(clubPost);
		builder.append(", comment=");
		builder.append(comment);
		builder.append(", feed=");
		builder.append(feed);
		builder.append(", feedComment=");
		builder.append(feedComment);
		builder.append(", live=");
		builder.append(live);
		builder.append(", readingStatus=");
		builder.append(readingStatus);
		builder.append("]");
		return builder.toString();
	}
	
}
