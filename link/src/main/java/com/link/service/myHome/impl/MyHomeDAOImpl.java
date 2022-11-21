package com.link.service.myHome.impl;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.link.common.Search;
import com.link.service.domain.User;
import com.link.service.myHome.MyHomeDAO;

@Repository("myHomeDAOImpl")
public class MyHomeDAOImpl implements MyHomeDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	SqlSession sqlSession;
    
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public MyHomeDAOImpl() {
	}
	@Override
    public void updateMyHomeOpenCondition(User user) throws Exception{
	
		System.out.println("\n[MyHomeDAOImpl updateMyHomeOpenCondition start]\n");
		sqlSession.update("UserMapper.updateOpenCondition", user);
	}
	@Override
	public void updateMyHomePushCondition(User user) throws Exception{
		
		System.out.println("\n[MyHomeDAOImpl updateMyHomePushCondition start]\n");
		sqlSession.update("UserMapper.updatePushCondition", user);
	}
	@Override
	public User getMyHomeCount(int totalVisitorCount) throws Exception{
		
	   System.out.println("\n[MyHomeDAOImpl getMyHomeCount start]\n");
	   return sqlSession.selectOne("UserMapper.getUser", totalVisitorCount);
	}
	@Override
	public void updateMyHomeCount(User user) throws Exception{
		
		System.out.println("\n[MyHomeDAOImpl updateMyHomeCount start]\n");
		sqlSession.update("UserMapper.updateVisitCount", user);
	}
	@Override
    public void addFollow(User user) throws Exception{
   
		System.out.println("\n[MyHomeDAOImpl addFollow start]\n");
    	sqlSession.insert("MyHomeMapper.addFollow", user);
    }
	
	
	@Override
	public List<User> getFollow(User user) throws Exception {
		System.out.println("\n[MyHomeDAOImpl getFollow start]\n");
		return sqlSession.selectList("MyHomeMapper.getFollow", user);
	}

	@Override
	public List<User>getFollowList (Search search) throws Exception{
		
		System.out.println("\n[MyHomeDAOImpl getFollowList start]\n");
		return sqlSession.selectList("MyHomeMapper.getFollowList", search);
	}
	@Override
	public List<User> getFollowerList(Search search) throws Exception{
		
		System.out.println("\n[MyHomeDAOImpl getFollowerList start]\n");
		return sqlSession.selectList("MyHomeMapper.getFollowerList", search);
	}
	@Override
	public void updateFollow(User user) throws Exception{
		
		System.out.println("\n[MyHomeDAOImpl deleteFollow start]\n");
		sqlSession.update("MyHomeMapper.updateFollow", user);
	}
	
    public int getFollowCount(Search search) throws Exception{
    	return sqlSession.selectOne("MyHomeMapper.getFollowCount", search);
    }
	
	public int getFollowerCount(Search search) throws Exception{
		return sqlSession.selectOne("MyHomeMapper.getFollowerCount", search);
		
	}

	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	@Override
	public List<User>getBlockList (Search search) throws Exception{
		
		System.out.println("\n[MyHomeDAOImpl getBlockList start]\n");
		return sqlSession.selectList("MyHomeMapper.getBlockList", search);
	}

}
