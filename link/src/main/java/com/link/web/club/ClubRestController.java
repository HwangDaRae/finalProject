package com.link.web.club;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.link.common.Page;
import com.link.common.Search;
import com.link.service.club.ClubService;
import com.link.service.domain.Club;
import com.link.service.domain.ClubUser;
import com.link.service.domain.Meeting;
import com.link.service.domain.Participant;
import com.link.service.domain.User;
import com.link.service.user.UserService;

@RestController
@RequestMapping("/clubRest/*")
public class ClubRestController {

	
	@Autowired
	@Qualifier("clubServiceImpl")
	private ClubService clubService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	UserService userServiceImpl;
	
	public ClubRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass() + "default constructor") ;
	}
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;


	@RequestMapping(value="/json/getClubList")
	public Map<String, Object> getClubList(@RequestBody Search search,Map<String, Object> map, HttpSession session, Club club) throws Exception {
		
		System.out.println("/club/json/getClubList : GET / POST");
		
		System.out.println(search);
		System.out.println(club);
		
		club.setUser((User) session.getAttribute("user"));
		search.setPageSize(pageSize);
		map.put("search", search);
		
		System.out.println("서치에 뭐 들어갔나요? : "+map.get("search"));
		
		return clubService.getClubList(search);		
						
	}
	
	@RequestMapping(value="/json/getClubMemberList")
//	public Map<String, Object> getClubMemberList(@RequestBody Search search, Model model, HttpServletRequest request) throws Exception {
		public Map<String, Object> getClubMemberList(@RequestBody Search search, ClubUser clubUser, Club club, HttpSession session, User user, String clubNo) throws Exception {
		
		System.out.println("/club/json/getClubMemberList : GET / POST");
		
		System.out.println("search : "+ search);
		
		user = (User) session.getAttribute("user");
		clubNo = (String) session.getAttribute("clubNo");
		
		System.out.println("유저 세션에 뭐 있나(REST) : "+user);
		System.out.println("클럽 넘버세션은 ? REST : "+clubNo);
		
		search.setSearchKeyword(clubNo);
		Map<String, Object> map = new HashMap<String, Object>();
		
		System.out.println("레스트 클럽멤버다~ : "+clubService.getClubMemberList(search));
		

		return map;
		

	}
	
//	@RequestMapping(value="json/updateMemberRole", method=RequestMethod.POST)
//	public ClubUser updateMemberRole(@RequestBody ClubUser clubUser, Search search, HttpSession session, User user, Club club) throws Exception {
//		
//		System.out.println("club/json/updateMemberRole : POST");
//		
//		user = (User) session.getAttribute("user");
//		club = (Club) session.getAttribute("club");
//		
//		
////		clubUser.setClubNo(club.getClubNo());
//		
//		System.out.println("클럽유저에 뭐 있지 ? :"+clubUser);
//		
//		clubService.updateMemberRole(clubUser);
//		
//		return (ClubUser) clubService.getClubMemberList(search);
//	}
	
	@RequestMapping(value="/json/updateMemberRole", method=RequestMethod.POST)
	public void updateMemberRole(@RequestBody ClubUser clubUser, Search search, HttpSession session, User user, Club club) throws Exception {
		
		System.out.println("club/json/updateMemberRole : POST");
		
//		user = (User) session.getAttribute("user");
//		club = (Club) session.getAttribute("club");
//		
		
		clubUser.setClubUserNo(clubUser.getClubUserNo());
		
		System.out.println("클럽유저에 뭐 있지 ? :"+clubUser);
		
		clubService.updateMemberRole(clubUser);
	}
	
	
	
	
	@RequestMapping(value="/json/deleteMeeting", method=RequestMethod.POST)
	public void deleteMeeting(@RequestParam(value="meetingNo") int meetingNo, Model model) throws Exception {
		
		System.out.println("deleteMeeting 시작");
		System.out.println("meetingNo = " +meetingNo);
		
		clubService.deleteMeeting(meetingNo);
	}
	
	@RequestMapping(value="/json/deleteClubMember", method=RequestMethod.POST)
	public void deleteClubMember(@RequestBody ClubUser clubUser) throws Exception {
		
		System.out.println("deleteClubMemer 시작");
		System.out.println("clubUserNo = : "+clubUser);
		
		clubUser.setClubUserNo(clubUser.getClubUserNo());
		
		clubService.deleteClubMember(clubUser);
	}
	
	@RequestMapping(value="/json/addMeetingMember", method=RequestMethod.POST)
	public void addMeetingMember(@RequestBody Participant participant, HttpSession session, User user) throws Exception {
		
		System.out.println("addMeetingMember 시작~");
		
		session.getAttribute("meetingNo");
		user = (User) session.getAttribute("user");
		
		System.out.println("meetingNo 잘왔나 ? : "+session.getAttribute("meetingNo"));
		
//		participant.setMeetingNo((int) session.getAttribute("meetingNo"));
//		participant.setUser(user.getUserId());
		
		clubService.addMeetingMember(participant);
		
	}
	
	@RequestMapping(value="/json/deleteMeetingMember", method=RequestMethod.POST)
	public void deleteMeetingMember(@RequestBody Participant participant, HttpSession session, User user, String meetingNo) throws Exception {
		
		System.out.println("deleteMeetingMember 시작~");
		
		user = (User) session.getAttribute("user");
		meetingNo = (String) session.getAttribute("meetingNo");
		
		System.out.println("유저 세션 들왔나? : "+user);
		System.out.println("미팅 넘버는 ? : "+meetingNo);
		
		participant.setMeetingNo(Integer.parseInt(meetingNo));
		participant.setUser(user);
		
		clubService.deleteMeetingMember(participant);
		
	}
	
	
	@RequestMapping(value="/json/updateApprovalCondition", method=RequestMethod.POST)
	public ClubUser updateApprovalCondition(@RequestBody ClubUser clubUser, Model model) throws Exception {
		
		System.out.println("updateApprovalCondition 시작!");
		
		
		clubUser.setApprovalCondition("1");
		clubService.updateApprovalCondition(clubUser);
		model.addAttribute("clubUser",clubUser);

		
		return null;
	}
//	
//	@RequestMapping(value="/json/deleteApprovalCondition", method=RequestMethod.POST)
//	public ClubUser deleteApprovalCondition(@RequestBody ClubUser clubUser, Model model) throws Exception {
//		
//		System.out.println("deleteApprovalCondition 시작 ! ");
//		
//		clubService.deleteApprovalCondition(clubUser);
//		model.addAttribute("clubUser", clubUser);
//		
//		return null;
//	}
	
	//캘린더
	@RequestMapping(value="/json/getMeetList",method = RequestMethod.POST)
	public List<Map<String, Object>>  getMeetList(@RequestBody Search search, Meeting meeting,Model model, HttpSession session, User user,String userId, Club club, String clubNo) throws Exception {
		
		System.out.println("/club/getMeetingList : GET/POST");
		user = (User) session.getAttribute("user");
		clubNo = (String) session.getAttribute("clubNo");
		
		System.out.println("(일정참여자)미팅넘버 세션에 뭐 있지? : "+ session.getAttribute("meetingNo"));
		System.out.println("미팅리스트 클럽 넘버 세션은 ? : "+clubNo);
		
//		search.setOrder(0);
		search.setSearchKeyword(clubNo);
		
//		Map<String, Object>  map = clubService.getMeetingMemberList(search);
		Map<String, Object>  map = clubService.getMeetingList(search);
		
		Map<String, Object> map1 = null;
		
		List<Map<String, Object>> meetingList = new ArrayList<>();
		
//		for (int i = 0; i < ((List<Participant>)map.get("meetingMemberList")).size(); i++) {
		for (int i = 0; i < ((List<Meeting>)map.get("meetingList")).size(); i++) {
			
			map1 = new HashMap<>();
			
//			map1.put("title", ((List<Participant>)map.get("meetingMemberList")).get(i).getMeeting().getMeetingTitle());
			map1.put("title", ((List<Meeting>)map.get("meetingList")).get(i).getMeetingTitle());
//			map1.put("start", ((List<Participant>)map.get("meetingMemberList")).get(i).getMeeting().getMeetingDate());
			map1.put("start", ((List<Meeting>)map.get("meetingList")).get(i).getMeetingDate());
//          map1.put("backgroundColor", "rgb(0, 185, 186)");
			map1.put("backgroundColor", "rgb(178, 118, 255)");
			map1.put("borderColor", "rgb(178, 118, 255)");
			map1.put("meetingNo", ( (List<Meeting>) map.get("meetingList")).get(i).getMeetingNo());
			map1.put("url","/club/getMeeting?meetingNo="+( (List<Meeting>) map.get("meetingList")).get(i).getMeetingNo());
			meetingList.add(map1);
		}
		//System.out.println("이응이응이응"+ map1.get("title").toString());
		//System.out.println("이응이응이응"+ map1.get("start").toString());
			
			
		
		
       System.out.println(meetingList.toString());	
		
		return meetingList;

	}
	
	// 기존 모임원 데이터 가져와서 해당 모임의 모임원인지 확인
	@RequestMapping(value = "/json/getClubMemberListCheck", method = RequestMethod.POST)
	public User getClubMemberListCheck(@RequestBody Club club, HttpSession session) throws Exception {
		club.setUser((User)session.getAttribute("user"));
		System.out.println("로그인한 회원 아이디 : " + club.getUser().getUserId() + ", 모임번호 : " + club.getClubNo());
		String returnUserId = clubService.getClubMemberListCheck(club);
		System.out.println("리턴 회원 아이디 : " + returnUserId);
		if(returnUserId == null) {
			returnUserId = "no";
		}
		User user = new User(returnUserId);
		System.out.println("리턴 회원 아이디 : " + returnUserId);
		return user;
	}
	
	
	
	
}
