package com.link.service.domain;

import java.sql.Date;

public class Club {

	private int clubNo;
	private User user;
	private String clubTitle;
	private String clubDetail;
	private Date clubRegDate;
	private String clubImage;
	private int currentMember;
	private int clubMaxMember;
	private String clubCategory;
	private String clubArea;
	private String approvalCondition;
	private int currentPage;
	private String roomId;
	private String deleteCondition;
	
	public String getApprovalCondition() {
		return approvalCondition;
	}
	public void setApprovalCondition(String approvalCondition) {
		this.approvalCondition = approvalCondition;
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
	public String getClubTitle() {
		return clubTitle;
	}
	public void setClubTitle(String clubTitle) {
		this.clubTitle = clubTitle;
	}
	public String getClubDetail() {
		return clubDetail;
	}
	public void setClubDetail(String clubDetail) {
		this.clubDetail = clubDetail;
	}
	public Date getClubRegDate() {
		return clubRegDate;
	}
	public void setClubRegDate(Date clubRegDate) {
		this.clubRegDate = clubRegDate;
	}
	public String getClubImage() {
		return clubImage;
	}
	public void setClubImage(String clubImage) {
		this.clubImage = clubImage;
	}
	public int getCurrentMember() {
		return currentMember;
	}
	public void setCurrentMember(int currentMember) {
		this.currentMember = currentMember;
	}
	public int getClubMaxMember() {
		return clubMaxMember;
	}
	public void setClubMaxMember(int clubMaxMember) {
		this.clubMaxMember = clubMaxMember;
	}
	public String getClubCategory() {
		return clubCategory;
	}
	public void setClubCategory(String clubCategory) {
		this.clubCategory = clubCategory;
	}
	public String getClubArea() {
		return clubArea;
	}
	public void setClubArea(String clubArea) {
		this.clubArea = clubArea;
	}
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public String getRoomId() {
		return roomId;
	}
	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}
	public String getDeleteCondition() {
		return deleteCondition;
	}
	public void setDeleteCondition(String deleteCondition) {
		this.deleteCondition = deleteCondition;
	}
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Club [clubNo=");
		builder.append(clubNo);
		builder.append(", user=");
		builder.append(user);
		builder.append(", clubTitle=");
		builder.append(clubTitle);
		builder.append(", clubDetail=");
		builder.append(clubDetail);
		builder.append(", clubRegDate=");
		builder.append(clubRegDate);
		builder.append(", clubImage=");
		builder.append(clubImage);
		builder.append(", currentMember=");
		builder.append(currentMember);
		builder.append(", clubMaxMember=");
		builder.append(clubMaxMember);
		builder.append(", clubCategory=");
		builder.append(clubCategory);
		builder.append(", clubArea=");
		builder.append(clubArea);
		builder.append(", approvalCondition=");
		builder.append(approvalCondition);
		builder.append(", currentPage=");
		builder.append(currentPage);
		builder.append(", roomId=");
		builder.append(roomId);
		builder.append(", deleteCondition=");
		builder.append(deleteCondition);
		builder.append("]");
		return builder.toString();
	}

}
