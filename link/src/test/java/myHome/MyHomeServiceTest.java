/*
 * package myHome;
 * 
 * import java.util.HashMap; import java.util.List; import java.util.Map;
 * 
 * import org.junit.Assert; import org.junit.Test; import
 * org.junit.runner.RunWith; import
 * org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.beans.factory.annotation.Qualifier; import
 * org.springframework.stereotype.Service; import
 * org.springframework.test.context.ContextConfiguration; import
 * org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
 * 
 * import com.link.common.Search; import com.link.service.domain.Feed; import
 * com.link.service.domain.User; import com.link.service.myHome.MyHomeDAO;
 * import com.link.service.myHome.MyHomeService; import
 * com.link.service.user.UserService;
 * 
 * @RunWith(SpringJUnit4ClassRunner.class)
 * 
 * @ContextConfiguration(locations = {"classpath:config/context-*.xml"}) public
 * class MyHomeServiceTest {
 * 
 * @Autowired
 * 
 * @Qualifier("myHomeServiceImpl") private MyHomeService myHomeService;
 * 
 * @Autowired
 * 
 * @Qualifier("userServiceImpl") private UserService userService;
 * 
 * //@Test public void updateMyHomeOpenCondition() throws Exception{
 * 
 * System.out.println("\n[MyHomeServiceImpl updateMyHomeOpenCondition start]\n"
 * );
 * 
 * User user1 = userService.getUser("user01");
 * 
 * System.out.println("변경 전 DATA : "+user1);
 * 
 * User user = new User(); user.setUserId("user01"); user.setOpenCondition("1");
 * 
 * myHomeService.updateMyHomeOpenCondition(user); User user2 =
 * userService.getUser("user01");
 * 
 * System.out.println("insert 결과 : "+user2);
 * 
 * } //@Test public void updateMyHomePushCondition() throws Exception{
 * 
 * System.out.println("\n[MyHomeServiceImpl updateMyHomePushCondition start]\n"
 * );
 * 
 * User user1 = userService.getUser("user01");
 * 
 * System.out.println("변경 전 DATA : "+user1);
 * 
 * User user = new User(); user.setUserId("user01"); user.setPushCondition("1");
 * 
 * myHomeService.updateMyHomePushCondition(user); User user2 =
 * userService.getUser("user01");
 * 
 * System.out.println("insert 결과 : "+user2);
 * 
 * }
 * 
 * 
 * // @Test public void addFollow() throws Exception{
 * 
 * System.out.println("\n[MyHomeServiceImpl addFollow start]\n"); User user1 =
 * userService.getUser("user01"); System.out.println("변경 전 DATA : "+user1);
 * 
 * User user = new User(); user.setUserId("user02");
 * user.setReceiveId("user01"); user.setFbState("1"); user.setFbType("1");
 * 
 * myHomeService.addFollow(user);
 * 
 * 
 * } //@Test public void getFollowList() throws Exception{
 * 
 * System.out.println("\n[MyHomeServiceImpl getFollowList start]\n"); Search
 * search = new Search(); search.setSearchKeyword("user02"); Map<String, Object>
 * map = myHomeService.getFollowList(search); List<User> list=
 * (List<User>)map.get("list"); System.out.println("followList 출력값 "+list);
 * 
 * 
 * }
 * 
 * //@Test public void getFollowerList() throws Exception{
 * 
 * System.out.println("\n[MyHomeServiceImpl getFollowerList start]\n"); Search
 * search = new Search(); search.setSearchKeyword("user01"); Map<String, Object>
 * map = myHomeService.getFollowerList(search); List<User> list=
 * (List<User>)map.get("list"); System.out.println("followerList 출력값 "+list);
 * 
 * }
 * 
 * @Test public void deleteFollow() throws Exception{
 * 
 * System.out.println("\n[MyHomeServiceImpl deleteFollow start]\n"); User user =
 * userService.getUser("user01"); System.out.println("변경전 "+ user);
 * 
 * User userId = new User(); userId.setUserId("user01");
 * userId.setReceiveId("user02");
 * 
 * userId.setFbState("2"); userId.setFbType("1");
 * myHomeService.deleteFollow(userId);
 * 
 * User user1 = userService.getUser("user01");
 * 
 * System.out.println("insert 결과 : "+user1);
 * 
 * 
 * }
 * 
 * }
 */