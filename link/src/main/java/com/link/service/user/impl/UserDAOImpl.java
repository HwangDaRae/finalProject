package com.link.service.user.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.link.common.Search;
import com.link.service.domain.Pay;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.user.UserDAO;

@Repository("userDAOImpl")
public class UserDAOImpl implements UserDAO {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSesstion) {
		this.sqlSession = sqlSesstion;
	}
	
	public UserDAOImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void addUser(User user) throws Exception {
		
		sqlSession.insert("UserMapper.addUser", user);
		// TODO Auto-generated method stub
		
	}
	
//	@Override
//	public void addSnsUser(User user) throws Exception {
//		// TODO Auto-generated method stub
//		sqlSession.insert("UserMapper.addSnsUser", user);
//	}

	@Override
	public void addBlockUser(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("MyHomeMapper.addFollow", user);
	}

	@Override
	public void addPush(Report report) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("Report_PushMapper.addReport",report);
	}

	@Override
	public User getUser(User user) throws Exception {
		// TODO Auto-generated method stub
		try {
		sqlSession.selectOne("UserMapper.getUser",user);
		} catch (Exception e) {
		e.printStackTrace();
			// TODO: handle exception
		}
		return (User)sqlSession.selectOne("UserMapper.getUser",user);
	}

//	@Override
//	public User getUserId(User user) throws Exception {
//		// TODO Auto-generated method stub
//		return (User)sqlSession.selectOne("UserMapper.getUserId",user);
//	}

	@Override
	public void updateUser(User user) throws Exception {
		sqlSession.update("UserMapper.updateUser", user);
		// TODO Auto-generated method stub
		
	}

//	@Override
//	public void updateProfile(User user) throws Exception {
//		// TODO Auto-generated method stub
//		sqlSession.update("UserMapper.updateProfil", user);
//		
//	}

//	@Override
//	public void updatePhoneNo(User user) throws Exception {
//		// TODO Auto-generated method stub
//		sqlSession.update("UserMapper.updatePhoneNo", user);
//		
//	}

//	@Override
//	public void updatePassword(User user) throws Exception {
//		// TODO Auto-generated method stub
//		sqlSession.update("UserMapper.updatePassword", user);
//		
//	}

	@Override
	public void updateBlockUser(User user) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("MyHomeMapper.deleteFollow", user);
	}

	@Override
	public void logout(String userId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("UserMapper.updateLogoutDate", userId);
	}

//	@Override
//	public void deleteUser(User user) throws Exception {
//		// TODO Auto-generated method stub
//		sqlSession.update("UserMapper.deleteUser", user);
//	}
	
	@Override
	public void updateClub(Pay pay) throws Exception {
	   System.out.println(getClass() + ".updateClub(Pay pay) 왔다");
	   sqlSession.update("UserMapper.updateClub", pay);
	}// end of addPay(Pay pay)

	@Override
	public List<User> getUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("UserMapper.getUserList",search);
	}

	@Override
	public List<User> getBlockUserList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	
//	@Override
//	public int getBlockTotalCount(Search search) throws Exception {
//		// TODO Auto-generated method stub
//		return sqlSession.selectOne("UserMapper.getTotalCount",search);
//	}
	
	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.getTotalCount",search);
	}
	
//	public List<Report>getPushList(Search search) throws Exception{
//		return sqlSession.selectOne("Report_PushMapper.",search);
//	}

//	@Override
//	public int getPushTotalCount(Search search) throws Exception {
//		// TODO Auto-generated method stub
//		return sqlSession.selectOne("Report_PushMapper.",search);
//	}
	
}
