package com.link.service.domain;

import java.sql.Date;

public class Meeting {

	private int meetingNo;
	private int clubNo;
//	private Club club;
	private User user;
	private String meetingTitle;
	private String meetingDate;
	private String meetingTime;
	private String meetingPlace;
	private String meetingWeather;
	private Date meetingRegDate;
	private int meetingMember;
	private int meetingMaximumMember;
	private String meetingContent;
		
	public Meeting() {
		// TODO Auto-generated constructor stub
	}

	public int getMeetingNo() {
		return meetingNo;
	}

	public void setMeetingNo(int meetingNo) {
		this.meetingNo = meetingNo;
	}

	public int getClubNo() {
		return clubNo;
	}

	public void setClubNo(int clubNo) {
		this.clubNo = clubNo;
	}

//	public Club getClub() {
//		return club;
//	}
//
//	public void setClub(Club club) {
//		this.club = club;
//	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getMeetingTitle() {
		return meetingTitle;
	}

	public void setMeetingTitle(String meetingTitle) {
		this.meetingTitle = meetingTitle;
	}

	public String getMeetingDate() {
		return meetingDate;
	}

	public void setMeetingDate(String meetingDate) {
		this.meetingDate = meetingDate;
	}

	public String getMeetingTime() {
		return meetingTime;
	}

	public void setMeetingTime(String meetingTime) {
		this.meetingTime = meetingTime;
	}

	public String getMeetingPlace() {
		return meetingPlace;
	}

	public void setMeetingPlace(String meetingPlace) {
		this.meetingPlace = meetingPlace;
	}

	public String getMeetingWeather() {
		return meetingWeather;
	}

	public void setMeetingWeather(String meetingWeather) {
		this.meetingWeather = meetingWeather;
	}

	public Date getMeetingRegDate() {
		return meetingRegDate;
	}

	public void setMeetingRegDate(Date meetingRegDate) {
		this.meetingRegDate = meetingRegDate;
	}

	public int getMeetingMember() {
		return meetingMember;
	}

	public void setMeetingMember(int meetingMember) {
		this.meetingMember = meetingMember;
	}

	public int getMeetingMaximumMember() {
		return meetingMaximumMember;
	}

	public void setMeetingMaximumMember(int meetingMaximumMember) {
		this.meetingMaximumMember = meetingMaximumMember;
	}

	public String getMeetingContent() {
		return meetingContent;
	}

	public void setMeetingContent(String meetingContent) {
		this.meetingContent = meetingContent;
	}

	@Override
	public String toString() {
		return "Meeting [meetingNo=" + meetingNo + ", clubNo=" + clubNo + ",  user=" + user
				+ ", meetingTitle=" + meetingTitle + ", meetingDate=" + meetingDate + ", meetingTime=" + meetingTime
				+ ", meetingPlace=" + meetingPlace + ", meetingWeather=" + meetingWeather + ", meetingRegDate="
				+ meetingRegDate + ", meetingMember=" + meetingMember + ", meetingMaximumMember=" + meetingMaximumMember
				+ ", meetingContent=" + meetingContent + "]";
	}

	
}
