상혁님
select * from users;

//모임등록
addClub()
INSERT INTO club (club_no, user_id, club_title, club_detail, club_reg_date, current_member, club_max_member, club_category, club_area, club_image)
VALUES (seq_club_no.nextval, 'user01', 'testClub', 'testDetail', sysdate, 1, 10, '봉사활동', '서울시 강남구', 'b.jpg');

//모임가입신청
addApprovalCondition()
INSERT INTO club_user (club_user_no, user_id, club_no, application_reg_date, join_reg_date, member_role, approval_condition, join_greeting)
VALUES (seq_club_user_no.nextval, 'user03',3, sysdate, null, null, null, '안녕하세요 테스트 가입인사입니다44');

//모임일정등록
addMeeting()
INSERT INTO meeting (meeting_no, club_no, add_meeting_user_id, meeting_title, meeting_content, meeting_date, meeting_place, meeting_time, meeting_weather, meeting_reg_date, meeting_member, meeting_maximum_member)
VALUES (seq_meeting_no.nextval, 2, 'user01', '테스트일정제목', '테스트일정내용', '테스트일정날짜', '테스트일정장소', '테스트일정시간', '테스트날씨', sysdate, 1, 10);
INSERT INTO meeting (meeting_no, club_no, add_meeting_user_id, meeting_title, meeting_content, meeting_date, meeting_place, meeting_time, meeting_weather, meeting_reg_date, meeting_member, meeting_maximum_member)
VALUES (seq_meeting_no.nextval, 2, 'user02', '테스트일정제목', '테스트일정내용', '테스트일정날짜', '테스트일정장소2', '테스트일정시간2', '테스트날씨2', sysdate, 1, 10);


//모임일정 참여1
addMeetingMember()
INSERT INTO participant (participant_no, meeting_no, participant_user_id)
VALUES (seq_participant_no.nextval, 2, 'user01');

//모임일정 참여2
addMeetingMember()
INSERT INTO participant (participant_no, meeting_no, participant_user_id)
VALUES (seq_participant_no.nextval, 2, 'user03');


//간단 select 문
//모임
select * from club;
//모임원
select * from club_user;
//모임일정
select * from meeting;
//모임일정참여자
일정 참여자 
select * from PARTICIPANT;

//모임 상세보기
getClub()
select 
		club_no, user_id, club_title, club_detail, club_reg_date, current_member, club_max_member, club_category, club_area, club_image
FROM club
WHERE club_no = 2;

//모임 수정
updateclub()
UPDATE club
	SET
	club_title = '모임이름수정 테스트' ,
	club_detail = '모임설명수정 테스트' ,
	club_category = '카테고리수정' ,
	club_area = '모임활동영역수정 테스트' ,
	club_image = '모임이미지 수정 테스트'
	WHERE club_no = 3;

//모임 삭제
deleteClub()
DELETE FROM club
WHERE club_no=10;


//모임리스트
getClubList()
SELECT 
	club_no, user_id, club_title, club_detail, club_reg_date, club_image, current_member, club_max_member, club_category, club_area
	FROM club
	ORDER BY club_no ASC;

	
//내가 가입한 모임리스트
SELECT
	club_user_no, club_no, user_id, application_reg_date, join_reg_date, logout_date, member_role, approval_condition, join_greeting
	FROM club_user
	WHERE user_id = 'user02';
	

//전체모임 수
getTotalClubCount()
SELECT
		COUNT(*)
		FROM (
				SELECT
				*
				FROM club		)
				
				

//모임원 리스트
getClubMemberList()
SELECT 
	club_user_no, user_id, club_no, application_reg_date, join_reg_date, logout_date, member_role, approval_condition, join_greeting
	FROM club_user
	WHERE club_no = 2;
	

//모임일정 리스트
getMeetingList()
SELECT
	meeting_no, club_no, meeting_title, meeting_date, meeting_time, meeting_place, meeting_weather, meeting_member, meeting_maximum_member
	FROM meeting
	WHERE club_no=2;

//모임일정 참여자 리스트(조인해야함)
getMeetingmemberList()
SELECT
	participant_no, meeting_no, participant_user_id
	FROM participant
	WHERE meeting_no = 2;

//모임일정 상세보기
getMeeting()
SELECT
	meeting_no ,
	club_no ,
	add_meeting_user_id ,
	meeting_title ,
	meeting_content ,
	meeting_date ,
	meeting_place ,
	meeting_time ,
	meeting_weather ,
	meeting_member ,
	meeting_maximum_Member
	FROM meeting
	WHERE meeting_no = 2;
	

//모임일정 수정
updateMeeting()
UPDATE meeting
	SET
		meeting_title = '모임일정제목수정test' ,
		meeting_content = '모임일정내용수정test' ,
		meeting_date = '모임일정날짜수정 test' ,
		meeting_place = '모임일정장소수정 test' ,
		meeting_time = '모임일정시간수정 test',
		meeting_maximum_member = '20'
		WHERE meeting_no = 24;

//모임일정 참여신청 취소
deleteMeetingMember()
DELETE FROM participant WHERE participant_no = 2;

//모임일정 삭제
deleteMeeting()
DELETE FROM meeting WHERE meeting_no = 6;

//모임원 직책 수정
updateMemberRole()
UPDATE club_user
	SET member_role = 1
	WHERE club_user_no = 12;


//모임원 추방
deleteClubMember()
DELETE FROM club_user WHERE club_user_no = 13;


//가입신청현황 삭제
deleteApprovalCondition()
update club_user
	SET approval_condition = 0
	WHERE club_user_no = 2;

	
//가입승인 및 거절
updateApprovalCondition()
UPDATE club_user
	SET approval_condition = 1
	WHERE club_user_no = 12;






//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



다래

// null값일 때  ${IMAGE:VARCHAR2} 붙이자
addClubPost()
INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_UPDATE_DATE, CLUB_POST_LIKE_COUNT, CLUB_POST_COMMENT_COUNT, REPORT_CONDITION,
DELETE_CONDITION, IMAGE1, IMAGE2, IMAGE3, IMAGE4, IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10)
VALUES (seq_club_post_no.NEXTVAL, 7, 'user02', 'clubposttitle1',
null, null, null, null, sysdate, null, 0, 0, 0, 0, 'a.jpg', null, null, null, null, null, null, null, null, null)



//모임원 전체에게 알림
addPush()
INSERT INTO REPORT_PUSH (NO, TITLE, CONTENT, REPORT_SOURCE, CLUB_POST_NO, USER_ID1, USER_ID2, REPORT_REGDATE, 
TYPE) VALUES (seq_REPORT_PUSH_NO.NEXTVAL, 'title', 'content', '1', seq_club_post_no.CURRVAL,
'user02', 'user03', sysdate, '2')



getClubPost() - 모임게시물 상세보기 가져오기
SELECT CLUB_POST_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, CLUB_POST_VIDEO3,
CLUB_POST_REG_DATE, CLUB_POST_UPDATE_DATE, CLUB_POST_LIKE_COUNT, CLUB_POST_COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION,
IMAGE1, IMAGE2, IMAGE3, IMAGE4, IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10 FROM CLUB_POST
WHERE REPORT_CONDITION = 0 AND DELETE_CONDITION = 0 AND CLUB_POST_NO = 20



getClubPost() - getClubPostCommentList - 모임게시물 댓글리스트 가져오기
SELECT CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_LIKE_COUNT,
COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE
FROM CLUB_POST_COMMENT
WHERE CLUB_POST_NO = 20
ORDER BY COMMENT_REG_DATE ASC



SELECT V3.*
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY CLUB_POST_NO DESC) AS R, V2.*
		FROM (
					SELECT CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_HEART_COUNT,
					COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE
					FROM CLUB_POST_COMMENT
					WHERE CLUB_POST_NO = 20
					ORDER BY COMMENT_REG_DATE ASC
			 ) V2
	 ) V3
WHERE R BETWEEN 11 AND 20






SELF OUTER JOIN()
SELECT *
FROM CLUB_POST_COMMENT C1 LEFT OUTER JOIN CLUB_POST_COMMENT C2
ON C1.CLUB_POST_COMMENT_NO = C2.PARENT
WHERE C1.CLUB_POST_NO = 20
ORDER BY C1.COMMENT_REG_DATE ASC, C2.SEQUENCE ASC;
GROUP BY C1.CLUB_POST







getClubPostList() - 가장 최근 가입한 모임
SELECT *
FROM CLUB_USER
WHERE USER_ID = 'user03' AND JOIN_REG_DATE IS NOT NULL
ORDER BY JOIN_REG_DATE DESC



getClubPostList() - 가장 최근 가입한 모임번호
SELECT V2.CLUB_NO
FROM ( SELECT ROWNUM, V1.*
		FROM ( SELECT *
				FROM CLUB_USER
				WHERE USER_ID = 'user03' AND JOIN_REG_DATE IS NOT NULL
				ORDER BY JOIN_REG_DATE DESC ) V1
		WHERE ROWNUM = 1
	 ) V2



getClubPostList() - 가장 최근 가입한 모임의 삭제 또는 신고승인 된 게시물 빼고 최신순 모임게시물 리스트
SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
FROM CLUB_POST
WHERE CLUB_NO = ( SELECT V2.CLUB_NO
					FROM ( SELECT ROWNUM, V1.*
							FROM ( SELECT *
									FROM CLUB_USER
									WHERE USER_ID = 'user03' AND JOIN_REG_DATE IS NOT NULL
									ORDER BY JOIN_REG_DATE DESC ) V1
							WHERE ROWNUM = 1
						 ) V2
				 ) AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'
ORDER BY CLUB_POST_REG_DATE DESC



getClubPostList() - 가장 최근 가입한 모임의 삭제 또는 신고승인 된 게시물 빼고 최신순 모임게시물 리스트
SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
FROM CLUB_POST
WHERE CLUB_NO = ( SELECT V2.CLUB_NO
					FROM ( SELECT ROWNUM, V1.*
							FROM ( SELECT *
									FROM CLUB_USER
									WHERE USER_ID = 'user03' AND JOIN_REG_DATE IS NOT NULL
									ORDER BY JOIN_REG_DATE DESC ) V1
							WHERE ROWNUM = 1
						 ) V2
				 ) AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'
ORDER BY CLUB_POST_REG_DATE DESC



getClubPostList() - 특정 모임의 최신순
SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
FROM CLUB_POST
WHERE CLUB_NO = 10 AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'
ORDER BY CLUB_POST_REG_DATE DESC 



getClubPostList() - 특정 모임의 오래된순
SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
FROM CLUB_POST
WHERE CLUB_NO = 10 AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'
ORDER BY CLUB_POST_REG_DATE ASC



getClubPostList() - 특정 모임의 좋아요 많은순
SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
FROM CLUB_POST
WHERE CLUB_NO = 10 AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'
ORDER BY CLUB_POST_HEART_COUNT DESC, CLUB_POST_REG_DATE DESC 



getClubPostList() - 특정 모임의 내가 작성한 게시물
SELECT CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
FROM CLUB_POST
WHERE CLUB_NO = 10 AND USER_ID = 'user02' AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'
ORDER BY CLUB_POST_REG_DATE DESC 



getClubPostList() - 페이징
SELECT V3.*
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY CLUB_POST_NO DESC) AS R, V2.*
		FROM ( 		
				SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
		FROM CLUB_POST
		WHERE CLUB_NO = 2
		AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'
		ORDER BY CLUB_POST_REG_DATE DESC		
			) V2
		) V3
WHERE R BETWEEN 21 AND 30



getClubPostList() - 좋아요 테이블과 조인
SELECT *
FROM CLUB_POST
WHERE CLUB_NO = 2
ORDER BY CLUB_POST_NO DESC



SELECT *
FROM HEART
ORDER BY HEART_NO DESC



SELECT CP.CLUB_POST_NO, CP.CLUB_POST_TITLE, CP.CLUB_NO, H.USER_ID AS H_USER_ID, CP.USER_ID AS CP_USER_ID, CP.IMAGE1, CP.CLUB_POST_HEART_COUNT, CP.CLUB_POST_REG_DATE
FROM CLUB_POST CP, HEART H
WHERE CP.CLUB_POST_NO = H.SOURCE_NO AND CP.CLUB_NO = 2



SELECT H.SOURCE_NO
FROM CLUB_POST CP, HEART H
WHERE CP.CLUB_POST_NO = H.SOURCE_NO AND CP.CLUB_NO = 2
GROUP BY H.SOURCE_NO



SELECT CP.CLUB_POST_NO AS CLUB_POST_NO, CP.CLUB_POST_TITLE AS CLUB_POST_TITLE, CP.CLUB_NO AS CLUB_NO, H.USER_ID AS H_USER_ID, CP.USER_ID AS CP_USER_ID, CP.IMAGE1, CP.CLUB_POST_HEART_COUNT, CP.CLUB_POST_REG_DATE
FROM CLUB_POST CP, HEART H
WHERE CP.CLUB_POST_NO = H.SOURCE_NO AND CP.CLUB_NO = 2
GROUP BY CP.CLUB_POST_NO, CP.CLUB_POST_TITLE, CP.CLUB_NO, H.USER_ID, CP.USER_ID, CP.IMAGE1, CP.CLUB_POST_HEART_COUNT, CP.CLUB_POST_REG_DATE
ORDER BY CP.CLUB_POST_NO DESC













getClubPostListMyHome()
SELECT CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_LIKE_COUNT
FROM CLUB_POST
WHERE USER_ID = 'user02' AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'
ORDER BY CLUB_POST_REG_DATE DESC


getClubPostListMyHomeCount()
SELECT COUNT(*) FROM CLUB_POST WHERE USER_ID = 'user02' AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'









// null값일 때  ${IMAGE:VARCHAR2} 붙이자
updateClubPost() - 모임게시물 수정할 떄
UPDATE CLUB_POST SET CLUB_POST_TITLE = 'updateTitle', CLUB_POST_CONTENT = 'updateContent', CLUB_POST_VIDEO1 = '1', CLUB_POST_VIDEO2 = '2',
CLUB_POST_VIDEO3 = '3', IMAGE1 = '1', IMAGE2 = '2', IMAGE3 = '3', IMAGE4 = '4', IMAGE5 = '5', IMAGE6 = '6', IMAGE7 = '7', IMAGE8 = '8',
IMAGE9 = '9', IMAGE10 = '10'
WHERE CLUB_POST_NO = 20



deleteClubPost()
UPDATE CLUB_POST SET DELETE_CONDITION = '1' WHERE CLUB_POST_NO = 20



updateClubPostLike()
UPDATE CLUB_POST SET CLUB_POST_LIKE_COUNT = CLUB_POST_LIKE_COUNT + 1 WHERE CLUB_POST_NO = 20



INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO)
VALUES( seq_heart_no.NEXTVAL, 'user03', '2', 20)











///////////////////////////////////////////////////////////////////////////////////// 모임게시물 댓글 /////////////////////////////////////////////////////////////////////////////////////



club_post_comment_no가 없다면 즉, 모임게시물의 댓글이라면? parent 0, depth 0, sequence는 parent의 번호가 같은것 중 sequence의 값이 가장 큰 것 +1
addClubPostComment()
INSERT INTO CLUB_POST_COMMENT (CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE,
COMMENT_LIKE_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE, COMMENT_COUNT)
VALUES (seq_club_post_comment_no.NEXTVAL,
10,
'user02',
'댓글내용이다',
sysdate, null, 0, '0', '0', 4, 1, 0, 0)



// 작성자에게 알림
addPush()
INSERT INTO REPORT_PUSH (NO, TITLE, CONTENT, REPORT_SOURCE, CLUB_POST_COMMENT_NO, USER_ID1, USER_ID2, REPORT_REGDATE, TYPE)
VALUES (seq_club_post_comment_no, 'titleComment', 'contentComment', '2', seq_club_post_no.currval, 'user03', 'user02')



getCurrval()
SELECT ROWNUM, seq_club_post_no.currval FROM CLUB_POST WHERE ROWNUM = 1



getClubPostCommentNo()
SELECT V1.CLUB_POST_COMMENT_NO FROM ( SELECT * FROM CLUB_POST_COMMENT ORDER BY COMMENT_REG_DATE DESC ) V1
WHERE ROWNUM = 1



getClubPostComment()
SELECT * FROM CLUB_POST_COMMENT WHERE CLUB_POST_COMMENT_NO = 9;



updateClubPostComment()
UPDATE CLUB_POST_COMMENT SET COMMENT_CONTENT = '댓글내용99' WHERE CLUB_POST_COMMENT_NO = 9



updateClubPostCommentLike()
UPDATE CLUB_POST_COMMENT SET COMMENT_LIKE_COUNT = COMMENT_LIKE_COUNT + 1 WHERE CLUB_POST_COMMENT_NO = 1



deleteClubPostComment()
UPDATE CLUB_POST_COMMENT SET DELETE_CONDITION = '1' WHERE CLUB_POST_COMMENT_NO = 1












///////////////////////////////////////////////////////////////////////////////////// 모임공지사항 /////////////////////////////////////////////////////////////////////////////////////



가장 최근 가입한 모임번호
SELECT V1.CLUB_NO
FROM 
( SELECT *
FROM CLUB
WHERE USER_ID = 'user01'
ORDER BY CLUB_REG_DATE DESC )V1
WHERE ROWNUM = 1



getClubNoticeList() - 가장 최근 가입한 모임의 리스트
SELECT V2.*
FROM ( SELECT *
		FROM NOTICE
		WHERE CLUB_NO = ( SELECT V1.CLUB_NO
							FROM ( SELECT *
									FROM CLUB
									WHERE USER_ID = 'user01'
									ORDER BY CLUB_REG_DATE DESC
								  )V1
							WHERE ROWNUM = 1
						 )
		ORDER BY NOTICE_REGDATE ASC
	 ) V2
WHERE ROWNUM BETWEEN 1 AND 10



getClubNoticeList() - 특정 모임의 리스트
SELECT V2.*
FROM ( SELECT *
		FROM NOTICE
		WHERE CLUB_NO = 2
		ORDER BY NOTICE_REGDATE ASC
	 ) V2
WHERE ROWNUM BETWEEN 1 AND 10



SELECT V3.*
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY NOTICE_NO DESC) AS R, V2.*
		FROM ( SELECT *
				FROM NOTICE
				WHERE CLUB_NO = 2
				ORDER BY NOTICE_REGDATE DESC
			 ) V2
	) V3
WHERE R BETWEEN 21 AND 30


















addClubNotice()
INSERT INTO NOTICE( NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_IMAGE1, NOTICE_IMAGE2, NOTICE_REGDATE, NOTICE_COUNT, CLUB_NO, USER_ID)
VALUES ( seq_notice_no.nextval, 'clubTitle', 'clubContent', null, null, SYSDATE, 0, 2, 'user03' )



getClubNoticetNo()
SELECT V1.NOTICE_NO
FROM ( SELECT *
		FROM NOTICE
		WHERE CLUB_NO = 2
		ORDER BY NOTICE_REGDATE DESC ) V1
WHERE ROWNUM = 1



updateClubNotice()
UPDATE NOTICE SET NOTICE_TITLE = '1', NOTICE_CONTENT = '2' WHERE NOTICE_NO = 6



deleteClubNotice()
DELETE FROM NOTICE WHERE NOTICE_NO = 6



getClubNotice()
SELECT * FROM NOTICE WHERE NOTICE_NO = 6



getClubNoticeList()
SELECT *
FROM NOTICE
WHERE CLUB_NO = 2
ORDER BY NOTICE_REGDATE DESC








///////////////////////////////////////////////////////////////////////////////////// 결제 /////////////////////////////////////////////////////////////////////////////////////



addPay()
INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT, UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (seq_pay_no.NEXTVAL, 'user03', 2, '1', '0', 10000, SYSDATE, 0, 20, '111')



updateClubMember() - 모임원 최대 수 증가
UPDATE CLUB SET CLUB_MAX_MEMBER = CLUB_MAX_MEMBER + 10 WHERE CLUB_NO = 2



updateClub() - 모임 최대 수 증가
UPDATE USERS SET JOIN_CLUB_LIMIT = JOIN_CLUB_LIMIT + 2 WHERE USER_ID = 'user03'







INSERT INTO REPORT_PUSH (NO, CONTENT, USER_ID2, REPORT_REGDATE, TYPE) VALUES (seq_REPORT_PUSH_NO.NEXTVAL, 'OOO님이 회원님의 게시물에 댓글을 남겼습니다', 'user02', sysdate, 2)
INSERT INTO REPORT_PUSH  ( NO, TITLE, CONTENT, REPORT_SOURCE, CLUB_POST_NO, CLUB_POST_COMMENT_NO, FEED_NO, FEED_COMMENT_NO,  USER_ID1,  USER_ID2, REPORT_REGDATE, REPORT_IMAGE1, REPORT_IMAGE2, TYPE, REPORT_REASON, REPORT_CONDITION)   VALUES (seq_report_push_no.nextval,     ?,     ?,     ?,     ?,     ?,     ?,     ?,      ?,     ?,     SYSDATE,     ?,     ?,      ?,     ?,        ? )


		SELECT
			club_user_no ,
			user_id ,
			club_no ,
			application_reg_date ,
			join_reg_date ,
			logout_date ,
			member_role ,
			approval_condition ,
			join_greeting 
		FROM club_user
		WHERE club_no = '1'


		
		
		
		
		
		
		
		
		
		
SELECT COUNT(*) FROM CLUB_POST WHERE CLUB_NO = 2 AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0' ORDER BY CLUB_POST_REG_DATE DESC
		
SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
FROM CLUB_POST
WHERE CLUB_NO = 2 AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'
ORDER BY CLUB_POST_REG_DATE DESC










INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO) VALUES (SEQ_HEART_NO.NEXTVAL, 'user01', 2, 64);
INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO) VALUES (SEQ_HEART_NO.NEXTVAL, 'user02', 2, 64);
INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO) VALUES (SEQ_HEART_NO.NEXTVAL, 'user01', 2, 63);
UPDATE CLUB_POST SET CLUB_POST_HEART_COUNT = CLUB_POST_HEART_COUNT + 1 WHERE CLUB_POST_NO = 64;
UPDATE CLUB_POST SET CLUB_POST_HEART_COUNT = CLUB_POST_HEART_COUNT + 1 WHERE CLUB_POST_NO = 64;
UPDATE CLUB_POST SET CLUB_POST_HEART_COUNT = CLUB_POST_HEART_COUNT + 1 WHERE CLUB_POST_NO = 63;



SELECT V3.*
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY CLUB_POST_NO DESC) AS R, V2.*
		FROM (
				SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
				FROM CLUB_POST
				WHERE CLUB_NO = 
				<choose>
					<when test="clubPost.clubNo != null and clubPost.clubNo != '' and clubPost.clubNo != 0">#{ clubPost.clubNo }</when>
					<when test="clubPost.clubNo != null and clubPost.clubNo != '' and clubPost.clubNo != 0 and search.order == 3">#{ clubPost.clubNo } AND USER_ID = #{ clubPost.user.userId }</when>
				<otherwise>
					( SELECT V2.CLUB_NO
						FROM ( SELECT ROWNUM, V1.*
								FROM ( SELECT *
										FROM CLUB_USER
										WHERE USER_ID = #{ clubPost.user.userId } AND JOIN_REG_DATE IS NOT NULL
										ORDER BY JOIN_REG_DATE DESC ) V1
								WHERE ROWNUM = 1 ) V2 )
				</otherwise>
				</choose>
				AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'
				ORDER BY
				<choose>
					<when test="search.order == 2">CLUB_POST_HEART_COUNT DESC, CLUB_POST_REG_DATE DESC</when>
					<when test="search.order == 1">CLUB_POST_REG_DATE DESC</when>
				<otherwise>
					CLUB_POST_REG_DATE DESC
				</otherwise>
				</choose>		
			 ) V2
	 ) V3
WHERE R BETWEEN ((#{ search.currentPage }-1)*#{ search.pageSize }+1) AND #{ search.currentPage }*#{ search.pageSize }
				
				
				
				
				
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				


명훈님

DROP TABLE FEED 					CASCADE CONSTRAINTS;
DROP TABLE FEED_COMMENT				CASCADE CONSTRAINTS;
DROP TABLE HEART					CASCADE CONSTRAINTS;

DROP SEQUENCE seq_feed_no;
DROP SEQUENCE seq_feed_comment_no;
DROP SEQUENCE seq_heart_no;

CREATE SEQUENCE seq_feed_no						INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_feed_comment_no				INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_heart_no					INCREMENT BY 1 START WITH 1;

CREATE TABLE FEED (
	feed_no							NUMBER												NOT NULL,
	user_id							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	feed_open_condition				CHAR(3)												NOT NULL,
	feed_content					VARCHAR2(840),
	feed_image1						VARCHAR2(100),
	feed_image2						VARCHAR2(100),
	feed_image3						VARCHAR2(100),
	feed_image4						VARCHAR2(100),
	feed_video						VARCHAR2(100),
	hashtag							VARCHAR2(840),
	feed_heart_count				NUMBER												NOT NULL,
	feed_comment_count				NUMBER												NOT NULL,
	feed_reg_date					DATE												NOT NULL,
	feed_update_date				DATE,
	report_condition				CHAR(3)												NOT NULL,
	delete_condition				CHAR(3)												NOT NULL,
	PRIMARY KEY(feed_no)
);

CREATE TABLE feed_comment (
	feed_comment_no					NUMBER												NOT NULL,
	feed_no							NUMBER												NOT NULL,
	user_id							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	feed_comment_content			VARCHAR2(210)										NOT NULL,
	feed_comment_heart_count		NUMBER												NOT NULL,
	feed_recomment_count			NUMBER												NOT NULL,
	feed_comment_reg_date			DATE												NOT NULL,
	feed_comment_update_date		DATE,
	report_condition				CHAR(3)												NOT NULL,
	delete_condition				CHAR(3)												NOT NULL,
	delete_user_id					VARCHAR2(20)													REFERENCES users(user_id),
	parent							NUMBER												NOT NULL,
	depth							NUMBER												NOT NULL,
	sequence						NUMBER												NOT NULL,
	PRIMARY KEY(feed_comment_no)
);

CREATE TABLE heart(
	heart_no						NUMBER												NOT NULL,
	user_id							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	source							CHAR(3)												NOT NULL,
	source_no						NUMBER												NOT NULL
);

INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user01', '3', '첫글입니다#first', 'a.jpg', 'b.jpg', null, null, null, '#first', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user02', '3', '두번째글입니다#second', 'a.jpg', 'b.jpg', null, null, null, '#second', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user03', '3', '세번째글입니다#third', 'a.jpg', 'b.jpg', null, null, null, '#third', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user04', '3', '네번째글입니다#fourth', 'a.jpg', 'b.jpg', null, null, null, '#fourth', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user05', '3', '다섯번째글입니다#fifth', 'a.jpg', 'b.jpg', null, null, null, '#fifth', '3', '5', SYSDATE, null, '0', '0' );

INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user01', 'first', '5', '0', SYSDATE, null, '0', '0', null,'0', '0', '0');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user02', 'second', '0', '0', SYSDATE, null, '0', '0', null,'0', '0', '1');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user03', 'third', '0', '0', SYSDATE, null, '0', '0', null,'0', '0', '2');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user04', 'fourth', '0', '0', SYSDATE, null, '0', '0', null,'0', '0', '3');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user05', 'fifit', '0', '0', SYSDATE, null, '0', '0', null,'0', '0', '4');

INSERT INTO heart VALUES (seq_heart_no.nextval, 'user01', '0', '5');
INSERT INTO heart VALUES (seq_heart_no.nextval, 'user02', '0', '5');
INSERT INTO heart VALUES (seq_heart_no.nextval, 'user03', '0', '5');
INSERT INTO heart VALUES (seq_heart_no.nextval, 'user04', '0', '5');
INSERT INTO heart VALUES (seq_heart_no.nextval, 'user05', '0', '5');

INSERT INTO heart VALUES (seq_heart_no.nextval, 'user01', '1', '1');
INSERT INTO heart VALUES (seq_heart_no.nextval, 'user02', '1', '1');
INSERT INTO heart VALUES (seq_heart_no.nextval, 'user03', '1', '1');
INSERT INTO heart VALUES (seq_heart_no.nextval, 'user04', '1', '1');
INSERT INTO heart VALUES (seq_heart_no.nextval, 'user05', '1', '1');





SELECT * FROM FEED ORDER BY feed_no DESC;

SELECT * FROM FEED_COMMENT ORDER BY feed_comment_no DESC;

SELECT * FROM HEART;

==========================================================================


set linesize 2000
set pagesize 2000

column user_id format a20;
column password format a20;
column name format a20;
column profile_writing format a20;
column rrn format a20;

column feed_no format a20;
column feed_open_condition format a20;
column feed_content format a20;
column feed_image1 format a20;
column feed_image2 format a20;
column feed_image3 format a20;
column feed_image4 format a20;
column feed_video format a20;
column hashtag format a20;

column feed_like_count format a80;
column feed_comment_count format a80;
column feed_reg_date format a20;
column feed_update_date format a20;
column report_condition format a20;
column delete_condition format a20;


CREATE TABLE feed (
	feed_no						NUMBER												NOT NULL,
	user_id						VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	feed_open_condition			CHAR(3)												NOT NULL,
	feed_content				VARCHAR2(840),
	feed_image1					VARCHAR2(100),
	feed_image2					VARCHAR2(100),
	feed_image3					VARCHAR2(100),
	feed_image4					VARCHAR2(100),
	feed_video					VARCHAR2(100),
	hashtag						VARCHAR2(840),
	feed_like_count				NUMBER												NOT NULL,
	feed_comment_count			NUMBER												NOT NULL,
	feed_reg_date				DATE												NOT NULL,
	feed_update_date			DATE,
	report_condition			CHAR(3)												NOT NULL,
	delete_condition			CHAR(3)												NOT NULL,
	PRIMARY KEY(feed_no)
);



CREATE TABLE feed_comment (
	feed_comment_no				NUMBER												NOT NULL,
	feed_no						NUMBER												NOT NULL,
	user_id						VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	feed_comment_content		VARCHAR2(210)										NOT NULL,
	feed_comment_like_count		NUMBER												NOT NULL,
	feed_recomment_count		NUMBER												NOT NULL,
	feed_comment_reg_date		DATE												NOT NULL,
	feed_comment_update_date	DATE,
	report_condition			CHAR(3)												NOT NULL,
	delete_condition			CHAR(3)												NOT NULL,
	parent						NUMBER												NOT NULL,
	depth						NUMBER												NOT NULL,
	sequence					NUMBER												NOT NULL,
	PRIMARY KEY(feed_comment_no)
);



CREATE TABLE heart(
	heart_no					NUMBER												NOT NULL,
	user_id						VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	source						CHAR(3)												NOT NULL,
	source_no					NUMBER												NOT NULL
);




INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user01', '3', '첫글입니다#first', 'a.jpg', 'b.jpg', null, null, null, '#first', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user02', '3', '두번째글입니다#second', 'a.jpg', 'b.jpg', null, null, null, '#second', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user03', '3', '세번째글입니다#third', 'a.jpg', 'b.jpg', null, null, null, '#third', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user04', '3', '네번째글입니다#fourth', 'a.jpg', 'b.jpg', null, null, null, '#fourth', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user05', '3', '다섯번째글입니다#fifth', 'a.jpg', 'b.jpg', null, null, null, '#fifth', '0', '0', SYSDATE, null, '0', '0' );



INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user01', 'first', '0', '0', SYSDATE, null, '0', '0', '0', '0', '0');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user02', 'second', '0', '0', SYSDATE, null, '0', '0', '0', '0', '0');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user03', 'third', '0', '0', SYSDATE, null, '0', '0', '0', '0', '0');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user04', 'fourth', '0', '0', SYSDATE, null, '0', '0', '0', '0', '0');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user05', 'fifit', '0', '0', SYSDATE, null, '0', '0', '0', '0', '0');



SELECT * from FEED ORDER BY feed_no DESC;

SELECT * from FEED_COMMENT ORDER BY feed_comment_no DESC;



SELECT
*
FROM feed f, heart h
WHERE f.feed_no = h.source_no
AND f.feed_no = '5' 
AND h.user_id = 'user01';


SELECT f.feed_no, f.user_id, f.feed_open_condition, f.feed_content, f.feed_image1, f.feed_image2, f.feed_image3, f.feed_image4, f.feed_video, f.hashtag, f.feed_like_count, f.feed_comment_count, f.feed_reg_date, f.feed_update_date, f.report_condition, f.delete_condition FROM feed f WHERE feed_content LIKE '%정말%' ORDER BY feed_no DESC; 



INSERT into feed_comment   VALUES (    seq_feed_comment_no.nextval,    '6',    'user01',    '2222',    0,    SYSDATE,    null,    '0',    '0', '34',    '2',    '0' , 'user01', 2    )

SELECT feed_comment_no, feed_no, user_id, feed_comment_content, feed_comment_like_count, feed_recomment_count, feed_comment_reg_date, feed_comment_update_date, report_condition, delete_condition, parent, depth, sequence FROM feed_comment WHERE feed_no = '5' AND report_condition = '0' AND delete_condition = '0' ORDER BY feed_comment_no ASC 




SELECT * FROM HEART;














SELECT 
*
FROM feed f, (
				SELECT
				*
				FROM	(
							SELECT
							*
							FROM HEART
							WHERE TRIM(source)		= '0'
							AND user_id				= 'user01'	)) isLike
WHERE f.feed_no = isLike.source_no(+)
ORDER BY feed_no DESC;














	SELECT
		COUNT(*)
		FROM	(
					SELECT
					heart_no,
					user_id,
					source,
					source_no
					FROM HEART
					WHERE TRIM(source)		= #{ source }
					AND source_no			= #{ sourceNo }	
					AND user_id				= #{ userId	}	)


				
				
				
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				
				
가람님
CREATE TABLE FOLLOW_BLOCK(
NO                     NUMBER(20) NOT NULL ,
SEND_USER_ID       VARCHAR(20) NOT NULL REFERENCES USERS(user_id), 
RECV_USER_ID       VARCHAR(20) NOT NULL REFERENCES USERS(user_id),
STATE                 CHAR(3) DEFAULT '0',
TYPE                   CHAR(3) DEFAULT '0',
PRIMARY KEY(NO)
);

CREATE SEQUENCE seq_FOLLOW_BLOCK_NO	INCREMENT BY 1 START WITH 1;


insert into follow_block values(seq_follow_block_no.nextval, 'user01', 'user02', '1', '1');
insert into follow_block values(seq_follow_block_no.nextval, 'user01', 'user03', '1', '1');
insert into follow_block values(seq_follow_block_no.nextval, 'user01', 'user04', '1', '1');
insert into follow_block values(seq_follow_block_no.nextval, 'user01', 'user05', '1', '1');


select * from users;
select * from FOLLOW_BLOCK;
select * from users;
select * from feed;

				
				
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				
				
경수님


// INSERT NOTICE    =  =  = addNotice()

	INSERT INTO NOTICE( NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_IMAGE1, NOTICE_IMAGE2, NOTICE_REGDATE, NOTICE_COUNT, CLUB_NO, USER_ID)
	VALUES (seq_notice_notice_no.nextval, '공지사항ss', '내용ss', 'abc.jpg', 'cdf.jpg' , SYSDATE, '1' , null, 'admin1');


// DELETE NOTICE  = = = deleteNotice()

	DELETE 
	FROM NOTICE
	WHERE NOTICE_NO = '3';

// SELECT NOTICE =   =  =  getNotice()

	SELECT NOTICE_NO , NOTICE_TITLE , NOTICE_CONTENT , NOTICE_IMAGE1 , NOTICE_IMAGE2, NOTICE_REGDATE, NOTICE_COUNT, CLUB_NO, USER_ID
	FROM NOTICE 
	WHERE NOTICE_NO = '3';


// UPDATE NOTICE = = = updateNotice()

	UPDATE NOTICE
	SET NOTICE_TITLE = '실험',
		NOTICE_CONTENT = '입니다',
		NOTICE_REGDATE = SYSDATE,
		NOTICE_IMAGE1 = 'ABC.JPG',
		NOTICE_IMAGE2 = 'DFE.JPG'
	WHERE NOTICE_NO = '3';


//===============================================================여기까지 노티스	
//===============================================================밑부턴 Q&A

// INSERT QANDA = = = addQandA()

	INSERT INTO QANDA ( QANDA_NO, QANDA_TITLE, QANDA_CONTENT, QANDA_REGDATE, QANDA_IMAGE1,
						QANDA_IMAGE2, ANSWER_CONDITION, QANDA_OPEN_CONDITION, QANDA_COUNT, USER_ID)
	VALUES (SEQ_QANDA_NO.NEXTVAL, '실험', '실험입니다', SYSDATE, 'ABC.JPG', 'JPS.JPG', '0', '0','0','admin1' );

// DELETE QANDA = = = deleteQandA()

	DELETE
	FROM QANDA
	WEHRE QANDA_NO ='3';

// SELECT QANDA = = = getQandA()

	SELECT QANDA_NO, QANDA_TITLE, QANDA_CONTENT, QANDA_REGDATE, QANDA_IMAGE1,
		   QANDA_IMAGE2, ANSWER_CONTENT, ANSWER_REGDATE, ANSWER_CONDITION, QANDA_OPEN_CONDITION, QANDA_COUNT, USER_ID
	FROM QANDA
	WHERE QANDA_NO = '3';

// UPDATE QANDA = = = updateQandA()

	UPDATE QANDA
	SET QANDA_TITLE = '실험',
		QANDA_CONTENT = '입니다',
		QANDA_REGDATE = SYSDATE,
		QANDA_IMAGE1 = 'ABC.JPG',
		QANDA_IMAGE2 = 'JPS.JPG',
	WHERE QANDA_NO = '3';

	
// ANSWER QANDA = = = updateQandA()    관리자 대답. updateQandA에서 아이디(세션)으로 나눌예정


	UPDATE QANDA
	SET	ANSWER_CONTENT = '대답',
	 	ANSWER_REGDATE = SYSDATE,
	 	ANSWER_CONDITION '1'
	 WHERE QANDA_NO = '3';
		


































//==========================================실험

DROP SEQUENCE seq_notice_notice_no;

CREATE SEQUENCE seq_notice_notice_no   INCREMENT BY 1 START WITH 1;


select * from notice;

delete from notice where notice_no = '6';



//==================여기까지가 Notice ====//

DROP SEQUENCE seq_qanda_qanda_no;
DROP SEQUENCE seq_qanda_no;

CREATE SEQUENCE SEQ_QANDA_NO					INCREMENT BY 1 START WITH 1;
 

select * from qanda;


//=================여기까지가 QandA

select * from users;

select * from report_push;
desc report_push;

select * from club_post;

DROP TABLE report_push;
================

CREATE TABLE REPORT_PUSH (
	NO				NUMBER(20)				NOT NULL,
	TITLE				VARCHAR2(200)				,
	CONTENT				VARCHAR2(2000)				NOT NULL,
	REPORT_SOURCE 			CHAR(3)					,
	CLUB_POST_NO			NUMBER(20)					NULL	REFERENCES club_post(club_post_no),
	CLUB_POST_COMMENT_NO		NUMBER(20)					NULL	REFERENCES club_post_comment(club_post_comment_no),
	CHAT_NO				NUMBER(20)				NULL		REFERENCES chat(chat_no),
	FEED_NO				NUMBER(20)					NULL	REFERENCES feed(feed_no),
	FEED_COMMENT_NO			NUMBER(20)				NULL		REFERENCES feed_comment(feed_comment_no),
	LIVE_NO				NUMBER(20)					NULL	REFERENCES live(live_no),
	USER_ID1				VARCHAR2(20)						REFERENCES users(user_id),
	USER_ID2				VARCHAR2(20)				NOT NULL	REFERENCES users(user_id),
	REPORT_REGDATE			DATE					NOT NULL,
	REPORT_IMAGE1			VARCHAR2(100),
	REPORT_IMAGE2			VARCHAR2(100),
	TYPE				CHAR(3)					NOT NULL,
	REPORT_REASON			CHAR(3)					,
	REPORT_CONDITION		CHAR(3)			DEFAULT '1'	,
	REPORT_DUPLICATION		CHAR(3)			,
	PRIMARY KEY(NO)
);

//addReport() 
INSERT INTO report_push
( no, title, content, report_source, club_post_no, club_post_comment_no, feed_no, feed_comment_no, live_no, user_id1,
 user_id2, report_regdate, report_image1, report_image2, type, report_reason, report_condition)
VALUES (seq_report_push_no.nextval, '신고', '신고합니다' , NULL , NULL , NULL , NULL , NULL , NULL, 'admin1' , 'user01' , SYSDATE, NULL , NULL ,
  '1' , '1' , '0'); 



 SELECT * FROM REPORT_PUSH;
 
 
 INSERT INTO REPORT_PUSH
	( NO, TITLE, CONTENT, REPORT_SOURCE, CLUB_POST_NO, CLUB_POST_COMMENT_NO, FEED_NO, FEED_COMMENT_NO,  USER_ID1,
	USER_ID2, REPORT_REGDATE, REPORT_IMAGE1, REPORT_IMAGE2, TYPE, REPORT_REASON, REPORT_CONDITION)

	VALUES (seq_report_push_no.nextval,
			 #{title},
			 #{content},
			 null,
			 #{clubPostComment.clubPostCommentNo},
			 #{feed.feedNo},
			 #{feedComment.feedCommentNo}, 
			 #{user1.userId},
			 #{user2.userId},
			 SYSDATE,
			 #{reportImage1},
			 #{reportImage2}, 
			 #{type},
			 #{reportReason},
		     #{reportCondition} )
 
 
 //updateReport()
 
 SELECT * FROM USERS where user_id='user02';
 
 SELECT * FROM REPORT_PUSH WHERE no='37';

SELECT u.report_count, u.penalty_type, r.report_reason, u.user_id
FROM USERS u, report_push r
WHERE u.user_id=r.user_id2 AND r.user_id2='user02';



SELECT REPORT_COUNT, penalty_type, stop_start_date, stop_end_date
FROM USERS
WHERE user_id='user02';
	
	
UPDATE USERS
SET
REPORT_COUNT = '0',
PENALTY_TYPE = '0',
STOP_START_DATE = NULL,
STOP_END_DATE = NULL
WHERE USER_ID = 'user02';



 SELECT to_number(1) + to_number(1)
 FROM users; 
 
 
SELECT r.*
FROM REPORT_PUSH R;

SELECT R.*
FROM CLUB_POST R
WHERE club_post_no='45';

DELETE report_push
WHERE no='45';



UPDATE REPORT_PUSH
SET CLUB_POST_NO = '30'
WHERE No='45';

SELECT *
FROM REPORT_PUSH
WHERE USER_ID1='admin1' AND USER_ID2='user01' AND REPORT_REGDATE < TO_CHAR(REPORT_REGDATE+7,'YYYYMMDD');

SELECT R.*   FROM REPORT_PUSH R      WHERE R.USER_ID1 = 'admin1' AND R.USER_ID2 = 'user01'   AND TO_CHAR(R.REPORT_REGDATE, 'YYYYMMDD') < TO_CHAR(R.REPORT_REGDATE+3, 'YYYYMMDD')




				
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////				
				
				
정민님
SELECT user_id, password, name, gender, rrn, phone_no, email, role, nickname, 
					profile_image, profile_writing, area1, area2, area3, category1, category2, 
					category3, penalty_type,  report_count, stop_start_date, stop_end_date,
					out_user_state, out_user_date, add_user_type, logout_date, add_user_date,
					total_visit_count, open_condition, push_condition, join_club_count, join_club_limit, sns_user_id
FROM users;
WHERE sns_user_id = 'bymin1992@naver.com' and add_user_type = '1';

DELETE users
WHERE user_id = 'Link4947';

INSERT
INTO users (user_id, add_user_type ,add_user_date)
VALUES ('user06', '1', SYSDATE);

INSERT 
INTO users (user_id, password, name, rrn, gender, phone_no, email, nickname, profile_writing, 
	area1, area2, area3, category1, category2, category3, add_user_date)
VALUES	('user07', '1233', '화요비', 1234561234567, '여자', 01033336666, 'bitcamp@bitcamp.com', '나락', NULL, NULL, NULL, NULL, NULL, NULL, NULL, SYSDATE);

UPDATE users
SET password = '1111', email = 'user01@bitcamp.com'
WHERE user_id = 'user01';

UPDATE users
SET password= ''
WHERE user_id = '';

UPDATE users
SET out_user_state = '0'
WHERE user_id = 'user01';

UPDATE users
SET out_user_date = SYSDATE
WHERE user_id = 'user01';

UPDATE users
SET phone_no = 01022224444
WHERE user_id = 'user01';

UPDATE users
SET nickname = '사랑', gender ='여자', area1 = '관악구', area2 = '동작구', area3 = '영등포구', category1 = '운동', category2 = '음식', category3 = '기타', profile_image = 'default.png', profile_writing = '반갑습니다~'
WHERE user_id = 'user01';

UPDATE users
SET logout_date = SYSDATE
WHERE user_id = 'user01';

UPDATE users
SET report_count = 1
WHERE user_id = 'user01';

UPDATE users
SET stop_start_date = '2022-10-11', stop_end_date = '2022-10-12'
WHERE user_id = 'user01';

UPDATE users
SET penalty_type = '1'
WHERE user_id = 'user01';

UPDATE users
SET total_visit_count = 1
WHERE user_id = 'user01';

UPDATE users
SET open_condition = '0'
WHERE user_id = 'user01';

UPDATE users
SET push_condition = '1'
WHERE user_id = 'user01';

UPDATE users
SET join_club_count = 0
WHERE user_id = 'user01';

UPDATE users
SET join_club_limit = 2
WHERE user_id = 'user01';














