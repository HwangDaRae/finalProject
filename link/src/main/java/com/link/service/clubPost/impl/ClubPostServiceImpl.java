package com.link.service.clubPost.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.link.common.Search;
import com.link.service.clubPost.ClubPostDAO;
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.Chat;
import com.link.service.domain.ClubPost;
import com.link.service.domain.ClubUser;
import com.link.service.domain.Comment;
import com.link.service.domain.Heart;
import com.link.service.domain.Pay;
import com.link.service.domain.Report;
import com.link.service.domain.User;

@Service("clubPostServiceImpl")
public class ClubPostServiceImpl implements ClubPostService {
	
	@Autowired
	@Qualifier("clubPostDAOImpl")
	ClubPostDAO clubPostDAOImpl;

	public ClubPostServiceImpl() {
		System.out.println(getClass() + " default 생성자 호출");
	}

	@Override
	public Map<String, Object> addClubPost(ClubPost clubPost) throws Exception {
		System.out.println(getClass() + ".addClubPost(ClubPost clubPost) 도착");
		return clubPostDAOImpl.addClubPost(clubPost);
	}// end of addClubPost(ClubPost clubPost)

	@Override
	public Map<String, Object> getClubPostList(Search search, ClubPost clubPost) throws Exception {
		System.out.println(getClass() + ".getClubPostList(Search search, ClubPost clubPost) 도착");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("clubPost", clubPost);
		return clubPostDAOImpl.getClubPostList(map);
	}// end of getClubPostList(Search search, ClubPost clubPost)

	@Override
	public Map<String, Object> getClubPost(Map<String, Object> map) throws Exception {
		System.out.println(getClass() + ".getClubPost(Map<String, Object> map) 도착");
		return clubPostDAOImpl.getClubPost(map);
	}// end of getClubPost(Map<String, Object> map)

	@Override
	public Map<String, Object> updateClubPost(Map<String, Object> map) throws Exception {
		System.out.println(getClass() + ".updateClubPost(Map<String, Object> map) 도착");
		
		if((Heart)map.get("heart") != null) {
			// heart가 null이 아니라며 즉, restController에서 왔다면 즉, 하트를 클릭했다면 수행
			
			// heart 테이블에서 모임게시물은 source 2번이다
			((Heart)map.get("heart")).setSource("2");
			
			// heart 테이블에 모임게시물 고유번호를 입력한다
			((Heart)map.get("heart")).setSourceNo(((ClubPost)map.get("clubPost")).getClubPostNo());

			// heartCondition = 1이면 좋아요 수행, -1이면 좋아요 취소 수행한다
			((ClubPost)map.get("clubPost")).setHeartCondition(((clubPostDAOImpl.getHeart((Heart)map.get("heart")) == 0) ? 1: -1));
			
			System.out.println("게시물 좋아요 또는 좋아요 취소를 위한 데이터 : heart : " + map.get("heart") + ", 하트컨디션 : " + ((ClubPost)map.get("clubPost")).getHeartCondition());
		}
		
		return clubPostDAOImpl.updateClubPost(map);
	}// end of updateClubPost(Map<String, Object> map)

	@Override
	public Map<String, Object> deleteClubPost(ClubPost clubPost, Search search) throws Exception {
		System.out.println(getClass() + ".deleteClubPost(ClubPost clubPost, Search search) 도착");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clubPost", clubPost);
		map.put("search", search);
		return clubPostDAOImpl.deleteClubPost(map);
	}// end of deleteClubPost(ClubPost clubPost, Search search)

	@Override
	public int getCheckHeart(Heart heart) throws Exception {
		System.out.println(getClass() + ".getCheckHeart(Heart heart) 도착");
		return clubPostDAOImpl.getHeart(heart);
	}

	
	
	
	
///////////////////////////////////////////////////////////////////////////////////// MyHome /////////////////////////////////////////////////////////////////////////////////////	
	
	


	
	@Override
	public Map<String, Object> getClubPostListMyHome(String userId) throws Exception {
		System.out.println(getClass() + ".getClubPostListMyHome(String userId) 도착");
		return clubPostDAOImpl.getClubPostListMyHome(userId);
	}// end of getClubPostListMyHome(String userId)

	
	
	
	
///////////////////////////////////////////////////////////////////////////////////// chat /////////////////////////////////////////////////////////////////////////////////////


	
	

	@Override
	public List<ClubUser> getRoomIdList(User user) throws Exception {
		System.out.println(getClass() + ".getRoomIdList(User user) 도착");
		return clubPostDAOImpl.getRoomIdList(user);
	}

	@Override
	public void addChat(Chat chat) throws Exception {
		System.out.println(getClass() + ".addChat(Chat chat) 도착");
		clubPostDAOImpl.addChat(chat);
	}

	@Override
	public List<Chat> getChatList(Chat chat) throws Exception {
		System.out.println(getClass() + ".getChatList(Chat chat) 도착");
		return clubPostDAOImpl.getChatList(chat);
	}

	@Override
	public List<Chat> getChat(Chat chat) throws Exception {
		System.out.println(getClass() + ".getChat(Chat chat) 도착");
		return clubPostDAOImpl.getChat(chat);
	}
	
	
	
	
	
///////////////////////////////////////////////////////////////////////////////////// Pay /////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	

	@Override
	public void addPay(Pay pay) throws Exception {
		System.out.println(getClass() + ".addPay(Pay pay) 도착");
		clubPostDAOImpl.addPay(pay);
	}// addPay(Pay pay)

	@Override
	public List<Pay> getPayList(User user) throws Exception {
		System.out.println(getClass() + ".getPayList(User user) 도착");
		return clubPostDAOImpl.getPayList(user);
	}// getPayList(User user)

	@Override
	public Pay getPay(Pay pay) throws Exception {
		System.out.println(getClass() + ".getPay(Pay pay) 도착");
		return clubPostDAOImpl.getPay(pay);
	}// getPay(Pay pay)
	
	
	
	
	
///////////////////////////////////////////////////////////////////////////////////// ClubPostComment /////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	

	@Override
	public Comment addClubPostComment(Comment comment) throws Exception {
		System.out.println(getClass() + ".addClubPostComment(Comment comment) 도착");
		if(comment.getClubPostCommentNo() == 0) {
			// 게시물의 댓글
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("comment", comment);

			List<Comment> c = (List<Comment>) clubPostDAOImpl.getClubPostCommentList(map);
			// 게시물 댓글 개수
			comment.setSequence(c.size());
			// 게시물의 댓글이니 부모번호는 게시물번호이다
			comment.setParent(comment.getClubPostNo());
		}else {
			// 댓글의 댓글
			Comment c = clubPostDAOImpl.getClubPostComment(comment);
			// 댓글의 댓글 개수
			comment.setSequence(c.getCommentCount());
			// 댓글의 댓글이니 부모번호는 댓글번호이다
			comment.setParent(comment.getClubPostCommentNo());
		}
		
		System.out.println("댓글인지 대댓글인지 : " + comment);
		return clubPostDAOImpl.addClubPostComment(comment);
	}// end of addClubPostComment(Comment comment)

	@Override
	public List<Comment> getClubPostCommentList(Map<String, Object> map) throws Exception {
		System.out.println(getClass() + ".getClubPostCommentList(Map<String, Object> map) 도착");
		return clubPostDAOImpl.getClubPostCommentList(map);
	}// end of getClubPostCommentList(Map<String, Object> map)

	@Override
	public Comment getClubPostComment(Comment comment) throws Exception {
		System.out.println(getClass() + ".getClubPostComment(Comment comment) 도착");
		return clubPostDAOImpl.getClubPostComment(comment);
	}// end of getClubPostComment(Comment comment)

	@Override
	public Comment updateClubPostComment(Comment comment, Heart heart, Report report) throws Exception {
		System.out.println(getClass() + ".updateClubPostComment(Comment comment, Heart heart) 도착");
		
		System.out.println("댓글 정보 : " + comment);
		System.out.println("heart댓글 정보 : " + heart);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(comment.getHeartCondition() == 1) {
			// heart가 null이 아니라며 즉, 하트를 클릭했다면 수행
			
			heart.setUserId(comment.getUser().getUserId());
			heart.setSource("3");
			heart.setSourceNo(comment.getClubPostCommentNo());

			comment.setHeartCondition((clubPostDAOImpl.getHeart(heart) == 0) ? 1: -1);

			System.out.println("수정된 heart : " + heart + "수정된 comment : " + comment);
		}
		
		map.put("heart", heart);
		map.put("comment", comment);
		map.put("report", report);
		
		return clubPostDAOImpl.updateClubPostComment(map);
	}// end of updateClubPostComment(Comment comment, Heart heart, Report report)

	@Override
	public Map<String, Object> deleteClubPostComment(Comment comment) throws Exception {
		System.out.println(getClass() + ".deleteClubPostComment(Comment comment) 도착");
		return clubPostDAOImpl.deleteClubPostComment(comment);
	}// end of deleteClubPostComment(Comment comment)

	
	
	

}
