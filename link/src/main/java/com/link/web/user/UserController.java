package com.link.web.user;

import java.io.File;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import javax.servlet.http.HttpSession;

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
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.Chat;
import com.link.service.domain.User;
import com.link.service.myHome.MyHomeService;
import com.link.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;

	@Autowired
	@Qualifier("myHomeServiceImpl")
	private MyHomeService myHomeService;
	
	@Autowired
	@Qualifier("clubPostServiceImpl")
	private ClubPostService clubPostService;

	public UserController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['uploadTempDir']}")
	String uploadTempDir;

	@RequestMapping(value = "addUser", method = RequestMethod.GET)
	public String addUser() throws Exception {
 
		System.out.println("/user/addUser : GET");

		return "redirect:/user/addUserView.jsp";
	}

	@RequestMapping(value = "addUser", method = RequestMethod.POST)
	public String addUser(@ModelAttribute("user") User user, HttpSession session,
			@RequestParam("profileImageFile") MultipartFile file) throws Exception {

		System.out.println("/user/addUser : POST");

		String sysName = "_User_";

		Date dateNow = new Date(System.currentTimeMillis());

		System.out.println(dateNow);

		User image = new User();
		image = userService.getUser(user);
		
		if (file != null && file.getSize() > 0) {

			file.transferTo(
					new File("C:\\Users\\bitcamp\\git\\link\\link\\src\\main\\webapp\\resources\\image\\uploadFiles\\", user.getUserId() + sysName + dateNow + ("_") + file.getOriginalFilename()));
			user.setProfileImage(user.getUserId() + sysName + dateNow + ("_") + file.getOriginalFilename());

		}else {
			if(image != null) {
				user.setProfileImage(image.getProfileImage());
			}
		}

		userService.addUser(user); // ???????????? ?????? DB??????

		User getUser = userService.getUser(user);

		session.setAttribute("user", getUser);

		return "redirect:/feed/getFeedList";
	}

	@RequestMapping(value = "addSnsUser", method = RequestMethod.POST)
	public String addSnsUser(@ModelAttribute("user") User user, HttpSession session) throws Exception {

		System.out.println("/user/addSnsUser : POST");

		User getUser = new User();
		User login = new User();
//		User user= new User();
//		user.setSnsUserId(snsUserId);
		Random rand = new Random();
		String no = "";

		while (true) {

			for (int i = 0; i < 4; i++) {
				String ran = Integer.toString(rand.nextInt(10));
				no += ran;

			}
			
			user.setUserId("Link" + no); // SNS?????? ID ????????? ?????? ?????? ??????
			
			user.setProfileImage("default.png");
			
			System.out.println("User??? ????????? Data : " + user);

			getUser = userService.getUser(user);

			if (getUser == null) {

				userService.addUser(user); // SNS?????? ID, ????????????, ???????????? DB??????

				login = userService.getUser(user);
 
				session.setAttribute("user", login);

				break;
			}
		}

		return "redirect:/user/updateProfile?userId=" + user.getUserId();

	}

	@RequestMapping(value = "getUser", method = RequestMethod.GET)
	public String getUser(@ModelAttribute("userId") String userId, Model model, HttpSession session, Chat chat) throws Exception {

		System.out.println("/user/getUser : GET");

		User user = new User();

		System.out.println("???????????? ???????????? ??????ID : " + userId);

		String sessionId = ((User) session.getAttribute("user")).getUserId();

		System.out.println("sessionId = " + sessionId);

		System.out.println("????????? ?????? 1??? ?????? : " + ((User) session.getAttribute("user")).getRole().equals("1"));

		user.setUserId(userId);

		User getUser = userService.getUser(user); // ????????? ????????? ???????????? ??????ID DB??????

		model.addAttribute("getUser", getUser); // DB?????? ???????????? ????????? ????????? Key(user)??? ??????
		
		
		
		///////////////////////// ????????? ????????? ?????? //////////////////////////////////
		// 1:1 ?????? ??????????????? ????????????
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// ???????????? roomId ????????????
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// ????????? ????????? ?????? //////////////////////////////////
		
		

		if (userId.equals(sessionId) || ((User) session.getAttribute("user")).getRole().equals("1")) {

			return "forward:/user/getUser.jsp";

		} else {

			return "redirect:/feed/getFeedList";
		}
	}

	@RequestMapping(value = "getUserId", method = RequestMethod.GET)
	public String getUserId() throws Exception {

		System.out.println("/user/getUser : GET");

		return "forward:/user/getIdView.jsp"; // ??????Navigation
	}

	@RequestMapping(value = "updateUser", method = RequestMethod.GET)
	public String updateUser(@ModelAttribute("userId") String userId, Model model, HttpSession session, Chat chat)
			throws Exception {

		System.out.println("/user/updateUser : GET");

		System.out.println("???????????? UserId : " + userId);

		String sessionId = ((User) session.getAttribute("user")).getUserId();

		System.out.println("????????? ????????? UserId : " + sessionId);
		
		
		
		///////////////////////// ????????? ????????? ?????? //////////////////////////////////
		// 1:1 ?????? ??????????????? ????????????
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// ???????????? roomId ????????????
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// ????????? ????????? ?????? //////////////////////////////////
		
		

		if (userId == null || userId.equals("")) {

			return "forward:/user/updateUserView.jsp";

		} else if (sessionId.equals(userId) || ((User) session.getAttribute("user")).getRole().equals("1")) {

			User user = new User();
			user.setUserId(userId);
			User getUser = userService.getUser(user);
			model.addAttribute("getUser", getUser);

			return "forward:/user/updateUserView.jsp";
		} else {
			return "redirect:/feed/getFeedList";
		}

	}

	@RequestMapping(value = "updateUser", method = RequestMethod.POST)
	public String updateUser(@ModelAttribute("user") User user, Model model, HttpSession session) throws Exception {

		System.out.println("/user/updateUser : POST");

		System.out.println("???????????? ????????? UserDate ??? : " + user);

		System.out.println("???????????? ????????? Date ??? : " + user.getStopEndDateString());

		if (user.getStopEndDateString() != "" && user.getStopEndDateString() != null) {

			java.sql.Date d = java.sql.Date.valueOf(user.getStopEndDateString());

			user.setStopEndDate(d);

		} else {
			user.setStopEndDate(null);
		}

		System.out.println("?????? Date ??? : " + user.getStopEndDate());

		System.out.println("???????????? ???????????? ????????? ??? : " + user.getPenaltyType());
		if (user.getPenaltyType() != null) {
			if (user.getPenaltyType().equals("???")) {
				user.setPenaltyType("0");
				System.out.println("???????????? ??? ??? ?????? : " + user.getPenaltyType());
				userService.updateUser(user);
			} else if (user.getPenaltyType().equals("??????")) {
				user.setPenaltyType("1");
				System.out.println("???????????? ????????? ?????? : " + user.getPenaltyType());
				userService.updateUser(user);
			} else {
				user.setPenaltyType("2");
				System.out.println("???????????? ??????????????? ?????? : " + user.getPenaltyType());
				userService.updateUser(user);
			}
		}

		userService.updateUser(user);

		user = userService.getUser(user);

		String sessionId = ((User) session.getAttribute("user")).getUserId();
		System.out.println("sessionId : " + sessionId);
		if (sessionId.equals(user.getUserId())) {
			session.setAttribute("user", user);
		}

		return "redirect:/user/getUser?userId=" + user.getUserId();
	}

	@RequestMapping(value = "updateProfile", method = RequestMethod.GET)
	public String updateProfile(@ModelAttribute("userId") String userId, Model model, HttpSession session)
			throws Exception {

		System.out.println("/user/updateProfile : GET");

		System.out.println(session.getAttribute("user").toString());

		String sessionId = ((User) session.getAttribute("user")).getUserId();

		System.out.println("????????? ????????? UserId : " + sessionId);

		if (sessionId.equals(userId)) {

			User user = new User();
			user.setUserId(userId);
			User getUser = userService.getUser(user);
			model.addAttribute("getUser", getUser);

			return "forward:/user/updateProfileView.jsp";
		} else {
			return "redirect:/feed/getFeedList";
		}
	}

	@RequestMapping(value = "updateProfile", method = RequestMethod.POST)
	public String updateProfile(@ModelAttribute("user") User user, Model model, HttpSession session,
			@RequestParam("profileImageFile") MultipartFile file) throws Exception {

		System.out.println("/user/updateProfile : POST");

		Date dateNow = new Date(System.currentTimeMillis());

		System.out.println("????????? file : "+file);
		
		User image = new User();
		image = userService.getUser(user);
		
		if (file != null && file.getSize() > 0) {
			file.transferTo(
					new File(uploadTempDir, user.getUserId() + "_User_" + dateNow + "_" + file.getOriginalFilename()));
			user.setProfileImage(user.getUserId() + "_User_" + dateNow + "_" + file.getOriginalFilename());
		} else {
			user.setProfileImage(image.getProfileImage());
		}

		userService.updateUser(user); // SNS?????? ????????? ??????

		User getUser = userService.getUser(user);

		session.setAttribute("user", getUser);

		System.out.println("????????? ????????? ??? : " + session.getAttribute("user").toString());

		String sessionId = ((User) session.getAttribute("user")).getUserId();
		if (sessionId.equals(getUser.getUserId())) {
			System.out.println("if ??? ?????? ????????? ????????? ??? : " + session.getAttribute("user").toString());
		}

		return "forward:/myHome/getMyHome?userId=" + user.getUserId();
	}

	@RequestMapping(value = "addProfile", method = RequestMethod.POST)
	public String addProfile(@ModelAttribute("user") User user, Model model, HttpSession session,
			@RequestParam("profileImageFile") MultipartFile file) throws Exception {

		System.out.println("/user/addProfile : POST");

		Date dateNow = new Date(System.currentTimeMillis());

		User image = new User();
		image = userService.getUser(user);
		
		if (file != null && file.getSize() > 0) {
			file.transferTo(
					new File(uploadTempDir, user.getUserId() + "_User_" + dateNow + "_" + file.getOriginalFilename()));
			user.setProfileImage(user.getUserId() + "_User_" + dateNow + "_" + file.getOriginalFilename());
		}else {
			user.setProfileImage(image.getProfileImage());
		}

		userService.updateUser(user); // SNS?????? ????????? ??????

		User getUser = userService.getUser(user);

		session.setAttribute("user", getUser);

		String sessionId = ((User) session.getAttribute("user")).getUserId();
		if (sessionId.equals(getUser.getUserId())) {
			session.setAttribute("user", getUser);
		}

		return "forward:/feed/getFeedList";
	}

	@RequestMapping(value = "getPassword", method = RequestMethod.GET)
	public String getPassword() throws Exception {

		System.out.println("/user/updatePassword : GET"); // ???????????? ?????? ?????? Navigation

		return "forward:/user/getPasswordView.jsp";
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() throws Exception {

		System.out.println("/user/login : GET");

		return "redirect:/user/login.jsp"; // login ?????? Navigation
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(@ModelAttribute("user") User user, HttpSession session) throws Exception {

		System.out.println("/user/login : POST");

		Map<String, Object> map = new HashMap<String, Object>();

		Search searchFoller = new Search();

		User getUser = userService.getUser(user); // ???????????? ??????ID??? ?????? ?????? ??????

		searchFoller.setSearchKeyword(getUser.getUserId());

		map.put("list", myHomeService.getFollowList(searchFoller).get("list"));

		System.out.println("?????????????????? : " + map.get("list").toString());

		String userRole = getUser.getRole().trim();

		getUser.setRole(userRole);

		System.out.println("???????????? ?????? User ?????? : " + getUser);

		if (getUser != null && user.getPassword().equals(getUser.getPassword())
				&& getUser.getOutUserState().trim().equals("0")) {
			session.setAttribute("user", getUser); // DB??? ?????? ?????? pass??? ???????????? pass??? ?????? ??? ?????? session??? ?????? ?????? ??? ???????????????
			session.setAttribute("follow", map.get("list"));
		}

		return "redirect:/feed/getFeedList";
	}

	@RequestMapping(value = "snsLogin", method = RequestMethod.POST)
	public String snsLogin(@ModelAttribute("user") User user, HttpSession session) throws Exception {

		System.out.println("/user/snsLogin : POST");

		User getUser = userService.getUser(user); // SNS???????????? snsUserId??? DB??? ????????? ??????
		System.err.println("????????? ?????? ?????? Data : " + user);
		System.out.println("getUser??? ????????? ?????? : " + getUser);

		if (getUser != null && getUser.getNickName() != null) {

			session.setAttribute("user", getUser); // ???????????? snsUserId??? ???????????? ????????? DB??? ?????? ????????? ????????? ?????? ??? session??? ?????? ??????
			System.out.println("????????? ??? ?????? : " + session.getAttribute("user").toString());

//			return null;
			return "redirect:/";
		} else if (getUser != null && getUser.getNickName() == null) {

			session.setAttribute("user", getUser); // ???????????? snsUserId??? ???????????? ????????? DB??? ?????? ????????? ????????? ?????? ??? session??? ?????? ??????
			System.out.println("????????? ??? ?????? : " + session.getAttribute("user").toString());
//			return null;
			return "redirect:/user/updateProfile?userId=" + getUser.getUserId();
		} else {
//			return null;
			return "forward:/user/addSnsUser";
		}
	}

	@RequestMapping(value = "logout", method = RequestMethod.GET)
	public String logout(@ModelAttribute("userId") String userId, HttpSession session) throws Exception {

		System.out.println("/user/logout : GET");

		userService.logout(userId); // logout?????? ??????

		session.invalidate(); // session?????? ??????

		return "redirect:/feed/getFeedList";
	}

	@RequestMapping(value = "deleteUser", method = RequestMethod.GET)
	public String deleteUser(@ModelAttribute("userId") String userId, @ModelAttribute("UserState") String userState,
			HttpSession session) throws Exception {

		System.out.println("/user/deleteUser : GET");

		User user = new User(); // get???????????? ????????? Data ????????? ?????? ??????

		user.setUserId(userId); // ??????ID domain????????? Set
		user.setOutUserState("1"); // ???????????? domain????????? Set

		userService.updateUser(user); // ?????? ????????? DB??? ??????

		session.invalidate();

		return "redirect:/";
	}

	@RequestMapping(value = "getUserList")
	public String getUserList(@ModelAttribute("search") Search search, Model model, Chat chat, HttpSession session) throws Exception {

		System.out.println("/user/getUserList : GET/POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);

		Map<String, Object> map = userService.getUserList(search);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit,
				pageSize);
		System.out.println(resultPage);

		model.addAttribute("list", map.get("userList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// ????????? ????????? ?????? //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 ?????? ??????????????? ????????????
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// ???????????? roomId ????????????
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// ????????? ????????? ?????? //////////////////////////////////
		
		

		return "forward:/user/getUserList.jsp";
	}

//	REST
//	@RequestMapping(value = "checkDuplication", method = RequestMethod.GET)
//	public String checkDuplication(@ModelAttribute("userId") String userId, Model model) throws Exception{
//		
//		System.out.println("/user/json/checkDuplication : GET");
//
//		boolean result = userService.checkDuplication(userId);
//		
//		return null;
//	}
}