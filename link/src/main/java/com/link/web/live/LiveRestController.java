package com.link.web.live;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.link.service.domain.Live;
import com.link.service.live.LiveService;

@RestController
@RequestMapping("/liveRest/*")
public class LiveRestController {
	
	@Autowired
	@Qualifier("liveServiceImpl")
	private LiveService liveService;

	public LiveRestController() {
		System.out.println(this.getClass());
	}

	@RequestMapping(value = "json/addLive", method = RequestMethod.POST)
	public Live addLive(@RequestBody Live live) throws Exception {
		System.out.println("/liveRest/json/addLive : POST");

		live.setMember(1);
		liveService.addLive(live);
		Live getLive = liveService.getLive(live); 
		System.out.println("add한 livedata : "+getLive);
		
		return getLive;

	}
	
	@RequestMapping(value = "json/exitLive", method = RequestMethod.POST)
	public Live exitLive(@RequestBody Live live) throws Exception {
		System.out.println("/liveRest/json/exitLive : POST");
		
		String roomName = live.getRoomName().trim();
		Live getLiveMember = liveService.getLive(live);
		System.out.println("서버 다녀욘 getLiveMember의 값 : "+getLiveMember);
		if(getLiveMember != null) {
		int mem = getLiveMember.getMember()-1;
		getLiveMember.setMember(mem);
		System.out.println("set한 LiveMember 값 : "+getLiveMember.getMember());
		liveService.updateLive(getLiveMember);
		System.out.println("update 진행완료 ");
		Live getLive = liveService.getLive(live);
		System.out.println("update 후 값 : "+getLive);
		
		if(getLive.getMember() == 0) { 
			getLive.setRoomName(roomName);
			liveService.deleteLive(getLive);
			System.out.println("delete진행");
		}
		
		Live deleteLive = liveService.getLive(getLive);
		System.out.println("delete 후 값 : "+deleteLive);
		
		return deleteLive;
		
		}else {
			return getLiveMember;
		}
		
	}
	
	@RequestMapping(value = "json/getLiveList", method = RequestMethod.POST)
	public List<Live> getLiveList(@RequestBody Live live)throws Exception{
		System.out.println("/live/json/getLiveList : POST");
		
		List<Live> list = new ArrayList<Live>();
		list = liveService.getLivelist(live);
		
		return list;
	}

	@RequestMapping(value = "json/getLive", method = RequestMethod.POST)
	public Live getLive(@RequestBody Live live)throws Exception{
		
		System.out.println("/live/json/getLiveList : POST/GET");
		
		Live limit = liveService.getLive(live);
		
		System.out.println("limit 값 확인하기 : "+limit);
		
		int count = limit.getMember()+1;
		
		live.setMember(count);
		
		System.out.println("count한 Member 값 : "+live.getMember());
		
		if(limit.getLimit() >= live.getMember()) {
		
		System.out.println("update 시작");
		
		liveService.updateLive(live);
		
		System.out.println("update완료");
		
		Live getLive = liveService.getLive(live);
		 
		System.out.println("update 후 받아온 결과 값 : "+getLive);
		
		return getLive;
		
		}else {
			
			System.out.println("조건에 만족하지 못할 경우");
			
			return null;
			
		}
	}
}
