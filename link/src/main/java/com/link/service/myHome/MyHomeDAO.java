package com.link.service.myHome;

import java.util.List;
import java.util.Map;

import com.link.common.Search;
import com.link.service.domain.User;

public interface MyHomeDAO {

	public void updateMyHomeOpenCondition(User user) throws Exception;
	
	public void updateMyHomePushCondition(User user) throws Exception;
	
	public User getMyHomeCount(int totalVisitorCount) throws Exception;
	
	public void updateMyHomeCount(User user) throws Exception;
	
    public void addFollow(User user) throws Exception;

    public List<User> getFollow(User user) throws Exception;
	
	public List<User> getFollowList(Search search) throws Exception;
	
	public List<User> getFollowerList(Search search) throws Exception;
	
	public void updateFollow(User user) throws Exception;
	
	public int getFollowCount(Search search) throws Exception;
	
	public int getFollowerCount(Search search) throws Exception;
	
	public int getTotalCount(Search search) throws Exception;
	
	public List<User> getBlockList(Search search) throws Exception;

	

	
}
