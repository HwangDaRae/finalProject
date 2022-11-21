package feed;

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

import com.link.common.Search;
import com.link.service.domain.Comment;
import com.link.service.domain.Feed;
import com.link.service.domain.Heart;
import com.link.service.domain.User;
import com.link.service.feed.FeedService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-*.xml" })
public class FeedServiceTest {
	
	@Autowired
	@Qualifier("feedServiceImpl")
	private FeedService feedService;

//	@Test
	public void testAddFeed() throws Exception {
		// 피드 등록

		Feed feed = new Feed();
//		feed.setUserId("user01");
		feed.setOpenCondition(3);
		feed.setContent("hiyo");
		feed.setImage1("a.jpg");
		feed.setImage2("b.jpg");
		feed.setImage3("c.jpg");
		feed.setImage4("d.jpg");
		feed.setVideo("www.naver.com");
		
		feedService.addFeed(feed);

	}
	
//	@Test
	public void testGetFeed() throws Exception {
		// 피드 조회
		
		Heart heart = new Heart();
		heart.setUserId("user01");
		heart.setSource("0");
		heart.setSourceNo(13);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("feedNo", 13);
		map.put("heart", heart);
		
		Feed feed = (Feed) feedService.getFeed(map).get("feed");
		
		Assert.assertEquals(13, feed.getFeedNo());
		Assert.assertEquals(0, map.get("heartCount"));
		Assert.assertEquals(0, map.get("commentCount"));
		
	}
	
//	@Test
	public void testUpdateFeed() throws Exception {
		// 피드 업데이트
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("feedNo", 5);
		
		Feed feed = (Feed) feedService.getFeed(map).get("feed");
		
		Assert.assertEquals(5, feed.getFeedNo());
		
		System.out.println("testUpdateFeed : " + feed);
		
		feed.setContent("정말 첫번째 일까요?");
		
		feedService.updateFeed(feed);
		
		Feed updateFeed = (Feed) feedService.getFeed(map).get("feed");
		
		Assert.assertEquals("정말 첫번째 일까요?", updateFeed.getContent());
	}

//	@Test
	public void testDeleteFeed() throws Exception {
		// 피드 삭제
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("feedNo", 5);
		
		Feed feed = (Feed) feedService.getFeed(map).get("feed");
		
		feedService.deleteFeed(feed.getFeedNo());
	}
	
//	@Test
	public void testGetFeedList() throws Exception {
		// 피드 리스트
		
		Search search = new Search();
		search.setCurrentPage(1);
		search.setPageSize(5);
		search.setPageUnit(5);
		search.setSearchKeyword("정말");
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		map = feedService.getFeedList(map);
		List<Feed> feed = (List<Feed>) map.get("feed");
		
		Assert.assertEquals("정말 첫번째 일까요?", feed.get(0).getContent());
	}
	
//	@Test
	public void testAddFeedComment() throws Exception {
		// 피드 댓글 추가

		User user = new User();
		
		user.setUserId("user01");
		
		Comment comment = new Comment();
		comment.setFeedNo(6);
		comment.setUser(user);
		comment.setCommentContent("test입니다");
		
//		feedService.addFeedComment(comment);
	}
	
//	@Test
	public void testGetFeedComment() throws Exception {
		// 피드 댓글 조회
		
		Comment comment = new Comment();
		
		comment = feedService.getFeedComment(5);
		
		Assert.assertEquals("fifit", comment.getCommentContent());
		
	}
	
//	@Test
	public void testUpdateFeedComment() throws Exception {
		// 피드 댓글 수정
		
		Comment comment = feedService.getFeedComment(5);
		
		comment.setCommentContent("solo");
		
		feedService.updateFeedComment(comment);
		
		comment = feedService.getFeedComment(5);
		
		Assert.assertEquals("solo", comment.getCommentContent());
		
	}
	
//	@Test
	public void testDeleteFeedComment() throws Exception {
		// 피드 댓글 삭제
		
		Comment comment = feedService.getFeedComment(5);
		
//		feedService.deleteFeedComment(comment.getFeedCommentNo());
		
		comment = feedService.getFeedComment(5);
		
		Assert.assertEquals("1", comment.getDeleteCondition().trim());
	}
	
//	@Test
	public void testGetFeedCommentList() throws Exception {
		// 피드 댓글 리스트
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("feedNo", 5);
		
		Map<String, Object> returnMap = feedService.getFeedCommentList(map);
		
		Assert.assertEquals("change", ((List<Comment>) returnMap.get("comment")).get(0).getCommentContent());
		Assert.assertEquals(30, returnMap.get("totalFeedCommentCount"));
	}
	
	@Test
	public void testAddFeedHeart() throws Exception {
		// 피드 좋아요 추가
		
		Heart heart = new Heart();
		heart.setUserId("user01");
		heart.setSource("0");
		heart.setSourceNo(5);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		Feed feed = new Feed();
		feed.setFeedNo(5);
		
		map.put("heart", heart);
		map.put("feed", feed);		
		
		feedService.addFeedHeart(map);
		
	}
	
//	@Test
	public void testDeleteFeedHeart() throws Exception {
		// 피드 좋아요 취소
		
		Heart heart = new Heart();
		heart.setUserId("user01");
		heart.setSource("0");
		heart.setSourceNo(5);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("heart", heart);
		
		feedService.deleteFeedHeart(map);
	}
	
}
