package com.link.web.myHome;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.tipis.AbstractReplicatedMap.MapEntry;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.link.common.Page;
import com.link.common.Search;
import com.link.service.club.ClubDAO;
import com.link.service.club.ClubService;
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.Chat;
import com.link.service.domain.Club;
import com.link.service.domain.ClubPost;
import com.link.service.domain.Feed;
import com.link.service.domain.Heart;
import com.link.service.domain.Participant;
import com.link.service.domain.User;
import com.link.service.feed.FeedService;
import com.link.service.myHome.MyHomeService;
import com.link.service.user.UserService;
import com.link.web.clubPost.ClubPostCommon;

@Controller
@SessionAttributes("user")
@RequestMapping("/myHome/*")
public class MyHomeController {
	
	@Autowired
	@Qualifier("myHomeServiceImpl")
	private MyHomeService myHomeService;
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	@Autowired
	@Qualifier("feedServiceImpl")
	private FeedService feedService;
	@Autowired
	@Qualifier("clubServiceImpl")
	private ClubService clubService;
	@Autowired
	@Qualifier("clubPostServiceImpl")
	private ClubPostService clubPostService;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//@Value("#{commonProperties['pageUnit'] ? : 3}")
	// 없다면 ? 3으로 초기화
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	
	public MyHomeController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass() + " default constructor");
	}
	
	@RequestMapping(value = "getMyHome")
	public String getMyHome(@ModelAttribute Search search, Heart heart, String userId,
		       Model model,HttpSession session, Chat chat) throws Exception{
		
		System.out.println("/myHome/getMyHome : GET");

		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
        search.setSearchCondition("1");
  
     
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("user", (User)session.getAttribute("user"));
	    map.put("heart", heart);
		map.put("myHome", 1);
		map.put("search", search);
		
		map = feedService.getFeedList(map);
		
		search.setSearchKeyword(userId);
		map.put("list",myHomeService.getFollowList(search).get("list"));
	   
		model.addAttribute("search", search);
		model.addAttribute("feedList", map.get("feedList"));
		model.addAttribute("list", map.get("list"));
		model.addAttribute("heart", heart);
		model.addAttribute("meetingMemberList", map.get("meetingMemberList"));
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/myHome/getMyHome.jsp";
	}  
	@RequestMapping(value = "getYourHome" ,method=RequestMethod.GET)
	public String getYourHome(@ModelAttribute Search search, Heart heart, String userId, HttpSession session,
		       Model model, Chat chat) throws Exception{
		
		System.out.println("/myHome/getYourHome : GET");
		 search.setSearchCondition("2");
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		String sessoinId = ((User)session.getAttribute("user")).getUserId();
		

		User cutUser = new User();
		User getUser = new User();
		User followUser = new User();
		User recevieId = new User();
		getUser.setUserId(userId);
		User getUserId =userService.getUser(getUser);
		recevieId.setUserId(userId);
		followUser.setReceiveId(recevieId);
		followUser.setUserId(sessoinId);
		cutUser.setReceiveId(followUser);
		cutUser.setUserId(userId);
		cutUser.setFbState("1");
		cutUser.setFbType("2");
		
	    Search search2 = new Search();
		
		search2.setSearchKeyword(userId);
	    search.setOrder(1);
		
		Map<String, Object> followUserId = myHomeService.getFollow(followUser);
		Map<String, Object> cutUserId =  myHomeService.getFollow(cutUser);
		
		System.out.println("/////////////////////컷유저!!!!!!//////"+cutUserId.get("block"));
		
		User users1 = new User();
		users1 = (User)cutUserId.get("block");
		
		
		Map<String, Object> map = new HashMap<String, Object>();
	

	
		map.put("list",myHomeService.getFollowList(search2).get("list"));
		System.out.println("////////////////////////////////////////////////////////////////"+map.get("list"));
		
		System.out.println("/////////////////////////////////userId"+ userId);
	    map.put("heart", heart);
		map.put("myHome", 1);
		map.put("search", search);
		map.put("user", getUserId);
		map.put("search2", search2);
		
		Map<String, Object> map2 = feedService.getFeedList(map);
		
		
		System.out.println( "서버에서 받은  DATA : "+followUserId);
		System.out.println( "팔로우  DATA : "+followUserId.get("followUser"));
		
		System.out.println("////////////////////////////////////////////////////////////////"+map.get("list"));
		
	
		model.addAttribute("search", search);
		model.addAttribute("search2", search2);
		model.addAttribute("feedList", map2.get("feedList"));
		model.addAttribute("totalFeedCount", map2.get("totalFeedCount"));
		model.addAttribute("list", map.get("list"));
		model.addAttribute("heart", heart);
		model.addAttribute("getUser", getUserId);
		model.addAttribute("block", followUserId.get("block"));
		model.addAttribute("followUser", followUserId.get("follow"));
		System.out.println("세션아이디"+sessoinId);
		System.out.println("유저아이디"+userId);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		if(users1 != null) {
			if(users1.getFbState().trim().equals("2")) {
			return "forward:/myHome/getYourHome.jsp";
			}
		}
		
	if(cutUserId.get("block")==null) {
		return "forward:/myHome/getYourHome.jsp";
	}else{
		return "forward:/";
	}
	
	}
	@RequestMapping(value = "getProfile", method = RequestMethod.GET)
	public String getProfile(@RequestParam("userId")String userId,Model model, HttpSession session) throws Exception{
		
		System.out.println("/myHome/getProfile : GET");
		User user = new User();
		user.setUserId(userId);
    	user = userService.getUser(user);
		
        session.setAttribute("user", user);
		
		String sessionId = ((User)session.getAttribute("user")).getUserId();
		System.out.println("sessionId : "+sessionId);
		if(sessionId.equals(user.getUserId())) {
			session.setAttribute("user", user);
		}
		
		return "forward:/myHome/getProfile.jsp";
		
	}
	@RequestMapping(value="updateProfile", method = RequestMethod.GET)
	public String updateProfile(@ModelAttribute("userId") String userId,  Model model) throws Exception {
		
		System.out.println("/user/updateProfile : GET");
		
		User user = new User();
		
		user.setUserId(userId);
		
		
		model.addAttribute("user",user);
		
		return "forward:/myHome/updateProfile.jsp";
	
	}
	@RequestMapping(value="updateProfile", method = RequestMethod.POST)
	public String updateProfile(@ModelAttribute("uesr") User user, Model model, HttpSession session) throws Exception {
		
		System.out.println("/user/updateProfile : POST");
		
		userService.updateUser(user);	//SNS회원 프로필 작성
		
		user = userService.getUser(user);
		
		session.setAttribute("user", user);
		
		String sessionId = ((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())) {
			session.setAttribute("user", user);
		}
		
		return "redirect:/myHome/getProfile?userId="+user.getUserId();
  
}
	@RequestMapping(value ="/updateMyHomeOpenCondition", method = RequestMethod.POST)
	public String updateMyHomeOpenCondition(@ModelAttribute("user")User user, Model model, HttpSession session)
	          throws Exception{
		System.out.println("/user/updateMyHomeOpenCondition : POST");
		
		myHomeService.updateMyHomeOpenCondition(user);
		user = userService.getUser(user);
		String sessionId = ((User)session.getAttribute("user")).getUserId();
		
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		
		return "redirect:/myHome/getMyHome?userId="+user.getUserId();
		
	}
	
	@RequestMapping(value ="/updateMyHomePushCondition", method = RequestMethod.POST)
	public String updateMyHomePushCondition(@ModelAttribute("user")User user, Model model, HttpSession session)
	          throws Exception{
		System.out.println("/user/updateMyHomePushCondition : POST");
		
		myHomeService.updateMyHomePushCondition(user);
		user = userService.getUser(user);
		String sessionId = ((User)session.getAttribute("user")).getUserId();
		
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		
		return "redirect:/myHome/getMyHome?userId="+user.getUserId();
		
	}
	
	@RequestMapping(value = "getFollowList")
	public String getFollowList(@ModelAttribute Search search, Model model) throws Exception {
	
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = new HashMap<String, Object>();		
		map = myHomeService.getFollowList(search);
		map.put("search", search);
		
		model.addAttribute("map", map);
		model.addAttribute("search", search);
		model.addAttribute("list", map.get("list"));
		
		return "forward:/myHome/getFollowList.jsp";
	}
	@RequestMapping(value = "getFollowerList")
	public String getFollowerList(@ModelAttribute Search search, Model model) throws Exception {
        
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = new HashMap<String, Object>();
	
		map.put("search", search);
				
		map = myHomeService.getFollowerList(search);
		
		
	
		model.addAttribute("search", search);
		model.addAttribute("list", map.get("list"));
		
		return "forward:/myHome/getFollowerList.jsp";
	}
	
	@RequestMapping(value = "getPayList")
	public String getPayList(HttpSession session, Model model) throws Exception {
		System.out.println("/getPayList : POST : 마이홈피에서 내가 결제한 리스트");
		User user = new User();
		String sessionId = ((User)session.getAttribute("user")).getUserId();
		user.setUserId(sessionId);
		model.addAttribute("payList", clubPostService.getPayList((User)session.getAttribute("user")));
		return "forward:/pay/getPayList.jsp";
	}
	
	@RequestMapping(value = "getBlockList")
	public String getBlockList(@ModelAttribute User user,HttpSession session,Search search,String userId, Model model) throws Exception {
	
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
		
		return "forward:/myHome/getBlockList.jsp";
	}
	
	
	
}



