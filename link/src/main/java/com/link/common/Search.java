package com.link.common;


public class Search {
	
	private int currentPage;
	private String searchCondition;
	private String searchKeyword;
	private int pageUnit;
	private int pageSize;
	private int order;
	private int startRowNum;
	private int endRowNum;
	private String userId;
	private String clubCategory;
	private String clubArea;
	
	public Search(){
		
	}

	public Search(String searchKeyword) {
		super();
		this.searchKeyword = searchKeyword;
	}

	// ClubPost에서 사용
	public Search(int currentPage, String searchCondition, String searchKeyword, int pageSize, int order) {
		super();
		this.currentPage = currentPage;
		this.searchCondition = searchCondition;
		this.searchKeyword = searchKeyword;
		this.pageSize = pageSize;
		this.order = order;
	}

	public int getPageUnit() {
		return pageUnit;
	}
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	
	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	public String getSearchKeyword() {
		return searchKeyword;
	}
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

	public int getStartRowNum() {
		return ((getCurrentPage() - 1) * getPageSize() + 1);
	}

	public int getEndRowNum() {
		return getCurrentPage() * getPageSize();
	}


	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("Search [currentPage=");
		builder.append(currentPage);
		builder.append(", searchCondition=");
		builder.append(searchCondition);
		builder.append(", searchKeyword=");
		builder.append(searchKeyword);
		builder.append(", pageUnit=");
		builder.append(pageUnit);
		builder.append(", pageSize=");
		builder.append(pageSize);
		builder.append(", order=");
		builder.append(order);
		builder.append(", startRowNum=");
		builder.append(startRowNum);
		builder.append(", endRowNum=");
		builder.append(endRowNum);
		builder.append(", userId=");
		builder.append(userId);
		builder.append(", clubCategory=");
		builder.append(clubCategory);
		builder.append(", clubArea=");
		builder.append(clubArea);
		builder.append("]");
		return builder.toString();
	}


}
	
