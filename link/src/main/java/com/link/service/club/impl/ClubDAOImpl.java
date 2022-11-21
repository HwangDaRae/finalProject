package com.link.service.club.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.link.common.Search;
import com.link.service.club.ClubDAO;
import com.link.service.domain.Club;
import com.link.service.domain.ClubPost;
import com.link.service.domain.ClubUser;
import com.link.service.domain.Meeting;
import com.link.service.domain.Participant;
import com.link.service.domain.Pay;
import com.link.service.domain.User;

@Repository("clubDAOImpl")
public class ClubDAOImpl implements ClubDAO {
	
	/*
	 * @Repository("clubDAOImpl") public class ClubDAOImpl implements ClubDAO {
	 */	

	//Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		System.out.println("::"+getClass() + ".setSqlSession() Call....");
		this.sqlSession = sqlSession;
	}
	
	
	public ClubDAOImpl() {
		System.out.println(this.getClass());
	}

	
	//Method
	@Override
	public int addClub(Club club) throws Exception {
		System.out.println("addClub DAO까지 왔나??");
		System.out.println("club에 값 뭐있지 ? : "+club);
		
		sqlSession.insert("ClubMapper.addClub",club);
		
		// 등록된 모임번호를 가져온다
		return sqlSession.selectOne("ClubMapper.getClubNo", club.getUser());
	}
	
//	//JUNIT TEST
//	@Override
//	public int addClub(Club club) throws Exception {
//		return sqlSession.insert("ClubMapper.addClub",club);
//	}

	//getClub bak!
//	@Override
//	public Club getClub(int clubNo) throws Exception {
//		
//		System.out.println("getClub DAOImpl 왔나? ");
//		return sqlSession.selectOne("ClubMapper.getClub",clubNo);
//	}
	
	@Override
	public Map<String, Object> getClub(int clubNo) throws Exception {
		
		System.out.println("getClub DAOImpl 왔나? ");
		
		Club club = sqlSession.selectOne("ClubMapper.getClub", clubNo);
		
		//추가중
		Search search = new Search();
		
		//List<ClubUser> clubMemberList = sqlSession.selectList("ClubMapper.getClubMemberList", search2);
		List<ClubUser> clubMemberList = sqlSession.selectList("ClubMapper.getClubMemberList", search);
		
		int totalClubMemberCount = sqlSession.selectOne("ClubMapper.getTotalClubMemberCount", new Search(clubNo+""));
			
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> map1 = new HashMap<String, Object>();
		
		map.put("club", club);
		map.put("totalClubMemberCount", totalClubMemberCount);
		//map1.put("clubMemberList", clubMemberList);
		
		return map;
	}
	

////	@Override
//	public Club getClub(int clubNo) throws Exception {
//		return (Club)sqlSession.selectOne("ClubMapper.getClub",clubNo);
//	}
	
	
	//getClubList bak!
	@Override
	public List<Club> getClubList(Search search) throws Exception {
		
		System.out.println("모임리스트 DAOImpl까지 왔나??");
		return sqlSession.selectList("ClubMapper.getClubList",search);
	}
	
//	@Override
//	public Map<String, Object> getClubList(Search search) throws Exception {
//		
//		System.out.println("모임리스트 DAOImpl까지 왔나??");
//		
//		sqlSession.selectList("ClubMapper.getClubList",search);
//		
//		int totalClubMemberCount = sqlSession.selectOne("ClubMapper.getTotalClubMemberCount", new Search(search+"") );
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("search", search);
//		map.put("totalClubMemberCount", totalClubMemberCount);
//		
//		return map;
//	}
	
//	@Override
//	public List<ClubUser> getMyClubList(Map<String, Object> map) throws Exception {
//		
//		System.out.println("나의 모임리스트 DAO Impl 왔나?? ");
//		
//		return sqlSession.selectList("ClubMapper.getClubList",map);
//	}
	
	@Override
	public List<ClubUser> getApprovalConditionList(Search search) throws Exception {
		
		System.out.println("나의 모임리스트 DAO Impl 왔나?? ");
		
		System.out.println(search.getSearchKeyword());
		
//		List<Club> list = sqlSession.selectList("ClubMapper.getApprovalConditionList",search);
//		
//		for (Club c : list) {
//			System.out.println(c);
//		}
		
//		return null;
		return sqlSession.selectList("ClubMapper.getApprovalConditionList",search);
	}
	
	@Override
	public void deleteClub(int clubNo) throws Exception {
		// 해당 모임의 모임원을 모두 삭제해야 결제 할때 잘 된다
		sqlSession.delete("ClubMapper.deleteClubMemberList", clubNo);
		sqlSession.update("ClubMapper.deleteClub",clubNo);
	}
	
	@Override
	public void updateClub(Club club) throws Exception {
		
		System.out.println("updateClub DAOImpl 왔나요? ");
		
//		club.setClubNo(26);
//		club.setUserId("일단테스트 아디입니다");
//		club.setClubCategory("일단테스트입니다");
//		club.setCurrentMember(1);
//		club.setClubMaxMember(10);
		sqlSession.update("ClubMapper.updateClub",club);
	}
	
	@Override
	public void addApprovalCondition(ClubUser clubUser) throws Exception {
		
		System.out.println("모임가입신청 DAOImpl 왔나?? ");
		if (clubUser.getMemberRole().equals("2")) {
			int clubNo = sqlSession.selectOne("ClubMapper.getClubNo", clubUser.getUser());
			clubUser.setClubNo(clubNo);
		}
		sqlSession.insert("ClubMapper.addApprovalCondition", clubUser);
	}
	
	//JUNIT TEst
//	@Override
//	public int addApprovalCondition(ClubUser clubUser) throws Exception {
//		return sqlSession.insert("ClubMapper.addApprovalCondition",clubUser);
//	}
	
	//가입신청현황 리스트 --> GetMyClubList와 병합
//	@Override
//	public List<ClubUser> getApprovalConditionList(Search search) throws Exception {
//		return sqlSession.selectList("ClubMapper.getApprovalConditionList",search);
//	}
//	
	@Override
	public void updateApprovalCondition(ClubUser clubUser) throws Exception {
		
		System.out.println("updateApprovalCondition DAOImpl 왔나?");
		sqlSession.update("ClubMapper.updateApprovalCondition",clubUser);
	}
	
	@Override
	public List<ClubUser> getClubMemberList(Search search) throws Exception {
		
		System.out.println("모임원리스트 DAOImpl 왔나? ");
		return sqlSession.selectList("ClubMapper.getClubMemberList",search);
	}
	
	@Override
	public void deleteClubMember(ClubUser clubUser) throws Exception {
		sqlSession.delete("ClubMapper.deleteClubMember",clubUser);
	}
	
	@Override
	public void updateMemberRole(ClubUser clubUser) throws Exception {
		
		System.out.println("업뎃 직책 DAO Impl 왔나?");
		sqlSession.update("ClubMapper.updateMemberRole",clubUser);
	}
	
	@Override
	public void deleteApprovalCondition(ClubUser clubUser) throws Exception {
		sqlSession.delete("ClubMapper.deleteApprovalCondition",clubUser);		
	}
	
	@Override
	public void addMeeting(Meeting meeting) throws Exception {
		
		System.out.println("addMeeting DAO왔는가 ? ");
		System.out.println("meeting 값이 뭔가 ? : "+meeting);
		sqlSession.insert("ClubMapper.addMeeting",meeting); 
	}
	
	//JUNIT TEST
//	@Override
//	public int addMeeting(Meeting meeting) throws Exception {
//		return sqlSession.insert("ClubMapper.addMeeting",meeting); 
//	}
	
	@Override
	public List<Meeting> getMeetingList(Search search) throws Exception {
		
		System.out.println("MeetingList DAOImpl 오나? ");
		return sqlSession.selectList("ClubMapper.getMeetingList",search);
	}
	
	@Override
	public Map<String, Object> getMeeting(int meetingNo) throws Exception {
		System.out.println("getMeeting DAOImpl 오나??");
		// 미팅번호로 미팅 도메인객체 받아온다
		Meeting meeting = sqlSession.selectOne("ClubMapper.getMeeting",meetingNo);
		// 미팅번호로 총 참여자 수 받아온다
		int totalMeetingMemberCount = sqlSession.selectOne("ClubMapper.getTotalMeetingMemberCount", new Search(meetingNo+""));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("meeting", meeting);
		map.put("totalMeetingMemberCount", totalMeetingMemberCount);
		return map; 
	}
	
	@Override
	public void updateMeeting(Meeting meeting) throws Exception {
		
		System.out.println("updateMeeting DAOImpl 오나 ?? ");
		
		sqlSession.update("ClubMapper.updateMeeting",meeting);
	}
	
	@Override
	public void deleteMeeting(int meetingNo) throws Exception {
		sqlSession.delete("ClubMapper.deleteMeeting",meetingNo);
	}
	
	@Override
	public void addMeetingMember(Participant participant) throws Exception {
		
		System.out.println("미팅참가 DAO Impl 왔나?");
		System.out.println("회원 정보 아이디 : " + participant.getUser().getUserId());
		System.out.println("미팅번호 : " + participant.getMeetingNo());
		
		// 일정 생성시 미팅번호가 없어서 로그인한 회원이 가장 최근 만든 
		Meeting meeting = sqlSession.selectOne("ClubMapper.getMeetingNo", participant);
		System.out.println("일정은? : " + meeting);
		participant.setMeetingNo(meeting.getMeetingNo());
		
		//if( meeting == null) {
		sqlSession.insert("ClubMapper.addMeetingMember",participant);
		//}
		
	}
	
	//JUNIT TEST
//	@Override
//	public int addMeetingMember(Participant participant) throws Exception {
//		return sqlSession.insert("ClubMapper.addMeetingMember",participant);
//	}
	
	@Override
	public void deleteMeetingMember(Participant participant) throws Exception {
		sqlSession.delete("ClubMapper.deleteMeetingMember",participant);
	}
	
	@Override
	public List<Meeting> getMeetingMemberList(Search search) throws Exception {
		return sqlSession.selectList("ClubMapper.getMeetingMemberList",search);
	}
	
	@Override
	public void addMeetingPush(Meeting meeting) throws Exception {
		
	}
	
	@Override
	public int getTotalClubCount(Search search) throws Exception {
		return sqlSession.selectOne("ClubMapper.getTotalClubCount",search);
	}
	
	@Override
	public int getTotalApprovalConditionCount(Search search) throws Exception {
		return sqlSession.selectOne("ClubMapper.getTotalApprovalConditionCount",search);
	}
	
	//가입신청현황 리스트 --> GetMyClubList와 병합
//	@Override
//	public int getTotalApprovalConditionCount(Search search) throws Exception {
//		return sqlSession.selectOne("ClubMapper.getTotalApprovalConditionCount",search);
//	}
	
	@Override
	public int getTotalClubMemberCount(Search search) throws Exception {
		return sqlSession.selectOne("ClubMapper.getTotalClubMemberCount",search);
	}
	
	@Override
	public int getTotalMeetingCount(Search search) throws Exception {
		return sqlSession.selectOne("ClubMapper.getTotalMeetingCount",search);
	}
	
	@Override
	public int getTotalMeetingMemberCount(Search search) throws Exception {
		return sqlSession.selectOne("ClubMapper.getTotalMeetingMemberCount",search);
	}
	
	//결제
	@Override
	public List<ClubUser> updateClubMember(Pay pay, Search search) throws Exception {
	   System.out.println(getClass() + ".updateClubMember(Pay pay, Search search) 왔다");
	   sqlSession.update("ClubMapper.updateClubMember", pay);
	   search.setSearchKeyword(pay.getClubNo()+"");
	   return sqlSession.selectList("ClubMapper.getClubMemberList",search);
	}// end of updateClubMember(Pay pay, Search search)
	
	@Override
	public int getCheckMeeting(Participant participant) throws Exception {
		System.out.println(getClass() + ".getCheckMeeting(Participant participant) 왔다");
		return sqlSession.selectOne("ClubMapper.getCheckMeeting", participant);
	}

	// 마이홈피에서 접근시 session에 clubNo가 없어서 미팅번호로 모임번호 가져온다
	@Override
	public int getClubNotoMyHome(int meetingNo) throws Exception {
		System.out.println(getClass() + ".getClubNotoMyHome(int meetingNo) 왔다");
		return sqlSession.selectOne("ClubMapper.getClubNotoMyHome", meetingNo);
	}

	// 게시물 아이콘 클릭시 로그인한 회원이 해당 모임의 모임원인지 확인
	@Override
	public String getClubMemberListCheck(Club club) throws Exception {
		System.out.println(getClass() + ".getClubMemberListCheck(String userId, int clubNo) 왔다");
		return sqlSession.selectOne("ClubMapper.getClubMemberListCheck", club);
	}


	@Override
	public Meeting getMeetingNo(Participant participant) throws Exception {
		System.out.println(getClass() + ".getMeetingNo(Participant participant) 왔다");
		System.out.println("가져온 것 : " + participant);
		Meeting me = sqlSession.selectOne("ClubMapper.getMeetingNo", participant);
		System.out.println(me);
		return me;
	}
}
