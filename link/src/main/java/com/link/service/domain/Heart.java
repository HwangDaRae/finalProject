package com.link.service.domain;

public class Heart {
	
	private int heartNo;			// 좋아요 테이블 고유번호
	private String userId;			// 좋아요하는 회원 아이디
	private String source;			// 출처 0:피드, 1:피드 댓글, 2:모임게시물 3:모임게시물 댓글
	private int sourceNo;			// 출처 고유번호
	
	public Heart() {
	}

	public Heart(String userId, String source, int sourceNo) {
		super();
		this.userId = userId;
		this.source = source;
		this.sourceNo = sourceNo;
	}

	public Heart(int heartNo, String userId, String source, int sourceNo) {
		super();
		this.heartNo = heartNo;
		this.userId = userId;
		this.source = source;
		this.sourceNo = sourceNo;
	}

	public int getHeartNo() {
		return heartNo;
	}

	public void setHeartNo(int heartNo) {
		this.heartNo = heartNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public int getSourceNo() {
		return sourceNo;
	}

	public void setSourceNo(int sourceNo) {
		this.sourceNo = sourceNo;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Heart [heartNo=");
		builder.append(heartNo);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", source=");
		builder.append(source);
		builder.append(", sourceNo=");
		builder.append(sourceNo);
		builder.append("]");
		return builder.toString();
	}

}
