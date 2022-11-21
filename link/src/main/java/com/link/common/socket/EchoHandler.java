package com.link.common.socket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.link.common.Search;
import com.link.service.domain.User;
import com.link.service.myHome.MyHomeService;

public class EchoHandler extends TextWebSocketHandler {
	
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	// 로그인중인 개별유저
	Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
	
	@Autowired
	@Qualifier("myHomeServiceImpl")
	private MyHomeService myHomeService;
	
	// 클라이언트가 서버로 연결 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		// 접속한 유저의 http 세션을 조회하여 id를 얻는 함수
		sessions.add(session);
		String senderId = getMemberId(session);
		
		// 로그인 값이 있는 경우만
		
		if(senderId != null) {
			users.put(senderId, session);	// 로그인중 개별 유저 저장
		} else {
			users.remove(senderId);
			sessions.remove(session);
		}
	}
	
	// 클라이언트가 메세지를 보냈을 때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		String senderId = getMemberId(session);
		String senderNickName = getMemberNickName(session);
		
		List<User> followerId = getFollowerId(session);
		
//		// 모든 유저에게 보내기
//		for(WebSocketSession sess : sessions) {
//			
//			WebSocketSession ownerSession = users.get(senderId);
//			
//			if(!sess.equals(ownerSession)) {
//				
//				if(followerId != null) {
//					
//					for(int i = 0 ; i < followerId.size() ; i++) {
//						
//						WebSocketSession followerSession = users.get(followerId.get(i).getUserId());
//						
//						if(sess.equals(followerSession)) {
//							sess.sendMessage(new TextMessage(senderNickName + message.getPayload()));
//						}
//						
//						
//					}
//					
//				}
//			}
//		}
		
		// 특정 유저에게 보내기
		String msg = message.getPayload();
		if(StringUtils.isNotEmpty(msg)) {
			String[] strs = msg.split(",");
			if(strs != null && strs.length == 4) {
				String type = strs[0];		// 
				String target = strs[1];	// m_id 저장
				String url = strs[2];		// url 번호
				String content = strs[3];	// 내용
				
				// WebSocketSession targetSession = users.get(target);
				
				// 실시간 접속 시

				// ex :  [XXX] 신청이 들어왔습니다.
				
				System.out.println("메시지 :: " + msg);
				
				if(type.equals("feed")) {
					
					System.out.println("전체");
					
					if(target.equals("all")) {
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							if(!sess.equals(ownerSession)) {
								sess.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
							}
							
						}
						
					} else if(target.equals("follower")) {
						
						System.out.println("팔로우 알림");
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							
							if(!sess.equals(ownerSession)) {
								if(followerId != null) {
									
									for(int i = 0 ; i < followerId.size() ; i++) {
										WebSocketSession followerSession = users.get(followerId.get(i).getUserId());
										
										if(sess.equals(followerSession)) {
											sess.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
										}
									}
								}
							}
						}
						
					} else {
						WebSocketSession targetSession = users.get(target);
						
						if(targetSession!=null) {
							targetSession.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
						}
						
					}
					
				} else if(type.equals("feedComment")) {
					
					if(target.equals("all")) {
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							if(!sess.equals(ownerSession)) {
								sess.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
							}
							
						}
						
					} else if(target.equals("follower")) {
						
						System.out.println("팔로우 알림");
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							
							if(!sess.equals(ownerSession)) {
								if(followerId != null) {
									
									for(int i = 0 ; i < followerId.size() ; i++) {
										WebSocketSession followerSession = users.get(followerId.get(i).getUserId());
										
										if(sess.equals(followerSession)) {
											sess.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
										}
									}
								}
							}
						}
						
					} else {
						WebSocketSession targetSession = users.get(target);
						
						if(targetSession!=null) {
							targetSession.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
						}
					}
					
				} else if(type.equals("follow")) {
					
					WebSocketSession targetSession = users.get(target);
					if(targetSession!=null) {
						targetSession.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
					}
					
				} else if(type.equals("club")) {
					
					if(target.equals("all")) {
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							if(!sess.equals(ownerSession)) {
								sess.sendMessage(new TextMessage(senderNickName + content + " <a href='/club/getClub?clubNo="+ url + "'>이동</a>"));
							}
							
						}
						
					} else if(target.equals("follower")) {
						
						System.out.println("팔로우 알림");
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							
							if(!sess.equals(ownerSession)) {
								if(followerId != null) {
									
									for(int i = 0 ; i < followerId.size() ; i++) {
										WebSocketSession followerSession = users.get(followerId.get(i).getUserId());
										
										if(sess.equals(followerSession)) {
											sess.sendMessage(new TextMessage(senderNickName + content + " <a href='/club/getClub?clubNo="+ url + "'>이동</a>"));
										}
									}
								}
							}
						}
						
					} else {
						WebSocketSession targetSession = users.get(target);

						if(targetSession!=null) {
							targetSession.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
						}
					}
					
				} else if(type.equals("clubPost")) {
					
					if(target.equals("all")) {
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							if(!sess.equals(ownerSession)) {
								sess.sendMessage(new TextMessage(senderNickName + content + " <a href='/clubPost/getClubPost?clubPostNo="+ url + "'>이동</a>"));
							}
							
						}
						
					} else if(target.equals("follower")) {
						
						System.out.println("팔로우 알림");
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							
							if(!sess.equals(ownerSession)) {
								if(followerId != null) {
									
									for(int i = 0 ; i < followerId.size() ; i++) {
										WebSocketSession followerSession = users.get(followerId.get(i).getUserId());
										
										if(sess.equals(followerSession)) {
											sess.sendMessage(new TextMessage(senderNickName + content + " <a href='/clubPost/getClubPost?clubPostNo="+ url + "'>이동</a>"));
										}
									}
								}
							}
						}
						
					} else {
						WebSocketSession targetSession = users.get(target);

						if(targetSession!=null) {
							targetSession.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
						}
					}
					
				} else if(type.equals("clubPostComment")) {
					
					if(target.equals("all")) {
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							if(!sess.equals(ownerSession)) {
								sess.sendMessage(new TextMessage(senderNickName + content + " <a href='/clubPost/getClubPost?clubPostNo="+ url + "'>이동</a>"));
							}
							
						}
						
					} else if(target.equals("follower")) {
						
						System.out.println("팔로우 알림");
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							
							if(!sess.equals(ownerSession)) {
								if(followerId != null) {
									
									for(int i = 0 ; i < followerId.size() ; i++) {
										WebSocketSession followerSession = users.get(followerId.get(i).getUserId());
										
										if(sess.equals(followerSession)) {
											sess.sendMessage(new TextMessage(senderNickName + content + " <a href='/clubPost/getClubPost?clubPostNo="+ url + "'>이동</a>"));
										}
									}
								}
							}
						}
						
					} else {
						WebSocketSession targetSession = users.get(target);

						if(targetSession!=null) {
							targetSession.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
						}
					}
					
				} else if(type.equals("service")) {
					
					WebSocketSession targetSession = users.get(target);

					if(targetSession!=null) {
						targetSession.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
					}

				} else if(type.equals("live")) {
					
					if(target.equals("all")) {
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							if(!sess.equals(ownerSession)) {
								sess.sendMessage(new TextMessage(senderNickName + content));
							}
							
						}
						
					} else if(target.equals("follower")) {
						
						System.out.println("팔로우 알림");
						
						for(WebSocketSession sess : sessions) {
							WebSocketSession ownerSession = users.get(senderId);
							
							if(!sess.equals(ownerSession)) {
								if(followerId != null) {
									
									for(int i = 0 ; i < followerId.size() ; i++) {
										WebSocketSession followerSession = users.get(followerId.get(i).getUserId());
										
										if(sess.equals(followerSession)) {
											sess.sendMessage(new TextMessage(senderNickName + content));
										}
									}
								}
							}
						}
						
					} else {
						WebSocketSession targetSession = users.get(target);

						if(targetSession!=null) {
							targetSession.sendMessage(new TextMessage(senderNickName + content + " <a href='/feed/getFeed?feedNo="+ url + "'>이동</a>"));
						}
					}
					
				} 
					
			}
		} // 특정 유저에게 보내기 close
	}

	// 연결 해제 시
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// TODO Auto-generated method stub
		String senderId = getMemberId(session);
		if(senderId!=null) {	// 로그인 값이 있는 경우만
			users.remove(senderId);
			sessions.remove(session);
		}
	}
	
	
	// 에러 발생 시
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		// TODO Auto-generated method stub
		System.out.println(session.getId() + " 오류 발생 : " + exception.getMessage());
	}

	private String getMemberId(WebSocketSession session) {
		// TODO Auto-generated method stub
		Map<String, Object> httpSession = session.getAttributes();
		
		String m_id = null;
		
		if((User)httpSession.get("user") != null) {
			m_id = ((User)httpSession.get("user")).getUserId();
		}
		
		return m_id == null? null : m_id;
	}
	
	private String getMemberNickName(WebSocketSession session) {
		// TODO Auto-generated method stub
		Map<String, Object> httpSession = session.getAttributes();
		
		String m_nickName = null;
		
		if((User)httpSession.get("user") != null) {
			m_nickName = ((User)httpSession.get("user")).getNickName();
		}
		
		return m_nickName == null? null : m_nickName;
	}
	
	@SuppressWarnings("unchecked")
	private List<User> getFollowerId(WebSocketSession session) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> httpSession = session.getAttributes();
		
		List<User> list = null;
		
		User user = (User)httpSession.get("user");
		Search search = new Search();
		search.setSearchKeyword(user.getUserId());
		
		System.out.println("서치 :: " + search);
		
		if(myHomeService.getFollowerList(search).get("followerList") != null) {
			list = (List<User>) myHomeService.getFollowerList(search).get("followerList");
		}
		
		System.out.println("겟팔로우 아이디 :: " + list);
		
		return list == null? null : list;
	}
	
}
