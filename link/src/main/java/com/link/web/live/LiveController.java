package com.link.web.live;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.link.service.domain.Live;
import com.link.service.live.LiveService;

@Controller
@RequestMapping("/live/*")
public class LiveController {
	
	@Autowired
	@Qualifier("liveServiceImpl")
	private LiveService liveService;

	public LiveController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	
	 
	@RequestMapping(value = "getLive")
	public String getLive() throws Exception{
		return null;
	}
	
	public String getLiveList() throws Exception{
		return null;
	}
	
}
