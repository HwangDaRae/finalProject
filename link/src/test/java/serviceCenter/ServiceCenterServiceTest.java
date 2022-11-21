package serviceCenter;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.link.common.Search;
import com.link.service.domain.ClubPost;
import com.link.service.domain.Comment;
import com.link.service.domain.Feed;
import com.link.service.domain.Notice;
import com.link.service.domain.QandA;
import com.link.service.domain.Report;
import com.link.service.domain.User;
import com.link.service.serviceCenter.ServiceCenterService;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
public class ServiceCenterServiceTest {
	
	@Autowired
	@Qualifier("ServiceCenterServiceImpl")
	private ServiceCenterService serviceCenterService;
	
	public ServiceCenterServiceTest() {
		System.out.println("Default");
	}

	
	//@Test
	public void testAddNotice() throws Exception {
													// 공지 등록

		Notice notice = new Notice();
		User user = new User();

		
		user.setUserId("admin1");
		
		
		notice.setNoticeNo(2);
		notice.setNoticeTitle("공지사항ss");
		notice.setNoticeContent("내용ss");
		notice.setNoticeImage1("abc.jpg");
		notice.setNoticeImage2("cdf.jpg");
		
		notice.setNoticeCount(1);
		notice.setUserId(user);
		notice.setClubNo(0);
		System.out.println(notice);
		serviceCenterService.addNotice(notice);
		Assert.assertEquals(2, notice.getNoticeNo());
		
	}
	
	
	//@Test
	public void testUpdateNotice() throws Exception {
													// 공지사항 수정
		Notice notice = new Notice();
		User user = new User();
		

		user.setUserId("admin1");
		notice.setNoticeNo(2);
		notice.setNoticeContent("바꾼 공지사항");
		notice.setNoticeTitle("바뀐내용ss");
		notice.setNoticeImage1("abc.jpg");
		notice.setNoticeImage2("cdf.jpg");
		
		notice.setNoticeCount(1);
		notice.setUserId(user);
		notice.setClubNo(0);
		

		serviceCenterService.updateNotice(notice);
		Assert.assertEquals(2, notice.getNoticeNo());
		
	}
	
	
	//@Test
	public void testGetNotice() throws Exception {
													// 공지 가져오기
		Notice notice = new Notice();
		User user = new User();
		
		
		user.setUserId("admin1");
		notice.setNoticeNo(1);
		
		Assert.assertEquals(1, notice.getNoticeNo());
	}
	
	//@Test
	public void testGetNoticeList()	throws Exception{
													// 공지 List
		Search search = new Search();
		search.setCurrentPage(0);
		search.setPageSize(1);
		search.setPageUnit(1);
		search.setSearchKeyword("내용");
		
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("search", search);
		
		
		List<Notice> notice = (List<Notice>)map.get("list");
		
		Assert.assertEquals("내용", notice.get(1).getNoticeContent());
		

		
	}
	
	
	//@Test
	public void testDeleteNotice()	throws Exception{
													// delete List
		Notice notice = new Notice();
		notice.setNoticeNo(1);
		System.out.println(notice.getNoticeNo());
		serviceCenterService.deleteNotice(1);
		
		Assert.assertEquals(1, notice.getNoticeNo());
	}
	
	
//=========================================================여기까지가 Notice
	
	//@Test
	public void testAddQandA() throws Exception {
													// QandA 등록

		QandA qandA = new QandA();
		User user = new User();

		
		user.setUserId("admin1");
		
		
		qandA.setQandANo(20);
		qandA.setQandATitle("Qna 제목");
		qandA.setQandAContent("내용ss");
		qandA.setQandAImage1("abc.jpg");
		qandA.setQandAImage2("cdf.jpg");
		

		qandA.setQandACondition(0);
		qandA.setQandAOpenCondition(0);
		qandA.setUserId(user);
		
		System.out.println(qandA);
		serviceCenterService.addQandA(qandA);
		Assert.assertEquals(20, qandA.getQandANo());

		
	}
	
	//@Test
	public void testUpdateQandA() throws Exception {
													// QandA 수정

		QandA qandA = new QandA();
		User user = new User();

		
		user.setUserId("user01");
		
		
		qandA.setQandANo(3);
		qandA.setQandATitle("바뀐바뀐Qna 제목");
		qandA.setQandAContent("바뀐내용ss");
		qandA.setQandAImage1("abc.jpg");
		qandA.setQandAImage2("cdf.jpg");
		
		qandA.setUserId(user);
		qandA.setQandAAnswerContent("바뀐답변입니다");
		qandA.setQandACondition(1);
		
		
		System.out.println(qandA);
		 serviceCenterService.updateQandA(qandA);
		Assert.assertEquals(3, qandA.getQandANo());

	}
	
	//@Test
	public void testGetQandA() throws Exception {
													// QandA 가져오기

		QandA qandA = new QandA();
		
		qandA.setQandANo(2);
		
		System.out.println(qandA);
		 serviceCenterService.getQandA(qandA.getQandANo());
		Assert.assertEquals(2, qandA.getQandANo());

	}
	
	//@Test
	public void testDelteQandA() throws Exception {
													// QandA 가져오기

		QandA qandA = new QandA();
		
		qandA.setQandANo(2);
		
		System.out.println(qandA);
		 serviceCenterService.deleteQandA(qandA.getQandANo());
		Assert.assertEquals(2, qandA.getQandANo());

	}
//===================================================================여기까지가 QandA
	
	//@Test
	public void testAddReport() throws Exception {
													// Report 등록

		Report report = new Report();
		
		User user = new User();
		user.setUserId("admin1");
		User user2 = new User();
		user2.setUserId("user01");
		

		
		 ClubPost clubPost = new ClubPost(); 
		 clubPost.setClubPostNo(10);
		 
	
		 

		
		report.setNo(1);
		report.setTitle("신고합니다");
		report.setContent("신고합니다");
		report.setReportSource(0);
		report.setClubPost(clubPost);
//		report.setClubPostComment(comment);
//		report.setFeed(feed);
//		report.setFeedComment(comment2);
		report.setUser1(user);
		report.setUser2(user2);
		
		report.setReportImage1("abc.jpg");
		report.setReportImage2("넌범죄자.jpg");
		/* report.setHandleDate(null); */
		report.setType(0);
		report.setReportReason(1);
		report.setReportCondition(1);
		
		System.out.println(report);
		
		
		serviceCenterService.addReport(report);
		Assert.assertEquals(1, report.getNo());

		
	}
	
	//@Test
	public void testGetReport() throws Exception{
	
		Report report = new Report();
		
		report.setNo(37);
		System.out.println(report+"여기");
		serviceCenterService.getReport(report.getNo());
		Assert.assertEquals(37, report.getNo());
	}
	
	//@Test
	public void testUpdateReport() throws Exception{
		
		Report report = new Report();
		User user = new User();
		user.setUserId("user02");
		user.setReportCount(2);
		
		
		user.setStopEndDate(null);
		report.setNo(26);
		report.setReportReason(7);
		report.setUser2(user);
		
		serviceCenterService.updateReport(report);
		Assert.assertEquals(26, report.getNo());
	}
	
	//@Test
	public void testDuplicationReport() throws Exception{
		
		Report report = new Report();
		User user = new User();
		report.setNo(45);
		user.setUserId("user01");
		report.setUser2(user);
		User user2 = new User(); 
		
		user2.setUserId("admin1");
		report.setUser1(user2);
		
		System.out.println(report+"데이터 확인용");
		serviceCenterService.getReportDuple(report);
		Assert.assertEquals(45, report.getNo());
		
	}
	
	//@Test
	public void testDuplication2Report() throws Exception{
		
		Report report = new Report();
		report.setNo(47);
		ClubPost clubPost = new ClubPost();
		clubPost.setClubPostNo(10);
		report.setClubPost(clubPost);
		User user = new User();
		user.setUserId("user01");
		report.setUser2(user);
		
		
		System.out.println(report+"데이터 확인요");
		
		Assert.assertEquals(47,report.getNo());
		
	}
	
}
