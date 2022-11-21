package com.link.web.clubPost;

import com.link.common.CommonUtil;
import com.link.common.Search;

public class ClubPostCommon {
	
	public static Search getSearch(Search search) {
		
		// 모임게시물 탭 클릭했을때 currentPage는 0이다
		int currentPage = 1;
		if (search.getCurrentPage() != 0) {
			currentPage = search.getCurrentPage();
		}
		
		// 게시물 내용에 관련되서만 검색 할 수 있다
		search.setSearchCondition("1");
		
		// 모임게시물 탭 클릭시 searchKeyword, searchCondition 둘 다 null ==> nullString 으로 변환
		String searchKeyword = CommonUtil.null2str(search.getSearchKeyword());
		String searchCondition = CommonUtil.null2str(search.getSearchCondition());
		
		return new Search(currentPage, searchCondition, searchKeyword, 10, search.getOrder());
	}
}
