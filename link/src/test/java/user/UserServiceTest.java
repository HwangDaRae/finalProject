package user;

import java.util.List;
import java.util.Map;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import org.json.simple.JSONObject;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.web.bind.annotation.ResponseBody;

import com.link.common.Search;
import com.link.service.domain.Feed;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.user.UserService;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:config/context-*.xml"})
public class UserServiceTest {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
//	@Test
	public void testAddUser() throws Exception {
		// TODO Auto-generated constructor stub
		
		System.out.println("\n================================");
		User user = new User();
		user.setUserId("user11");
		user.setPassword("1111");
		user.setName("을지문덕");
		user.setGender("남자");
		user.setNickName("낭만");
		
		userService.addUser(user);
//		Assert.assertEquals(0, userService.addUser(user)); 
		System.out.println("==============================\n");
	}

//	@Test
	public void testSnsAddUser() throws Exception {
		// TODO Auto-generated constructor stub
		
		System.out.println("\n================================");
		User user = new User();
		user.setUserId("user12");
		user.setAddType("1");
		
		userService.addUser(user);
		
		User getUser = userService.getUser(user);
		System.out.println("GET한 DATA : "+getUser);
//		Assert.assertEquals(0, userService.addUser(user)); 
		System.out.println("==============================\n");
	}

//	@Test
	public void testGetUser() throws Exception{
		
		System.out.println("\n===================================");
		User userId = new User();
		userId.setUserId("user11");
		User user = userService.getUser(userId);
		System.out.println("GET한 DATA : "+user);
		
//		Assert.assertEquals("uesr01", user.getUserId());
		System.out.println("==============================\n");
	}

//	@Test
	public void testUpdateUser() throws Exception{
		
		System.out.println("\n===================================");
		User user = new User();
		user.setUserId("user01");
		user.setPassword("8520");
		user.setEmail("skdi@gmail.com");

		userService.updateUser(user);
		
		User getUser = userService.getUser(user);
		
		System.out.println("변경된 결과 값 : "+getUser);
		
//		Assert.assertEquals("uesr01", user.getUserId());
		System.out.println("==============================\n");
	}

//	@Test
	public void testUpdateProfile() throws Exception{
		
		System.out.println("\n===================================");
		
		User user2 = new User();
		user2.setUserId("user01");
		
		User user1 = userService.getUser(user2);
		
		System.out.println("변경전 Data : "+user1);
		
		User user = new User();
		user.setUserId("user01");
		user.setNickName("향기");
		user.setGender("여자");
		user.setArea1("영등포구");
		user.setArea2("금천구");
		user.setCategory1("운동");
		user.setCategory2("음악/댄스");
		user.setCategory3("여행");
		user.setProfileWriting("만나서 반갑습니다!");
		
		userService.updateUser(user);
		
		User getUser = userService.getUser(user);
		
		System.out.println("변경된 결과 값 : "+getUser);
		
//		Assert.assertEquals("uesr01", user.getUserId());
		System.out.println("==============================\n");
	}
	
//	@Test
	public void testDeleteUser() throws Exception{
		
		System.out.println("\n===================================");
		
		User user2 = new User();
		user2.setUserId("user02");
		
		User user1 = userService.getUser(user2);
		
		System.out.println("변경 전 Data : "+ user1);
		
		User user = new User();
		user.setUserId("user02");
		user.setOutUserState("1");
		
		userService.updateUser(user);
		
		User getUser = userService.getUser(user);
		
		System.out.println("변경된 Data : "+getUser);
		
//		Assert.assertEquals("uesr01", user.getUserId());
		System.out.println("==============================\n");
	}
	
//	@Test
	public void testGetUserList() throws Exception{
		
		System.out.println("\n===================================");
		
		Search search = new Search(); 
		
		Map<String, Object> map = userService.getUserList(search);
		
		List<User> list = (List<User>) map.get("userList");
		
		System.out.println("select 결과 : "+list);

		System.out.println("==============================\n");
	}
	
//	@Test
	public void testUpdatePassword() throws Exception{
		System.out.println("\n===================================");
		
		User user1 = new User();
		
		user1.setUserId("user01");
		
		user1 = userService.getUser(user1);
		
		System.out.println("변경 전 Data : "+user1.getPassword());
		
		Random rand = new Random();
		String password = "";
		
		for(int i=0; i<6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			password += ran;	//Random한 숫자 6자리 생성
		}
		
		User user = new User();
		
		user.setUserId("user01");
		user.setPassword(password);	//임의의 6자리 숫자 Set
		
		userService.updateUser(user);	//임의의 password DB에 update
		
		User getUser = userService.getUser(user);
		
		System.out.println(getUser.getPassword());
		
		System.out.println("==============================\n");
	}
	
//	@Test
	public void testPhoneNo() throws Exception{
		
		System.out.println("\n===================================");
		
		User user1 = new User();
		
		user1.setUserId("user01");
		
		user1 = userService.getUser(user1);
		
		System.out.println("변경 전 Data : "+user1.getPhoneNo());
		
		User user = new User();
		
		user.setUserId("user01");
		
		user.setPhoneNo("01048229119");
		
		userService.updateUser(user);
		
		User getUser = userService.getUser(user);
		
		System.out.println(getUser.getPhoneNo());
		
		System.out.println("==============================\n");
		
	}
	
//	@Test
	public @ResponseBody
	void sendSMS() throws Exception{
		
		System.out.println("\n===================================");
		
		Random rand = new Random();
		String numStr = "";
		
		for (int i = 0; i < 4; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}
		
		String phoneNo = "01099636601";
		
		System.out.println("수신자 번호 : "+phoneNo);
		System.out.println("인증번호 : "+numStr);
		
		String api_key = "NCSLBJQF2TUBD2NO";
		String api_secret = "Y7LH5YMNTFYTCWBHKDJ2YEJRTFOPE9EN";
		Message coolsms = new Message(api_key,api_secret);
		
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phoneNo);
		params.put("from", "01099636601");
		params.put("type", "SMS");
		params.put("text", "Link에서 보낸 인증번호["+numStr+"]");
		params.put("app_version", "test app 1,2");
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		}catch (CoolsmsException e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		
	
		System.out.println("==============================\n");
		}
		}	
		
//	@Test
	public void testAddPush() throws Exception{
		
		System.out.println("\n===================================");
		
		Report push = new Report();
		Feed feed = new Feed();
		User user1 = new User();
		User user2 = new User();
		
		user1.setUserId("user02");
		feed.setFeedNo(2);
		user2.setUserId("user01");
		push.setUser1(user1);
		push.setUser2(user2);
		push.setFeed(feed);
		push.setContent("User02님이 피드를 등록했습니다.");
		push.setType(2);
		
		System.out.println("입력한 Data"+push);
		
		userService.addPush(push);
		System.out.println("==============================\n");
	}

//	@Test
	public void testAddBlockUser() throws Exception{
		
		System.out.println("\n===================================");
		
		User user1 = new User();
		
		user1.setUserId("user09");
		user1.setReceiveId("user10");
		user1.setFbState("1");
		user1.setFbType("2");
		
		System.out.println("입력한 Data"+user1);
		
		userService.addBlockUser(user1);
		System.out.println("==============================\n");
	}

//	@Test
	public void testUpdateBlockUser() throws Exception{
		
		System.out.println("\n===================================");
		
		User user1 = new User();
		
		user1.setUserId("user09");
		user1.setReceiveId("user10");
		user1.setFbState("2");
		user1.setFbType("2");
		
		System.out.println("입력한 Data"+user1);
		
		userService.updateBlockUser(user1);
		System.out.println("==============================\n");
	}
}
	
