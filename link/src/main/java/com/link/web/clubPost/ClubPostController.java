package com.link.web.clubPost;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.link.common.Search;
import com.link.service.club.ClubService;
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.Chat;
import com.link.service.domain.Club;
import com.link.service.domain.ClubPost;
import com.link.service.domain.Comment;
import com.link.service.domain.Heart;
import com.link.service.domain.Pay;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.serviceCenter.ServiceCenterService;
import com.link.service.user.UserService;

@Controller
@RequestMapping("/clubPost/*")
public class ClubPostController {

	@Autowired
	@Qualifier("clubPostServiceImpl")
	ClubPostService clubPostServiceImpl;

	@Autowired
	@Qualifier("clubServiceImpl")
	ClubService clubServiceImpl;

	@Autowired
	@Qualifier("userServiceImpl")
	UserService userServiceImpl;
	
	@Autowired
	@Qualifier("ServiceCenterServiceImpl")
	private ServiceCenterService serviceCenterService;
	
	public ClubPostController() {
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

	

	
///////////////////////////////////////////////////////////////////////////////////// ClubPost /////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	
	
	@RequestMapping(value = "getClubPostList")
	public String getClubPostList(Search search, ClubPost clubPost, Model model, HttpSession session, Chat chat, Map<String, Object> map) throws Exception {
		System.out.println("/getClubPostList : GET,POST : 모임 상세보기에서 모임게시물 탭 클릭시 session에 있는 모임번호로 해당 모임의 모임게시물리스트, 모임게시물 리스트 개수 가져온 후 모임게시물 리스트 화면으로 이동");

		

		////////////////////////////////////// DATA /////////////////////////////////////////
		
		
		
		// 로그인한 회원 정보를 가져온다
		clubPost.setUser((User)session.getAttribute("user"));
		
		// club 상세보기에서 모임번호를 session으로 가져온다 어떤 모임의 게시물인지 알기위해 필요하다
		clubPost.setClubNo(Integer.parseInt((String)session.getAttribute("clubNo")));
		//clubPost.setClubNo(1);
		System.out.println("clubNo : " + clubPost.getClubNo());

		// meta 데이터인 pageSize = 10 화면에 게시물이 10개 나온다
		search.setPageSize(pageSize);
		// order = 0 최신순, currentPage = 1, searchCondition = 1 게시물 내용
		search = ClubPostCommon.getSearch(search);
		
		
		
		////////////////////////////////////// BUSINESS LOGIC /////////////////////////////////////////
		
		
		
		map = clubPostServiceImpl.getClubPostList(search, clubPost);
		//model.addAttribute("clubNo", Integer.parseInt((String)session.getAttribute("clubNo")));
		model.addAttribute("search", search);
		model.addAttribute("clubPostList", map.get("clubPostList"));
		model.addAttribute("clubPostListCount", map.get("clubPostListCount"));
		// 모임게시물 리스트 : clubPostList, 모임게시물 리스트 개수 : clubPostListCount
		
		// 모임대표이미지 가져온다
		Map<String, Object> clubMap = clubServiceImpl.getClub(clubPost.getClubNo());
		model.addAttribute("club", clubMap.get("club"));
		
		// 알림
		//model.addAttribute("alarm", serviceCenterService.getPushList((User)session.getAttribute("user")).get("alarm"));
		//model.addAttribute("alarmCount", serviceCenterService.getPushList((User)session.getAttribute("user")).get("alarmCount"));
		
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostServiceImpl.getChat(chat));
				
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostServiceImpl.getRoomIdList((User)session.getAttribute("user")));
		
		
		
		//return "forward:/clubPost/getClubPostList_backup.jsp";
		return "forward:/clubPost/getClubPostList.jsp";
	}

	@RequestMapping(value = "addClubPost", method = RequestMethod.POST)
	public String addClubPost(@ModelAttribute ClubPost clubPost, Model model, HttpSession session) throws Exception {
		System.out.println("/addClubPost : POST : 모임게시물 등록, 모임원에게 알림, 모임게시물상세보기 가져온 후 모임게시물 상세보기 화면으로 이동");
		// session으로 로그인한 회원 정보를 가져온다
		clubPost.setUser((User)session.getAttribute("user"));

		System.out.println("확인용 : " + clubPost);		
		/*
		// 파일명.확장자만 DB에 넣기위해 빼내자
		String specificString = "/resources/image/temp/";
		String specificVideo = "<iframe frameborder=\"0\" src=\"//";
		String content = clubPost.getClubPostContent();
		int count = 1;
		//while(true) {
			int isIndex = 0;
			// 이미지가 있다면 수행해서 다음 Image 필드에 파일명을 넣어준다
			while(true) {
				isIndex = content.indexOf(specificString);
				if(isIndex == -1) {
					break;
				}
				int startIndex = content.indexOf(specificString)+specificString.length();
				int endIndexFromStartIndex = content.substring(startIndex).indexOf("\"");
				// 파일명.확장자
				String str = content.substring(startIndex).substring(0, endIndexFromStartIndex);
				switch (count) {
				case 1: clubPost.setImage1(str); break;
				case 2: clubPost.setImage2(str);break;
				case 3: clubPost.setImage3(str);break;
				case 4: clubPost.setImage4(str);break;
				case 5: clubPost.setImage5(str);break;
				case 6: clubPost.setImage6(str);break;
				case 7: clubPost.setImage7(str);break;
				case 8: clubPost.setImage8(str);break;
				case 9: clubPost.setImage9(str);break;
				case 10: clubPost.setImage10(str);break;
				}
				System.out.println(count + "번째");
				count++;
				// 기존 문자열에서 startIndex부터 찾는다는 것은 다음 이미지를 찾을 수 있다
				System.out.println(content = content.substring(startIndex));
				System.out.println(clubPost);
			}//else {
				// 이미지 경로가 없다면 더이상 이미지가 없다는 것 while 나간다
				//break;
			//}
		//}//end of while
		*/
		String specificImage = "/resources/image/uploadFiles/";
		//String specificVideo = "<iframe frameborder=\"0\" src=\"//";
		String specificVideo = "embed/";
		
		int isIndexImage = clubPost.getClubPostContent().indexOf(specificImage);
		int isIndexVideo = clubPost.getClubPostContent().indexOf(specificVideo);
		
		if( isIndexImage != -1) {
			System.out.println("이미지가 있다");
			int startIndex = isIndexImage+specificImage.length();
			int endIndexFromStartIndex = clubPost.getClubPostContent().substring(startIndex).indexOf("\"");
			// 파일명.확장자
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
			String str = clubPost.getClubPostContent().substring(startIndex).substring(0, endIndexFromStartIndex);
			System.out.println(str);
			clubPost.setClubPostVideo1(str);
		}
		
		System.out.println("모임 게시물 대표 영상 썸네일 : " + clubPost.getClubPostVideo1() + ", 모임 게시물 대표 이미지 : " + clubPost.getImage1() + ", 모임 게시물 작성자 아이디 : " + clubPost.getUser().getUserId());
		
		model.addAttribute("clubPost", clubPostServiceImpl.addClubPost(clubPost));
		
		// 알림
		//model.addAttribute("alarm", serviceCenterService.getPushList((User)session.getAttribute("user")).get("alarm"));
		//model.addAttribute("alarmCount", serviceCenterService.getPushList((User)session.getAttribute("user")).get("alarmCount"));
		
		// 모임 대표이미지 가져간다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubServiceImpl.getClub(clubPost.getClubNo());
		model.addAttribute("club", clubMap.get("club"));
		
		
		return "forward:/clubPost/getClubPost.jsp";
	}

	@RequestMapping(value = "getClubPost", method = RequestMethod.GET)
	public String getClubPost(@ModelAttribute ClubPost clubPost, Comment comment, Chat chat, Search search, Heart heart, Map<String, Object> map, Model model, HttpSession session) throws Exception {
		System.out.println("/getClubPost : GET : 모임게시물 상세보기, 모임게시물 댓글 리스트 가져온 후 모임게시물 상세보기 화면 또는 수정 화면으로 이동");
		
		
		
		System.out.println("모임번호 : " + clubPost.getClubNo() + ", 모임게시물번호 : " + clubPost.getClubPostNo());

		
		
		////////////////////////////////////// DATA /////////////////////////////////////////
		
		
		
		// search가 없으면 상세보기만 가져오고 있으면 상세보기 + 댓글리스트를 가져온다
		map.put("search", ClubPostCommon.getSearch(search));
		
		// 로그인한 회원의 모임 직책을 알기위해 모임번호가 필요하다
		clubPost.setClubNo(clubPost.getClubNo());
		// 로그인한 회원의 좋아요 여부 알기위해 회원 아이디 필요하다
		clubPost.setUser((User)session.getAttribute("user"));
		map.put("clubPost", clubPost);
		
		// 로그인한 회원이 해당 게시물에 좋아요 여부 알기위해 로그인한 회원의 아이디 필요하다
		comment.setUser((User)session.getAttribute("user"));
		// 해당 게시물의 댓글리스트만 가져오기 위해 필요하다
		comment.setClubPostNo(clubPost.getClubPostNo());
		map.put("comment", comment);

		
		
		////////////////////////////////////// BUSINESS LOGIC /////////////////////////////////////////
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostServiceImpl.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostServiceImpl.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		// 모임 대표이미지 가져간다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubServiceImpl.getClub(clubPost.getClubNo());
		model.addAttribute("club", clubMap.get("club"));
		// 게시물 상세보기 + 댓글리스트
		model.addAttribute("clubPost", clubPostServiceImpl.getClubPost(map));
		// 모임게시물 상세보기 : getClubPost, 모임게시물 댓글 리스트 : getClubPostCommentList, 좋아요 여부 : getClubPost.heartCondition, 모임 직책 : getClubPost.clubRole
		
		
		
		return "forward:/clubPost/getClubPost.jsp";
	}

	@RequestMapping(value = "updateClubPost")
	public String updateClubPost(@ModelAttribute ClubPost clubPost, Model model, Map<String, Object> map, Report report, HttpSession session, Comment comment, Chat chat) throws Exception {
		System.out.println("/updateClubPost : POST : 모임게시물 수정, 수정된 모임게시물 상세보기 가져온 후 모임게시물 상세보기 화면으로 이동");
		System.out.println("모임번호 : " + clubPost.getClubNo() + ", 모임게시물번호 : " + clubPost.getClubPostNo()
		+ ", 제목 : " + clubPost.getClubPostTitle() + ", 내용 : " + clubPost.getClubPostContent());
		
		// session으로 로그인한 회원 정보를 가져온다
		clubPost.setUser((User)session.getAttribute("user"));

		String specificImage = "/resources/image/uploadFiles/";
		String specificVideo = "embed/";
		
		int isIndexImage = clubPost.getClubPostContent().indexOf(specificImage);
		int isIndexVideo = clubPost.getClubPostContent().indexOf(specificVideo);

		if( isIndexImage != -1) {
			System.out.println("이미지가 있다");
			int startIndex = isIndexImage+specificImage.length();
			int endIndexFromStartIndex = clubPost.getClubPostContent().substring(startIndex).indexOf("\"");
			// 파일명.확장자
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
			System.out.println("시작 index : " + startIndex + ", 마지막 index : " + endIndexFromStartIndex);
			String str = clubPost.getClubPostContent().substring(startIndex).substring(0, endIndexFromStartIndex);
			clubPost.setClubPostVideo1(str);
		}
		
		System.out.println("모임 게시물 대표 영상 썸네일 : " + clubPost.getClubPostVideo1() + ", 모임 게시물 대표 이미지 : " + clubPost.getImage1() + ", 모임 게시물 작성자 아이디 : " + clubPost.getUser().getUserId());
		
		map.put("comment", comment);
		map.put("report", report);
		map.put("clubPost", clubPost);
		model.addAttribute("clubPost", clubPostServiceImpl.updateClubPost(map));
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostServiceImpl.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostServiceImpl.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		// 댓글 가져온다
		//model.addAttribute("clubPost", clubPostServiceImpl.getClubPost(map));
		
		// 모임 대표이미지 가져간다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubServiceImpl.getClub(clubPost.getClubNo());
		model.addAttribute("club", clubMap.get("club"));
				
		return "forward:/clubPost/getClubPost.jsp";
	}

	@RequestMapping(value = "deleteClubPost", method = RequestMethod.POST)
	public String deleteClubPost(@ModelAttribute ClubPost clubPost, Search search, Model model, Map<String, Object> map, HttpSession session) throws Exception {
		System.out.println("/deleteClubPost : POST : 모임게시물 삭제 flag 처리, 모임게시물 리스트 가져온 후 모임게시물 리스트 화면으로 이동");
		// 모임번호와 해당 유저아이디는 모임게시물 삭제할 때 필요하고 모임번호와 search는 모임게시물 리스트 가져올 때 필요하다
		clubPost.setUser((User)session.getAttribute("user"));
		map = clubPostServiceImpl.deleteClubPost(clubPost, ClubPostCommon.getSearch(search));
		
		model.addAttribute("clubPostList", map.get("clubPostList"));
		model.addAttribute("heartList", map.get("heartList"));
		model.addAttribute("clubPostListCount", map.get("clubPostListCount"));
		// 모임게시물 리스트 : clubPostList, 모임게시물 리스트 개수 : clubPostListCount

		// 모임 대표이미지 가져간다
		Map<String, Object> clubMap = new HashMap<String, Object>();
		clubMap = clubServiceImpl.getClub(clubPost.getClubNo());
		model.addAttribute("club", clubMap.get("club"));
		
		return "forward:/clubPost/getClubPostList.jsp";
	}
	
	
	
	
///////////////////////////////////////////////////////////////////////////////////// chat /////////////////////////////////////////////////////////////////////////////////////
	
	
	
	
	@RequestMapping(value = "/chatRoomList", method = RequestMethod.GET)
	public String chatClubList(HttpSession session, String roomId, String clubTitle, Model model) throws Exception {
		System.out.println("/chatRoomList : GET : 모임번호를 가지고 모임채팅리스트 화면으로 이동");
		
		System.out.println("채팅방 번호 : " + roomId);
		
		model.addAttribute("roomId", roomId);
		
		// 알림
		//model.addAttribute("alarm", serviceCenterService.getPushList((User)session.getAttribute("user")).get("alarm"));
		//model.addAttribute("alarmCount", serviceCenterService.getPushList((User)session.getAttribute("user")).get("alarmCount"));
		
		return "forward:/chat/chatRoom.jsp";
	}
	
	@RequestMapping(value = "/chatRoom", method = RequestMethod.GET)
	public String chatRoom(HttpSession session, Model model) throws Exception {
		System.out.println("/chatRoom : GET : 방번호를 가지고 모임채팅방 화면으로 이동");
		UUID roomId = UUID.randomUUID();
		System.out.println(roomId);
		model.addAttribute("roomId", roomId );
		return "forward:/chat/chatRoom.jsp";
	}
	
	

///////////////////////////////////////////////////////////////////////////////////// Pay /////////////////////////////////////////////////////////////////////////////////////	
	
	
	
	
	
	@RequestMapping(value = "addPayView", method = RequestMethod.GET)
	public String addPayView(@ModelAttribute Pay pay, Model model, HttpSession session, Chat chat) throws Exception {
		System.out.println("/addPayView : GET : 모임번호를 가지고 결제화면으로 이동");

		int maxPay = 0;
		// 모임번호 + navigation이 1이면 모임 상세보기로 간다
		// pay.setPayNavigation(1);
		// pay.setClubNo(1);
		
		// 모임번호만 있으면 모임원리스트로 간다
		// pay.setClubNo(1);
			
		// 둘 다 없으면 모임리스트로 간다
				
		System.out.println("모임번호 : " + pay.getClubNo() + ", 네비게시션 : " + pay.getPayNavigation() + ", 아이디 : " + ((User)session.getAttribute("user")).getUserId());
		if( pay.getClubNo() != 0 && pay.getPayNavigation() == 0 ) {
			// 모임대표가 가입승인 클릭시
			// 해당 모임의 최대 인원수까지의 최대 결제금액을 가져간다
			Map<String, Object> map = clubServiceImpl.getClub(pay.getClubNo());
			Club returnClub = (Club)map.get("club");
			System.out.println("전달받은 모임 정보 : " + returnClub);
			model.addAttribute("returnClub", returnClub);
			
			switch (returnClub.getClubMaxMember()) {
			case 10: maxPay = 20000; break;
			case 20: maxPay = 15000; break;
			case 30: maxPay = 10000; break;
			case 40: maxPay = 5000; break;
			}
		}else {
			// 모임등록시 모임가입신청시
			// 해당 회원의 최대 가입수까지의 최대 결제금액을 가져간다
			User returnUser = userServiceImpl.getUser((User)session.getAttribute("user"));
			System.out.println("전달받은 회원 정보 : " + returnUser);
			model.addAttribute("returnUser", returnUser);
			
			switch (returnUser.getJoinClubLimit()) {
			case 2: maxPay = 20000; break;
			case 4: maxPay = 15000; break;
			case 6: maxPay = 10000; break;
			case 8: maxPay = 5000; break;
			}
		}
		pay.setMaxPay(maxPay);
		model.addAttribute("pay", pay);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostServiceImpl.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostServiceImpl.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/pay/addPayView.jsp";
	}
	
	@RequestMapping(value = "addPay", method = RequestMethod.POST)
	public String addPay(@ModelAttribute Pay pay, Search search, Model model, HttpSession session, Chat chat) throws Exception {
		System.out.println("/addPay : POST : 모임원 최대 수 수정 후 모임원 리스트 화면으로 이동 모임대표만 올 수 있다, 모임번호가 있으면 모임 상세보기, 모임번호가 없으면 모임리스트 화면으로 이동");
		System.out.println(pay);
		pay.setUser(new User(((User)session.getAttribute("user")).getUserId()));
		//결제추가
		clubPostServiceImpl.addPay(pay);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostServiceImpl.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostServiceImpl.getRoomIdList((User)session.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		if(pay.getUpdateClubMemberCount() != 0) {
			// 모임원 업데이트 수가 있다면 모임대표가 가입승인 클릭 후 이벤트이다 결제 후 모임원리스트 화면으로 이동
			// 모임원 최대수 CLUB_MAX_MEMBER 증가
			model.addAttribute("clubMemberList", clubServiceImpl.updateClubMember(pay, ClubPostCommon.getSearch(search)));
			return "forward:/club/getClubMemberList.jsp";
		}else {
			// 모임 업데이트 수가 있다면 모임등록 또는 모임가입신청 클릭 후 이벤트이다 결제 후 모임번호가 있다면 모임상세보기 화면으로 모임번호가 없다면 모임리스트 화면으로 이동
			// 모임 최대수 JOIN_CLUB_LIMIT 증가
			userServiceImpl.updateClub(pay);
			
			if(pay.getPayNavigation() == 1) {
				// 모임상세보기
				model.addAttribute("getClub", clubServiceImpl.getClub(pay.getClubNo()));
				return "forward:/club/getClub.jsp";
			}else {
				// 모임리스트
				search = ClubPostCommon.getSearch(search);
				// searchCondition = null로 가야 에러없다
				search.setSearchCondition(null);
				Map<String, Object> map = clubServiceImpl.getClubList(search);
				model.addAttribute("clubList", map.get("clubList"));
				return "forward:/club/getClubList.jsp";
			}
		}
	}//end of addPay

	@RequestMapping(value = "getPayList", method = RequestMethod.POST)
	public String getPayList(HttpSession session, Model model) throws Exception {
		System.out.println("/getPayList : POST : 마이홈피에서 내가 결제한 리스트");
		model.addAttribute("payList", clubPostServiceImpl.getPayList((User)session.getAttribute("user")));
		return "forward:/pay/getPayList.jsp";
	}
	
	@RequestMapping(value = "getPay", method = RequestMethod.POST)
	public String getPay(@ModelAttribute Pay pay, Model model) throws Exception {
		System.out.println("/getPay : POST : 마이홈피에서 내가 결제 상세보기");
		model.addAttribute("pay", clubPostServiceImpl.getPay(pay));
		return "forward:/pay/getPay.jsp";
	}

}




