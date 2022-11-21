package com.link.service.feed.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.link.common.Search;
import com.link.service.domain.Comment;
import com.link.service.domain.Feed;
import com.link.service.domain.Heart;
import com.link.service.domain.Push;
import com.link.service.domain.Report;
import com.link.service.feed.FeedDAO;

@Repository("feedDAOImpl")
public class FeedDAOImpl implements FeedDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public FeedDAOImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass() + " default constructor");
	}

	
	
	///////////////////////////////////////////////////// Feed /////////////////////////////////////////////////////
	
	
	
	@Override
	public void addFeed(Feed feed) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FeedMapper.addFeed", feed);
	}
	
	@Override
	public Feed getFeedLast() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getFeedLast");
	}
	
	// 사용
	@Override
	public Feed getFeed(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getFeed", map);
	}
	
	// 사용
	@Override
	public void updateFeed(Feed feed) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FeedMapper.updateFeed", feed);
	}
	
	@Override
	public void deleteFeed(int feedNo) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FeedMapper.deleteFeed", feedNo);
	}
	
	
	
	///////////////////////////////////////////////////// Feed Comment /////////////////////////////////////////////////////
	
	
	
	// 사용
	@Override
	public void addFeedComment(Comment comment) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FeedMapper.addFeedComment", comment);
	}
	
	@Override
	public Comment getFeedComment(int feedCommentNo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getFeedComment", feedCommentNo);
	}
	
	@Override
	public Comment getFeedLastComment() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getFeedLastComment");
	}

	@Override
	public void updateFeedComment(Comment comment) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FeedMapper.updateFeedComment", comment);
	}

	@Override
	public void deleteFeedComment(int commentNo) throws Exception{
		// TODO Auto-generated method stub
		sqlSession.update("FeedMapper.deleteFeedComment", commentNo);
	}
	
	// 사용
	@Override
	public void updateFeedCommentOrder(Comment comment) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("FeedMapper.updateFeedCommentOrder", comment);
	}
	
	// 사용
	@Override
	public Comment getFeedCommentBySequence(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getFeedCommentBySequence", map);
	}
	
	@Override
	public int getChildrenCommentCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getChildrenCommentCount", map);
	}
	
	///////////////////////////////////////////////////// List /////////////////////////////////////////////////////
	
	
	
	@Override
	public List<Feed> getFeedList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getFeedList", map);
	}
	
	@Override
	public List<Comment> getFeedCommentList(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FeedMapper.getFeedCommentList", map);
	}
	
	
	
	///////////////////////////////////////////////////// Count /////////////////////////////////////////////////////
	
		
		
	@Override
	public int getTotalFeedCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getTotalFeedCount", search);
	}
	
	@Override
	public int getTotalFeedCommentCount(Map<String, Object> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FeedMapper.getTotalFeedCommentCount", map);
	}
	
	
	
	///////////////////////////////////////////////////// Like /////////////////////////////////////////////////////
	
	
	
	@Override
	public void addFeedHeart(Heart heart) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("HeartMapper.insertHeart", heart);
	}
	
	@Override
	public int checkFeedHeart(Heart heart) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("HeartMapper.checkFeedHeart", heart);
	}
	
	@Override
	public void deleteFeedHeart(Heart heart) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("HeartMapper.deleteHeart", heart);
	}

	// 사용
	@Override
	public void addFeedCommentHeart(Heart heart) throws Exception {
		// TODO Auto-generated method stub
		// 사용
		sqlSession.insert("HeartMapper.insertHeart", heart);
	}
	
	// 사용
	@Override
	public void deleteFeedCommentHeart(Heart heart) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("HeartMapper.deleteHeart", heart);
	}

	@Override
	public int getTotalFeedHeart(Heart heart) throws Exception {
		// TODO Auto-generated method stub
//		return sqlSession.selectOne("HeartMapper.getTotalHeart", heart);
		return 14;
	}

	@Override
	public int getTotalFeedCommentHeart(Heart heart) throws Exception {
		// TODO Auto-generated method stub
//		return sqlSession.selectOne("HeartMapper.getTotalHeart", heart);
		return 15;
	}
	
	
	
	///////////////////////////////////////////////////// Report /////////////////////////////////////////////////////
	
		
		
	@Override
	public void addReport(Report report) throws Exception {
		// TODO Auto-generated method stub
//		sqlSession.insert("Report_PushMapper.addReport", report);
	}
	
	
	
	///////////////////////////////////////////////////// Push /////////////////////////////////////////////////////
	
	

}
