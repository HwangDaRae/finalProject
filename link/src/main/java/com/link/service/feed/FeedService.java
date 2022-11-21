package com.link.service.feed;

import java.util.Map;

import com.link.service.domain.Comment;
import com.link.service.domain.Feed;
import com.link.service.domain.Report;

public interface FeedService {
	
	
	
	///////////////////////////////////////////////////// Feed /////////////////////////////////////////////////////
	
	
	// 피드 추가
	public void addFeed(Feed feed) throws Exception;
	
	// 피드 조회 (피드 & 피드 댓글)
	/*
	 * 
	 * map.put("feedNo", feed.getFeedNo());
	 * map.put("search", search);
	 * 
	 */
	
	public Map<String, Object> getFeed(Map<String, Object> map) throws Exception;
	
	public Feed getFeedLast() throws Exception;
	
	// 피드 수정
	public void updateFeed(Feed feed) throws Exception;
	
	// 피드 삭제
	public void deleteFeed(int feedNo) throws Exception;
	
	
	
	///////////////////////////////////////////////////// Feed Comment /////////////////////////////////////////////////////
	
	
	// 피드 댓글 추가
	public void addFeedComment(Map<String, Object> map) throws Exception;
	
	// 피드 댓글 조회
	public Comment getFeedComment(int feedCommentNo) throws Exception;
	
	public Comment getCommentLast() throws Exception;
	
	// 피드 댓글 수정
	public void updateFeedComment(Comment comment) throws Exception;
	
	// 피드 댓글 삭제
	public void deleteFeedComment(Map<String, Object> map) throws Exception;
	
	
	
	///////////////////////////////////////////////////// List /////////////////////////////////////////////////////
	
	
	
	// 피드 리스트
	public Map<String, Object> getFeedList(Map<String, Object> map) throws Exception;
	
	// 피드 댓글 리스트
	public Map<String, Object> getFeedCommentList(Map<String, Object> map) throws Exception;

	
	
	///////////////////////////////////////////////////// Report /////////////////////////////////////////////////////
	
	
	
	// 피드 & 피드 댓글 신고
	public void addReport(Report report) throws Exception;

	
	
	///////////////////////////////////////////////////// Like /////////////////////////////////////////////////////
	
	/*
	 * map 안에 feedNo, userId
	 * 
	 * 
	 * 
	 * 
	 */
	
	// 피드 좋아요
	public Feed addFeedHeart(Map<String, Object> map) throws Exception;
	
	// 피드 싫어요
	public Feed deleteFeedHeart(Map<String, Object> map) throws Exception;
	
	// 피드 댓글 좋아요
	public Comment addFeedCommentHeart(Map<String, Object> map) throws Exception;
	
	// 피드 댓글 싫어요
	public Comment deleteFeedCommentHeart(Map<String, Object> map) throws Exception;
	
	
	
}
