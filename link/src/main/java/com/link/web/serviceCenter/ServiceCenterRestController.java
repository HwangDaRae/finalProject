package com.link.web.serviceCenter;



import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.compress.utils.IOUtils;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.link.common.Search;
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.Club;
import com.link.service.domain.ClubPost;
import com.link.service.domain.Comment;
import com.link.service.domain.Feed;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.feed.FeedService;
import com.link.service.serviceCenter.ServiceCenterService;

@RestController
@RequestMapping("/serviceCenterRest/*")
public class ServiceCenterRestController {
	
	@Autowired
	@Qualifier("ServiceCenterServiceImpl")
	private ServiceCenterService serviceCenterService;
		
	@Autowired
	@Qualifier("clubPostServiceImpl")
	private ClubPostService	clubPostService;
	
	@Autowired
	@Qualifier("feedServiceImpl")
	private FeedService	feedService;
	
	public ServiceCenterRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass() + "default constructor");
	}
	
	@Value("#{commonProperties['pageSize'] ?: 10}")
	int pageSize;

	@Value("#{commonProperties['pageUnit'] ?: 10}")
	int pageUnit;
	
	@RequestMapping(value = "/json/addReport", method = RequestMethod.POST)
	public String addReport(@RequestBody Report report,  Model model , @RequestParam int clubNo,
			@RequestParam(value = "clubPostNo", required =false) int clubPostNo, Search search  )throws Exception {
			//Search search  )throws Exception {
		
		Comment comment = new Comment();
		System.out.println("/serviceCenterRest/json/addReport : POST");

		System.out.println(report);
		System.out.println("asdf   "+clubNo);  //모임번호
		System.out.println("asdf   "+clubPostNo); //모임게시물번호
		//사진 업로드
		
		Map<String, Object> map = new HashMap<String, Object>();
					Club club = new Club();
					ClubPost clubPost = new ClubPost();
					Feed feed = new Feed();
					
					if(report.getReportSource()==1) {				//모임게시물
						club.setClubNo(clubNo);
						clubPost.setClubPostNo(report.getNo());
						report.setClub(club);
						report.setClubPost(clubPost);
					}else if(report.getReportSource()==2) {   		//모임게시물댓글
						comment.setClubPostCommentNo(report.getNo());
						club.setClubNo(clubNo);
						clubPost.setClubPostNo(clubPostNo);
						report.setComment(comment);
						report.setClub(club);
						report.setClubPost(clubPost);
					}
					else if(report.getReportSource()==3) {			//피드
						feed.setFeedNo(report.getNo());
						report.setFeed(feed);
						
					}else if(report.getReportSource()==4) {			//피드댓글
					report.setFeedComment(feedService.getFeedComment(report.getNo()));
					map.put("feedNo", report.getFeedComment().getFeedNo());
					report.setFeed((Feed)feedService.getFeed(map).get("feed"));
					}
					

			serviceCenterService.addReport(report);
			model.addAttribute("report", report);

		
		//돌려보내는 곳 신고하기 전 -1하고, alter 창? 완료 되었습니다 2개 변경
		return "forward:/serviceCenter/serviceCenterHome.jsp";
	}
	
	@RequestMapping(value= "/json/getFestivalList")   // 축제 리스트가져오기 
	public String getFestivalList(HttpServletRequest request, HttpServletResponse response, @RequestParam String contentTypeId) throws Exception{
		
		
		String addr = "http://apis.data.go.kr/B551011/KorService/searchFestival?ServiceKey=";
		String serviceKey="zBGM3gx0Dc2jBEW14Zfw26CVqo2w018oxuxycZo6dMCuzeN25ma4CNoVlRDiS2k%2BXoOyBXC88QgaP1T4DZ9DuQ%3D%3D";
		String parameter ="";
		String pattern = "yyyyMMdd";
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
		String date = simpleDateFormat.format(new Date());
	//	System.out.println(date);
		
		parameter = parameter + "&" +"numOfRows=7";
		parameter = parameter + "&" +"pageNo=1";
		parameter = parameter + "&" +"MobileOS=ETC";
		parameter = parameter + "&" +"MobileApp=AppTest";
		parameter = parameter + "&" +"_type=json";
		parameter = parameter + "&" +"listYN=Y";
		parameter = parameter + "&" +"arrange=A";
		parameter = parameter + "&" +"eventStartDate="+date;
		parameter = parameter + "&" +"eventEndDate=20221230";
		parameter = parameter + "&" +"areaCode=1";
		
		
		addr = addr + serviceKey + parameter;
		URL url = new URL(addr);
		
		//System.out.println(addr);
		
		InputStream in = url.openStream();
		
		ByteArrayOutputStream bos1 = new ByteArrayOutputStream();
		IOUtils.copy(in, bos1);
		in.close();
		bos1.close();
		
		String mbos = bos1.toString("UTF-8");

		return mbos;
	}
	
	@RequestMapping(value= "/json/getFestival", produces = "application/text; charset=UTF-8")  //축제 하나씩 설명 가져오기
	public String getFestival(HttpServletRequest request, HttpServletResponse response, 
			@RequestParam String contentid) throws Exception{
		
		
		String addr = "http://apis.data.go.kr/B551011/KorService/detailCommon?ServiceKey=";
		String serviceKey="zBGM3gx0Dc2jBEW14Zfw26CVqo2w018oxuxycZo6dMCuzeN25ma4CNoVlRDiS2k%2BXoOyBXC88QgaP1T4DZ9DuQ%3D%3D";
		String parameter ="";
	//	System.out.println(contentid);
		parameter = parameter + "&" +"contentTypeId=15";
		parameter = parameter + "&" +"contentId="+contentid;
		parameter = parameter + "&" +"MobileOS=ETC";
		parameter = parameter + "&" +"_type=json";
		parameter = parameter + "&" +"MobileApp=AppTest";
		parameter = parameter + "&" +"defaultYN=Y";
		parameter = parameter + "&" +"firstImageYN=Y";
		parameter = parameter + "&" +"areacodeYN=Y";
		parameter = parameter + "&" +"catcodeYN=Y";
		parameter = parameter + "&" +"addrinfoYN=Y";
		parameter = parameter + "&" +"mapinfoYN=Y";
		parameter = parameter + "&" +"overviewYN=Y";


		
		addr = addr + serviceKey + parameter;
		URL url = new URL(addr);
		
		//System.out.println(addr);
		
		InputStream in = url.openStream();
		
		ByteArrayOutputStream bos1 = new ByteArrayOutputStream();
		IOUtils.copy(in, bos1);
		in.close();
		bos1.close();
		
		String mbos = bos1.toString("UTF-8");

		return mbos;
	}
	
	
	/*
	 * @RequestMapping(value = "/json/updateReport", method = RequestMethod.POST)
	 * public String updateReport(@RequestBody Report report, Model model , Search
	 * search )throws Exception {
	 * 
	 * 
	 * 
	 * return "forward:/serviceCenter/serviceCenterHome.jsp"; }
	 */
	/*
	 * @RequestMapping(value="/json/getQandAList", method = RequestMethod.POST)
	 * public Map<String, Object> getQandAList(@RequestBody Search search, QandA
	 * qandA, String userId) throws Exception {
	 * 
	 * System.out.println("/serviceCenter/getQandAList :POST");
	 * if(search.getCurrentPage() == 0) { search.setCurrentPage(1); }
	 * search.setPageSize(pageSize); String userId1=""; Map<String, Object> map =
	 * serviceCenterService.getQandAList(search, qandA , userId1);
	 * 
	 * Page resultPage = new Page(search.getCurrentPage(),
	 * ((Integer)map.get("totalCount")), pageUnit, pageSize);
	 * 
	 * map.put("search", search); map.put("qandA", qandA); map.put("resultPage",
	 * resultPage); map.put("userId", "userId");
	 * 
	 * return map; }
	 */
	
	@RequestMapping(value = "/json/updateReport", method = RequestMethod.POST)
	public String updateReport(@RequestBody Report report,  String number,
			User user, Map<String, Object> map, ClubPost clubPost, Comment comment, HttpSession httpSession, Model model) throws Exception {
		
		System.out.println("/ServiceCenter/updateReport : POST");

			System.out.println("처음 들어온 신고이유 "+report.getReportReason());
			serviceCenterService.updateReport(report);
			System.out.println(report);
			report = serviceCenterService.getReport(report.getNo());
			
			model.addAttribute("report", report);
		
			return "redirect:/serviceCenter/getReportList";
		
	}
	
	/////////////////////////////////////////////// 알림 ///////////////////////////////////////////////
	
	@RequestMapping(value = "/json/getPushList", method = RequestMethod.POST)
	public Map<String, Object> getPushList(@RequestBody User user, HttpSession httpSession) throws Exception {
		
		user = (User) httpSession.getAttribute("user");
		
		return serviceCenterService.getPushList(user);
		
	}
	
	
	/////////////////////////////////////////////// 알림 ///////////////////////////////////////////////

}//RestController 끝
