package com.link.web.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.link.common.Search;
import com.link.service.domain.User;
import com.link.service.myHome.MyHomeService;
import com.link.service.user.UserService;

@RestController
@RequestMapping("/userRest/*")
public class UserRestController {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("myHomeServiceImpl")
	private MyHomeService myHomeService;
	
	public UserRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@RequestMapping(value = "json/getUser", method = RequestMethod.POST)
	public User getUser(@RequestBody User user) throws Exception {

		System.out.println("/userRest/json/getUser : POST");

		System.out.println("입력받은 User 값 : " + user);

		User getUser = new User();

		if (user.getUserId() != null) {

			if (!user.getUserId().equals("")) {

				getUser = userService.getUser(user);
			}
		} else if (user.getNickName() != null) {

			if (!user.getNickName().equals("")) {

				getUser = userService.getUser(user);

			}
		}else {

			getUser = userService.getUser(user);
			
		}
		System.out.println("DB에서 받은 정보 : " + getUser);

		if (getUser != null) {

			return getUser; // 회원정보가 null이 아닐경우 리턴

		} else {

			user.setUserId("");
			user.setNickName("");

			System.out.println("null값을 넣은 User : " + user);

			return user; // 회원정보가 없을 경우 회원ID에 null값을 저장하여 출력
		}
	}

	@RequestMapping(value = "json/getUserId", method = RequestMethod.POST)
	public User getUserId(@RequestBody User user) throws Exception {

		System.out.println("/userRest/json/getUserId : POST");

		return userService.getUser(user);
	}

	@RequestMapping(value = "json/updatePenalty", method = RequestMethod.POST)
	public User updatePenalty(@RequestBody User user) throws Exception {

		System.out.println("/userRest/json/updatePenalty : POST");

		User getUser = new User();

		if (user.getPenaltyType().equals("ㅡ")) {
			System.out.println("패널틸가 ㅡ 일 경우 : " + user.getPenaltyType());
			user.setPenaltyType("0");
			userService.updateUser(user);
		} else if (user.getPenaltyType().equals("정지")) {
			System.out.println("패널틸가 정지일 경우 : " + user.getPenaltyType());
			user.setPenaltyType("1");
			userService.updateUser(user);
		} else {
			System.out.println("패널틸가 영구정지일 경우 : " + user.getPenaltyType());
			user.setPenaltyType("2");
			userService.updateUser(user);
		}

		getUser = userService.getUser(user);

		return getUser;
	}

	@RequestMapping(value = "json/updatePassword", method = RequestMethod.POST)
	public User updatePassword(@RequestBody User user) throws Exception {

		System.out.println("/user/json/updatePassword : POST");

		System.out.println("입력받는 email : " + user.getEmail());

		Random rand = new Random();
		String password = "";

		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			password += ran; // Random한 숫자 6자리 생성
		}

		user.setPassword(password); // 임의의 6자리 숫자 Set

		userService.updateUser(user); // 임의의 password DB에 update

		User getUser = userService.getUser(user);

		System.out.println("변경된 비밀번호 : " + getUser.getPassword());

		if (user.getEmail() == "") {

			userService.sendPasswordSMS(getUser);

		} else {

			getUser.setEmail(user.getEmail());
			userService.sendPasswordEmail(getUser);

		}

		return getUser;
	}

	@RequestMapping(value = "json/updatePhoneNo", method = RequestMethod.POST)
	public User updatePhoneNo(@RequestBody User user) throws Exception {

		System.out.println("/user/json/updatePhoneNo : POST");

		userService.updateUser(user); // 입력받은 핸드폰번호 DB에 update

		return userService.getUser(user); // update된 회원의 핸드폰번호 출력
	}

//	@RequestMapping(value = "json/checkDuplication/{userId}", method = RequestMethod.GET)
//	public String checkDuplication(@RequestBody String userId) throws Exception{
//		
//		System.out.println("/user/json/checkDuplication : GET");
//		
//		User user = new User();
//		
//		user.setUserId(userId);
//
//		boolean result = userService.checkDuplication(user);
//		
//		return result;
//	}

	@RequestMapping(value = "json/sendSMS", method = RequestMethod.GET)
	public @ResponseBody String sendSMS(String phoneNo) throws Exception {

		System.out.println("/userRest/json/sendSMS : GET");

		Random rand = new Random();
		String numStr = "";

		for (int i = 0; i < 4; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}

		System.out.println("수신자 번호 : " + phoneNo);
		System.out.println("인증번호 : " + numStr);

		userService.sendSMS(phoneNo, numStr);

		return numStr;
	}

	@RequestMapping(value = "json/mailCheck/{email}", method = RequestMethod.GET)
	public String mailCheck(@PathVariable String email) throws Exception {

		System.out.println("/userRest/json/mailCheck : GET");

		Random rand = new Random();
		String numStr = "";

		for (int i = 0; i < 6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}

		System.out.println(email);

		String emailStr = email + ".com";

		System.out.println(emailStr);

		userService.mailCheck(emailStr, numStr);

		return numStr;

	}
	
	@RequestMapping(value = "json/addBlock", method = RequestMethod.POST)
	public Map<String, Object> addBlock(@RequestBody User user, HttpSession session, Search search)throws Exception{
		
		System.out.println("/userRest/json/addBlock : POST");
		
		String sessionId = ((User)session.getAttribute("user")).getUserId();
		
		System.out.println("세션에 저장된 회원ID : "+sessionId);
		
		user.setUserId(sessionId);
		
		user.setFbType("2");
		
		user.setFbState("1");
		
		myHomeService.addFollow(user);
		
		Map<String, Object> getUser = myHomeService.getFollow(user);

		
		return getUser;
	}
	
	@RequestMapping(value = "json/updateBlock", method = RequestMethod.POST)
	public Map<String, Object>  updateBlock(@RequestBody User user, HttpSession session) throws Exception{
		
		System.out.println("/userRest/json/updateBlock : POST");
		
		String sessionId = ((User)session.getAttribute("user")).getUserId();
		
		user.setUserId(sessionId);
		
		System.out.println("입력받은 회원정보 : "+user);
		
		myHomeService.updateFollow(user);
		
		Map<String, Object> getUser = myHomeService.getFollow(user);
		
		return getUser;
		
	}
}
