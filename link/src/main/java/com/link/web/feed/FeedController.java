package com.link.web.feed;

import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.link.common.Page;
import com.link.common.Search;
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.Chat;
import com.link.service.domain.Feed;
import com.link.service.domain.Heart;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.feed.FeedService;
import com.link.service.myHome.MyHomeService;
import com.link.service.serviceCenter.ServiceCenterService;

import edu.emory.mathcs.backport.java.util.Arrays;

@Controller
@RequestMapping("/feed/*")
public class FeedController {
	
	@Autowired
	@Qualifier("feedServiceImpl")
	private FeedService feedService;
	
	@Autowired
	@Qualifier("ServiceCenterServiceImpl")
	private ServiceCenterService serviceCenterService;
	
	// 채팅에 필요한 코딩
	@Autowired
	@Qualifier("clubPostServiceImpl")
	private ClubPostService clubPostService;
	
	@Autowired
	@Qualifier("myHomeServiceImpl")
	private MyHomeService myHomeService;
	
	public FeedController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass() + " default constructor");
	}
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	//@Value("#{commonProperties['pageUnit'] ? : 3}")
	// 없다면 ? 3으로 초기화
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	
	
	///////////////////////////////////////////////////// Feed /////////////////////////////////////////////////////
	
	
	
	// 사용
	@RequestMapping(value = "addFeed", method = RequestMethod.POST)
	public String addFeed(@ModelAttribute Feed feed, MultipartFile file,
							User user, Report report, Model model, HttpSession httpSession) throws Exception {
		
		// 회원 피드 등록
		
		user = (User) httpSession.getAttribute("user");
		feed.setUser(user);
		
		String originalContent = feed.getFullContent();
		// 이미지 파싱
		
		Pattern pattern  =  Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		Matcher match = pattern.matcher(feed.getFullContent());
		
		String[] fileName = new String[4];
		
		System.out.println("이미지 커트 전 : " + feed.getFullContent());
		
		int count = 0;
		while(match.find()){
			String inputString;
			
			fileName[count] = match.group();
			
			if (count == 0) {
				int startPoint = fileName[count].indexOf("uploadFiles/") + 12;
				inputString = fileName[count].substring(startPoint, fileName[count].length() - 2);
				String[] splitBy = inputString.split("\" ");
				feed.setImage1(splitBy[0]);
				
			} else if (count == 1) {
				int startPoint = fileName[count].indexOf("uploadFiles/") + 12;
				inputString = fileName[count].substring(startPoint, fileName[count].length() - 2);
				String[] splitBy = inputString.split(" ");
				feed.setImage2(splitBy[0]);
				
			} else if (count == 2) {
				int startPoint = fileName[count].indexOf("uploadFiles/") + 12;
				inputString = fileName[2].substring(startPoint, fileName[count].length() - 2);
				String[] splitBy = inputString.split(" ");
				feed.setImage3(splitBy[0]);
				
			} else if (count == 3) {
				int startPoint = fileName[count].indexOf("uploadFiles/") + 12;
				inputString = fileName[count].substring(startPoint, fileName[count].length() - 2);
				String[] splitBy = inputString.split(" ");
				feed.setImage4(splitBy[0]);
			}
			
			count++;
			
		}
		
		feed.setContent(feed.getFullContent().replaceAll("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>", ""));
		System.out.println("확인 :: " + feed.getContent());
		
		// 영상 등록
		
		System.out.println("영상커트 : " + feed.getContent());
		
		if((feed.getContent()).contains("src=\"")) {
			int startPoint = feed.getContent().indexOf("src=\"") + 7;
			String inputString = feed.getContent().substring(startPoint, feed.getContent().length());
			String[] splitBy = inputString.split("\" ");
			feed.setVideo(splitBy[0]);
			
			System.out.println(splitBy[0]);
			
			int lastPoint = feed.getContent().lastIndexOf("\">") + 2;
			String videoString = feed.getContent().substring(feed.getContent().indexOf("<iframe"), lastPoint);
			
			feed.setContent(feed.getContent().replaceAll(videoString, " "));
		}

		// 해시태그 저장하기 시작
		
		StringBuilder stringBuilder = new StringBuilder();
		String[] hashtag = feed.getContent().split("#");
		
		for(int i = 0 ; i < hashtag.length ; i++) {
			hashtag[i] = hashtag[i].replaceAll(" ", "");
			System.out.println("테스트 : " + hashtag[i]);
		}
		
		@SuppressWarnings("unchecked")
		LinkedHashSet<String> hashSet = new LinkedHashSet<String>(Arrays.asList(hashtag));
		String[] resultHashtag = hashSet.toArray(new String[0]);
		
		for(String str : resultHashtag) {
			System.out.println("결과 : " + str + "\n");
		}
		
		for(int i = 1 ; i < resultHashtag.length ; i++) {
			
			if(resultHashtag[i].contains(" ")) {
				// 공백 체크
				int index = resultHashtag[i].indexOf(" ");
				
				resultHashtag[i] = resultHashtag[i].substring(0, index);
			}
			
			stringBuilder.append("#").append(resultHashtag[i]);
			
		}
		
		feed.setHashtag(stringBuilder.toString());
		
		// 해시태그 저장하기 종료
		
		// Report & Push
		
		feedService.addFeed(feed);
		
		report.setReportSource(3);
		report.setType(2);
		report.setContent(user.getNickName() + "님이 피드를 작성했습니다.");
		
		report.setFeed(feedService.getFeedLast());
		report.setUser1(user);
		
		serviceCenterService.addPush(report);
		
		return "redirect:/feed/getFeedList";
	}
	
	// 사용
	@RequestMapping(value = "getFeed")
	public String getFeed(@RequestParam(value = "feedNo") int feedNo, Search search, 
								User user, Heart heart, Model model, HttpSession httpSession, Chat chat) throws Exception {
		
		user = (User) httpSession.getAttribute("user");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		heart.setSource("0");
		heart.setSourceNo(feedNo);
		
		if(user != null) {
			heart.setUserId(user.getUserId());
		}
		
		map.put("feedNo", feedNo);
		map.put("search", search);
		map.put("heart", heart);
		map.put("user", user);
		
		map = feedService.getFeed(map);
		
		Map<String, Object> commentMap = feedService.getFeedCommentList(map);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)commentMap.get("totalFeedCommentCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("feed", map.get("feed"));
		model.addAttribute("commentList", commentMap.get("commentList"));
		model.addAttribute("totalFeedCommentCount", commentMap.get("totalFeedCommentCount"));
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(httpSession.getAttribute("user") != null) {
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)httpSession.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)httpSession.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/feed/getFeed.jsp";
	}
	
	// 사용
	@RequestMapping(value = "updateFeed", method = RequestMethod.GET)
	public String updateFeed(@RequestParam(value = "feedNo") int feedNo, Search search, 
								User user, Heart heart, Model model) throws Exception {
		
		heart.setSource("0");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("feedNo", feedNo);
		map.put("search", search);
		map.put("heart", heart);
				
		model.addAttribute("feed", (Feed) feedService.getFeed(map).get("feed"));
		
		return "forward:/feed/updateFeedView.jsp";
	}
	
	@RequestMapping(value = "updateFeedModal", method = RequestMethod.GET)
	public String updateFeedModal(@RequestParam(value = "feedNo") int feedNo, Search search, 
								User user, Heart heart, Model model) throws Exception {
		
		heart.setSource("0");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("feedNo", feedNo);
		map.put("search", search);
		map.put("heart", heart);
				
		model.addAttribute("feed", (Feed) feedService.getFeed(map).get("feed"));
		
		return "forward:/feed/updateFeedViewModal.jsp";
	}
	
	// 사용
	@RequestMapping(value = "updateFeed", method = RequestMethod.POST)
	public String updateFeed(@ModelAttribute Feed feed, MultipartFile file, Search search, 
								User user, Heart heart, Model model) throws Exception {
		
		String originalContent = feed.getFullContent();
		// 이미지 파싱
		
		System.out.println("테스트 : " + feed.getFullContent());
		
		Pattern pattern  =  Pattern.compile("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>");
		Matcher match = pattern.matcher(feed.getFullContent());
		
		String[] fileName = new String[4];
		
		System.out.println("이미지 커트 전 : " + feed.getContent());
		
		int count = 0;
		while(match.find()){
			String inputString;
			
			fileName[count] = match.group();
			
			if (count == 0) {
				int startPoint = fileName[count].indexOf("uploadFiles/") + 12;
				inputString = fileName[count].substring(startPoint, fileName[count].length() - 2);
				String[] splitBy = inputString.split("\" ");
				feed.setImage1(splitBy[0]);
				
			} else if (count == 1) {
				int startPoint = fileName[count].indexOf("uploadFiles/") + 12;
				inputString = fileName[count].substring(startPoint, fileName[count].length() - 2);
				String[] splitBy = inputString.split(" ");
				feed.setImage2(splitBy[0]);
				
			} else if (count == 2) {
				int startPoint = fileName[count].indexOf("uploadFiles/") + 12;
				inputString = fileName[2].substring(startPoint, fileName[count].length() - 2);
				String[] splitBy = inputString.split(" ");
				feed.setImage3(splitBy[0]);
				
			} else if (count == 3) {
				int startPoint = fileName[count].indexOf("uploadFiles/") + 12;
				inputString = fileName[count].substring(startPoint, fileName[count].length() - 2);
				String[] splitBy = inputString.split(" ");
				feed.setImage4(splitBy[0]);
			}
			
			count++;
			
		}
		
		feed.setContent(feed.getFullContent().replaceAll("<img[^>]*src=[\"']?([^>\"']+)[\"']?[^>]*>", ""));
		System.out.println("확인 :: " + feed.getContent());
		
		// 영상 등록
		
		System.out.println("영상커트 : " + feed.getContent());
		
		if((feed.getContent()).contains("src=\"")) {
			int startPoint = feed.getContent().indexOf("src=\"") + 7;
			String inputString = feed.getContent().substring(startPoint, feed.getContent().length());
			String[] splitBy = inputString.split("\" ");
			feed.setVideo(splitBy[0]);
			
			System.out.println(splitBy[0]);
			
			int lastPoint = feed.getContent().lastIndexOf("\">") + 2;
			String videoString = feed.getContent().substring(feed.getContent().indexOf("<iframe"), lastPoint);
			
			feed.setContent(feed.getContent().replaceAll(videoString, " "));
		}

		// 해시태그 저장하기 시작
		
		StringBuilder stringBuilder = new StringBuilder();
		String[] hashtag = feed.getContent().split("#"); 
		
		for(int i = 1 ; i < hashtag.length ; i++) {
			
			if(hashtag[i].contains(" ")) {
				// 공백 체크
				int index = hashtag[i].indexOf(" ");
				
				hashtag[i] = hashtag[i].substring(0, index);
			}
			
			stringBuilder.append("#").append(hashtag[i]);
			
		}
		
		feed.setHashtag(stringBuilder.toString());
		
		// 해시태그 저장하기 종료
		
		// Report & Push
		
		feedService.updateFeed(feed);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		heart.setSource("0");
		
		// 피드 번호 전달
		map.put("feedNo", feed.getFeedNo());
		map.put("search", search);
		map.put("heart", heart);
		
		// 업데이트 된 피드 찾기
		map = feedService.getFeed(map);
				
		model.addAttribute("feed", map.get("feed"));
		
		return "forward:/feed/getFeed";
	}
	
	// 사용
	@RequestMapping(value = "deleteFeed", method = RequestMethod.GET)
	public String deleteFeed(@RequestParam(value = "feedNo") int feedNo, Model model) throws Exception {
		
		feedService.deleteFeed(feedNo);
		
		return "forward:/feed/getFeedList";
	}
	
	
	
	///////////////////////////////////////////////////// Feed Comment /////////////////////////////////////////////////////
	
	
	
	///////////////////////////////////////////////////// Feed List /////////////////////////////////////////////////////
	
	
	// 사용
	@RequestMapping(value = "getFeedList")
	public String getFeedList(@ModelAttribute Search search, Heart heart, Chat chat,
								User user, HttpSession httpSession, Map<String, Object> map, Model model) throws Exception {
		
		user = (User) httpSession.getAttribute("user");
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		map.put("heart", heart);
		map.put("search", search);
		map.put("user", user);
		map.put("myHome", 0);
				
		map = feedService.getFeedList(map);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer)map.get("totalFeedCount")).intValue(), pageUnit, pageSize);
		
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("feedList", map.get("feedList"));
		// model.addAttribute("alarm", serviceCenterService.getPushList(user).get("alarm"));
		// model.addAttribute("alarmCount", serviceCenterService.getPushList(user).get("alarmCount"));
		
		///////////////////////// 팔로우 리스트 가져오기 /////////////////////////
		
//		if(user != null) {
//			search.setSearchKeyword(user.getUserId());
//			model.addAttribute("list", myHomeService.getFollowList(search).get("list"));
//		}
		
		///////////////////////// 팔로우 리스트 가져오기 /////////////////////////
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(httpSession.getAttribute("user") != null) {
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)httpSession.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)httpSession.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/feed/getFeedList.jsp";
	}
	
	
	
	
	
	///////////////////////////////////////////////////// Feed List /////////////////////////////////////////////////////
	
	
	
}
