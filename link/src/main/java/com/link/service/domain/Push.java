package com.link.service.domain;

public class Push {
	
	private User user;
	private Club club;
	private ClubPost clubPost;
	private Feed feed;
	private Comment comment;
	private String type;	// 1 : 신고 - 2 : 알림
	private String content;	// 내용
	private int flag;		// 예비

	public Push() {
		// TODO Auto-generated constructor stub
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Club getClub() {
		return club;
	}

	public void setClub(Club club) {
		this.club = club;
	}

	public ClubPost getClubPost() {
		return clubPost;
	}

	public void setClubPost(ClubPost clubPost) {
		this.clubPost = clubPost;
	}

	public Feed getFeed() {
		return feed;
	}

	public void setFeed(Feed feed) {
		this.feed = feed;
	}

	public Comment getComment() {
		return comment;
	}

	public void setComment(Comment comment) {
		this.comment = comment;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Push [user=");
		builder.append(user);
		builder.append(", club=");
		builder.append(club);
		builder.append(", clubPost=");
		builder.append(clubPost);
		builder.append(", feed=");
		builder.append(feed);
		builder.append(", comment=");
		builder.append(comment);
		builder.append(", type=");
		builder.append(type);
		builder.append(", content=");
		builder.append(content);
		builder.append(", flag=");
		builder.append(flag);
		builder.append("]");
		return builder.toString();
	}

}
