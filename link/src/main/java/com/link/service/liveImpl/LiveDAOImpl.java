package com.link.service.liveImpl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.link.service.domain.Live;
import com.link.service.live.LiveDAO;

@Repository("liveDAOImpl")
public class LiveDAOImpl implements LiveDAO {

	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public LiveDAOImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void addLive(Live live) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("LiveMapper.addLive", live);
	}

	@Override
	public void updateLive(Live live) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("LiveMapper.updateLive", live);
	}

	@Override
	public Live getLive(Live live) throws Exception {
		// TODO Auto-generated method stub
		return (Live)sqlSession.selectOne("LiveMapper.getLive", live);
	}

	@Override
	public void deleteLive(Live live) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("LiveMapper.deleteLive", live);
	}

	@Override
	public List<Live> getLivelist(Live live) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("LiveMapper.getLiveList", live);
	}

}
