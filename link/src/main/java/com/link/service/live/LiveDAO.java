package com.link.service.live;

import java.util.List;

import com.link.service.domain.Live;

public interface LiveDAO {

	public void addLive(Live live) throws Exception;
	
	public void updateLive(Live live) throws Exception;

	public Live getLive(Live live) throws Exception;

	public void deleteLive(Live live) throws Exception;
	
	public List<Live> getLivelist(Live live) throws Exception;
}
