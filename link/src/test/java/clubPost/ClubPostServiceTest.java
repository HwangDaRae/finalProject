package clubPost;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.link.common.Search;
import com.link.service.clubPost.ClubPostService;
import com.link.service.domain.ClubPost;
import com.link.service.domain.Comment;
import com.link.service.domain.Heart;
import com.link.service.domain.Notice;
import com.link.service.domain.Pay;
import com.link.service.domain.Report;
import com.link.service.domain.User;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
public class ClubPostServiceTest {
	
	@Autowired
	@Qualifier("clubPostServiceImpl")
	private ClubPostService clubPostServiceImpl;

	//@Test
	public void addClubPostComment() throws Exception {
		// 모임게시물 댓글 등록

		Comment comment = new Comment();
		comment.setClubPostNo(20);
		comment.setClubPostCommentNo(15);
		User user = new User();
		user.setUserId("user03");
		comment.setUser(user);
		comment.setCommentContent("댓글내용 들어간다");
		comment.setParent(5);
		comment.setDepth(2);
		comment.setCommentCount(2);
		
		comment = clubPostServiceImpl.addClubPostComment(comment);
		
		System.out.println("///////////////////////////////////////////////////////////////");
		System.out.println(comment);
	}

	//@Test
	public void getClubPostComment() throws Exception {
		// 모임게시물 댓글 상세보기

		Comment comment = new Comment();
		comment.setClubPostCommentNo(9);
		
		comment = clubPostServiceImpl.getClubPostComment(comment);
		System.out.println(comment);
	}
	
	//@Test
	public void updateClubPostComment() throws Exception {
		// 모임 게시물 댓글 수정
		
		Comment comment = new Comment();
		comment.setClubPostCommentNo(34);
		comment.setHeartCondition(1);
		//comment.setCommentContent("1");
		//comment.setCommentUpdateDate("22/10/04");
		
		Heart heart = new Heart();
		heart.setSource("3");
		heart.setSourceNo(34);
		heart.setUserId("user01");
		
		clubPostServiceImpl.updateClubPostComment(comment, heart);
	}
	
	//@Test
	public void deleteClubPostComment() throws Exception {
		// 모임 게시물 댓글 삭제
		
		Comment comment = new Comment();
		comment.setClubPostCommentNo(15);
		
		clubPostServiceImpl.deleteClubPostComment(comment);
	}
	
	//@Test
	public void addClubNotice() throws Exception {
		// 모임 공지사항 등록
		Search search = new Search();
		Notice notice = new Notice();
		notice.setNoticeTitle("title");
		notice.setNoticeContent("content");
		notice.setClubNo(2);
		notice.setNoticeCount(0);
		User user = new User();
		user.setUserId("user03");
		notice.setUserId(user);
		
		clubPostServiceImpl.addClubNotice(search, notice);
	}
	
	//@Test
	public void getClubNotice() throws Exception {
		// 모임 공지사항 수정
		Notice notice = new Notice();
		notice.setNoticeNo(6);
		
		clubPostServiceImpl.getClubNotice(notice);
	}
	
	//@Test
	public void getClubNoticeList() throws Exception {
		// 모임 공지사항 수정
		Search search = new Search();
		Notice notice = new Notice();
		notice.setNoticeNo(6);
		String userId = "user02";
		
		clubPostServiceImpl.getClubNoticeList(search, notice, userId);
	}
	
	//@Test
	public void updateClubNotice() throws Exception {
		// 모임 공지사항 수정
		Search search = new Search();
		Notice notice = new Notice();
		notice.setNoticeTitle("title");
		notice.setNoticeContent("content");
		
		clubPostServiceImpl.updateClubNotice(search, notice);
	}
	
	//@Test
	public void deleteClubNotice() throws Exception {
		// 모임 공지사항 삭제
		Search search = new Search();
		Notice notice = new Notice();
		notice.setClubNo(2);
		
		clubPostServiceImpl.deleteClubNotice(search, notice);
	}
	
	//@Test
	public void updateClubMember() throws Exception {
		// 모임원 추가
		Search search = new Search();
		Pay pay = new Pay();
		User user = new User();
		user.setUserId("user03");
		pay.setUser(user);
		pay.setClubNo(2);
		pay.setPayOption("0");
		pay.setPayProduct("1");
		pay.setTotalPrice(10000);
		pay.setUpdateClubMemberCount(20);
		pay.setMerchant_uid("111");
		
		//clubPostServiceImpl.updateClubMember(pay, search);
		clubPostServiceImpl.addPay(pay);
	}
	
	//@Test
	public void updateClub() throws Exception {
		// 모임 추가
		Search search = new Search();
		Pay pay = new Pay();
		User user = new User();
		user.setUserId("user03");
		pay.setUser(user);
		pay.setClubNo(2);
		pay.setPayOption("0");
		pay.setPayProduct("1");
		pay.setTotalPrice(10000);
		pay.setUpdateClubCount(2);
		pay.setMerchant_uid("111");
		
		//clubPostServiceImpl.updateClub(pay);
		clubPostServiceImpl.addPay(pay);
	}
	
	//@Test
	public void clubNotice() throws Exception {
		// 공지사항
		Search search = new Search();
		search.setCurrentPage(3);
		search.setPageSize(10);
		search.setPageUnit(10);
		search.setOrder(0);					// 0 : 최신순, 1 : 역최신순
		Notice notice = new Notice();
		//notice.setNoticeNo(5);
		notice.setClubNo(2);
		//notice.setNoticeImage1("1");
		//notice.setNoticeImage2("2");
		//notice.setNoticeTitle("title65");
		//notice.setNoticeContent("content65");
		//notice.setNoticeCount(0);
		String userId = "user02";
		
		//clubPostServiceImpl.addClubNotice(search, notice);
		//notice = clubPostServiceImpl.getClubNotice(notice);
		Map<String, Object> map = clubPostServiceImpl.getClubNoticeList(search, notice, userId);
		//clubPostServiceImpl.updateClubNotice(search, notice);
		//clubPostServiceImpl.deleteClubNotice(search, notice);
		
		//System.out.println(notice);
		//System.out.println(map.get("getClubNoticeListCount"));
		System.out.println("///////////////////////////////////////////////////////////////////////");
		System.out.println(map.get("getClubNoticeList"));
		//System.out.println(map.get("getClubNotice"));
		
	}
	
	//@Test
	public void clubPost() throws Exception {
		// 모임게시물		
		ClubPost clubPost = new ClubPost();
		clubPost.setClubPostNo(64);
		User user = new User();
		user.setUserId("user03");
		clubPost.setUser(user);
		clubPost.setHeartCondition(1);
		//clubPost.setHeartCondition(1);
		//clubPost.setClubPostCommentNo(3);
		//clubPost.setClubPostTitle("title");
		//clubPost.setClubPostContent("content");
		clubPost.setClubNo(2);
		//clubPost.setImage1("image01");
		
		Heart heart = new Heart();
		heart.setSource("2");
		heart.setSourceNo(63);
		heart.setUserId("user02");
		
		//clubPostServiceImpl.updateClubPostLike(clubPost, heart);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("clubPost", clubPost);
		map.put("heart", heart);
		clubPostServiceImpl.updateClubPost(map);
		
		//clubPostServiceImpl.addClubPost(clubPost);
	}
	
	//@Test
	public void clubPostList() throws Exception {
		// 모임 게시물 리스트
		Search search = new Search();
		search.setCurrentPage(2);
		search.setPageSize(10);
		search.setOrder(0);					// 0 : 최신순, 1 : 역최신순, 2 : 좋아요 많은순, 3 : 내가 작성한 게시물
		
		ClubPost clubPost = new ClubPost();
		clubPost.setClubNo(2);
		User user = new User();
		user.setUserId("user02");
		clubPost.setUser(user);
		
		// 모임게시물 탭 클릭시 => 최근 가입한 모임의 모임게시물리스트 가져온다
		// search.order = 0, user_id = 'user03'
		// 모임게시물에서 최신순 클릭시 => 최신순 모임게시물 리스트
		// search.order = 0, user_id = 'user03', club_no = 10
		// 모임리스트에서 좋아요많은순 클릭시 => 좋아요 많은순 모임게시물 리스트
		// search.order = 2, user_id = 'user03', club_no = 10
		// 내가 작성한 모임게시물 리스트
		// search.order = 3, user_id = 'user03', club_no = 10
		
		Map<String, Object> map = clubPostServiceImpl.getClubPostList(search, clubPost);
		System.out.println("///////////////////////////////////////////");
		System.out.println(map.get("clubPostListCount"));
		System.out.println("///////////////////////////////////////////");
		List<ClubPost> list = (List<ClubPost>)map.get("clubPostList");
		for (ClubPost c : list) {
			System.out.println("======== " + c);
		}
		System.out.println("///////////////////////////////////////////");
	}
	
	//@Test
	public void pay() throws Exception {
		Pay pay = new Pay();
		pay.setPayNo(21);
		User user = new User();
		user.setUserId("user02");
		
		//clubPostServiceImpl.getPay(pay);
		clubPostServiceImpl.getPayList(user);
	}
	
	@Test
	public void Date() throws Exception {
		String from = "2019-09-02 08:10:55";
		SimpleDateFormat transFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date to = transFormat.parse(from);		
		System.out.println("//////////////////////////////" + to);		
		String day = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(to);
		System.out.println(day);
	}
	
	
	
}


