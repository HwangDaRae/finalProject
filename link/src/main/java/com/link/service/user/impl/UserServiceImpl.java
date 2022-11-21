package com.link.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.link.common.Search;
import com.link.service.domain.Pay;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.user.UserDAO;
import com.link.service.user.UserService;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

@Service("userServiceImpl")
public class UserServiceImpl implements UserService {
	
	@Autowired
	@Qualifier("userDAOImpl")
	private UserDAO userDAO;
	
	@Autowired
	private JavaMailSender javaMailSender;
	
	public void setUserDAO(UserDAO userDAO) {
		this.userDAO = userDAO;
	}
	
	public void setJavaMailSender(JavaMailSender javaMailSender) {
		System.out.println("javaMailSender 생성완료");
		this.javaMailSender =  javaMailSender;
	}
	
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}

	@Override
	public void addUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.addUser(user);
		
	}
	
//	@Override
//	public void addSnsUser(User user) throws Exception {
//		// TODO Auto-generated method stub
//		userDAO.addSnsUser(user);
//	}
	
	@Override
	public void addBlockUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.addBlockUser(user);
	}

	@Override
	public void addPush(Report report) throws Exception {
		// TODO Auto-generated method stub
		userDAO.addPush(report);
	}

	@Override
	public User getUser(User user) throws Exception {
		// TODO Auto-generated method stub
		return userDAO.getUser(user);
	}

//	@Override
//	public User getUserId(User user) throws Exception {
//		// TODO Auto-generated method stub
//		return userDAO.getUserId(user);
//	}

	@Override
	public void updateUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.updateUser(user);
	}

	/*
	 * @Override public void updateProfile(User user) throws Exception { // TODO
	 * Auto-generated method stub userDAO.updateProfile(user); }
	 * 
	 * @Override public void updatePhoneNo(User user) throws Exception { // TODO
	 * Auto-generated method stub userDAO.updatePhoneNo(user); }
	 * 
	 * @Override public void updatePassword(User user) throws Exception { // TODO
	 * Auto-generated method stub userDAO.updatePassword(user); }
	 */

	@Override
	public void updateBlockUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDAO.updateBlockUser(user);
	}

	@Override
	public void logout(String userId) throws Exception {
		// TODO Auto-generated method stub
		userDAO.logout(userId);
	}

//	@Override
//	public void deleteUser(User user) throws Exception {
//		// TODO Auto-generated method stub
//		userDAO.deleteUser(user);
//	}
	
	@Override
	public void updateClub(Pay pay) throws Exception {
	   System.out.println(getClass() + ".updateClub(Pay pay) 도착");
	   userDAO.updateClub(pay);
	}// updateClub(Pay pay)
	
	@Override
	public boolean checkDuplication(User user) throws Exception {
		// TODO Auto-generated method stub
		boolean result = true;			//중복확인을 위해 Default 값을 True로 준다.
		
		User getUser = userDAO.getUser(user);
		
		if(getUser != null) {
			result = false;					//userId로 확인 하여 값이 있을 경우 False로 처리 한다.
		}
		
		return result;
	}

	@Override
	public void sendSMS(String phoneNo, String cerNo) {
		// TODO Auto-generated method stub
		String api_key = "NCSLST2PMJ9SKBCH";
		String api_secret = "WBT25HFORXO44GDVYEXDZLMGTULR4SFN";
		Message coolsms = new Message(api_key,api_secret);
		
		HashMap<String, String> params = new HashMap<String, String>();
		params.put("to", phoneNo);
		params.put("from", "01047669445");
		params.put("type", "SMS");
		params.put("text", "Link에서 보낸 인증번호["+cerNo+"]");
		params.put("app_version", "test app 1,2");
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(params);
			System.out.println(obj.toString());
		}catch (CoolsmsException e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
	} 
	
	@Override
	public void sendPasswordSMS(User user) {
		// TODO Auto-generated method stub
		String api_key = "NCSLST2PMJ9SKBCH";
		String api_secret = "WBT25HFORXO44GDVYEXDZLMGTULR4SFN";
		Message coolsms = new Message(api_key,api_secret);
		
		String phoneNo = user.getPhone1()+user.getPhone2()+user.getPhone3();
		System.out.println("전화번호 : "+phoneNo);
		
		HashMap<String, String> param = new HashMap<String, String>();
		param.put("to",phoneNo);
		param.put("from","01047669445");
		param.put("type","SMS");
		param.put("text","임시비밀번호발급["+user.getPassword()+"]");
		param.put("app_version", "test app 1,2");
		
		try {
			JSONObject obj = (JSONObject) coolsms.send(param);
			System.out.println(obj.toString());
		}catch (CoolsmsException e) {
			// TODO: handle exception
			System.out.println(e.getMessage());
			System.out.println(e.getCode());
		}
	}
	
	@Override
	public void mailCheck(String email, String cerNo) {
		// TODO Auto-generated method stub
		String subject = "본인인증 인증코드 입니다.";
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.append("Link에서 보낸 인증코드["+cerNo+"]입니다.");
		System.out.println("보낼 인증코드 내용 : "+stringBuilder);
		
		MimeMessage message = javaMailSender.createMimeMessage();
		System.out.println("message값 : "+message);
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setSubject(subject);
//			helper.setText("<img src=\'http://192.168.0.183:8080/resources/image/uploadFiles/Log.png\'>","text/html");
//			helper.setText(stringBuilder.toString(), true); 
			helper.setFrom("bymini1992@gmail.com"); 
			helper.setTo(email);
			
			System.out.println("helper 값 : "+helper);
			
			message.setContent("<head><meta charset=\"UTF-8R\"></head><div style='background: #dff0ff; width: 700px; border-radius: 20px; padding: 20px;'>"
					+"<a href=http://192.168.0.183:8080/main.jsp>"
					+"<img style='margin-left: 47px; margin-top: 30px;' src=\'https://192.168.0.183:8443/resources/image/uploadFiles/Log.png\'></a>"
					+"<div style='font-size: xx-large;  font-weight: bold;     margin-left: 50px; margin-top: 20px;'>LINK에서 보낸 인증코드["+cerNo+"]입니다.</div></div>","text/html;charset=UTF-8"); 
			  
			javaMailSender.send(message);
			
			System.out.println("message 보내기 성공");
		} catch (MessagingException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	
	@Override
	public void sendPasswordEmail(User user) {
		// TODO Auto-generated method stub
		String subject = "임시비밀번호 입니다.";
		StringBuilder stringBuilder = new StringBuilder();
		System.out.println("보낼 내용 : "+stringBuilder);
		
		MimeMessage message = javaMailSender.createMimeMessage();
		System.out.println("message 값 : "+message);
		
		try {
			MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");
			helper.setSubject(subject);
//			helper.setText("<img src=\'http://192.168.0.183/resurces/image/uploadFiles/로고큰사이즈.png\'>","text/html");
//			helper.setText("<h1>Link에서 보낸 임시비밀번호["+user.getPassword()+"] 입니다.</h1>","text/html");
			helper.setFrom("bymini1992@gmail.com");
			helper.setTo(user.getEmail());
			
			System.out.println("helper 값 : "+helper);
			
			message.setContent("<head><meta charset=\"UTF-8R\"></head><div style='background: #dff0ff; width: 700px; border-radius: 20px; padding: 20px;'>"
					+"<a href=http://192.168.0.183:8080/main.jsp>"
					+"<img style='margin-left: 47px; margin-top: 30px;' src=\'https://192.168.0.183:8443/resources/image/uploadFiles/Log.png\'></a>"
	 				+"<div style='font-size: x-large;  font-weight: bold;    margin-left: 50px; margin-top: 20px;'>LINK에서 보낸 임시비밀번호는 ["+user.getPassword()+"]입니다.</div></div>","text/html;charset=UTF-8");
			
			javaMailSender.send(message);
			
		} catch (MessagingException e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	@Override
	public Map<String, Object> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		List<User> list = userDAO.getUserList(search);
		int totalCount = userDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userList", list);
		map.put("totalCount",new Integer(totalCount));
		return map;
	}
	
	@Override
	public Map<String, Object> getBlockUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		
		List<User> blockUserList = userDAO.getBlockUserList(search);
		int totalCount = userDAO.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("stopUserList", blockUserList);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

//	@Override
//	public Map<String, Object> getStopList(Search search) throws Exception {
//		// TODO Auto-generated method stub
//		
//		List<User> stopUserList = userDAO.getUserList(search);
//		int totalCount = userDAO.getTotalCount(search);
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("stopUserList", stopUserList);
//		map.put("totalCount", new Integer(totalCount));
//		
//		return map;
//	}

//	@Override
//	public Map<String, Object> getForeverStopList(Search search) throws Exception {
//		// TODO Auto-generated method stub
//		
//		List<User> list = userDAO.getUserList(search);
//		int totalCount = userDAO.getTotalCount(search);
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("ForeverStopUserList", list);
//		map.put("totalCount", new Integer(totalCount));
//		
//		return map;
//	}

//	@Override
//	public Map<String, Object> getPushList(Search search) throws Exception {
//		// TODO Auto-generated method stub
//		
//		List<Report> list = userDAO.getPushList(search);
//		int totalCount = userDAO.getPushTotalCount(search);
//		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("Push", list);
//		map.put("tatalCount", totalCount);
//		
//		return map;
//	}


}
