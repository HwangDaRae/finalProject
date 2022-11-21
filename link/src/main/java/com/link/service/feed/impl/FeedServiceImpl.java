package com.link.service.feed.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.link.common.Search;
import com.link.service.domain.Comment;
import com.link.service.domain.Feed;
import com.link.service.domain.Heart;
import com.link.service.domain.Report;
import com.link.service.feed.FeedDAO;
import com.link.service.feed.FeedService;

@Service("feedServiceImpl")
public class FeedServiceImpl implements FeedService {

	@Autowired
	@Qualifier("feedDAOImpl")
	private FeedDAO feedDAO;
	
	public void setFeedDao(FeedDAO feedDAO) {
		this.feedDAO = feedDAO;
	}

	public FeedServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass() + " default constructor");
	}
	
	
	
	///////////////////////////////////////////////////// Feed /////////////////////////////////////////////////////

	
	// 사용
	@Override
	public void addFeed(Feed feed) throws Exception {
		// TODO Auto-generated method stub
		feedDAO.addFeed(feed);
//		feedDAO.addPush(null);
	}
	
	@Override
	public Feed getFeedLast() throws Exception {
		// TODO Auto-generated method stub
		return feedDAO.getFeedLast();
	}
	
	// 사용
	@Override
	public Map<String, Object> getFeed(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		/*
		 * map.put("feedNo")
		 * map.put("search", search);
		 * map.put("heart", heart);
		 * map.put("user", user);
		*/
		
		Feed feed = feedDAO.getFeed(map);
		map.put("feed", feed);
		
		return map;
	}
	
	// 사용
	@Override
	public void updateFeed(Feed feed) throws Exception{
		feedDAO.updateFeed(feed);
	}
	
	// 사용
	@Override
	public void deleteFeed(int feedNo) throws Exception{
		// TODO Auto-generated method stub
		feedDAO.deleteFeed(feedNo);
	}
	
	
	
	///////////////////////////////////////////////////// Feed Comment /////////////////////////////////////////////////////
	
	
	// 사용
	@Override
	public void addFeedComment(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		Feed feed = feedDAO.getFeed(map);
		feed.setCheckComment(1);
		feedDAO.updateFeed(feed);
		
		// 하나의 댓글에 달린 대댓글 개수 세어서 넣어주기
		// 댓글 달릴곳의 위치
		Comment originalComment = (Comment) map.get("comment");
		
		if(feedDAO.getFeedCommentBySequence(map) != null) {
			
			// 자식 댓글 개수는
			int children = feedDAO.getChildrenCommentCount(map);
			
			for(int i = 0 ; i < children ; i++) {
				Comment comment = feedDAO.getFeedCommentBySequence(map);
				comment.setClubNo(1);
				map.put("comment", comment);
				
				comment.setSequence(comment.getSequence() + feedDAO.getChildrenCommentCount(map) + 1);
				map.put("comment", comment);
				
			}
			
		}
		
		// 댓글의 순서 변경
		if(((Comment) map.get("comment")).getSequence() < feed.getCommentCount()) {
			((Comment) map.get("comment")).setHeartCondition(1);
			feedDAO.updateFeedCommentOrder((Comment) map.get("comment"));
		}
		
		originalComment.setSequence(((Comment) map.get("comment")).getSequence());
		feedDAO.addFeedComment((originalComment));
		
		
	}
	
	@Override
	public Comment getFeedComment(int feedCommentNo) throws Exception {
		// TODO Auto-generated method stub
		return feedDAO.getFeedComment(feedCommentNo);
	}
	
	@Override
	public Comment getCommentLast() throws Exception {
		// TODO Auto-generated method stub
		return feedDAO.getFeedLastComment();
	}

	@Override
	public void updateFeedComment(Comment comment) throws Exception {
		// TODO Auto-generated method stub
		feedDAO.updateFeedComment(comment);
	}

	@Override
	public void deleteFeedComment(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		Feed feed = feedDAO.getFeed(map);
		feed.setCheckComment(-1);
		feedDAO.updateFeed(feed);
		
		feedDAO.deleteFeedComment( ((Comment) map.get("comment")).getFeedCommentNo() );
		
		((Comment) map.get("comment")).setHeartCondition(-1);
		
		feedDAO.updateFeedCommentOrder((Comment) map.get("comment"));
		
	}
	
	

	///////////////////////////////////////////////////// List /////////////////////////////////////////////////////

	
	
	// 사용
	@Override
	public Map<String, Object> getFeedList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		/*
		 * map.put("heart", heart);
		 * map.put("search", search);
		 * map.put("user", user);
		 */
		
		List<Feed> feedList = feedDAO.getFeedList(map);
		int totalFeedCount = feedDAO.getTotalFeedCount((Search) map.get("search"));
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("feedList", feedList);
		returnMap.put("totalFeedCount", totalFeedCount);
		
		return returnMap;
	}
	
	// 피드 하나에 달린 댓글 리스트
	// 사용
	@Override
	public Map<String, Object> getFeedCommentList(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		
		List<Comment> commentList = feedDAO.getFeedCommentList(map);
		int totalFeedCommentCount = feedDAO.getTotalFeedCommentCount(map);
		
		Map<String, Object> returnMap = new HashMap<String, Object>();
		returnMap.put("commentList", commentList);
		returnMap.put("totalFeedCommentCount", totalFeedCommentCount);
		
		return returnMap;
	}

	
	
	///////////////////////////////////////////////////// Report /////////////////////////////////////////////////////
	
	
	
	@Override
	public void addReport(Report report) throws Exception {
		// TODO Auto-generated method stub
		feedDAO.addReport(report);
	}
	
	
	
	///////////////////////////////////////////////////// Heart /////////////////////////////////////////////////////
	
	
	
//	private int heartNo;		// 좋아요 테이블 고유번호
//	private String userId;		// 좋아요하는 회원 아이디
//	private String source;		// 출처 0:피드, 1:피드 댓글, 2:모임게시물 3:모임게시물 댓글
//	private int sourceNo;		// 출처 고유번호
	
	

	// 사용
	@Override
	public Feed addFeedHeart(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		feedDAO.addFeedHeart((Heart) map.get("heart"));
		
		// 피드 테이블 좋아요 개수 증가
		
		Feed feed = (Feed) map.get("feed");
		
		feed.setCheckHeart(1);
		feedDAO.updateFeed(feed);
		
		Feed returnFeed = feedDAO.getFeed(map);

		return returnFeed;
	}

	// 사용
	@Override
	public Feed deleteFeedHeart(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		feedDAO.deleteFeedHeart((Heart)map.get("heart"));
		
		Feed feed = (Feed) map.get("feed");
		
		feed.setCheckHeart(-1);
		feedDAO.updateFeed(feed);
		
		Feed returnFeed = feedDAO.getFeed(map);

		return returnFeed;
	}

	// 사용
	@Override
	public Comment addFeedCommentHeart(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		feedDAO.addFeedCommentHeart((Heart)map.get("heart"));
		
		Comment comment = (Comment) map.get("comment");
		
		comment.setHeartCondition(1);
		feedDAO.updateFeedComment(comment);
		
		Comment returnComment = feedDAO.getFeedComment(comment.getFeedCommentNo());
		
		return returnComment;
	}

	// 사용
	@Override
	public Comment deleteFeedCommentHeart(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		feedDAO.deleteFeedCommentHeart((Heart)map.get("heart"));
				
		Comment comment = (Comment) map.get("comment");
		
		comment.setHeartCondition(-1);
		feedDAO.updateFeedComment(comment);
		
		Comment returnComment = feedDAO.getFeedComment(comment.getFeedCommentNo());
		
		return returnComment;
	}


	
}
