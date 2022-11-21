package com.link.service.user;

import java.util.List;

import com.link.common.Search;
import com.link.service.domain.Pay;
import com.link.service.domain.Report;
import com.link.service.domain.User;

public interface UserDAO {

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
	
	public List<User> getUserList(Search search) throws Exception;
	
	public List<User> getBlockUserList(Search search) throws Exception;

	public int getTotalCount(Search search) throws Exception;
	
//	public List<Report> getPushList(Search search) throws Exception;
	
//	public int getPushTotalCount(Search search) throws Exception;

}
