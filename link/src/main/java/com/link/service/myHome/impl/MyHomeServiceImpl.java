package com.link.service.myHome.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.link.common.Search;
import com.link.service.club.ClubDAO;
import com.link.service.domain.Feed;
import com.link.service.domain.Meeting;
import com.link.service.domain.User;
import com.link.service.myHome.MyHomeDAO;
import com.link.service.myHome.MyHomeService;

@Service("myHomeServiceImpl")
public class MyHomeServiceImpl implements MyHomeService {
    
	@Autowired
	@Qualifier("myHomeDAOImpl")
	private MyHomeDAO myHomeDAO;
	
	@Autowired
	@Qualifier("clubDAOImpl")
	private ClubDAO clubDAO;
	
	
	public void setMyHomeDAO(MyHomeDAO myHomeDAO) {
		this.myHomeDAO = myHomeDAO;
	}
	
	public MyHomeServiceImpl() {
		// TODO Auto-generated constructor stub
		System.out.println("MyHomeServiceImpl default Constructor");
	}
	
	@Override
    public void updateMyHomeOpenCondition(User user) throws Exception{
		
		System.out.println("\n[MyHomeServiceImpl updateMyHomeOpenCondition start]\n");
		myHomeDAO.updateMyHomeOpenCondition(user);
		
	}
	
	@Override
	public void updateMyHomePushCondition(User user) throws Exception{
		
		System.out.println("\n[MyHomeServiceImpl updateMyHomePushCondition start]\n");
		myHomeDAO.updateMyHomePushCondition(user);
	}
	
	@Override
	public User getMyHomeCount(int totalVisitorCount) throws Exception{
		
		System.out.println("\n[MyHomeServiceImpl getMyHomeCount start]\n");
		User user = myHomeDAO.getMyHomeCount(totalVisitorCount);
		
		return user;
	}
	
	@Override
	public void updateMyHomeCount(User user) throws Exception{
		
		System.out.println("\n[MyHomeServiceImpl updateMyHomeCount start]\n");
		myHomeDAO.updateMyHomeCount(user);
	}

	@Override
	public void addFollow(User user) throws Exception{
		
		System.out.println("\n[MyHomeServiceImpl addFollow start]\n");
		myHomeDAO.addFollow(user);
		
		
	}
	
	@Override
	public Map<String,Object> getFollow(User user) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("\n[MyHomeServiceImpl getFollow start]\n");
		
	    Map<String, Object> map = new HashMap<String, Object>();
		List<User> list = myHomeDAO.getFollow(user);
		System.out.println("//////////" + list);
		for (int i = 0; i < list.size(); i++) {
			if(list.get(i) != null) {	
				System.out.println("//////////" + list.get(i).getFbType().trim());

				if(list.get(i).getFbType().trim().equals("1")) {
					User follow = new User();
				    follow = (User)(list.get(i));
					map.put("follow", follow);
					System.out.println("fbType=1"+map.get("follow").toString());
				}else if(list.get(i).getFbType().trim().equals("2")){
					User block = new User();
					block =(User)list.get(i);
					map.put("block", block);
					System.out.println("fbType=2"+map.get("block").toString());
				}
			}
		}
		return map;
	}

	@Override
	public Map<String, Object> getFollowList (Search search) throws Exception{
		
		System.out.println("\n[MyHomeServiceImpl getFollowList start]\n");
		
		List<User> list = myHomeDAO.getFollowList(search);
		
		for (User u : list) {
			System.out.println("여기는 getFollowList : " + u);
		}
	
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
	
		
		return map;
	}
	@Override
	public Map<String, Object> getFollowerList(Search search) throws Exception{
		
		System.out.println("\n[MyHomeServiceImpl getFollowerList start]\n");
		
		List<User> list= myHomeDAO.getFollowerList(search);

		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("followerList", list);

		
		return map;
	}
	
	public void updateFollow(User user) throws Exception{
		
		System.out.println("\n[MyHomeServiceImpl deleteFollow start]\n");
		myHomeDAO.updateFollow(user);
		
	}
	@Override
	public Map<String, Object> getBlockList (Search search) throws Exception{
		
		System.out.println("\n[MyHomeServiceImpl getBlockList start]\n");
		
		List<User> list = myHomeDAO.getBlockList(search);
		
		for (User u : list) {
			System.out.println("여기는 getBlockList : " + u);
		}
	
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
	
		
		return map;
	}
	
}
