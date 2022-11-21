package com.link.web.clubPost;

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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.JsonObject;
import com.link.common.Search;
import com.link.service.club.ClubService;
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.Chat;
import com.link.service.domain.ClubPost;
import com.link.service.domain.Comment;
import com.link.service.domain.Heart;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.serviceCenter.ServiceCenterService;

@RestController
@RequestMapping("/clubPostRest/*")
public class ClubPostRestController {

	@Autowired
	@Qualifier("clubPostServiceImpl")
	ClubPostService clubPostServiceImpl;

	@Autowired
	@Qualifier("clubServiceImpl")
	ClubService clubServiceImpl;

	@Autowired
	@Qualifier("ServiceCenterServiceImpl")
	private ServiceCenterService serviceCenterService;

	public ClubPostRestController() {
		System.out.println(getClass() + " default 생성자 호출");
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@Value("#{commonProperties['clubPostUploadTemDir']}")
	String clubPostUploadTemDir;
	
	@Value("#{commonProperties['tempDir']}")
	String tempDir;

	
	
	

	
///////////////////////////////////////////////////////////////////////////////////// ClubPost /////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	@RequestMapping(value = "json/getClubPost", method = RequestMethod.POST)
	public ClubPost getClubPost(@RequestBody ClubPost clubPost, Map<String, Object> map, HttpSession session) throws Exception {
		System.out.println("/getClubPost : POST : 상세보기에서 모달창으로 게시물정보 가져오기");

		// 전달받은 게시물 번호
		System.out.println("모임 번호 : " + clubPost.getClubNo() + ", 모임 게시물 번호 : " + clubPost.getClubPostNo());
		
		////////////////////////////////////// DATA /////////////////////////////////////////

		clubPost.setUser((User)session.getAttribute("user"));
		map.put("clubPost", clubPost);
		
		////////////////////////////////////// Business Logic /////////////////////////////////////////
		
		map = clubPostServiceImpl.getClubPost(map);
		
		return (ClubPost)map.get("getClubPost");
	}
	
	@RequestMapping(value = "json/getClubPostList", method = RequestMethod.POST)
	public Map<String, Object> getClubPostList(@RequestBody Search search, ClubPost clubPost, Map<String, Object> map, HttpSession session) throws Exception {
		System.out.println("/getClubPostList : POST : 페이징, 특정 모임에서 모임게시물 리스트, 개수");
		// search.order => 0 : 최신순, 1 : 역최신순, 2 : 좋아요 많은순, 3 : 내가 작성한 게시물

		System.out.println(search);
		System.out.println(clubPost);
		
		clubPost.setUser((User) session.getAttribute("user"));
		search.setPageSize(pageSize);
		clubPost.setClubNo(search.getPageUnit());
		map.put("search", search);
		//map.put("clubPost", clubPostServiceImpl.getClubPostList(ClubPostCommon.getSearch(search), clubPost));
		// 모임게시물 리스트 : clubPostList, 모임게시물 리스트 개수 : clubPostListCount
		
		System.out.println("확인용 데이터 : " + map.get("clubPost"));
		
		return clubPostServiceImpl.getClubPostList(ClubPostCommon.getSearch(search), clubPost);
	}

	@RequestMapping(value = "json/updateClubPost", method = RequestMethod.POST)
	public ClubPost updateClubPost(@RequestBody ClubPost clubPost, Heart heart, Map<String, Object> map, HttpSession session) throws Exception {
		System.out.println("/updateClubPost : POST : 특정 모임게시물에 좋아요, 좋아요 수");
		
		
		
		System.out.println("모임번호 : " + clubPost.getClubNo() + ", 모임게시물번호 : " + clubPost.getClubPostNo());
		
		

		////////////////////////////////////// DATA /////////////////////////////////////////
		
		

		// 좋아요 등록/삭제 를 위해 userId가 필요하다
		heart.setUserId(((User)session.getAttribute("user")).getUserId());
		map.put("heart", heart);
		// 상세보기 가져올때 좋아요여부와 모임직책을 가져오기 위해 user.userId가 필요하다
		clubPost.setUser((User)session.getAttribute("user"));
		map.put("clubPost", clubPost);
		
		
		
		////////////////////////////////////// BUSINESS LOGIC /////////////////////////////////////////
		
		
		
		// ServiceImpl에서 좋아요인지 좋아요 취소인지 구분해 DAOImpl에 보낸준다
		return ((ClubPost)clubPostServiceImpl.updateClubPost(map).get("getClubPost"));
	}

	@RequestMapping(value = "/json/updateClubPostSummernote", method = RequestMethod.POST)
	public ClubPost updateClubPostSummernote(@RequestBody ClubPost clubPost, Model model, Map<String, Object> map, Report report, HttpSession session) throws Exception {
		System.out.println("/updateClubPostSummernote : POST : 상세보기에서 모달로 게시물 수정 했을때");
		
		System.out.println("게시물번호 : " + clubPost.getClubPostNo() + ", 게시물제목 : " + clubPost.getClubPostTitle() + ", 게시물내용 : " + clubPost.getClubPostContent());

		////////////////////////////////////// DATA /////////////////////////////////////////
		
		// session으로 로그인한 회원 정보를 가져온다
		clubPost.setUser((User)session.getAttribute("user"));

		
		
		// specificImage 문자열이 있다면 summernote로 받아온 clubPostContent안에 이미지가 있다는 것
		String specificImage = "/resources/image/uploadFiles/";
		// specificVideo 문자열이 있다면 summernote로 받아온 clubPostContent안에 영상이 있다는 것
		String specificVideo = "embed/";
		
		
		
		// isIndexImage가 -1이면 이미지가 없다
		int isIndexImage = clubPost.getClubPostContent().indexOf(specificImage);
		// isIndexVideo가 -1이면 영상이 없다
		int isIndexVideo = clubPost.getClubPostContent().indexOf(specificVideo);
		
		

		if( isIndexImage != -1) {
			System.out.println("이미지가 있다");
			
			int startIndex = isIndexImage+specificImage.length();
			int endIndexFromStartIndex = clubPost.getClubPostContent().substring(startIndex).indexOf("\"");
			// 파일명.확장자
			System.out.println("시작 index : " + startIndex + ", 시작부터 마지막 index : " + endIndexFromStartIndex);
			String str = clubPost.getClubPostContent().substring(startIndex).substring(0, endIndexFromStartIndex);
			clubPost.setImage1(str);
		}
		
		if( isIndexVideo != -1) {
			System.out.println("영상이 있다");
			
			int startIndex = isIndexVideo+specificVideo.length();
			int endIndexFromStartIndex = clubPost.getClubPostContent().substring(startIndex).indexOf("\"");
			if(clubPost.getClubPostContent().substring(startIndex).indexOf("?") != -1) {
				endIndexFromStartIndex = clubPost.getClubPostContent().substring(startIndex).indexOf("?");
			}
			// 파일명.확장자
			System.out.println("시작 index : " + startIndex + ", 시작부터 마지막 index : " + endIndexFromStartIndex);
			String str = clubPost.getClubPostContent().substring(startIndex).substring(0, endIndexFromStartIndex);
			clubPost.setClubPostVideo1(str);
		}
		
		System.out.println("모임 게시물 대표 영상 썸네일 : " + clubPost.getClubPostVideo1() + ", 모임 게시물 대표 이미지 : " + clubPost.getImage1() + ", 모임 게시물 작성자 아이디 : " + clubPost.getUser().getUserId());
		
		
		
		////////////////////////////////////// BUSINESS LOGIC /////////////////////////////////////////

		
		// 모임 대표이미지 가져간다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubServiceImpl.getClub(clubPost.getClubNo());
		model.addAttribute("club", clubMap.get("club"));
		
		
		map.put("report", report);
		map.put("clubPost", clubPost);
		return (ClubPost) clubPostServiceImpl.updateClubPost(map).get("getClubPost");
	}
	
	@RequestMapping(value="/json/uploadSummernoteImageFile", produces = "application/json; charset=utf8")
	@ResponseBody
	public String uploadSummernoteImageFile(@RequestParam("file") MultipartFile multipartFile, HttpServletRequest request )  {
		JsonObject jsonObject = new JsonObject();
		
		// 내부경로로 저장
		//String originalFileName = multipartFile.getOriginalFilename();
		//String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		//String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		String savedFileName = multipartFile.getOriginalFilename();	//저장될 파일 명
		
		File targetFile = new File("C:\\Users\\903-19\\git\\link\\link\\src\\main\\webapp\\resources\\image\\uploadFiles\\" + savedFileName);	//저장될 전체 파일 경로 + 파일명
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



	

///////////////////////////////////////////////////////////////////////////////////// Chat /////////////////////////////////////////////////////////////////////////////////////

	
	///*
	@RequestMapping(value = "/json/addChat", method = RequestMethod.POST)
	public List<Chat> addChat(HttpSession session, @RequestBody Chat chat) throws Exception {
		System.out.println("/addChat : POST : 1:1 채팅에서 전송버튼을 클릭하면 채팅방 생성한다");

		chat.setUser((User)session.getAttribute("user"));
		chat.setUser2(new User(chat.getUserId2()));
		chat.setRoomId(((User)session.getAttribute("user")).getUserId()+chat.getUserId2());
		
		System.out.println("채팅방 번호 : " + chat.getRoomId() + ", 상대방 아이디 : " + chat.getUserId2());
		
		
		
		//////////////////////////////////////BUSINESS LOGIC /////////////////////////////////////////

		
		
		// 로그인한 회원과 상대방의 채팅방이 없으면 만들고 있으면 안 만든다
		List<Chat> list = clubPostServiceImpl.getChatList(chat);
		System.out.println("로그인한 회원과 상대방과의 방 : " + list);
		
		String currentRoomId = "";
		if( list.size() == 0 ) {
			// DB에 로그인한 회원과 상대방과의 채팅방이 없으면 채팅방 만듬, 1:1 채팅에서 메세지를 보내면 채팅방 만들어짐
			clubPostServiceImpl.addChat(chat);
			currentRoomId = chat.getRoomId();
		}
		
		// 내가 들어있는 채팅방 가져오기
		List<Chat> chatList = clubPostServiceImpl.getChat(chat);
		for (int i = 0; i < chatList.size(); i++) {
			if( chatList.get(i).getRoomId().indexOf(chat.getUserId2()) != -1) {
				currentRoomId = chatList.get(i).getRoomId();
				System.out.println("1111111111currentRoomId : " + currentRoomId);
			}
		}
		
		for (int i = 0; i < chatList.size(); i++) {
			System.out.println("currentRoomId : " + currentRoomId);
			chatList.get(i).setCurrentRoomId(currentRoomId);
		}
		
		return chatList;
	}
	//*/
	
	
///////////////////////////////////////////////////////////////////////////////////// MyHome /////////////////////////////////////////////////////////////////////////////////////
	
	
	
	

	@RequestMapping(value = "getClubPostListMyHome", method = RequestMethod.POST)
	public Map<String, Object> getClubPostListMyHome(HttpSession session) throws Exception {
		System.out.println("/getClubPostListMyHome : GET : 마이홈피로 내가 작성한 모임게시물 리스트, 모임게시물 리스트 개수");
		// 모임게시물 리스트 : clubPostList, 모임게시물 리스트 개수 : clubPostListCount
		String userId = ((User) session.getAttribute("user")).getUserId();
		return clubPostServiceImpl.getClubPostListMyHome(userId);
	}
	
	
	

	
///////////////////////////////////////////////////////////////////////////////////// Report /////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	
	
	@RequestMapping(value = "json/addReport", method = RequestMethod.POST)
	public void addReport(@RequestBody Report report) throws Exception {
		System.out.println("/addReport : POST : 모임게시물 또는 모임게시물 댓글을 신고, 작성자 이외에 가능, 신고되었다 아직 신고승인 전");
		serviceCenterService.addReport(report);
	}
	
	@RequestMapping(value = "json/addReportConfirm", method = RequestMethod.POST)
	public void addReportConfirm(@RequestBody Report report) throws Exception {
		System.out.println("/addReportConfirm : POST : 신고처리승인, 관리자만 가능");
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("report", report);
		map.put("reportCondition", 1);
		clubPostServiceImpl.updateClubPost(map);
	}
	
	
	

	
///////////////////////////////////////////////////////////////////////////////////// ClubPostComment /////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	@RequestMapping(value = "json/addClubPostComment", method = RequestMethod.POST)
	public Comment addClubPostComment(@RequestBody Comment comment, HttpSession session) throws Exception {
		System.out.println("/addClubPostComment : POST : 모임게시물 댓글 등록, 모임게시물 작성자에게 알림, 해당 모임게시물 댓글 가져온다");
		
		
		
		System.out.println("모임게시물번호 : " + comment.getClubPostNo() + ", 댓글 내용 : " + comment.getCommentContent() + ", 댓글번호 : " + comment.getClubPostCommentNo() + ", 댓글깊이 : " + comment.getDepth());
		
		
		
		////////////////////////////////////// DATA /////////////////////////////////////////
		
		

		// 댓글 등록 하기위해 필요하다 user.userId
		comment.setUser((User) session.getAttribute("user"));
		
		
		
		////////////////////////////////////// BUSINESS LOGIC /////////////////////////////////////////
		
		
		
		return clubPostServiceImpl.addClubPostComment(comment);
	}
	
	@RequestMapping(value = "json/getClubPostCommentList", method = RequestMethod.POST)
	public List<Comment> getClubPostCommentList(@RequestBody Comment comment, Search search, Map<String, Object> map, HttpSession session) throws Exception {
		System.out.println("/getClubPostCommentList : POST : 특정 모임의 또는 특정 댓글의 댓글리스트");
		// search - currentPaget와 pageSize, comment - depth, clubPostCommentNo
		
		System.out.println("해당 댓글의 깊이 : " + comment.getDepth() + ", 해당 댓글의 번호 : " + comment.getClubPostCommentNo() + ", 해당 댓글의 게시물번호 : " + comment.getClubPostNo());
		

		
		////////////////////////////////////// DATA /////////////////////////////////////////
		
		
		
		// 해당 댓글에 좋아요 여부 확인위해서 필요하다
		comment.setUser((User)session.getAttribute("user"));
		map.put("comment", comment);
		map.put("search", ClubPostCommon.getSearch(search));
		
		
		
		////////////////////////////////////// BUSINESS LOGIC /////////////////////////////////////////

		
	
		System.out.println("search 처리 후 : " + map.get("search"));
		
		return clubPostServiceImpl.getClubPostCommentList(map);
	}
	
	@RequestMapping(value = "json/getClubPostComment", method = RequestMethod.POST)
	public Comment getClubPostComment(@RequestBody Comment comment) throws Exception {
		System.out.println("/getClubPostComment : POST : 모임게시물 댓글");
		return clubPostServiceImpl.getClubPostComment(comment);
	}
	
	@RequestMapping(value = "json/updateClubPostComment", method = RequestMethod.POST)
	public Comment updateClubPostComment(@RequestBody Comment comment, Heart heart, Report report, HttpSession session) throws Exception {
		System.out.println("/updateClubPostComment : POST : 모임게시물 댓글 수정, 해당 모임게시물 댓글 상세보기 가져온다");
		
		
		
		// heartCondition이 0이면 댓글 수정, 1이면 좋아요
		System.out.println("clubPostCommentNo : " + comment.getClubPostCommentNo() + ", heartCondition : " + comment.getHeartCondition());
		
		
		
		////////////////////////////////////// DATA /////////////////////////////////////////
		
		
		
		// 로그인한 회원의 좋아요 여부를 알기위해 필요하다
		comment.setUser((User)session.getAttribute("user"));
		
		
		
		////////////////////////////////////// BUSINESS LOGIC /////////////////////////////////////////
		
		// 좋아요 또는 좋아요 취소
		return clubPostServiceImpl.updateClubPostComment(comment, heart, report);
	}
	
	@RequestMapping(value = "json/deleteClubPostComment", method = RequestMethod.POST)
	public Map<String, Object> deleteClubPostComment(@RequestBody Comment comment, HttpSession session) throws Exception {
		System.out.println("/deleteClubPostComment : POST : 모임게시물 댓글 삭제, 해당 모임게시물 댓글 리스트 가져온다");
		
		
		
		// 댓글개수를 수정하기 위해 게시물번호 필요하다
		System.out.println("clubPostCommentNo : " + comment.getClubPostCommentNo() + ", clubPostNo : " + comment.getHeartCondition());
		
		
		
		////////////////////////////////////// DATA /////////////////////////////////////////
		
		
		
		// 삭제한 회원의 아이디를 delete_user_id에 입력하기위해 필요하다
		comment.setUser((User) session.getAttribute("user"));
		
		
		
		////////////////////////////////////// BUSINESS LOGIC /////////////////////////////////////////
		
		// 댓글 삭제
		return clubPostServiceImpl.deleteClubPostComment(comment);
	}

}




