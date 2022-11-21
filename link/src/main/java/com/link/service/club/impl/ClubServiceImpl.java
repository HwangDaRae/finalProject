package com.link.service.club.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.link.common.Search;
import com.link.service.club.ClubDAO;
import com.link.service.club.ClubService;
import com.link.service.domain.Club;
import com.link.service.domain.ClubPost;
import com.link.service.domain.ClubUser;
import com.link.service.domain.Meeting;
import com.link.service.domain.Participant;
import com.link.service.domain.Pay;
import com.link.service.domain.User;

@Service("clubServiceImpl")
public class ClubServiceImpl implements ClubService {

	
	
	//Field
	@Autowired
	@Qualifier("clubDAOImpl")
	private ClubDAO clubDAO;
	public void setClubDAO(ClubDAO clubDAO) {
		this.clubDAO = clubDAO;
	}
	
	
	public ClubServiceImpl() {
		System.out.println(this.getClass()+ " default constructor");
	}
	
	@Override
	public int addClub(Club club) throws Exception {
		
		System.out.println("addClub 서비스 왔나? ");

		return clubDAO.addClub(club);
	}
	
//	// JUnit TEST
//	@Override
//	public int addClub(Club club) throws Exception {
//		return clubDAO.addClub(club);
//	}
	
	
	@Override
	public Map<String, Object> getClub(int clubNo) throws Exception {
		
		System.out.println("getClub ServiceImpl 오나??");
		return clubDAO.getClub(clubNo);
	}
	
	@Override
	public void deleteClub(int clubNo) throws Exception {
		clubDAO.deleteClub(clubNo);
	}
	
	@Override
	public void updateClub(Club club) throws Exception {
		clubDAO.updateClub(club);
	}
	
	@Override
	public void addApprovalCondition(ClubUser clubUser) throws Exception {
		clubDAO.addApprovalCondition(clubUser);
	}
	
	//JUNIT test
//	@Override
//	public int addApprovalCondition(ClubUser clubUser) throws Exception {
//		return clubDAO.addApprovalCondition(clubUser);
//	}
//	
	@Override
	public void updateApprovalCondition(ClubUser clubUser) throws Exception {
		clubDAO.updateApprovalCondition(clubUser);
	}
	
	@Override
	public void deleteClubMember(ClubUser clubUser) throws Exception {
		clubDAO.deleteClubMember(clubUser);
	}
	
	@Override
	public void updateMemberRole(ClubUser clubUser) throws Exception {
		
		System.out.println("업데이트 직책 sevice Impl 왔나? ");
		clubDAO.updateMemberRole(clubUser);
	}
	
	@Override
	public void deleteApprovalCondition(ClubUser clubUser) throws Exception {
		clubDAO.deleteApprovalCondition(clubUser);
	}
	
	@Override
	public void addMeeting(Meeting meeting) throws Exception {
		
		System.out.println("addMeeting 서비스 왔나??");
		clubDAO.addMeeting(meeting);
//		clubDAO.addMeetingPush(meeting);
	}
	
	//JUNIT TEST
//	@Override
//	public int addMeeting(Meeting meeting) throws Exception {
//		return clubDAO.addMeeting(meeting);
////		clubDAO.addMeetingPush(meeting);
//	}
	
	@Override
	public Map<String, Object> getMeeting(int meetingNo) throws Exception {		
		System.out.println("getMeeting ServiceImpl 오나??");
		return clubDAO.getMeeting(meetingNo);
	}
	
	@Override
	public void updateMeeting(Meeting meeting) throws Exception {
		
		System.out.println("updateMeeting ServiceImpl 오나?? ");
		clubDAO.updateMeeting(meeting);
	}
	
	@Override
	public void deleteMeeting(int meetingNo) throws Exception {
		clubDAO.deleteMeeting(meetingNo);
	}
	
	@Override
	public void addMeetingMember(Participant participant) throws Exception {
		
		System.out.println("미팅참가 Service Impl 왔나?? ");
		clubDAO.addMeetingMember(participant);
	}
	
	//JUNIT TEST
//	@Override
//	public int addMeetingMember(Participant participant) throws Exception {
//		return clubDAO.addMeetingMember(participant);
//	}
	
	@Override
	public void deleteMeetingMember(Participant participant) throws Exception {
		clubDAO.deleteMeetingMember(participant);
	}
	
	@Override
	public void addMeetingPush(Meeting meeting) throws Exception {
		clubDAO.addMeetingPush(meeting);
	}

	//getClubList bak!
	@Override
	public Map<String, Object> getClubList(Search search) throws Exception {
		
		System.out.println("clubList ServiceImpl까지 왔나??");
		List<Club> list = clubDAO.getClubList(search);
		int totalClubCount = clubDAO.getTotalClubCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clubList", list);
		map.put("totalClubCount", new Integer(totalClubCount));
		return map;
	}
	
//	@Override
//	public Map<String, Object> getClubList(Search search) throws Exception {
//		
//		System.out.println("clubList ServiceImpl까지 왔나??");
//				
//		return clubDAO.getClubList(search);
//	}
	
//	@Override
//	public Map<String, Object> getMyClubList(Map<String, Object> map) throws Exception {
//		
//		System.out.println("나의 모임리스트 ServiceImpl 왔나??");
//		List<ClubUser> list = clubDAO.getMyClubList(map);
//		int totalMyClubCount = clubDAO.getTotalMyClubCount((Search) map.get("search"));
//		
//		Map<String, Object> returnMap = new HashMap<String, Object>();
//		returnMap.put("myClubList",list);
//		returnMap.put("totalMyClubCount", new Integer(totalMyClubCount));
//		return returnMap;
//	}
	
	@Override
	public Map<String, Object> getApprovalConditionList(Search search) throws Exception {
		
		System.out.println("나의 모임리스트 ServiceImpl 왔나??");
		List<ClubUser> list = clubDAO.getApprovalConditionList(search);
		
		int totalApprovalConditionCount = clubDAO.getTotalApprovalConditionCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("approvalConditionList",list);
		map.put("totalApprovalConditionCount", new Integer(totalApprovalConditionCount));
		
		return map;
	}
	
//	//가입신청현황 리스트 --> GetMyClubList와 병합
//	@Override
//	public Map<String, Object> getApprovalConditionList(Search search) throws Exception {
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		List<ClubUser> list = clubDAO.getApprovalConditionList(search);
//		int totalApprovalConditionCount = clubDAO.getTotalApprovalConditionCount(search);
//		
//		map.put("list", list);
//		map.put("totalApprovalConditionCount", totalApprovalConditionCount);
//		
//		return map;
//	}
	
	@Override
	public Map<String, Object> getClubMemberList(Search search) throws Exception {

		
		System.out.println("모임원 리스트 Service왔나?");
		List<ClubUser> list = clubDAO.getClubMemberList(search);
		int totalClubMemberCount = clubDAO.getTotalClubMemberCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("clubMemberList", list);
		map.put("totalClubMemberCount", totalClubMemberCount);
		
		return map;
	}
		
	@Override
	public Map<String, Object> getMeetingList(Search search) throws Exception {

				
		List<Meeting> list = clubDAO.getMeetingList(search);
		int totalMeetingCount = clubDAO.getTotalMeetingCount(search);

		Map<String, Object> map = new HashMap<String,Object>();
		map.put("meetingList", list);
		map.put("totalMeetingCount", totalMeetingCount);
		
		return map;
	}
	
	@Override
	public Map<String, Object> getMeetingMemberList(Search search) throws Exception {
		
		System.out.println("일정참여자리스트 Service Impl 왔나??");
		Map<String,Object> map = new HashMap<String, Object>();
		
		List<Meeting> list = clubDAO.getMeetingMemberList(search);
		int totalMeetingMemberCount = clubDAO.getTotalMeetingMemberCount(search);
		
		map.put("meetingMemberList", list);
		map.put("totalMeetingMemberCount",totalMeetingMemberCount);
		
		return map;
	}
	
//	@SuppressWarnings("unchecked")
//	@Override
//	public List<Map<String, Object>> getCalendarList(Map<String, Object> map) throws Exception {
//		
//		System.out.println("일정참여자리스트 Service Impl 왔나??");
//		List<Map<String, Object>> listMap = new ArrayList<Map<String, Object>>();
//		Map<String, Object> map = new HashMap<String, Object>();
//		
//		
//		map.put("listMap", listMap);
//		map.put("club", listMap)
//
//		int totalMeetingMemberCount = clubDAO.getTotalMeetingMemberCount(search);
//		
//		map.put("totalMeetingMemberCount",totalMeetingMemberCount);
//		
//		return (List<Map<String, Object>>) map;
//	}
	
	//결제
	@Override
	public List<ClubUser> updateClubMember(Pay pay, Search search) throws Exception {
	   System.out.println(getClass() + ".updateClubMember(Pay pay, Search search) 도착");
	   return clubDAO.updateClubMember(pay, search);
	}
	
	// 일정에 참가신청 했었는지 안 했었는지 확인
	public int getCheckMeeting(Participant participant) throws Exception {
		System.out.println(getClass() + ".getCheckMeeting(Participant participant) 도착");
		return clubDAO.getCheckMeeting(participant);
	}

	// 마이홈피에서 접근시 session에 clubNo가 없어서 미팅번호로 모임번호 가져온다
	@Override
	public int getClubNotoMyHome(int meetingNo) throws Exception {
		System.out.println(getClass() + ".getClubNotoMyHome(int meetingNo) 도착");
		return clubDAO.getClubNotoMyHome(meetingNo);
	}

	// 게시물 아이콘 클릭시 로그인한 회원이 해당 모임의 모임원인지 확인
	@Override
	public String getClubMemberListCheck(Club club) throws Exception {
		System.out.println(getClass() + ".getClubMemberListCheck(Club clubNo) 도착");
		return clubDAO.getClubMemberListCheck(club);
	}

	@Override
	public Meeting getMeetingNo(Participant participant) throws Exception {
		System.out.println(getClass() + ".getMeetingNo(Participant participant) 도착");
		return clubDAO.getMeetingNo(participant);
	}
	
	
}
