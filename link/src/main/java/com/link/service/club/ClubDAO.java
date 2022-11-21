package com.link.service.club;

import java.util.List;
import java.util.Map;

import com.link.common.Search;
import com.link.service.domain.Club;
import com.link.service.domain.ClubPost;
import com.link.service.domain.ClubUser;
import com.link.service.domain.Meeting;
import com.link.service.domain.Participant;
import com.link.service.domain.Pay;
import com.link.service.domain.User;

public interface ClubDAO {

	public int addClub(Club club) throws Exception;
	
//	public Club getClub(int clubNo) throws Exception;
	
	public Map<String, Object> getClub(int clubNo) throws Exception;
	
	public List<Club> getClubList(Search search) throws Exception;
	
//	public Map<String, Object> getClubList(Search search) throws Exception;
	
//	public List<Club> getClubList(Map<String, Object> map) throws Exception;
	
	//GetMyClubList
//	public List<ClubUser> getMyClubList(Map<String, Object> map) throws Exception;
	
//	public List<ClubUser> getMyClubList(Search search) throws Exception;
	
	public void deleteClub(int clubNo) throws Exception;
	
	public void updateClub(Club club) throws Exception;
	
	public void addApprovalCondition(ClubUser clubUser) throws Exception;
	
	//JUNIT TEST
//	public int addApprovalCondition(ClubUser clubUser) throws Exception;
	
	//가입신청현황 리스트 --> GetMyClubList와 병합
	public List<ClubUser> getApprovalConditionList(Search search) throws Exception;
	
	public void updateApprovalCondition(ClubUser clubUser) throws Exception;
	
	public List<ClubUser> getClubMemberList(Search search) throws Exception;
	
	public void deleteClubMember(ClubUser clubUser) throws Exception;
	
	public void updateMemberRole(ClubUser clubUser) throws Exception;
	
	public void deleteApprovalCondition(ClubUser clubUser) throws Exception;
	
	public void addMeeting(Meeting meeting) throws Exception;
	
	//JUNIT TEST
//	public int addMeeting(Meeting meeting) throws Exception;
	
	public List<Meeting> getMeetingList(Search search) throws Exception;
	
	public Map<String, Object> getMeeting(int meetingNo) throws Exception;
	
	public void updateMeeting(Meeting meeting) throws Exception;
	
	public void deleteMeeting(int meetingNo) throws Exception;
	
//	public void addMeetingMember(Participant participant) throws Exception;
	
	//JUNIT TEST
	public void addMeetingMember(Participant participant) throws Exception;
	
	public void deleteMeetingMember(Participant participant) throws Exception;
	
	public List<Meeting> getMeetingMemberList(Search search) throws Exception;
	
	public void addMeetingPush(Meeting meeting) throws Exception;
	
	public int getTotalClubCount(Search search) throws Exception;
	
	//가입신청현황 리스트 --> GetMyClubList와 병합
//	public int getTotalApprovalConditionCount(Search search) throws Exception;
	
	public int getTotalClubMemberCount(Search search) throws Exception;
	
	public int getTotalMeetingCount(Search search) throws Exception;
	
	public int getTotalMeetingMemberCount(Search search) throws Exception;
	
//	public int getTotalMyClubCount(Search search) throws Exception;
	
	public int getTotalApprovalConditionCount(Search search) throws Exception;
	
	//결제
	public List <ClubUser> updateClubMember(Pay pay, Search search) throws Exception;
	
	// 일정에 참가신청 했었는지 안 했었는지 확인
	public int getCheckMeeting(Participant participant) throws Exception;

	// 마이홈피에서 접근시 session에 clubNo가 없어서 미팅번호로 모임번호 가져온다
	public int getClubNotoMyHome(int meetingNo) throws Exception;
	
	// 게시물 아이콘 클릭시 로그인한 회원이 해당 모임의 모임원인지 확인
	public String getClubMemberListCheck(Club club) throws Exception;
	
	// 일정 생성 후 참여자로 등록하기 위해서 가장 최근 등록한 일정번호를 가져온다
	public Meeting getMeetingNo(Participant participant) throws Exception;
	
	
}