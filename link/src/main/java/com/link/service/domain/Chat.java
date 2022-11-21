package com.link.service.domain;

public class Chat {
	
	private int chatNo;
	private String userId;
	private User user;
	private String roomId;
	private String userId2;
	private User user2;
	private String currentRoomId;
	
	public Chat() {
	}

	public int getChatNo() {
		return chatNo;
	}

	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getRoomId() {
		return roomId;
	}

	public void setRoomId(String roomId) {
		this.roomId = roomId;
	}

	public String getUserId2() {
		return userId2;
	}

	public void setUserId2(String userId2) {
		this.userId2 = userId2;
	}

	public User getUser2() {
		return user2;
	}

	public void setUser2(User user2) {
		this.user2 = user2;
	}

	public String getCurrentRoomId() {
		return currentRoomId;
	}

	public void setCurrentRoomId(String currentRoomId) {
		this.currentRoomId = currentRoomId;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Chat [chatNo=");
		builder.append(chatNo);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", user=");
		builder.append(user);
		builder.append(", roomId=");
		builder.append(roomId);
		builder.append(", userId2=");
		builder.append(userId2);
		builder.append(", user2=");
		builder.append(user2);
		builder.append(", currentRoomId=");
		builder.append(currentRoomId);
		builder.append("]");
		return builder.toString();
	}
}
