package com.link.service.domain;

public class Live {

	private String roomName;
	private String viewRoomName;
	private String profileImage;
	private int limit;
	private int member;
	private String type;
	private int clubNo;

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
		
		if(roomName != null && roomName != "") {
			this.viewRoomName = roomName.split(":")[1];
		}
	}

	public String getViewRoomName() {
		return viewRoomName;
	}

	public void setViewRoomName(String viewRoomName) {
		this.viewRoomName = viewRoomName;
	}

	public String getProfileImage() {
		return profileImage;
	}

	public void setProfileImage(String profileImage) {
		this.profileImage = profileImage;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public int getMember() {
		return member;
	}

	public void setMember(int member) {
		this.member = member;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	public int getClubNo() {
		return clubNo;
	}

	public void setClubNoint (int clubNo) {  
		this.clubNo = clubNo;
	}

	@Override
	public String toString() {
		return "Live [roomName=" + roomName + ", viewRoomName=" + viewRoomName + ", profileImage=" + profileImage
				+ ", limit=" + limit + ", member=" + member + ", type=" + type + ", clubNo=" + clubNo + "]";
	}

}
