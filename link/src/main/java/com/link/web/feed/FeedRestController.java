package com.link.web.feed;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.link.common.Search;
import com.link.service.domain.Comment;
import com.link.service.domain.Feed;
import com.link.service.domain.Heart;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.feed.FeedService;
import com.link.service.serviceCenter.ServiceCenterService;
import com.link.service.user.UserService;

@RestController
@RequestMapping("/feedRest/*")
public class FeedRestController {

	@Autowired
	@Qualifier("feedServiceImpl")
	private FeedService feedService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("ServiceCenterServiceImpl")
	private ServiceCenterService serviceCenterService;
	
	public FeedRestController() {
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
	
	@RequestMapping(value = "/json/getFeedLastNo", method = RequestMethod.POST)
	public int getFeed() throws Exception {
		
		return feedService.getFeedLast().getFeedNo();
	}
	
	
	// 사용
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/json/addFeedComment", method = RequestMethod.POST)
	public List<Comment> addFeedComment(@RequestBody Comment comment, Report push, Search search, User user) throws Exception {
		
		// 댓글 작성
			
		user.setUserId(comment.getUserId());
		user = userService.getUser(user);
		
		comment.setUser(user);
		
		if(search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		} else {
			search.setOrder(1);
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("comment", comment);
		map.put("user", user);
		map.put("feedNo", comment.getFeedNo());
		map.put("search", search);
		
		feedService.addFeedComment(map);
		
//		push.setReportSource(4);
//		push.setType(2);
//		push.setContent(user.getNickName() + "님이 댓글을 작성했습니다.");
//		
//		push.setFeedComment(feedService.getCommentLast());
//		push.setUser1(user);
//		
//		serviceCenterService.addPush(push);
		
		return (List <Comment>)(feedService.getFeedCommentList(map).get("commentList"));
		
	}
	
	
	@RequestMapping(value = "/json/getFeedComment", method = RequestMethod.POST)
	public Comment getFeedComment(@RequestBody Comment comment) throws Exception {

		comment = feedService.getFeedComment(comment.getFeedCommentNo());
		
		return comment;
		
	}
	
	// 사용
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/json/updateFeedComment", method = RequestMethod.POST)
	public List<Comment> updateFeedComment(@RequestBody Comment comment, Search search, User user) throws Exception {
		
		if(comment.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		} else {
			search.setCurrentPage(1);
			search.setOrder( comment.getCurrentPage() );
			System.out.println("테스트 " + search.getOrder());
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		feedService.updateFeedComment(comment);
		
		comment = feedService.getFeedComment(comment.getFeedCommentNo());
		
		user.setUserId(comment.getUser().getUserId());
		user = userService.getUser(user);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("comment", comment);
		map.put("feedNo", comment.getFeedNo());
		map.put("user", user);
		
		return (List<Comment>) feedService.getFeedCommentList(map).get("commentList");
				
	}
	
	// 사용
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/json/deleteFeedComment", method = RequestMethod.POST)
	public List<Comment> deleteFeedComment(@RequestBody Comment comment, Search search, User user) throws Exception {
		
		if(comment.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		} else {
			search.setCurrentPage(1);
			search.setOrder( comment.getCurrentPage() );
			System.out.println("테스트 " + search.getOrder());
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		user.setUserId(comment.getUserId());
		user = userService.getUser(user);

		comment = feedService.getFeedComment(comment.getFeedCommentNo());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("comment", comment);
		map.put("feedNo", comment.getFeedNo());
		map.put("user", user);
		
		feedService.deleteFeedComment(map);
		
		return (List<Comment>) feedService.getFeedCommentList(map).get("commentList");
		
	}

	// 사용
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/json/getFeedList", method = RequestMethod.POST)
	public List<Feed> getFeedList(@RequestBody Feed feed, Search search, User user,
										HttpSession httpSession) throws Exception {
		
		user = (User) httpSession.getAttribute("user");
		
		System.out.println("search 테스트 " + search);
		
		// 피드 리스트
		
		if(feed.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		} else {
			search.setCurrentPage(feed.getCurrentPage());
		}
		
		search.setSearchKeyword(feed.getSearchKeyword());
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		map.put("feed", feed);
		map.put("feedNo", feed.getFeedNo());
		map.put("user", user);
		
		System.out.println("유저 : " + user);
		
		return (List<Feed>) feedService.getFeedList(map).get("feedList");
		
	}
	
	// 사용
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/json/getFeedCommentList", method = RequestMethod.POST)
	public List<Comment> getFeedCommentList(@RequestBody Feed feed, Search search, User user,
												HttpSession httpSession) throws Exception{
		
		user = (User) httpSession.getAttribute("user");

		// 피드 댓글 리스트
		
		if(feed.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		} else {
			
			if(feed.getCheckComment() == 1) {
				search.setCurrentPage(1);
				search.setOrder( feed.getCurrentPage() );
			} else {
				search.setCurrentPage(feed.getCurrentPage());
			}
			
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("feedNo", feed.getFeedNo());
		map.put("search", search);
		map.put("user", user);
		
		return (List<Comment>) feedService.getFeedCommentList(map).get("commentList");
		
	}
	
	
	
	///////////////////////////////////////////////////// Heart /////////////////////////////////////////////////////
	
	
	
	// 사용
	@RequestMapping(value = "/json/addFeedHeart", method = RequestMethod.POST)
	public int addFeedHeart(@RequestBody Heart heart, User user, Feed feed) throws Exception {
		
		// 피드 좋아요 추가
		
		user.setUserId(heart.getUserId());
		user = userService.getUser(user);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("heart", heart);
		map.put("user", user);
		map.put("feedNo", heart.getSourceNo());
		
		feed = ((Feed) feedService.getFeed(map).get("feed"));
		
		map.put("feed", feed);
		
		feed = feedService.addFeedHeart(map);
				
		return feed.getHeartCount();
		
	}
	
	// 사용
	@RequestMapping(value = "/json/deleteFeedHeart", method = RequestMethod.POST)
	public int deleteFeedHeart(@RequestBody Heart heart, User user, Feed feed) throws Exception {
		
		// 피드 좋아요 취소
		
		user.setUserId(heart.getUserId());
		user = userService.getUser(user);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("heart", heart);
		map.put("user", user);
		map.put("feedNo", heart.getSourceNo());
		
		feed = ((Feed) feedService.getFeed(map).get("feed"));
		
		map.put("feed", feed);
		
		feed = feedService.deleteFeedHeart(map);
				
		return feed.getHeartCount();

	}
	
	
	
	///////////////////////////////////////////////////// HEART COMMENT  /////////////////////////////////////////////////////
	
	
	
	// 사용
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/json/addFeedCommentHeart", method = RequestMethod.POST)
	public List<Comment> addFeedCommentHeart(@RequestBody Comment comment, Search search, User user, Heart heart) throws Exception {
		
		if(comment.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		} else {
			search.setCurrentPage(1);
			search.setOrder( comment.getCurrentPage() );
			System.out.println("테스트 " + search.getOrder());
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		// 피드 댓글 좋아요
		
		user.setUserId(comment.getUserId());
		user = userService.getUser(user);
		
		comment = feedService.getFeedComment(comment.getFeedCommentNo());
		
		heart.setSource("1");
		heart.setSourceNo(comment.getFeedCommentNo());
		heart.setUserId(user.getUserId());
		
		comment = feedService.getFeedComment(comment.getFeedCommentNo());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("heart", heart);
		map.put("comment", comment);
		map.put("search", search);
		map.put("user", user);
		map.put("feedNo", comment.getFeedNo());
		
		feedService.addFeedCommentHeart(map);
		
		return (List<Comment>) feedService.getFeedCommentList(map).get("commentList");
		
	}
	
	// 사용
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/json/deleteCommentHeart", method = RequestMethod.POST)
	public List<Comment> deleteFeedCommentHeart(@RequestBody Comment comment, Search search, User user, Heart heart) throws Exception {
		
		if(comment.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		} else {
			search.setCurrentPage(1);
			search.setOrder( comment.getCurrentPage() );
			System.out.println("테스트 " + search.getOrder());
		}
		
		search.setPageSize(pageSize);
		search.setPageUnit(pageUnit);
		
		// 피드 댓글 싫어요
		
		user.setUserId(comment.getUserId());
		user = userService.getUser(user);
		
		comment = feedService.getFeedComment(comment.getFeedCommentNo());
		
		heart.setSource("1");
		heart.setSourceNo(comment.getFeedCommentNo());
		heart.setUserId(user.getUserId());
		
		comment = feedService.getFeedComment(comment.getFeedCommentNo());
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("heart", heart);
		map.put("comment", comment);
		map.put("search", search);
		map.put("user", user);
		map.put("feedNo", comment.getFeedNo());
		
		feedService.deleteFeedCommentHeart(map);
		
		return (List<Comment>) feedService.getFeedCommentList(map).get("commentList");
		
	}
	
	
	
	///////////////////////////////////////////////////// REPORT /////////////////////////////////////////////////////
		
		
		
	
	
	
	
	///////////////////////////////////////////////////// UPLOAD /////////////////////////////////////////////////////
	
	
	@RequestMapping(value = "/json/uploadImage", produces = "application/json; charset=utf-8")
	public String uploadImage(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request) throws Exception {
		JsonObject jsonObject = new JsonObject();
		
		// 내부경로로 저장
		String originalFileName = multipartFile.getOriginalFilename();	//오리지날 파일명
		//String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		//String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		String savedFileName = originalFileName;	//저장될 파일 명
		
		File targetFile = new File("C:\\Users\\bitcamp\\git\\link\\link\\src\\main\\webapp\\resources\\image\\uploadFiles\\" + savedFileName);
		try {
			InputStream fileStream = multipartFile.getInputStream();
			FileUtils.copyInputStreamToFile(fileStream, targetFile);	//파일 저장
			jsonObject.addProperty("url", "/resources/image/uploadFiles/"+savedFileName); // contextroot + resources + 저장할 내부 폴더명
			jsonObject.addProperty("responseCode", "success");
			
		} catch (IOException e) {
			FileUtils.deleteQuietly(targetFile);	//저장된 파일 삭제
			jsonObject.addProperty("responseCode", "error");
			e.printStackTrace();
		}
		return jsonObject.toString();
	}
	
}
