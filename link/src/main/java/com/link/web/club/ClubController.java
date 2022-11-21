package com.link.web.club;

import java.io.File;
import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.jsp.PageContext;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.link.common.Page;
import com.link.common.Search;
import com.link.service.club.ClubService;
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.Chat;
import com.link.service.domain.Club;
import com.link.service.domain.ClubUser;
import com.link.service.domain.Meeting;
import com.link.service.domain.Participant;
import com.link.service.domain.User;
import com.link.service.serviceCenter.ServiceCenterService;

@Controller
@RequestMapping("/club/*")
public class ClubController {

	@Autowired
	@Qualifier("clubServiceImpl")
	private ClubService clubService;
	
	@Autowired
	@Qualifier("ServiceCenterServiceImpl")
	private ServiceCenterService serviceCenterService;
	
	// 채팅에 필요한 코딩
	@Autowired
	@Qualifier("clubPostServiceImpl")
	private ClubPostService clubPostService;
	
	public ClubController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass() + " default constructor");
	}
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['clubUploadTempDir']}")
	String clubUploadTempDir;

	@RequestMapping(value="addClub", method=RequestMethod.POST)
	//public String addClub(@ModelAttribute Club club, HttpSession httpSession, User user, ClubUser clubUser, @RequestParam("clubImage") List<MultipartFile> file) throws Exception {
	public String addClub(@ModelAttribute Club club, HttpSession httpSession, User user, ClubUser clubUser, Chat chat,
			Search search, Model model, @RequestParam("file") MultipartFile file) throws Exception {
		
		System.out.println("club/addClub : POST");
		
		user = (User) httpSession.getAttribute("user");
		
		String sysName = "_User_";
		
		Date dateNow = new Date(System.currentTimeMillis());
		
		System.out.println("세션에 뭐 있나? : " + user);
		
		club.setUser(user);
		club.setCurrentMember(1);
		club.setClubMaxMember(10);

		////////////////////////////////////////////////////////////////
		// 모임 생성시 해당 모임의 고유한 채팅방 번호를 생성해서 DB에 넣어준다
		String roomId = UUID.randomUUID()+"";
		System.out.println("채팅방 번호 : " + roomId);
		club.setRoomId(roomId);
		clubUser.setRoomId(roomId);
		////////////////////////////////////////////////////////////////
		
		clubUser.setUser(user);
		clubUser.setMemberRole("2");
		clubUser.setApprovalCondition("1");
		clubUser.setJoinGreeting("모임대표의 가입인사");
		
		if (file != null && file.getSize() > 0) {
			
			//file.transferTo( new File("C:\\Users\\bitcamp\\git\\link\\link\\src\\main\\webapp\\resources\\image\\uploadFiles\\", user.getUserId()+ sysName + dateNow + ("_") + file.getOriginalFilename() ) );
			file.transferTo( new File("C:\\Users\\903-19\\git\\link\\link\\src\\main\\webapp\\resources\\image\\uploadFiles\\", user.getUserId()+ sysName + dateNow + ("_") + file.getOriginalFilename() ) );
					club.setClubImage(user.getUserId() + sysName + dateNow + ("_") + file.getOriginalFilename());
		}
		
		int clubNo = clubService.addClub(club);
		System.out.println("가장 최근 모임번호 : " + clubNo);
		clubService.addApprovalCondition(clubUser);
		
		search.setSearchKeyword(clubNo+"");
		Map<String, Object> map2 = clubService.getClubMemberList(search);
		model.addAttribute("clubMemberList", map2.get("clubMemberList"));
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)httpSession.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)httpSession.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////

		
		// 모임 대표 이미지 가져온다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubService.getClub(clubNo);
		model.addAttribute("club", clubMap.get("club"));
		
		
		
		return "forward:/club/getClub.jsp";
	}
	
	@RequestMapping(value="getClub", method=RequestMethod.POST)
	public String getClub(@ModelAttribute Club club, Model model) throws Exception {
		
		System.out.println("club/getClub : POST");
		
		clubService.addClub(club);
		
		return "forward:/club/getClub.jsp";
	}
	
	@RequestMapping(value="getClub", method=RequestMethod.GET)
	public String getClub(@RequestParam("clubNo") String clubNo, Model model, HttpSession session, User user, Search search, Chat chat) throws Exception {
		
		System.out.println("/club/getClub : GET");
		
		user = (User) session.getAttribute("user");
		
		search.setSearchKeyword(user.getUserId());
		
		Search search2 = new Search();
		
		search2.setSearchKeyword(clubNo);
		
		//Business Logic
		Map<String, Object> map = clubService.getClub(Integer.parseInt(clubNo));
		Map<String, Object> map1 = clubService.getApprovalConditionList(search);
		Map<String, Object> map2 = clubService.getClubMemberList(search2);
		
		//Model 과 View 연결
		System.out.println("MODEL VIEW 연결 전");
		
		model.addAttribute("club", map.get("club"));
		model.addAttribute("clubMemberCount", map.get("totalClubMemberCount"));
		model.addAttribute("totalApprovalConditionCount", map1.get("totalApprovalConditionCount"));
		model.addAttribute("clubMemberList", map2.get("clubMemberList"));
		model.addAttribute("search2", search2);
		session.setAttribute("clubNo", clubNo);
		
		
		System.out.println("유저 세션 뭐지? : " +user);
		System.out.println("클럽 맵에 뭐 들어갔지? : "+map.get("club"));
		System.out.println(" Map1 값은? : "+map1.get("totalApprovalConditionCount"));
		System.out.println("Map2 값은? : "+map2.get("clubMemberList"));
		System.out.println("클럽 넘버 세션은? : "+clubNo);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/club/getClub.jsp";
		
	}
	
	@RequestMapping(value = "updateClubView", method = RequestMethod.GET)
	public String updateClubView(@RequestParam int clubNo, Model model, Chat chat, HttpSession session) throws Exception {
		Map<String, Object> map = clubService.getClub(clubNo);
		model.addAttribute("club", map.get("club"));
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/club/updateClubView.jsp";
	}
	
	
	@RequestMapping(value="updateClub", method=RequestMethod.POST)
	public String updateClub(@ModelAttribute Club club, Model model, HttpSession session, User user,  @RequestParam("file") MultipartFile file, String clubNo)  throws Exception {
		
		System.out.println("club/updateClub : POST");
		
		user = (User) session.getAttribute("user");
		//Business Logic
		clubNo = (String) session.getAttribute("clubNo");
		
		Map<String, Object> map = clubService.getClub(Integer.parseInt(clubNo));
		
		System.out.println("유저 세션에 뭐? : "+user);
		System.out.println("클럽 넘버는? : "+club);
		
//		club.setUser(user);
		club.setClubNo(Integer.parseInt(clubNo));
		
		model.addAttribute("club", map.get("club"));
		System.out.println("클럽 맵에 뭐 있지? : "+ map.get("club"));
		
		String sysName = "_User_";
		
		Date dateNow = new Date(System.currentTimeMillis());		

		
		if (file != null && file.getSize() > 0) {
			
			file.transferTo( new File("C:\\Users\\903-19\\git\\link\\link\\src\\main\\webapp\\resources\\image\\uploadFiles\\", user.getUserId()+ sysName + dateNow + ("_") + file.getOriginalFilename() ) );
			club.setClubImage(user.getUserId() + sysName + dateNow + ("_") + file.getOriginalFilename());
		}
		
		
		///////////////////////////////////////// Business Logic //////////////////////////////////////////				
		
		clubService.updateClub(club);
		 map = clubService.getClub(Integer.parseInt(clubNo));
		 
		 model.addAttribute("club", map.get("club"));
		 model.addAttribute("clubMemberCount", map.get("totalClubMemberCount"));
		
		return "forward:/club/getClub.jsp";
	}
	
	@RequestMapping(value="deleteClub")
	public String deleteClub(@ModelAttribute Club club, Model model, HttpSession session, String clubNo) throws Exception {
		
		System.out.println("deleteClub 시작");
		
		club = (Club) session.getAttribute("club");
		
		clubNo = (String) session.getAttribute("clubNo");
		
		System.out.println("세션에 뭐 있지 : "+session.getAttribute("clubNo"));
		
//		club.setClubNo(Integer.parseInt(clubNo));
		
		// 해당 모임의 모임원 모두 삭제한 뒤 모임 flag처리한다
		clubService.deleteClub(Integer.parseInt(clubNo));
		
		return "forward:/club/getClubList";
	}
		
	@RequestMapping(value="getClubList")
	public String getClubList(@ModelAttribute("search") Search search, Model model, HttpSession session, User user, Chat chat) throws Exception {
		
		System.out.println("/club/getClubList : GET/POST");
		
		user = (User) session.getAttribute("user");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		if(search.getSearchCondition() != null) {
			if(search.getSearchCondition().equals("0")) {
				search.setSearchCondition(null);
			}
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Search search2 = new Search();
		
		search2.setSearchKeyword(user.getUserId());
		
		System.out.println("페이지 : " + search.getCurrentPage() + ", seachConditoin : " + search.getSearchCondition());
		
		Map<String, Object> map = clubService.getClubList(search);
		Map<String, Object> map1 = clubService.getApprovalConditionList(search2);
		
		System.out.println("Map1 값은? : "+map1.get("totalApprovalConditionCount"));
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalClubCount")).intValue(), pageUnit, pageSize);
		
		System.out.println("resultPage : "+resultPage);
		
		model.addAttribute("clubList",map.get("clubList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search",search);
		model.addAttribute("totalApprovalConditionCount", map1.get("totalApprovalConditionCount"));
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/club/getClubList.jsp";
	}
	
	@RequestMapping(value="getApprovalConditionList")
	public String getMyClubList(@ModelAttribute("search") Search search, Model model, User user, HttpSession session, Club club, ClubUser clubUser, String userId) throws Exception {
		
		System.out.println("/club/getApprovalConditionList : GET/POST");
		
		user = (User) session.getAttribute("user");
//		club = (Club) session.getAttribute("club");
		
		session.getAttribute("clubNo");
//		clubUser.setClubNo(club.getClubNo());
		
		System.out.println("유저 세션에 뭐가 있나요 : "+user);
		System.out.println("클럽넘버는 왔나요 : "+session.getAttribute("clubNo"));
		System.out.println("유저 아이디는 뭐지? : "+userId);
		
		if(search.getOrder()==0) {
			search.setSearchKeyword(user.getUserId());
		}else {
			search.setSearchKeyword(userId);
		}
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
//		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = clubService.getApprovalConditionList(search);
		
		System.out.println("서치에 뭐 들어있나요 ? ? : "+search);
		System.out.println("카운트 개수 뭐지? : "+map.get("totalApprovalConditionCount"));
		
//		ArrayList<Integer> arr = new ArrayList<>();
//		arr.addAll((ArrayList) map.get("totalApprovalConditionCount"));
//		int arrlen = arr.size();
//		
//		
//		System.out.println("리스트 개수 가능? : "+arrlen);
		
		
		//Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalApprovalConditionCount")).intValue(), pageUnit, pageSize);
		//Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalApprovalConditionCount")).intValue(), pageUnit, pageSize);
		
		//System.out.println("resultPage : "+resultPage);
		
		model.addAttribute("approvalConditionList",map.get("approvalConditionList"));
		//model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		return "forward:/club/getApprovalConditionList.jsp";
	}
	
	
	@RequestMapping(value="addApprovalCondition", method = RequestMethod.POST)
	public String addApprovalCondition(@ModelAttribute ClubUser clubUser, User user, Club club, Model model, HttpSession httpSession, String clubNo, Map<String, Object> map) throws Exception {
		
		System.out.println("/addApprovalCondition : POST");
		
		user = (User) httpSession.getAttribute("user");
		clubNo = (String) httpSession.getAttribute("clubNo");
		
		System.out.println("유저 세션에 뭐있나? : "+user);
		System.out.println("클럽 넘버는? : "+clubNo);
		
		
		clubUser.setUser(user);
		clubUser.setClubNo(Integer.parseInt(clubNo));
		clubUser.setMemberRole("0");
		clubUser.setApprovalCondition("0");
		
		
		///////////////////////////////////////// Business Logic //////////////////////////////////////////
				
		clubService.addApprovalCondition(clubUser);
		map = clubService.getClub(Integer.parseInt(clubNo));
		
		model.addAttribute("club", map.get("club"));
		model.addAttribute("clubMemberCount", map.get("totalClubMemberCount"));
		
		return "forward:/club/getClub.jsp";		
	}
	
	@RequestMapping(value="getClubMemberList")
	public String getClubMemberList(@ModelAttribute("search") Search search, Model model, HttpSession session, User user, ClubUser clubUser, Club club, String clubNo, Chat chat) throws Exception {
		
		System.out.println("/club/getClubMemberList : GET/POST");
		
		clubNo = (String) session.getAttribute("clubNo");
		user = (User) session.getAttribute("user"); 
		
		search.setSearchKeyword(clubNo);

		
		Map<String, Object> map = clubService.getClubMemberList(search);
		Map<String, Object> map1 = clubService.getClub(Integer.parseInt(clubNo));
		
		System.out.println("유저 세션에 뭐 있지? : "+user);
		System.out.println("클럽 번호 왔나? : "+session.getAttribute("clubNo"));
		System.out.println("클럽 맵에 뭐 있나? : "+map1.get("club"));
		System.out.println("총 클럽원은? : "+map.get("totalClubMemberCount"));
		System.out.println("유저 닉네임 어케 가져오지 : "+user.getNickName());

		model.addAttribute("club",map1.get("club"));
		model.addAttribute("clubMemberList",map.get("clubMemberList"));
//		model.addAttribute("resultPage",resultPage);
		model.addAttribute("totalClubMemberCount",map.get("totalClubMemberCount"));
		model.addAttribute("search",search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/club/getClubMemberList.jsp";
	}
	
	@RequestMapping(value="getMeetingMemberList")
	public String getMeetingMemberList(@ModelAttribute("search") Search search, Model model, HttpSession session, User user, Participant participant, Chat chat) throws Exception {
		
		System.out.println("/club/getMeetingMemberList : GET/POST");
		
		user = (User) session.getAttribute("user");
		System.out.println("(일정참여자)미팅넘버 세션에 뭐 있지? : "+ session.getAttribute("meetingNo"));
		System.out.println("(일정참여자) 유저 세션의 아이디는? : "+user.getUserId());
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		search.setSearchKeyword((String) session.getAttribute("meetingNo"));
		
		Map<String, Object>  map = clubService.getMeetingMemberList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalMeetingMemberCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : "+resultPage);
		
		
		model.addAttribute("meetingMemberList", map.get("meetingMemberList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		// 미팅번호로 모임번호 가져온다
		int returnClubNo = clubService.getClubNotoMyHome(Integer.parseInt((String)session.getAttribute("meetingNo")));
		
		// 모임 대표 이미지 가져온다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubService.getClub(returnClubNo);
		model.addAttribute("club", clubMap.get("club"));
		
		
		
		return "forward:/club/getMeetingMemberList.jsp";
	}
	@RequestMapping(value = "addMeetingView", method = RequestMethod.GET)
	public String addMeetingView(@ModelAttribute Club club, Model model, Map<String, Object> map, Chat chat, HttpSession session) throws Exception{
		System.out.println("모임번호 : " + club.getClubNo());
		map = clubService.getClub(club.getClubNo());
		System.out.println("모임이미지 : " + ((Club)map.get("club")).getClubImage());
		model.addAttribute("club", map.get("club"));
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/club/addMeetingView.jsp";
	}
	
	@RequestMapping(value="addMeeting", method=RequestMethod.POST)
	public String addMeeting(@ModelAttribute Meeting meeting, Model model, HttpSession session, String clubNo, User user, Club club, Map<String, Object> map) throws Exception {
		Participant participant = new Participant();
		
		System.out.println("club/addMeeting : POST ");
		
		user = (User) session.getAttribute("user");
		club = (Club) session.getAttribute("club");
		clubNo = (String) session.getAttribute("clubNo");
		String meetingNo = (String) session.getAttribute("meetingNo");
		
		System.out.println("유저 세션에 뭐있나? : "+user);
		System.out.println("클럽넘버는 잘 왔나? : "+clubNo);
		System.out.println("미팅세션은 ? : "+meetingNo);

		meeting.setUser(user);
		meeting.setClubNo(Integer.parseInt(clubNo));
		meeting.setMeetingMember(1);
		meeting.setMeetingWeather("테스트 날씨");
		
		//participant 들어가나?
		participant.setUser(user);
	//	participant.setMeetingNo(meeting.getMeetingNo());
		/////////////////////////////////// Business Logic /////////////////////////////////////////////////////

		clubService.addMeeting(meeting);
		// 가장 최근 등록한 일정번호 가져온다
		//Meeting me = clubService.getMeetingNo(participant);
		//participant.setMeetingNo(me.getMeetingNo());
		clubService.addMeetingMember(participant);
		map = clubService.getClub(Integer.parseInt(clubNo));
		
		
		model.addAttribute("club", map.get("club"));
		model.addAttribute("clubMemberCount", map.get("totalClubMemberCount"));
		session.setAttribute("clubNo", clubNo);
		
		
		System.out.println("유저 세션 뭐지? : " +user);
		System.out.println("클럽 맵에 뭐 들어갔지? : "+map.get("club"));
		System.out.println("클럽 넘버 세션은? : "+clubNo);
		
		return "forward:/club/getClub.jsp";
	}
	
	@RequestMapping(value="addMeetingMember", method=RequestMethod.POST)
	public String addMeetingMember(@ModelAttribute Participant participant, HttpSession session, User user, String meetingNo) throws Exception {
		
		System.out.println("/club/addMeetingMember : POST ");
		
		user = (User) session.getAttribute("user");
		meetingNo = (String) session.getAttribute("meetingNo");
		
		System.out.println("유저 세션에 뭐있지 : "+user);
		System.out.println("미팅넘버 왔나? : "+session.getAttribute("meetingNo"));

		participant.setUser(user);
		participant.setMeetingNo(Integer.parseInt(meetingNo));
		
		// 참가신청 했는지 알아본다
		int check = clubService.getCheckMeeting(participant);
		
		if( check == 0) {
			// 참가신청 안 했다면
			clubService.addMeetingMember(participant);
		}
		
		return "forward:/club/getMeetingMemberList";
	}
	
	
	@RequestMapping(value="getMeetingList")
	public String getMeetingList(@ModelAttribute("search") Search search, Model model, HttpSession session, Club club, User user) throws Exception {
		
		System.out.println("/club/getMeetingList : GET/POST");
		
		user = (User) session.getAttribute("user");
		
		session.getAttribute("clubNo");
		System.out.println("세션에 뭐가 있나요 ?? : "+ session.getAttribute("clubNo"));
		
		
		
		search.setSearchKeyword((String) session.getAttribute("clubNo"));
//		search.setSearchKeyword(user.getUserId());
		search.setSearchCondition("0");
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String, Object> map = clubService.getMeetingList(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalMeetingCount")).intValue(), pageUnit, pageSize);
		
		System.out.println("resultPage : "+resultPage);
		
		
		search.setSearchKeyword((String) session.getAttribute("clubNo"));
		model.addAttribute("meetingList",map.get("meetingList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search",search);
		
		return "forward:/club/getMeetingList.jsp";
		
	}
	
	@RequestMapping(value="getMeeting", method = RequestMethod.POST)
	public String getMeeting(@ModelAttribute Meeting meeting, Chat chat, HttpSession session, Model model) throws Exception {
		
		System.out.println("club/getMeeting : POST ");
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		clubService.addMeeting(meeting);
		
		return "forward:/club/getMeeting.jsp";
	}
	
	@RequestMapping(value="getMeeting", method=RequestMethod.GET)
	public String getMeeting(@RequestParam("meetingNo") String meetingNo, Model model, HttpSession session, Search search, String clubNo, Chat chat) throws Exception {
	
		System.out.println("/club/getMeeting : GET");
		
		clubNo = (String) session.getAttribute("clubNo");
		search.setSearchKeyword(clubNo);
		
		if( search.getSearchKeyword() == null || search.getSearchKeyword().equals("") ) {
			// 마이홈피에서 접근시 session에 clubNo가 없어서 미팅번호로 모임번호 가져온다
			int no = clubService.getClubNotoMyHome(Integer.parseInt(meetingNo));
			System.out.println("모임 번호 : " + no);
			search.setSearchKeyword(no+"");
		}
		
		//Business Logic
		Map<String, Object> map = clubService.getMeeting(Integer.parseInt(meetingNo));
		Map<String, Object> map2 = clubService.getClubMemberList(search);
		// 미팅정보 : meeting, 미팅의 총 참여자 수 : totalMeetingMemberCount
		
		//Model 과 View 연결
		System.out.println("MODEL VIEW 연결 전 ");
		
		model.addAttribute("meeting", map.get("meeting"));
		model.addAttribute("meetingCount", map.get("totalMeetingMemberCount"));
		model.addAttribute("clubMemberList", map2.get("clubMemberList"));
		session.setAttribute("meetingNo", meetingNo);
		
		System.out.println("미팅 맵에 뭐 있나? : " + map.get("meeting"));
		System.out.println("겟에서 세션에 들어갔나? :"+meetingNo);
		System.out.println("Map2 값은? : "+map2.get("clubMemberList"));
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		// 미팅번호로 모임번호 가져온다
		int returnClubNo = clubService.getClubNotoMyHome(Integer.parseInt(meetingNo));
		
		// 모임 대표 이미지 가져온다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubService.getClub(returnClubNo);
		model.addAttribute("club", clubMap.get("club"));
		
		// 모임에 참여하는 인원 리스트
		Map<String, Object> meetingMember = new HashMap<String, Object>();
		Search search2 = new Search();
		search2.setSearchKeyword(meetingNo);
		meetingMember = clubService.getMeetingMemberList(search2);
		model.addAttribute("meetingMemberList", meetingMember.get("meetingMemberList"));
		
		return "forward:/club/getMeeting.jsp";
	}
	
	@RequestMapping(value="updateMeetingView", method=RequestMethod.GET)
	public String updateMeetingView(@RequestParam int meetingNo, Model model, Chat chat, HttpSession session) throws Exception {
		
		Map<String, Object> map = clubService.getMeeting(meetingNo);
		model.addAttribute("meeting", map.get("meeting"));
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		// 미팅번호로 모임번호 가져온다
		int returnClubNo = clubService.getClubNotoMyHome(meetingNo);
		
		// 모임 대표 이미지 가져온다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubService.getClub(returnClubNo);
		model.addAttribute("club", clubMap.get("club"));
		
		
		return "forward:/club/updateMeetingView.jsp";
	}
	
	
	@RequestMapping(value="updateMeeting", method=RequestMethod.POST)
	public String updateMeeting(@ModelAttribute Meeting meeting, Model model, HttpSession session, String clubNo, User user, Club club, String meetingNo) throws Exception {
		
		System.out.println("club/updateMeeting : POST");
		
		user = (User) session.getAttribute("user");
		clubNo = (String) session.getAttribute("clubNo");
		meetingNo = (String) session.getAttribute("meetingNo");
		
		System.out.println("유저 세션 잘 왔나? : "+user);
		System.out.println("클럽넘버 왔나? : "+clubNo);
		
		meeting.setMeetingNo(Integer.parseInt(meetingNo));
		meeting.setUser(user);
		meeting.setClubNo(Integer.parseInt(clubNo));
		meeting.setMeetingMember(1);
		meeting.setMeetingWeather("수정 테스트 날씨");
		
		//Business Logic
		clubService.updateMeeting(meeting);
		
		// 모임 대표 이미지 가져온다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubService.getClub(Integer.parseInt(clubNo));
		model.addAttribute("club", clubMap.get("club"));
		
		return "forward:/club/getMeeting.jsp";
	}
	
	@RequestMapping(value="deleteMeeting")
	public String deleteMeeting(@ModelAttribute Meeting meeting, String meetingNo, Model model, HttpSession session, String clubNo, Map<String, Object> map) throws Exception {
		
		System.out.println("deleteMeeting 시작~~~~~~~~~~~~~~~~~~~");
		
		clubNo = (String) session.getAttribute("clubNo");
		meetingNo = (String) session.getAttribute("meetingNo");
		
		System.out.println("세션에 뭐 있지 : "+session.getAttribute("meetingNo"));
		
		meeting.setMeetingNo(Integer.parseInt(meetingNo));
		
		/////////////////////////////////// Business Logic /////////////////////////////////////////////////////
		
		clubService.deleteMeeting(Integer.parseInt(meetingNo));
		map = clubService.getClub(Integer.parseInt(clubNo));
		
		model.addAttribute("club", map.get("club"));
		model.addAttribute("clubMemberCount", map.get("totalClubMemberCount"));
		
		return "forward:/club/getClub.jsp";
	}
	
	@RequestMapping(value="deleteMeetingMember", method=RequestMethod.POST)
	public String deleteMeeting(@ModelAttribute Participant participant, Model model, HttpSession session, Search search, User user, String meetingNo, String clubNo, Map<String, Object> map, Chat chat, HttpSession httpSession) throws Exception {
		
		System.out.println("deleteMeetingMember 시작~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~");
		
		user = (User) session.getAttribute("user");
		meetingNo = (String) session.getAttribute("meetingNo");
		clubNo = (String) session.getAttribute("clubNo");
		
		System.out.println("유저 세션 잘왔나? : "+user);
		System.out.println("미팅 넘버는 ? : "+meetingNo);
		
		participant.setMeetingNo(Integer.parseInt(meetingNo));
		participant.setUser(user);
		
		
		/////////////////////////////////// Business Logic /////////////////////////////////////////////////////
		
		clubService.deleteMeetingMember(participant);
		map = clubService.getMeeting(Integer.parseInt(meetingNo));
		
		model.addAttribute("club", map.get("club"));
		model.addAttribute("clubMemberCount", map.get("totalClubMemberCount"));
		model.addAttribute("meeting", map.get("meeting"));
		model.addAttribute("meetingCount", map.get("totalMeetingMemberCount"));
		
		// 참가신청 취소한 뒤 참가신청 버튼 나오게 하려면 모임원인지 알아야해서 모임원 리스트 가져간다
		clubNo = (String) session.getAttribute("clubNo");
		search.setSearchKeyword(clubNo);
		Map<String, Object> map2 = clubService.getClubMemberList(search);
		model.addAttribute("clubMemberList", map2.get("clubMemberList"));
		
		
		
		// 모임 대표 이미지 가져온다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubService.getClub(Integer.parseInt(clubNo));
		model.addAttribute("club", clubMap.get("club"));
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)httpSession.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)httpSession.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/club/getMeeting.jsp";
	}
	
	@RequestMapping(value="deleteApprovalCondition", method=RequestMethod.POST)
	public String deleteApprovalCondition(@ModelAttribute ClubUser clubUser, HttpSession session, Club club, User user, String clubNo) throws Exception {
		
		System.out.println("deleteApprovalCondition 시작~~~~~ ");
		
		user = (User) session.getAttribute("user");
		clubNo = (String) session.getAttribute("clubNo");
		
		clubUser.setUser(user);
		clubUser.setClubNo(Integer.parseInt(clubNo));
		
		clubService.deleteApprovalCondition(clubUser);
		
		return "forward:/club/getClubList";
	}
	
//	
//	@RequestMapping(value="deleteClubMember", method=RequestMethod.POST)
//	public String deleteClubMember(@ModelAttribute ClubUser clubUser) throws Exception {
//		
//		System.out.println("deleteClubMember 시작~~~~~");
//		
//		clubUser.setClubUserNo(clubUser.getClubUserNo());
//		
//		clubService.deleteClubMember(clubUser);
//		
//		return "forward:/club/getClubMemberList";
//	}
}
