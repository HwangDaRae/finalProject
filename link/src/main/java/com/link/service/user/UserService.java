package com.link.service.user;

import java.util.Map;

import com.link.common.Search;
import com.link.service.domain.Pay;
import com.link.service.domain.Report;
import com.link.service.domain.User;

public interface UserService {

	public void addUser(User user) throws Exception;

//	public void addSnsUser(User user) throws Exception;

	public void addBlockUser(User user) throws Exception;
	
	public void addPush(Report report) throws Exception;
	
	public User getUser(User user) throws Exception;

//	public User getUserId(User user) throws Exception;
	
	public void updateUser(User user) throws Exception;

//	public void updateProfile(User user) throws Exception;
	
//	public void updatePhoneNo(User user) throws Exception;
	
//	public void updatePassword(User user) throws Exception;

	public void updateBlockUser(User user) throws Exception;
	
	public void logout(String userId) throws Exception;
	
	public void updateClub(Pay pay) throws Exception;
	
//	public void deleteUser(User user) throws Exception;
	
	public boolean checkDuplication(User User) throws Exception;
	
	public void sendSMS(String phoneNo, String cerNo);

	public void sendPasswordSMS(User user);
	
	public void sendPasswordEmail(User user);

	public void mailCheck(String email, String cerNo);
	
	public Map<String, Object> getUserList(Search search) throws Exception;
	
	public Map<String, Object> getBlockUserList(Search search) throws Exception;

//	public Map<String, Object> getStopList(Search search) throws Exception;

//	public Map<String, Object> getForeverStopList(Search search) throws Exception;
	
//	public Map<String, Object> getPushList(Search search) throws Exception;
	
}
