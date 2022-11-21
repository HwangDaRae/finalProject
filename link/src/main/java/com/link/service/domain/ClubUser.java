package com.link.service.domain;

import java.sql.Date;

public class ClubUser {
	
	private int clubUserNo;
	private int clubNo;
	private User user;
	private Date applicationRegDate;
	private Date joinRegDate;
	private Date logoutDate;
	private String memberRole;
	private String approvalCondition;
	private String joinGreeting;
//	private String nickName;
	private Club club;
	private String roomId;
	

	public Club getClub() {
		return club;
	}


	public void setClub(Club club) {
		this.club = club;
	}


	public ClubUser() {
		// TODO Auto-generated constructor stub
	}


	public int getClubUserNo() {
		return clubUserNo;
	}


	public void setClubUserNo(int clubUserNo) {
		this.clubUserNo = clubUserNo;
	}


	public int getClubNo() {
		return clubNo;
	}
	
	public void setClubNo(int clubNo) {
		this.clubNo = clubNo;
	}
	
	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getApplicationRegDate() {
		return applicationRegDate;
	}

	public void setApplicationRegDate(Date applicationRegDate) {
		this.applicationRegDate = applicationRegDate;
	}

	public Date getJoinRegDate() {
		return joinRegDate;
	}

	public void setJoinRegDate(Date joinRegDate) {
		this.joinRegDate = joinRegDate;
	}

	public Date getLogoutDate() {
		return logoutDate;
	}

	public void setLogoutDate(Date logoutDate) {
		this.logoutDate = logoutDate;
	}

	public String getMemberRole() {
		return memberRole;
	}

	public void setMemberRole(String memberRole) {
		this.memberRole = memberRole;
	}

	public String getApprovalCondition() {
		return approvalCondition;
	}

	public void setApprovalCondition(String approvalCondition) {
		this.approvalCondition = approvalCondition;
	}

	public String getJoinGreeting() {
		return joinGreeting;
	}

	public void setJoinGreeting(String joinGreeting) {
		this.joinGreeting = joinGreeting;
	}


	public String getRoomId() {
		return roomId;
	}


	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}


	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ClubUser [clubUserNo=");
		builder.append(clubUserNo);
		builder.append(", clubNo=");
		builder.append(clubNo);
		builder.append(", user=");
		builder.append(user);
		builder.append(", applicationRegDate=");
		builder.append(applicationRegDate);
		builder.append(", joinRegDate=");
		builder.append(joinRegDate);
		builder.append(", logoutDate=");
		builder.append(logoutDate);
		builder.append(", memberRole=");
		builder.append(memberRole);
		builder.append(", approvalCondition=");
		builder.append(approvalCondition);
		builder.append(", joinGreeting=");
		builder.append(joinGreeting);
		builder.append(", club=");
		builder.append(club);
		builder.append(", roomId=");
		builder.append(roomId);
		builder.append("]");
		return builder.toString();
	}

	

}
