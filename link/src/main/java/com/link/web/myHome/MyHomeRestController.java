package com.link.web.myHome;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.link.common.Page;
import com.link.common.Search;
import com.link.service.club.ClubService;
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.Club;
import com.link.service.domain.ClubPost;
import com.link.service.domain.ClubUser;
import com.link.service.domain.Feed;
import com.link.service.domain.Heart;
import com.link.service.domain.Meeting;
import com.link.service.domain.Participant;
import com.link.service.domain.User;
import com.link.service.myHome.MyHomeService;
import com.link.service.user.UserService;
import com.link.web.clubPost.ClubPostCommon;

@RestController
@RequestMapping("/myHomeRest/*")
public class MyHomeRestController {
	
	@Autowired
	@Qualifier("myHomeServiceImpl")
	private MyHomeService myHomeService;
	
	@Autowired
	@Qualifier("clubPostServiceImpl")
	private ClubPostService clubPostService;
	
	@Autowired
	@Qualifier("clubServiceImpl")
	private ClubService clubService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	public MyHomeRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(":: MyHomeRestController default Constructor");
	}
	
	//@Value("#{commonProperties['pageSize'] ? : 2}")
		@Value("#{commonProperties['pageSize']}")
		int pageSize;
		
		//@Value("#{commonProperties['pageUnit'] ? : 3}")
		// 없다면 ? 3으로 초기화
		@Value("#{commonProperties['pageUnit']}")
		int pageUnit;
	
	
	@RequestMapping(value = "/json/getFollowList", method = RequestMethod.POST)
	 public Map<String, Object> getFollowList(@RequestBody Search search, User user, HttpSession session) throws Exception{
		 System.out.println("/myHomeRest/json/getFollowList : POST");
		 
		 if(search.getCurrentPage() == 0) {
				search.setCurrentPage(1);
			}
			
			search.setPageSize(pageSize);
			search.setPageUnit(pageUnit);
			
			Map<String, Object> map = new HashMap<String, Object>();
			
			if((User) session.getAttribute("user") != null) {
				String userId = ((User) session.getAttribute("user")).getUserId();
				search.setSearchKeyword(userId);
				
				map.put("search",search);
				map.put("user", user);	
				map.put("list",myHomeService.getFollowList(search).get("list"));
			}
			
		 return map;
		 
	 }
	@RequestMapping(value = "/json/getFollowerList", method = RequestMethod.POST)
	 public Map<String, Object> getFollowerList(@RequestBody Search search,User user) throws Exception{
				 System.out.println("/myHomeRest/json/getMyHome : POST");
				 
				
				 if(search.getCurrentPage() == 0) {
						search.setCurrentPage(1);
					}
					
					search.setPageSize(pageSize);
					search.setPageUnit(pageUnit);
					
					
			         
				 
				 Map<String,Object>map = myHomeService.getFollowerList(search);
				 
				 map.put("search",search);
				 map.put("user", user);	
				 map.put("followerList",myHomeService.getFollowerList(search).get("followerList"));
				 
				 
				 
				 return map;
				 
    }
	 
	@RequestMapping(value = "/json/addFollow", method = RequestMethod.POST)
	public Map<String, Object> addFollow(@RequestBody User user, HttpSession session, Search search)throws Exception{
		
		System.out.println("/myHomeRest/json/addFollow : POST");
		
		String sessionId = ((User)session.getAttribute("user")).getUserId();
		
		System.out.println("세션에 저장된 회원ID : "+sessionId);
		
		user.setUserId(sessionId);
		
		user.setFbType("1");
		
		user.setFbState("1");
		
		myHomeService.addFollow(user);
		
		Map<String, Object> getUser = myHomeService.getFollow(user);

		
		return getUser;
	}
    @RequestMapping(value="/json/updateFollow", method=RequestMethod.POST)
    public Map<String, Object> updateFollow(@RequestBody User user, HttpSession session) throws Exception{
      

         
        System.out.println("/userRest/json/updateBlock : POST");
		
		String sessionId = ((User)session.getAttribute("user")).getUserId();
		
		user.setUserId(sessionId);
		
		System.out.println("입력받은 회원정보 : "+user);
		
		myHomeService.updateFollow(user);
	
		Map<String, Object> map = myHomeService.getFollow(user);
		
		
		return map;

       
         
		 }
    
    
	@RequestMapping(value = "/json/getClubPostListMyHome", method = RequestMethod.POST)
	public Map<String, Object> getClubPostListMyHome(@RequestBody User user,Search search,ClubPost clubPost ,HttpSession session) throws Exception {
		System.out.println("/getClubPostListMyHome : GET : 마이홈피로 내가 작성한 모임게시물 리스트, 모임게시물 리스트 개수");
		// 모임게시물 리스트 : clubPostList, 모임게시물 리스트 개수 : clubPostListCount
		String userId =  ((User)session.getAttribute("user")).getUserId();
		System.out.println((User)session.getAttribute("user"));
	
		search.setSearchKeyword(userId);
		 Map<String, Object> map = new HashMap<String, Object>();
		 System.out.println(clubPostService);
		 System.out.println("ddd"+ (clubPostService.getClubPostListMyHome(userId)));
	
		 map.put("ClubPostList",clubPostService.getClubPostListMyHome(userId).get("clubPostList"));
		 
		 return map;

		
	}
	
	
	
			 
	@RequestMapping(value="/json/getMeetingList",method = RequestMethod.POST)
	public Map<String, Object> getMeetingList(@RequestBody Search search, Model model, HttpSession session, Club club, User user) throws Exception {
		
		System.out.println("/club/getMeetingList : GET/POST");
		
		user = (User) session.getAttribute("user");
		
		session.getAttribute("clubNo");
		System.out.println("세션에 뭐가 있나요 ?? : "+ session.getAttribute("clubNo"));
		
		search.setSearchCondition("1");
		
		search.setSearchKeyword((String) session.getAttribute("clubNo"));
		search.setSearchKeyword(user.getUserId());
		
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
		
		return map;
	}
	@RequestMapping(value="/json/getMeetingMemberList",method = RequestMethod.POST)
	public Map<String, Object>  getMeetingMemberList(@RequestBody Search search, Meeting meeting,Model model, HttpSession session, User user, Participant participant) throws Exception {
		
		System.out.println("/club/getMeetingMemberList : GET/POST");
		
		user = (User) session.getAttribute("user");
		System.out.println("(일정참여자)미팅넘버 세션에 뭐 있지? : "+ session.getAttribute("meetingNo"));
				
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		

		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		search.setOrder(1);
		
		Map<String, Object>  map = clubService.getMeetingMemberList(search);
		
		
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalMeetingMemberCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : "+resultPage);
		
		model.addAttribute("meetingMemberList", map.get("meetingMemberList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("meeting", meeting);
		
		return map;
	}

	@RequestMapping(value="/json/getMeetList",method = RequestMethod.POST)
	public List<Map<String, Object>>  getMeetList(@RequestBody Search search, Meeting meeting,Model model, HttpSession session, User user,String userId) throws Exception {
		
		System.out.println("/club/getMeetingMemberList : GET/POST");
		user = (User) session.getAttribute("user");
		
		System.out.println("(일정참여자)미팅넘버 세션에 뭐 있지? : "+ session.getAttribute("meetingNo"));
		
		search.setOrder(1);
		
		Map<String, Object>  map = clubService.getMeetingMemberList(search);
		
		Map<String, Object> map1 = null;
		
		List<Map<String, Object>> meetingList = new ArrayList<>();
		
		for (int i = 0; i < ((List<Participant>)map.get("meetingMemberList")).size(); i++) {
			
			map1 = new HashMap<>();
			
			map1.put("title", ((List<Participant>)map.get("meetingMemberList")).get(i).getMeeting().getMeetingTitle());
			map1.put("start", ((List<Participant>)map.get("meetingMemberList")).get(i).getMeeting().getMeetingDate());
			map1.put("backgroundColor", "rgb(178, 118, 255)");
            map1.put("borderColor", "rgb(178, 118, 255)");
            map1.put("width", "90px");
            map1.put("url","/club/getMeeting?meetingNo="+( (List<Participant>) map.get("meetingMemberList") ).get(i).getMeetingNo() );
			meetingList.add(map1);
		}
		
       System.out.println("일정 리스트 : " + meetingList.toString());
		
		return meetingList;

	}
	

		@RequestMapping(value = "/json/getFollow", method = RequestMethod.POST)
		public Map<String, Object> getFollow(@RequestBody User user, HttpSession session) throws Exception{
			
			System.out.println("/club/json/getFollow :  POST");
			
			String sessionId = ((User)session.getAttribute("user")).getUserId();
			
			user.setUserId(sessionId);
		
			Map<String, Object> followUser = myHomeService.getFollow(user);
			

			
			return followUser ;
			
		}
		@RequestMapping(value = "/json/getClubPostList", method = RequestMethod.POST)
		public Map<String, Object> getClubPostList(@RequestBody ClubPost clubPost, User user,Search search ) throws Exception {
			System.out.println("/getClubPostListMyHome : GET : 마이홈피로 내가 작성한 모임게시물 리스트, 모임게시물 리스트 개수");
			// 모임게시물 리스트 : clubPostList, 모임게시물 리스트 개수 : clubPostListCount
			
			 String userId = clubPost.getUserId();
			 search.setSearchKeyword(userId);
			 Map<String, Object> map = new HashMap<String, Object>();
			 System.out.println(clubPostService);
			 map.put("ClubPostList",clubPostService.getClubPostListMyHome(userId).get("clubPostList"));
			 
			 return map;

			
		}

		/*
		 * @RequestMapping(value = "/json/getBlockList", method = RequestMethod.POST)
		 * public Map<String, Object> getBlockList(@RequestBody Search search, User
		 * user, HttpSession session) throws Exception{
		 * System.out.println("/myHomeRest/json/getBlockList : POST");
		 * 
		 * if(search.getCurrentPage() == 0) { search.setCurrentPage(1); }
		 * 
		 * search.setPageSize(pageSize); search.setPageUnit(pageUnit);
		 * 
		 * 
		 * String userId = ((User) session.getAttribute("user")).getUserId();
		 * search.setSearchKeyword(userId); Map<String, Object> map = new
		 * HashMap<String, Object>(); map.put("search",search); map.put("user", user);
		 * map.put("blockList",myHomeService.getFollowList(search).get("list"));
		 * 
		 * 
		 * 
		 * 
		 * return map;
		 * 
		 * }
		 */
		@RequestMapping(value="/json/getApprovalConditionList")
		public Map<String, Object> getMyClubList(@RequestBody Search search, Model model, User user, HttpSession session, Club club, ClubUser clubUser, String userId) throws Exception {
			
			System.out.println("/club/getApprovalConditionList : GET/POST");
			
			user = (User) session.getAttribute("user");
//			club = (Club) session.getAttribute("club");
			
			session.getAttribute("clubNo");
//			clubUser.setClubNo(club.getClubNo());
			
			System.out.println("유저 세션에 뭐가 있나요 : "+user);
			System.out.println("클럽넘버는 왔나요 : "+session.getAttribute("clubNo"));
			System.out.println("유저 아이디는 뭐지? : "+userId);
			
			if(search.getOrder()==0) {
				search.setSearchKeyword(user.getUserId());
//				search.setSearchKeyword(userId);
			}else {
				search.setSearchKeyword(userId);
			}
			
			if(search.getCurrentPage()==0) {
				search.setCurrentPage(1);
			}
			search.setPageSize(pageSize);
//			search.setPageUnit(pageUnit);
			
			Map<String, Object> map = clubService.getApprovalConditionList(search);
			
			System.out.println("서치에 뭐 들어있나요 ? ? : "+search);
			
			Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalApprovalConditionCount")).intValue(), pageUnit, pageSize);
			
			System.out.println("resultPage : "+resultPage);
			
			model.addAttribute("approvalConditionList",map.get("approvalConditionList"));
			model.addAttribute("resultPage", resultPage);
			model.addAttribute("search", search);
			
			return map;
		}
		@RequestMapping(value = "/json/getBlockList")
		public Map<String, Object> getBlockList(@ModelAttribute User user,HttpSession session,Search search,String userId, Model model) throws Exception {
		
			String sessionId = ((User)session.getAttribute("user")).getUserId();
			user.setUserId(sessionId);
			
			
			Map<String, Object> map = new HashMap<String, Object>();		
			map.put("user", (User)session.getAttribute("user"));
			map.put("search", search);
			
			search.setSearchKeyword(sessionId);
			map.put("blockList",myHomeService.getBlockList(search).get("list"));
			
			model.addAttribute("blockList", map.get("blockList"));
			model.addAttribute("search", search);
			
			System.out.println("............ "+myHomeService.getBlockList(search).get("list"));
			
			return map;
		}
			
		
}