package com.link.service.clubPost;

import java.util.List;
import java.util.Map;

import com.link.common.Search;
import com.link.service.domain.Chat;
import com.link.service.domain.ClubPost;
import com.link.service.domain.ClubUser;
import com.link.service.domain.Comment;
import com.link.service.domain.Heart;
import com.link.service.domain.Pay;
import com.link.service.domain.Report;
import com.link.service.domain.User;

public interface ClubPostService {

	// 모임게시물 등록
	public Map<String, Object> addClubPost(ClubPost clubPost) throws Exception;
	
	// 모임게시물 리스트, 개수
	public Map<String, Object> getClubPostList(Search search, ClubPost clubPost) throws Exception;
	
	// 모임게시물 상세보기 + 모임게시물 댓글리스트
	public Map<String, Object> getClubPost(Map<String, Object> map) throws Exception;
	
	// 모임게시물 수정 후 모임게시물 상세보기
	public Map<String, Object> updateClubPost(Map<String, Object> map) throws Exception;
	
	// 모임게시물 삭제 후 모임게시물 리스트
	public Map<String, Object> deleteClubPost(ClubPost clubPost, Search search) throws Exception;
	
	// 상세보기에서 좋아요 여부
	public int getCheckHeart(Heart heart) throws Exception;
	
	
	
	
	
	// 결제
	public void addPay(Pay pay) throws Exception;
	
	// 결제 리스트
	public List<Pay> getPayList(User user) throws Exception;
	
	// 결제 상세보기
	public Pay getPay(Pay pay) throws Exception;
	
	
	

	
	// 내가 가입한 모임의 채팅방 번호 가져오기
	public List<ClubUser> getRoomIdList(User user) throws Exception;
	// 1:1 채팅
	public void addChat(Chat chat) throws Exception;
	
	// 1:1 채팅
	public List<Chat> getChatList(Chat chat) throws Exception;
	
	// 1:1 채팅
	public List<Chat> getChat(Chat chat) throws Exception;
	
	
	
	
	
	// 모임게시물 댓글 등록
	public Comment addClubPostComment(Comment comment) throws Exception;
	
	// 모임게시물 댓글 리스트
	public List<Comment> getClubPostCommentList(Map<String, Object> map) throws Exception;
	
	// 모임게시물 댓글 상세보기
	public Comment getClubPostComment(Comment comment) throws Exception;
	
	// 모임게시물 댓글 수정
	public Comment updateClubPostComment(Comment comment, Heart heart, Report report) throws Exception;
	
	// 모잉게시물 댓글 삭제
	public Map<String, Object> deleteClubPostComment(Comment comment) throws Exception;

	
	
	
	
	// 마이홈피 - 내가 작성한 모임게시물 리스트
	public Map<String, Object> getClubPostListMyHome(String userId) throws Exception;

}
