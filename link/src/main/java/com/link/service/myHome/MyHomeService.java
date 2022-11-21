package com.link.service.myHome;

import java.util.List;
import java.util.Map;

import com.link.common.Search;
import com.link.service.domain.User;

public interface MyHomeService  {

    public void updateMyHomeOpenCondition(User user) throws Exception;
	
	public void updateMyHomePushCondition(User user) throws Exception;
	
	public User getMyHomeCount(int totalVisitorCount) throws Exception;
	
	public void updateMyHomeCount(User user) throws Exception;
	
	public void addFollow(User user) throws Exception;

	public Map<String, Object> getFollow(User user) throws Exception;
	
	public Map<String, Object> getFollowList(Search search) throws Exception;
	
	public Map<String, Object> getFollowerList(Search search) throws Exception;
	
	public Map<String, Object> getBlockList(Search search) throws Exception;
	
	public void updateFollow(User user) throws Exception;


}



