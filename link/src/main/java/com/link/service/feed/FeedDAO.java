package com.link.service.feed;

import java.util.List;
import java.util.Map;

import com.link.common.Search;
import com.link.service.domain.Comment;
import com.link.service.domain.Feed;
import com.link.service.domain.Heart;
import com.link.service.domain.Push;
import com.link.service.domain.Report;

public interface FeedDAO {
	
	
	
	///////////////////////////////////////////////////// Feed /////////////////////////////////////////////////////

	
	
	// 피드 추가
	public void addFeed(Feed feed) throws Exception;
	
	// 피드 상세
	public Feed getFeed(Map<String, Object> map) throws Exception;
	
	public Feed getFeedLast() throws Exception;
	
	// 피드 수정
	public void updateFeed(Feed feed) throws Exception;
	
	// 피드 삭제
	public void deleteFeed(int feedNo) throws Exception;
	

	
	///////////////////////////////////////////////////// Feed Comment /////////////////////////////////////////////////////
	
	
	
	// 피드 댓글 추가
	public void addFeedComment(Comment comment) throws Exception;
	
	// 피드 댓글 수정
	public Comment getFeedComment(int feedCommentNo) throws Exception;
	
	public Comment getFeedLastComment() throws Exception;
	
	// 피드 댓글 수정
	public void updateFeedComment(Comment comment) throws Exception;
	
	// 피드 댓글 삭제
	public void deleteFeedComment(int commentNo) throws Exception;
	
	// 댓글의 순서 변경
	public void updateFeedCommentOrder(Comment comment) throws Exception;
	
	// 사용 : 순서로 댓글 확인하기
	public Comment getFeedCommentBySequence(Map<String, Object> map) throws Exception; 

	// 사용 : 자식 댓글 개수
	public int getChildrenCommentCount(Map<String, Object> map) throws Exception;
	
	
	///////////////////////////////////////////////////// List /////////////////////////////////////////////////////
	
	
	
	// 피드 리스트
	public List<Feed> getFeedList(Map<String, Object> map) throws Exception;
	
	// 피드 댓글 리스트
	public List<Comment> getFeedCommentList(Map<String, Object> map) throws Exception;
	
	
	
	///////////////////////////////////////////////////// Count /////////////////////////////////////////////////////
	
		
	// 피드 전체 개수
	public int getTotalFeedCount(Search search) throws Exception;
	
	// 피드 댓글 전체 개수
	
	/*
	 * map.put("feedNo")
	 */
	
	public int getTotalFeedCommentCount(Map<String, Object> map) throws Exception;
	
	
	
	///////////////////////////////////////////////////// Like /////////////////////////////////////////////////////
	
	
	
	/*
	 * map 안에 feedNo, userId
	 * 
	 * 
	 * 
	 * 
	 */
	
	// 피드 좋아요
	public void addFeedHeart(Heart heart) throws Exception;
	
	public int checkFeedHeart(Heart heart) throws Exception;
	
	// 피드 싫어요
	public void deleteFeedHeart(Heart heart) throws Exception;
	
	// 피드 댓글 좋아요
	public void addFeedCommentHeart(Heart heart) throws Exception;
		
	// 피드 댓글 싫어요
	public void deleteFeedCommentHeart(Heart heart) throws Exception;
	
	// 피드 좋아요 개수
	public int getTotalFeedHeart(Heart heart) throws Exception;
	
	//피드 댓글 좋아요 개수
	public int getTotalFeedCommentHeart(Heart heart) throws Exception;
	
	
	
	///////////////////////////////////////////////////// Report /////////////////////////////////////////////////////
		
	
		
	// 피드 & 피드 댓글 신고
	public void addReport(Report report) throws Exception;
	
	
	
	///////////////////////////////////////////////////// Push /////////////////////////////////////////////////////
	
	
	
	
}
