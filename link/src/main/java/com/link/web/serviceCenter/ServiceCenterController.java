package com.link.web.serviceCenter;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.link.common.Page;
import com.link.common.Search;
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.Chat;
import com.link.service.domain.ClubPost;
import com.link.service.domain.Comment;
import com.link.service.domain.Feed;
import com.link.service.domain.Notice;
import com.link.service.domain.QandA;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.feed.FeedService;
import com.link.service.serviceCenter.ServiceCenterService;

@Controller
@RequestMapping("/serviceCenter/*")
public class ServiceCenterController {

	@Autowired
	@Qualifier("ServiceCenterServiceImpl")
	private ServiceCenterService serviceCenterService;

	@Autowired
	@Qualifier("feedServiceImpl")
	private FeedService feedService;

	@Autowired
	@Qualifier("clubPostServiceImpl")
	ClubPostService clubPostServiceImpl;
	
	// 채팅에 필요한 코딩
	@Autowired
	@Qualifier("clubPostServiceImpl")
	private ClubPostService clubPostService;

	public ServiceCenterController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass() + " default constructor ");
	}

	@Value("#{commonProperties['pageSize'] ?: 10}")
	int pageSize;

	@Value("#{commonProperties['pageUnit'] ?: 10}")
	int pageUnit;
	
	@RequestMapping(value = "serviceCenterHome", method = RequestMethod.GET)
	public String serviceCenterHome(HttpSession session, Chat chat, Model model) throws Exception {
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/serviceCenter/serviceCenterHome.jsp";
	}

	@RequestMapping(value = "addNotice", method = RequestMethod.POST)
	public String addNotice(@ModelAttribute Notice notice, @RequestParam("image") MultipartFile[] file, Model model)
			throws Exception {
		System.out.println(notice);
		System.out.println("/ServiceCenter/addNotice : GET & POST");

		// 파일 업로드 시작
		int fileCount = 0;

		String root = "C:\\Users\\bitcamp\\git\\link\\link\\src\\main\\webapp\\resources\\image\\uploadFiles\\";

		for (MultipartFile files : file) {
			fileCount++;
			System.out.println(files.getOriginalFilename());

			if (fileCount != file.length) {
				notice.setNoticeImage2(files.getOriginalFilename());
			}
			notice.setNoticeImage1(files.getOriginalFilename());
			File saveFile = new File(root + files.getOriginalFilename());
			boolean isExists = saveFile.exists();
			if (!isExists) {
				files.transferTo(saveFile);
			}
		}

		serviceCenterService.addNotice(notice);

		model.addAttribute("notice", notice);
		System.out.println(notice + "확인용 데이터");
		return "forward:/serviceCenter/addNotice.jsp";
	}

	@RequestMapping(value = "getNotice")
	public String getNotice(@ModelAttribute Notice notice, Model model, HttpSession session, Chat chat, HttpServletResponse response) throws Exception {

		System.out.println("/ServiceCenter/getNotice : GET & POST");

		serviceCenterService.getCount(notice.getNoticeNo());
		notice = serviceCenterService.getNotice(notice.getNoticeNo());

		model.addAttribute("notice", notice);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		String URI = "forward:/serviceCenter/getNotice.jsp"; // 지워야됨

		return URI;
	}

	@RequestMapping(value = "deleteNotice")
	public String deleteNotice(@ModelAttribute Notice notice, Model model, HttpServletResponse response)
			throws Exception {

		System.out.println("/ServiceCenter/deleteNotice : GET & POST");
		serviceCenterService.deleteNotice(notice.getNoticeNo());
		return "forward:/serviceCenter/getNoticeList";

	}

	@RequestMapping(value = "updateNotice", method = RequestMethod.GET)
	public String updateNotice(@ModelAttribute Notice notice, Model model) throws Exception {

		System.out.println("/serviceCenter/updateNotice : GET");
		System.out.println(notice);
		notice = serviceCenterService.getNotice(notice.getNoticeNo());
		model.addAttribute("notice", notice);
		return "forward:/serviceCenter/updateNoticeView.jsp";
	}

	@RequestMapping(value = "updateNotice", method = RequestMethod.POST)
	public String updateNotice(@ModelAttribute Notice notice, Model model, User user,
			@RequestParam("image") MultipartFile[] file) throws Exception {

		System.out.println("/serviceCenter/updateNotice : POST");
		int fileCount = 0;


		String root = "C:\\Users\\bitcamp\\git\\link\\link\\src\\main\\webapp\\resources\\image\\uploadFiles\\";


		for (MultipartFile files : file) {
			fileCount++;
			System.out.println(files.getOriginalFilename());

			if (fileCount != file.length) {
				notice.setNoticeImage2(files.getOriginalFilename());
			}
			notice.setNoticeImage1(files.getOriginalFilename());
			File saveFile = new File(root + files.getOriginalFilename());
			boolean isExists = saveFile.exists();
			if (!isExists) {
				files.transferTo(saveFile);
			}
		}
		serviceCenterService.updateNotice(notice);
		System.out.println(notice);
		notice = serviceCenterService.getNotice(notice.getNoticeNo());
		model.addAttribute("notice", notice);
		return "forward:/serviceCenter/getNotice.jsp";
	}

	@RequestMapping(value = "getNoticeList")
	public String getNoticeList(@ModelAttribute("search") Search search, Notice notice, HttpSession session, Chat chat, Model model) throws Exception {
		System.out.println("/ServiceCenter/listNotice : GET & POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		System.out.println(search);
		Map<String, Object> map = serviceCenterService.getNoticeList(search, notice);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")), pageUnit, pageSize);

		model.addAttribute("getNoticeList", map.get("getNoticeList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		return "forward:/serviceCenter/getNoticeList.jsp";
	}

//======================================================================================여기까지가 Notice
	
	@RequestMapping(value = "addQandAView", method = RequestMethod.GET)
	public String addQandAView(HttpSession session, Chat chat, Model model) throws Exception {
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		
		
		return "forward:/serviceCenter/addQandAView.jsp";
	}

	@RequestMapping(value = "addQandA", method = RequestMethod.POST)
	public String addQandA(@ModelAttribute QandA qandA, @RequestParam("image") MultipartFile[] file, Model model, Chat chat,
			HttpSession session) throws Exception {
		System.out.println(qandA);

		System.out.println("/ServiceCenter/addQandA : GET& POST");
		User userId = (User) session.getAttribute("user");
		qandA.setUserId(userId);
		int fileCount = 0;

		String root = "C:\\Users\\bitcamp\\git\\link\\link\\src\\main\\webapp\\resources\\image\\uploadFiles\\";


		for (MultipartFile files : file) {
			fileCount++;
			System.out.println(files.getOriginalFilename());

			if (fileCount != file.length) {
				qandA.setQandAImage2(files.getOriginalFilename());
			}

			qandA.setQandAImage1(files.getOriginalFilename());

			File saveFile = new File(root + files.getOriginalFilename());

			boolean isExists = saveFile.exists();

			if (!isExists) {
				files.transferTo(saveFile);
			}
		}

		serviceCenterService.addQandA(qandA);

		model.addAttribute("qandA", qandA);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		


		return "forward:/serviceCenter/addQandA.jsp";
	}

	@RequestMapping(value = "getQandA", method = RequestMethod.GET)
	public String getQandA(@ModelAttribute QandA qandA, HttpSession session, Chat chat,
			@RequestParam(value = "menu", defaultValue = "search") String menu, Model model,
			HttpServletResponse response) throws Exception {

		System.out.println("/ServiceCenter/getQandA : GET & POST");

		qandA = serviceCenterService.getQandA(qandA.getQandANo());

		model.addAttribute("qandA", qandA);
		model.addAttribute("menu", menu);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		String URI = null;

		if (menu.equals("manage")) {
			URI = "forward:/serviceCenter/updateQandA";
		} else if (menu.equals("search")) {
			URI = "forward:/serviceCenter/getQandA.jsp";
		} else {
			URI = "forward:/serviceCenter/getQandA.jsp"; // 지워야됨
		}

		return URI;
	}

	@RequestMapping(value = "updateQandA", method = RequestMethod.GET)
	public String updateQandA(@ModelAttribute QandA qandA, Model model, HttpSession session, Chat chat) throws Exception {

		System.out.println("/ServiceCenter/updateQandA : GET");

		System.out.println(qandA);
		User userId = (User) session.getAttribute("user");
		qandA.setUserId(userId);
		qandA = serviceCenterService.getQandA(qandA.getQandANo());

		model.addAttribute("qandA", qandA);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		


		return "forward:/serviceCenter/updateQandAView.jsp";
	}

	@RequestMapping(value = "updateQandA", method = RequestMethod.POST)
	public String updateQandA(@ModelAttribute QandA qandA, @RequestParam("image") MultipartFile[] file,
			Model model, User user, HttpSession session) throws Exception {

		System.out.println("/ServiceCenter/updateQandA : POST");

		User userId = (User) session.getAttribute("user");
		qandA.setUserId(userId);
		System.out.println(qandA);
		int fileCount = 0;

		String root = "C:\\Users\\bitcamp\\git\\link\\link\\src\\main\\webapp\\resources\\image\\uploadFiles\\";


		for (MultipartFile files : file) {
			fileCount++;
			System.out.println(files.getOriginalFilename());

			if (fileCount != file.length) {
				qandA.setQandAImage2(files.getOriginalFilename());
			}

			qandA.setQandAImage1(files.getOriginalFilename());

			File saveFile = new File(root + files.getOriginalFilename());

			boolean isExists = saveFile.exists();

			if (!isExists) {
				files.transferTo(saveFile);
			}
		}
		serviceCenterService.updateQandA(qandA);

		qandA = serviceCenterService.getQandA(qandA.getQandANo());

		model.addAttribute("qandA", qandA);

		return "redirect:/serviceCenter/getQandA?qandANo="+qandA.getQandANo();
	}

	@RequestMapping(value = "deleteQandA")
	public String deleteQandA(@ModelAttribute QandA qandA, @RequestParam(defaultValue = "search") String menu,
			Model model, HttpServletResponse response) throws Exception {

		System.out.println("/ServiceCenter/deleteQandA : GET & POST");

		serviceCenterService.deleteQandA(qandA.getQandANo());

		return "forward:/serviceCenter/getQandAList";
	}

	@RequestMapping(value = "getQandAList", method = RequestMethod.GET)
	public String getQandAList(@ModelAttribute("search") Search search, QandA qandA, Model model, Chat chat, HttpSession session,
			@RequestParam(value = "menu", defaultValue = "search") String menu) throws Exception {

		System.out.println("/serviceCenter/getQandAList : GET ");
		if (search.getOrder() == 0) {
			search.setOrder(2);
		}
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);
		Map<String, Object> map = serviceCenterService.getQandAList(search, qandA);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")), pageUnit, pageSize);

		model.addAttribute("getQandAList", map.get("getQandAList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		return "forward:/serviceCenter/getQandAList.jsp";
	}

	@RequestMapping(value = "getQandAList/{userId}", method = RequestMethod.POST)
	public String getQandAList(@ModelAttribute("search") Search search, QandA qandA, String UserId, Model model, Chat chat,
			@PathVariable String userId, HttpSession httpSession) throws Exception {
		System.out.println("/serviceCenter/getQandAList :POST");

		if (search.getOrder() == 0) {
			search.setOrder(3);
		}
		
		

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setPageSize(pageUnit);
		Map<String, Object> map = serviceCenterService.getQandAList(search, qandA);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")), pageUnit, pageSize);

		model.addAttribute("getQandAList", map.get("getQandAList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(httpSession.getAttribute("user") != null) {
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)httpSession.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)httpSession.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		return "forward:/serviceCenter/getQandAList.jsp";
	}
	//정민이형 요구사항
	@RequestMapping(value = "getUserQandAList/{userId}", method = RequestMethod.POST)
	public String getUserQandAList(@ModelAttribute("search") Search search, QandA qandA, String UserId, Model model,
			@PathVariable String userId, HttpSession httpSession, Chat chat) throws Exception {
		System.out.println("/serviceCenter/getQandAList :POST");

		if (search.getOrder() == 0) {
			search.setOrder(3);
		}
		
		

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setPageSize(pageUnit);
		Map<String, Object> map = serviceCenterService.getQandAList(search, qandA);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")), pageUnit, pageSize);

		model.addAttribute("getQandAList", map.get("getQandAList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(httpSession.getAttribute("user") != null) {
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)httpSession.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)httpSession.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		return "forward:/user/getQandAList.jsp";
	}
	
	//정민이형 요구사항 
	@RequestMapping(value = "getUserQandAList", method = RequestMethod.GET)
	public String getUserQandAList(@ModelAttribute("search") Search search, QandA qandA, Model model, HttpSession session, Chat chat,
			@RequestParam(value = "menu", defaultValue = "search") String menu) throws Exception {

		System.out.println("/serviceCenter/getQandAList : GET ");
		if (search.getOrder() == 0) {
			search.setOrder(2);
		}
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);
		Map<String, Object> map = serviceCenterService.getQandAList(search, qandA);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")), pageUnit, pageSize);

		model.addAttribute("getQandAList", map.get("getQandAList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		return "forward:/user/getQandAList.jsp";
	}
// 여기까지가 QandA 끝 ====================================================================



	@RequestMapping(value = "addReport")
	public String addReport(@ModelAttribute Report report, @RequestParam(value = "sourceNumber") String number,
			User user, Map<String, Object> map, ClubPost clubPost, Comment comment, HttpSession httpSession,
			Model model) throws Exception {

		// number ->> 피드 번호, 댓글번호 etc

		user = (User) httpSession.getAttribute("user");

		if (report.getReportSource() == 1) {
			// 모임 게시물 신고
			clubPost.setUser(user);
			System.out.println("모임 게시물 신고 : " + clubPost);
			map.put("clubPost", clubPost);
			report.setClubPost((ClubPost) clubPostServiceImpl.getClubPost(map).get("clubPost"));
			clubPost.setClubPostNo(Integer.parseInt(number));
			report.setClubPost(clubPost);
			report.setUser2(new User(clubPost.getUserId()));
		} else if (report.getReportSource() == 2) {
			// 모임 게시물 댓글 신고
			comment.setClubPostCommentNo(Integer.parseInt(number));
			report.setClubPostComment(comment);
			report.setUser2(new User(comment.getUserId()));
		} else if (report.getReportSource() == 3) {

			map.put("feedNo", number);
			map.put("user", user);

			report.setFeed((Feed) (feedService.getFeed(map)).get("feed"));

		} else if (report.getReportSource() == 4) {
			report.setFeedComment(feedService.getFeedComment(Integer.parseInt(number)));
		}

		model.addAttribute("reportSource", report.getReportSource());
		model.addAttribute("user02", report.getUser2().getUserId());
		model.addAttribute("report", report);
		model.addAttribute("sourceNumber", number);

		return "forward:/serviceCenter/addReportView.jsp";
	}

	@RequestMapping(value = "updateReport", method = RequestMethod.GET)
	public String updateReport(@ModelAttribute Report report, Model model) throws Exception {

		System.out.println("/ServiceCenter/updateReport : GET");

		report = serviceCenterService.getReport(report.getNo());

		model.addAttribute("report", report);

		return "forward:/serviceCenter/updateReportView.jsp";
	}

	@RequestMapping(value = "updateReport", method = RequestMethod.POST)
	public String updateReport(@ModelAttribute Report report, String number, User user, Map<String, Object> map,
			ClubPost clubPost, Comment comment, HttpSession httpSession, Model model) throws Exception {

		System.out.println("/ServiceCenter/updateReport : POST");

		System.out.println(report + " 처음 들어온 값");
		serviceCenterService.updateReport(report);
		System.out.println(report);
		report = serviceCenterService.getReport(report.getNo());

		model.addAttribute("report", report);

		return "redirect:/serviceCenter/getReportList";

	}

	@RequestMapping(value = "getReport")
	public String getReport(@ModelAttribute Report report, Model model, HttpServletResponse response, Chat chat, HttpSession session) throws Exception {

		System.out.println("/ServiceCenter/getReport : GET & POST");

		report = serviceCenterService.getReport(report.getNo());

		model.addAttribute("report", report);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		String URI = "forward:/serviceCenter/getReport.jsp";

		return URI;
	}

	@RequestMapping(value = "getReportList/{userId}", method = RequestMethod.POST)
	public String getReportList(@ModelAttribute("search") Search search, Report report, Model model, Chat chat, HttpSession session,
			@PathVariable String userId) throws Exception {

		System.out.println("/serviceCenter/getReportList : GET & POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);

		Map<String, Object> map = serviceCenterService.getReportList(search, report, userId);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")), pageUnit, pageSize);

		model.addAttribute("getReportList", map.get("getReportList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)session.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		return "forward:/serviceCenter/getReportList.jsp";
	}

	@RequestMapping(value = "getReportList", method = RequestMethod.GET)
	public String getReportList(@ModelAttribute("search") Search search, Report report, Model model, Chat chat, HttpSession session) throws Exception {

		System.out.println("/serviceCenter/getReportList : GET & POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);

		String userId = "";

		System.out.println(search);
		Map<String, Object> map = serviceCenterService.getReportList(search, report, userId);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")), pageUnit, pageSize);

		model.addAttribute("getReportList", map.get("getReportList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		return "forward:/serviceCenter/getReportList.jsp";
	}
	
	//정민이형 요구사항
	@RequestMapping(value = "getUserReportList/{userId}", method = RequestMethod.POST)
	public String getUserReportList(@ModelAttribute("search") Search search, Report report, Model model, HttpSession httpSession, Chat chat,
			@PathVariable String userId) throws Exception {

		System.out.println("/serviceCenter/getReportList : GET & POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);

		Map<String, Object> map = serviceCenterService.getReportList(search, report, userId);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")), pageUnit, pageSize);

		model.addAttribute("getReportList", map.get("getReportList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		// 1:1 채팅 채팅방번호 가져온다
		chat.setUser((User)httpSession.getAttribute("user"));
		model.addAttribute("getChat", clubPostService.getChat(chat));
		// 모임채팅 roomId 가져온다
		model.addAttribute("roomList", clubPostService.getRoomIdList((User)httpSession.getAttribute("user")));
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		return "forward:/user/getReportList.jsp";
	}
	//정민이형 요구사항
	@RequestMapping(value = "getUserReportList", method = RequestMethod.GET)
	public String getUserReportList(@ModelAttribute("search") Search search, Report report, Model model, Chat chat, HttpSession session) throws Exception {

		System.out.println("/serviceCenter/getReportList : GET & POST");

		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}

		search.setPageSize(pageSize);

		String userId = "";

		System.out.println(search);
		Map<String, Object> map = serviceCenterService.getReportList(search, report, userId);

		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")), pageUnit, pageSize);

		model.addAttribute("getReportList", map.get("getReportList"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		
		
		
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		if(session.getAttribute("user") != null) {
			// 1:1 채팅 채팅방번호 가져온다
			chat.setUser((User)session.getAttribute("user"));
			model.addAttribute("getChat", clubPostService.getChat(chat));
			// 모임채팅 roomId 가져온다
			model.addAttribute("roomList", clubPostService.getRoomIdList((User)session.getAttribute("user")));
		}
		///////////////////////// 채팅에 필요한 코딩 //////////////////////////////////
		
		

		return "forward:/user/getReportList.jsp";
	}
	
}// ServiceCenter 끝
