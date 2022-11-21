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

		userService.addUser(user); // 회원가입 정보 DB저장

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
			
			user.setUserId("Link" + no); // SNS회원 ID 임의로 생성 하여 저장
			
			user.setProfileImage("default.png");
			
			System.out.println("User에 입력된 Data : " + user);

			getUser = userService.getUser(user);

			if (getUser == null) {

				userService.addUser(user); // SNS회원 ID, 가입유형, 가입날짜 DB저장

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

		System.out.println("화면에서 입력받은 회원ID : " + userId);

		String sessionId = ((User) session.getAttribute("user")).getUserId();

		System.out.println("sessionId = " + sessionId);

		System.out.println("세선의 롤값 1과 비교 : " + ((User) session.getAttribute("user")).getRole().equals("1"));

		user.setUserId(userId);

		User getUser = userService.getUser(user); // 회원의 정보를 얻기위해 회원ID DB전송

		model.addAttribute("getUser", getUser); // DB에서 전송받은 회원의 정보를 Key(user)에 저장
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		if (userId.equals(sessionId) || ((User) session.getAttribute("user")).getRole().equals("1")) {

			return "forward:/user/getUser.jsp";

		} else {

			return "redirect:/feed/getFeedList";
		}
	}

	@RequestMapping(value = "getUserId", method = RequestMethod.GET)
	public String getUserId() throws Exception {

		System.out.println("/user/getUser : GET");

		return "forward:/user/getIdView.jsp"; // 화면Navigation
	}

	@RequestMapping(value = "updateUser", method = RequestMethod.GET)
	public String updateUser(@ModelAttribute("userId") String userId, Model model, HttpSession session, Chat chat)
			throws Exception {

		System.out.println("/user/updateUser : GET");

		System.out.println("입력받은 UserId : " + userId);

		String sessionId = ((User) session.getAttribute("user")).getUserId();

		System.out.println("세션에 저장된 UserId : " + sessionId);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

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

		System.out.println("화면에서 받아온 UserDate 값 : " + user);

		System.out.println("화면에서 받아온 Date 값 : " + user.getStopEndDateString());

		if (user.getStopEndDateString() != "" && user.getStopEndDateString() != null) {

			java.sql.Date d = java.sql.Date.valueOf(user.getStopEndDateString());

			user.setStopEndDate(d);

		} else {
			user.setStopEndDate(null);
		}

		System.out.println("바꾼 Date 값 : " + user.getStopEndDate());

		System.out.println("회면에서 입력받은 패널티 값 : " + user.getPenaltyType());
		if (user.getPenaltyType() != null) {
			if (user.getPenaltyType().equals("ㅡ")) {
				user.setPenaltyType("0");
				System.out.println("패널틸가 ㅡ 일 경우 : " + user.getPenaltyType());
				userService.updateUser(user);
			} else if (user.getPenaltyType().equals("정지")) {
				user.setPenaltyType("1");
				System.out.println("패널틸가 정지일 경우 : " + user.getPenaltyType());
				userService.updateUser(user);
			} else {
				user.setPenaltyType("2");
				System.out.println("패널틸가 영구정지일 경우 : " + user.getPenaltyType());
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

		System.out.println("세션에 저장된 UserId : " + sessionId);

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

		System.out.println("받아온 file : "+file);
		
		User image = new User();
		image = userService.getUser(user);
		
		if (file != null && file.getSize() > 0) {
			file.transferTo(
					new File(uploadTempDir, user.getUserId() + "_User_" + dateNow + "_" + file.getOriginalFilename()));
			user.setProfileImage(user.getUserId() + "_User_" + dateNow + "_" + file.getOriginalFilename());
		} else {
			user.setProfileImage(image.getProfileImage());
		}

		userService.updateUser(user); // SNS회원 프로필 작성

		User getUser = userService.getUser(user);

		session.setAttribute("user", getUser);

		System.out.println("세션에 저장된 값 : " + session.getAttribute("user").toString());

		String sessionId = ((User) session.getAttribute("user")).getUserId();
		if (sessionId.equals(getUser.getUserId())) {
			System.out.println("if 문 안의 세션에 저장된 값 : " + session.getAttribute("user").toString());
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

		userService.updateUser(user); // SNS회원 프로필 작성

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

		System.out.println("/user/updatePassword : GET"); // 비밀번호 찾기 화면 Navigation

		return "forward:/user/getPasswordView.jsp";
	}

	@RequestMapping(value = "login", method = RequestMethod.GET)
	public String login() throws Exception {

		System.out.println("/user/login : GET");

		return "redirect:/user/login.jsp"; // login 화면 Navigation
	}

	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(@ModelAttribute("user") User user, HttpSession session) throws Exception {

		System.out.println("/user/login : POST");

		Map<String, Object> map = new HashMap<String, Object>();

		Search searchFoller = new Search();

		User getUser = userService.getUser(user); // 입력받은 회원ID로 회원 정보 확인

		searchFoller.setSearchKeyword(getUser.getUserId());

		map.put("list", myHomeService.getFollowList(searchFoller).get("list"));

		System.out.println("팔로우리스트 : " + map.get("list").toString());

		String userRole = getUser.getRole().trim();

		getUser.setRole(userRole);

		System.out.println("로그인시 받는 User 정보 : " + getUser);

		if (getUser != null && user.getPassword().equals(getUser.getPassword())
				&& getUser.getOutUserState().trim().equals("0")) {
			session.setAttribute("user", getUser); // DB에 있는 회원 pass와 입력받은 pass가 일치 할 경우 session에 정보 저장 후 로그인처리
			session.setAttribute("follow", map.get("list"));
		}

		return "redirect:/feed/getFeedList";
	}

	@RequestMapping(value = "snsLogin", method = RequestMethod.POST)
	public String snsLogin(@ModelAttribute("user") User user, HttpSession session) throws Exception {

		System.out.println("/user/snsLogin : POST");

		User getUser = userService.getUser(user); // SNS로그인시 snsUserId가 DB에 있는지 확인
		System.err.println("서버로 부터 받은 Data : " + user);
		System.out.println("getUser로 검색한 결과 : " + getUser);

		if (getUser != null && getUser.getNickName() != null) {

			session.setAttribute("user", getUser); // 입력받은 snsUserId와 가입유형 번호가 DB에 있는 데이터 내용과 같을 시 session에 정보 저장
			System.out.println("세션에 값 저장 : " + session.getAttribute("user").toString());

//			return null;
			return "redirect:/";
		} else if (getUser != null && getUser.getNickName() == null) {

			session.setAttribute("user", getUser); // 입력받은 snsUserId와 가입유형 번호가 DB에 있는 데이터 내용과 같을 시 session에 정보 저장
			System.out.println("세션에 값 저장 : " + session.getAttribute("user").toString());
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

		userService.logout(userId); // logout시간 저장

		session.invalidate(); // session정보 제거

		return "redirect:/feed/getFeedList";
	}

	@RequestMapping(value = "deleteUser", method = RequestMethod.GET)
	public String deleteUser(@ModelAttribute("userId") String userId, @ModelAttribute("UserState") String userState,
			HttpSession session) throws Exception {

		System.out.println("/user/deleteUser : GET");

		User user = new User(); // get방식으로 들어온 Data 저장을 위해 생성

		user.setUserId(userId); // 회원ID domain객체에 Set
		user.setOutUserState("1"); // 회원상태 domain객체에 Set

		userService.updateUser(user); // 회원 정보를 DB에 저장

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
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

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