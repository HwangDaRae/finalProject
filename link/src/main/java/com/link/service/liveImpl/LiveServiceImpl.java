package com.link.service.liveImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.link.service.domain.Live;
import com.link.service.live.LiveDAO;
import com.link.service.live.LiveService;

@Service("liveServiceImpl")
public class LiveServiceImpl implements LiveService {

	@Autowired
	@Qualifier("liveDAOImpl")
	private LiveDAO liveDAO;
	
	public void setLiveDAO(LiveDAO liveDAO) {
		this.liveDAO = liveDAO;
	}

	public LiveServiceImpl() {
		System.out.println(this.getClass());
	}
	
	@Override
	public void addLive(Live live) throws Exception {
		// TODO Auto-generated method stub
		liveDAO.addLive(live);
	}

	@Override
	public void updateLive(Live live) throws Exception {
		// TODO Auto-generated method stub
		liveDAO.updateLive(live);
	}

	@Override
	public Live getLive(Live live) throws Exception {
		// TODO Auto-generated method stub
		return liveDAO.getLive(live);
	}

	@Override
	public void deleteLive(Live live) throws Exception {
		// TODO Auto-generated method stub
		liveDAO.deleteLive(live);
	}

	@Override
	public List<Live> getLivelist(Live live) throws Exception {
		// TODO Auto-generated method stub
		return liveDAO.getLivelist(live);
	}

}
