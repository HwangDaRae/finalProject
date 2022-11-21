package club;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.link.common.Search;
import com.link.service.club.ClubDAO;
import com.link.service.club.ClubService;
import com.link.service.domain.Club;
import com.link.service.domain.ClubUser;
import com.link.service.domain.Meeting;
import com.link.service.domain.Participant;
import com.link.service.user.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
public class ClubServiceTest {
	
	@Autowired
	@Qualifier("clubServiceImpl")
	private ClubService clubService;
	
	@Autowired
	@Qualifier("clubDAOImpl")
	private ClubDAO clubDAO;
	

//	@Test
//	public void testAddClub() throws Exception {
//		
//		System.out.println("\n ===================================");
//		Club club = new Club();
//		club.setClubNo(10);
//		club.setUserId("user01");
//		club.setClubTitle("JunitTEST 모임제목");
//		club.setClubDetail("JUNIT TEST 모임상세");
//		club.setClubRegDate(null);
//		club.setCurrentMember(1);
//		club.setClubMaxMember(10);
//		club.setClubCategory("JUNIT TEST 모임카타고리");
//		club.setClubArea("JUNIT TEST 모임활동영역");
//		club.setClubImage("JUNIT TEST 모임이미지");
//				
		//int로 바꿔야함
//		System.out.println("insert 결과 : "+clubService.addClub(club));
//		Assert.assertEquals(1, clubService.addClub(club));		
//	}
	
//	@Test
//	public void testGetClub() throws Exception {
//		
//		System.out.println("\n ===========================");
//		Club club = clubService.getClub(1);
//		System.out.println(club);
//		
//		Assert.assertEquals(1, club.getClubNo());
//		
//		System.out.println("========================\n");
//		
//	}
	
	//@Test
	public void testGetClubList() throws Exception {
		
		System.out.println("\n============================");
		
		Search search = new Search();
		
		Map<String, Object> map = clubService.getClubList(search);
						
		List<Club> list = (List<Club>) map.get("clubList");
		
		System.out.println("list값?? : "+list);		
		System.out.println("=============================\n");
	}
	
	
	@Test
	public void testGetApprovalConditionList() throws Exception {
		
		System.out.println("\n==============================");
		
		Search search = new Search();
		
		search.setSearchKeyword("user02");
		
		Map<String, Object> map = clubService.getApprovalConditionList(search);
		
		List<Club> list = (List<Club>) map.get("approvalConditionList");
				
		System.out.println("list 값?? : "+list);
		System.out.println("==================================\n");
	}

//	@Test
	public void testDeleteClub() throws Exception {
		
		System.out.println("\n ===============================");
		
		
		clubService.deleteClub(4);
	}
	
//	@Test
//	public void testUpdateClub() throws Exception {
//		
//		System.out.println("\n=================================");
//		
//		Club club = clubService.getClub(3);
//		
//		System.out.println("변경전 club : "+club);
//		
//		Club club01 = new Club();
//		club.setClubNo(3);
//		club.setClubTitle("JUNIT 수정테스트 모임제목");
//		club.setClubDetail("Junit 수정테스트 모임상세");
//		club.setClubCategory("Junit 수정테스트 모임카타");
//		club.setClubArea("Junit 수정테스트 모임지역");
//		club.setClubImage("Junit 수정테스트 모임이미지");
//		
//		clubService.updateClub(club);
//		System.out.println("변경 후 club : " + club);
//	}
	
	//@Test
//	public void TestAddApptrovalCondition() throws Exception {
//		
//		System.out.println("\n========================================");
//		
//		ClubUser clubUser = new ClubUser();
//		clubUser.setClubUserNo(55);
//		clubUser.setUserId("user03");
//		clubUser.setClubNo(2);
//		clubUser.setApplicationRegDate(null);
//		clubUser.setJoinRegDate(null);
//		clubUser.setMemberRole("1");
//		clubUser.setApprovalCondition("1");
//		clubUser.setJoinGreeting("JUNIT 테스트 가입인사");
//		
//		System.out.println("insert 결과 : "+clubService.addApprovalCondition(clubUser));
//		Assert.assertEquals(1, clubService.addApprovalCondition(clubUser));
//		
//	}

	//가입신청현황 리스트 --> GetMyClubList와 병합
//	//@Test
//	public void TestgetApprovalConditionList() throws Exception {
//		
//		System.out.println("\n===============================================");
//		
//		Search search = new Search();
//		
//		search.setSearchKeyword("user03");
//		Map<String, Object> map = clubService.getApprovalConditionList(search);
//		
//		List<ClubUser> list = (List<ClubUser>) map.get("ApprovalConditionList");
//		
//		System.out.println("list 값 ?? : "+list);
//		System.out.println("================================================\n");
//		
//	}
	
	//@Test
	public void TestUpdateApprovalCondition() throws Exception {
		
		System.out.println("\n===============================================");
				
		ClubUser clubUser = new ClubUser();
		clubUser.setClubUserNo(55);
		clubUser.setApprovalCondition("2");
		
		clubService.updateApprovalCondition(clubUser);
	}
	
	//@Test
	public void TestUpdateMemberRole() throws Exception {
		
		System.out.println("\n===============================================");
				
		ClubUser clubUser = new ClubUser();
		clubUser.setClubUserNo(19);
		clubUser.setMemberRole("2");
		
		clubService.updateMemberRole(clubUser);
	}
	
	//@Test
	public void TestDeleteClubMember() throws Exception {
		
		System.out.println("\n==============================================");
		
//		clubService.deleteClubMember(19);
	}
	
	//@Test
	public void TestDeleteApprovalCondition() throws Exception {
		
		System.out.println("\n==============================================");
		
		ClubUser clubUser = new ClubUser();
		clubUser.setClubUserNo(18);
		clubUser.setApprovalCondition("0");
		
		clubService.deleteApprovalCondition(clubUser);
	}
	
//	@Test
	public void TestGetClubMemberList() throws Exception {
		
		System.out.println("\n====================================");
		Search search = new Search();
		
		search.setSearchKeyword("2");
		Map<String, Object> map = clubService.getClubMemberList(search);
		
		List<ClubUser> list = (List<ClubUser>) map.get("clubMemberList");
				
		System.out.println("list 값 ?? : "+list);		
		System.out.println("===========================\n");
	}
	
//	@Test
//	public void TestAddMeeting() throws Exception {
//		
//		System.out.println("\n============================================");
//		
//		Meeting meeting = new Meeting();
//		meeting.setMeetingNo(6);
//		meeting.setClubNo(9);
//		meeting.setUserId("user02");
//		meeting.setMeetingTitle("JUNIT TEST 일정제목");
//		meeting.setMeetingContent("JUNIT TEST 미팅내용");
//		meeting.setMeetingDate("2022/10/05");
//		meeting.setMeetingPlace("JUNIT TEST 장소");
//		meeting.setMeetingTime("JUNIT TEST 시간");
//		meeting.setMeetingWeather("JUNIT TEST 날씨");
//		meeting.setMeetingRegDate(null);
//		meeting.setMeetingMember(5);
//		meeting.setMeetingMaximumMember(10);
//		
//		System.out.println("insert 결과 : "+clubService.addMeeting(meeting));
//		Assert.assertEquals(1, clubService.addMeeting(meeting));		
//	}
	
	//@Test
//	public void TestGetMeeting() throws Exception {
//		
//		System.out.println("\n====================================");
//		
//		Meeting meeting = clubService.getMeeting(6);
//		System.out.println(meeting);
//		
//		Assert.assertEquals(6, meeting.getMeetingNo());
//		
//		System.out.println("==============================\n");
//	}
	
	//@Test
//	public void TestUpdateMeeting() throws Exception {
//		
//		System.out.println("\n===========================================");
//		
//		Meeting meeting = clubService.getMeeting(6);
//		
//		System.out.println("변경 전 meeting : "+meeting);
//		
//		Meeting meeting01 = new Meeting();
//		meeting.setMeetingNo(6);
//		meeting.setMeetingTitle("JUNIT 수정테스트 일정제목");
//		meeting.setMeetingContent("JUNIT 수정TEST 미팅내용");
//		meeting.setMeetingDate("JUNIT 수정테스트 date");
//		meeting.setMeetingTime("JUNIT 수정테스트 일정시간");
//		meeting.setMeetingMaximumMember(50);
//		
//		clubService.updateMeeting(meeting);
//		System.out.println("변경 후 meeting : "+meeting);
//	}
	
//	@Test
	public void TestGetMeetingList() throws Exception {
		
		System.out.println("\n======================================");
		Search search = new Search();
		
		search.setSearchKeyword("2");
		Map<String, Object> map = clubService.getMeetingList(search);
		
		List<Meeting> list = (List<Meeting>) map.get("meetingList");
		
		System.out.println("list 값 ?? : "+list);		
		System.out.println("===================================\n");
	}
	
	//@Test
	public void TestDeleteMeeting() throws Exception {
		
		System.out.println("\n============================================");
		
		clubService.deleteMeeting(5);
	}
	
//	@Test
//	public void TestAddMeetingMember() throws Exception {
//		
//		System.out.println("\n========================================");
//		
//		Participant participant = new Participant();
//		
//		participant.setParticipantNo(10);
//		participant.setMeetingNo(2);
//		participant.setParticipantUserId("user04");
//		
//		System.out.println("insert 결과 : "+clubService.addMeetingMember(participant));
//		Assert.assertEquals(1, clubService.addMeetingMember(participant));
//	}
//	
//	//@Test
//	public void TestDeleteMeetingMember() throws Exception {
//		
//		System.out.println("\n==========================================");
//		
//		clubService.deleteMeetingMember(23);
//	}
	
//	@Test
	public void TestGetMeetingMemberList() throws Exception {
		
		System.out.println("\n===========================================");
		Search search = new Search();
		
		search.setSearchKeyword("2");
		Map<String, Object> map = clubService.getMeetingMemberList(search);
		
		List<Participant> list = (List<Participant>) map.get("participantList");
		
		System.out.println("list 값 ?? : " +list);
		
		System.out.println("=======================================\n");
		
	}
}
