
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
SELECT CP.CLUB_POST_NO, CP.CLUB_NO, CP.USER_ID, U.PROFILE_IMAGE, U.NICKNAME, CP.CLUB_POST_TITLE, CP.CLUB_POST_CONTENT,
CP.CLUB_POST_VIDEO1, CP.CLUB_POST_VIDEO2, CP.CLUB_POST_VIDEO3, CP.CLUB_POST_REG_DATE, CP.CLUB_POST_UPDATE_DATE,
CP.CLUB_POST_HEART_COUNT, CP.CLUB_POST_COMMENT_COUNT, CP.IMAGE1, CP.IMAGE2, CP.IMAGE3, CP.IMAGE4, CP.IMAGE5, CP.IMAGE6,
CP.IMAGE7, CP.IMAGE8, CP.IMAGE9, CP.IMAGE10
FROM CLUB_POST CP, USERS U
WHERE CP.USER_ID = U.USER_ID AND CP.CLUB_POST_NO = 20



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



getClubPostList() - 가장 최근 가입한 모임의 삭제 또는 신고승인 된 게시물 빼고 최신순 검색 모임게시물 리스트
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
				 ) AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0' AND CLUB_POST_CONTENT LIKE '%내용%'
ORDER BY CLUB_POST_REG_DATE DESC



getClubPostList() - 가장 최근 가입한 모임의 삭제 또는 신고승인 된 게시물 빼고 최신순 검색 페이징 모임게시물 리스트
SELECT V4.*
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY CLUB_POST_NO DESC) AS R, V3.*
		FROM (
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
								 ) AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0' AND CLUB_POST_CONTENT LIKE '%내용%'
			) V3
	 ) V4
WHERE R BETWEEN 1 AND 10



getClubPostList() - 유저와 조인
SELECT V4.*, U.USER_ID, U.PROFILE_IMAGE, U.NICKNAME
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY CLUB_POST_NO DESC) AS R, V3.*
		FROM (
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
								 ) AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0' AND CLUB_POST_CONTENT LIKE '%내용%'
			) V3
	 ) V4, USERS U
WHERE V4.USER_ID = U.USER_ID AND R BETWEEN 1 AND 10



getClubPostList() - 가장 최근 가입한 모임의 삭제 또는 신고승인 된 게시물 빼고 오래된순 검색 페이징 모임게시물 리스트
SELECT V4.*
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY CLUB_POST_NO ASC) AS R, V3.*
		FROM ( SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
				FROM CLUB_POST
				WHERE CLUB_NO = ( SELECT V2.CLUB_NO
									FROM ( SELECT ROWNUM, V1.*
											FROM ( SELECT *
													FROM CLUB_USER
													WHERE USER_ID = 'user03' AND JOIN_REG_DATE IS NOT NULL
													ORDER BY JOIN_REG_DATE DESC ) V1
											WHERE ROWNUM = 1 ) V2
								) AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0' AND CLUB_POST_CONTENT LIKE '%내용%'
			) V3
	) V4
WHERE R BETWEEN 1 AND 10



getClubPostList() - 가장 최근 가입한 모임의 삭제 또는 신고승인 된 게시물 빼고 좋아요 많은순 검색 페이징 모임게시물 리스트
SELECT V4.*
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY CLUB_POST_HEART_COUNT DESC, CLUB_POST_NO DESC) AS R, V3.*
		FROM ( SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
				FROM CLUB_POST
				WHERE CLUB_NO = ( SELECT V2.CLUB_NO
									FROM ( SELECT ROWNUM, V1.*
											FROM ( SELECT *
													FROM CLUB_USER
													WHERE USER_ID = 'user03' AND JOIN_REG_DATE IS NOT NULL
													ORDER BY JOIN_REG_DATE DESC ) V1
											WHERE ROWNUM = 1 ) V2
								) AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0' AND CLUB_POST_CONTENT LIKE '%내용%'
			) V3
	) V4
WHERE R BETWEEN 1 AND 10



getClubPostList() - 가장 최근 가입한 모임의 삭제 또는 신고승인 된 게시물 빼고 내가 작성한 게시물 최신순 검색 페이징 모임게시물 리스트
SELECT V4.*
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY CLUB_POST_NO DESC) AS R, V3.*
		FROM ( SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
				FROM CLUB_POST
				WHERE CLUB_NO = 2 AND USER_ID = 'user03' AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0' AND CLUB_POST_CONTENT LIKE '%내용%'
			) V3
	) V4
WHERE R BETWEEN 1 AND 10


SELECT V4.*
FROM ( SELECT ROW_NUMBER() OVER(ORDER BY CLUB_POST_NO DESC ) AS R, V3.*
		FROM ( SELECT CLUB_NO, CLUB_POST_NO, IMAGE1, CLUB_POST_TITLE, USER_ID, CLUB_POST_HEART_COUNT
				FROM CLUB_POST
				WHERE CLUB_NO = 2 AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0' ) V3 ) V4
WHERE R BETWEEN 1 AND 10



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
SELECT CP.CLUB_POST_NO, CP.IMAGE1, CP.CLUB_POST_TITLE, CP.USER_ID, U.NICKNAME, U.PROFILE_IMAGE, CP.CLUB_POST_HEART_COUNT
FROM CLUB_POST CP, USERS U
WHERE CP.USER_ID = U.USER_ID AND CP.USER_ID = 'user02' AND CP.REPORT_CONDITION = '0' AND CP.DELETE_CONDITION = '0'
ORDER BY CP.CLUB_POST_REG_DATE DESC




getClubPostListMyHomeCount()
SELECT COUNT(*) FROM CLUB_POST WHERE USER_ID = 'user02' AND REPORT_CONDITION = '0' AND DELETE_CONDITION = '0'








checkFeedHeart() - 좋아요 했는지 체크
SELECT
COUNT(*)
FROM	(
			SELECT
			heart_no,
			user_id,
			source,
			source_no
			FROM HEART
			WHERE TRIM(source)		= 2
			AND source_no			= 71
			AND user_id				= 'user01'	)



// null값일 때  ${IMAGE:VARCHAR} 붙이자
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



getPayList()
SELECT PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE,
PAY_REG_DATE, UPDATE_CLUB_COUNT, UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID
FROM PAY
WHERE USER_ID = #{ USER_ID }



getPay()
SELECT PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE,
PAY_REG_DATE, UPDATE_CLUB_COUNT, UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID
FROM PAY
WHERE PAY_NO = #{ PAY_NO }






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









INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO) VALUES (SEQ_HEART_NO.NEXTVAL, 'user03', 2, 99);
INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO) VALUES (SEQ_HEART_NO.NEXTVAL, 'user03', 2, 75);
INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO) VALUES (SEQ_HEART_NO.NEXTVAL, 'user03', 2, 74);
INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO) VALUES (SEQ_HEART_NO.NEXTVAL, 'user03', 2, 64);
INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO) VALUES (SEQ_HEART_NO.NEXTVAL, 'user03', 2, 56);
UPDATE CLUB_POST SET CLUB_POST_HEART_COUNT = CLUB_POST_HEART_COUNT + 1 WHERE CLUB_POST_NO = 99;
UPDATE CLUB_POST SET CLUB_POST_HEART_COUNT = CLUB_POST_HEART_COUNT + 1 WHERE CLUB_POST_NO = 75;
UPDATE CLUB_POST SET CLUB_POST_HEART_COUNT = CLUB_POST_HEART_COUNT + 1 WHERE CLUB_POST_NO = 74;
UPDATE CLUB_POST SET CLUB_POST_HEART_COUNT = CLUB_POST_HEART_COUNT + 1 WHERE CLUB_POST_NO = 64;
UPDATE CLUB_POST SET CLUB_POST_HEART_COUNT = CLUB_POST_HEART_COUNT + 1 WHERE CLUB_POST_NO = 56;
INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO) VALUES (SEQ_HEART_NO.NEXTVAL, 'user03', 3, 4);
INSERT INTO HEART (HEART_NO, USER_ID, SOURCE, SOURCE_NO) VALUES (SEQ_HEART_NO.NEXTVAL, 'user03', 3, 1);
UPDATE CLUB_POST_COMMENT SET COMMENT_HEART_COUNT = 0 WHERE CLUB_POST_COMMENT_NO = 4;
UPDATE CLUB_POST_COMMENT SET COMMENT_HEART_COUNT = 0 WHERE CLUB_POST_COMMENT_NO = 1;
UPDATE CLUB_POST_COMMENT SET COMMENT_HEART_COUNT = COMMENT_HEART_COUNT + 1 WHERE CLUB_POST_COMMENT_NO = 4;
UPDATE CLUB_POST_COMMENT SET COMMENT_HEART_COUNT = COMMENT_HEART_COUNT + 1 WHERE CLUB_POST_COMMENT_NO = 1;






INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT,UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (seq_pay_no.NEXTVAL, 'user02', 2, 0, 0, 10000, SYSDATE, 4, 0, 0);
INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT,UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (seq_pay_no.NEXTVAL, 'user02', 2, 1, 0, 10000, SYSDATE, 0, 20, 0);







UPDATE CLUB_POST SET IMAGE1 = 'user03flower1clubPost.jpg', IMAGE2 = 'user03flower2clubPost.jpg', IMAGE3 = 'user03flower3clubPost.jpg', IMAGE4 = 'user03flower4clubPost.jpg', IMAGE5 = 'user03flower5clubPost.jpg', IMAGE6 = 'user03flower6clubPost.jpg', IMAGE7 = 'user03flower7clubPost.jpg', IMAGE8 = 'user03flower8clubPost.jpg', IMAGE9 = 'user03flower9clubPost.jpg', IMAGE10 = 'user03flower10clubPost.jpg' WHERE CLUB_POST_NO = 75;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower20clubPost.jpg', IMAGE2 = 'user03flower11clubPost.jpg', IMAGE3 = 'user03flower1clubPost.jpg', IMAGE4 = 'user03flower2clubPost.jpg', IMAGE5 = 'user03flower8clubPost.jpg', IMAGE6 = 'user03flower9clubPost.jpg', IMAGE7 = 'user03flower6clubPost.jpg', IMAGE8 = 'user03flower12clubPost.jpg', IMAGE9 = 'user03flower13clubPost.jpg', IMAGE10 = 'user03flower14clubPost.jpg' WHERE CLUB_POST_NO = 74;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower11clubPost.jpg', IMAGE2 = 'user03flower6clubPost.jpg', IMAGE3 = 'user03flower5clubPost.jpg', IMAGE4 = 'user03flower6clubPost.jpg', IMAGE5 = 'user03flower17clubPost.jpg' WHERE CLUB_POST_NO = 71;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower17clubPost.jpg', IMAGE2 = 'user03flower15clubPost.jpg', IMAGE3 = 'user03flower11clubPost.jpg', IMAGE4 = 'user03flower20clubPost.jpg' WHERE CLUB_POST_NO = 64;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower2clubPost.jpg' WHERE CLUB_POST_NO = 63;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower8clubPost.jpg', IMAGE2 = 'user03flower17clubPost.jpg', IMAGE3 = 'user03flower10clubPost.jpg', IMAGE4 = 'user03flower14clubPostjpg.jpg', IMAGE5 = 'user03flower20clubPost.jpg' WHERE CLUB_POST_NO = 62;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower14clubPost.jpg', IMAGE2 = 'user03flower12clubPost.jpg' WHERE CLUB_POST_NO = 61;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower12clubPost.jpg', IMAGE2 = 'user03flower7clubPost.jpg', IMAGE3 = 'user03flower13clubPost.jpg', IMAGE4 = 'user03flower11clubPost.jpg' WHERE CLUB_POST_NO = 60;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower13clubPost.jpg', IMAGE2 = 'user03flower18clubPost.jpg' WHERE CLUB_POST_NO = 59;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower9clubPost.jpg', IMAGE2 = 'user03flower16clubPost.jpg', IMAGE3 = 'user03flower2clubPost.jpg' WHERE CLUB_POST_NO = 58;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower5clubPost.jpg' WHERE CLUB_POST_NO = 57;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower6clubPost.jpg' WHERE CLUB_POST_NO = 56;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower14clubPostjpg.jpg' WHERE CLUB_POST_NO = 55;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower1clubPost.jpg' WHERE CLUB_POST_NO = 54;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower6clubPost.jpg' WHERE CLUB_POST_NO = 53;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower15clubPost.jpg' WHERE CLUB_POST_NO = 52;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower7clubPost.jpg' WHERE CLUB_POST_NO = 51;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower18clubPost.jpg' WHERE CLUB_POST_NO = 50;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower11clubPost.jpg' WHERE CLUB_POST_NO = 49;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower19clubPostjpg.jpg' WHERE CLUB_POST_NO = 48;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower9clubPost.jpg' WHERE CLUB_POST_NO = 29;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower16clubPost.jpg' WHERE CLUB_POST_NO = 27;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower10clubPost.jpg' WHERE CLUB_POST_NO = 26;
UPDATE CLUB_POST SET IMAGE1 = 'user03flower17clubPost.jpg' WHERE CLUB_POST_NO = 25;









UPDATE USERS SET PROFILE_IMAGE = 'profile_image1clubPost.jpg' WHERE USER_ID = 'user01';
UPDATE USERS SET PROFILE_IMAGE = 'profile_image2clubPost.jpg' WHERE USER_ID = 'user02';
UPDATE USERS SET PROFILE_IMAGE = 'profile_image3clubPost.jpg' WHERE USER_ID = 'user03';
UPDATE USERS SET PROFILE_IMAGE = 'profile_image4clubPost.jpg' WHERE USER_ID = 'user04';









INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT, UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (1, 'user555', 22, '모임원 추가', '신용카드', 5000, SYSDATE, 0, 10, 'a' );
INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT, UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (2, 'user555', 0, '모임 추가', '카카오페이', 10000, SYSDATE, 4, 0, 'a' );
INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT, UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (3, 'user555', 22, '모임원 추가', '휴대폰결제', 10000, SYSDATE, 0, 20, 'a' );
INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT, UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (4, 'user555', 0, '모임 추가', '토스페이', 15000, SYSDATE, 6, 0, 'a' );
INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT, UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (5, 'user555', 22, '모임원 추가', '실시간 계좌이체', 5000, SYSDATE, 0, 10, 'a' );


























INSERT INTO CHAT (CHAT_NO, USER_ID, ROOMID, USER_ID2) VALUES(seq_chat_no.NEXTVAL, #{ user.userId }, #{ roomID }, #{ user2.userId })
INSERT INTO CHAT (CHAT_NO, USER_ID, ROOMID, USER_ID2) VALUES(seq_chat_no.NEXTVAL, 'user111', 'user111user222', 'user222');
INSERT INTO CHAT (CHAT_NO, USER_ID, ROOMID, USER_ID2) VALUES(seq_chat_no.NEXTVAL, 'user222', 'user222user333', 'user333');
INSERT INTO CHAT (CHAT_NO, USER_ID, ROOMID, USER_ID2) VALUES(seq_chat_no.NEXTVAL, 'user444', '222', 'user222');



SELECT *
FROM ( SELECT * FROM CHAT WHERE USER_ID = 'user333' OR USER_ID2 = 'user333' )
WHERE USER_ID = 'user111' OR USER_ID2 = 'user111'




SELECT *
FROM users u, ( SELECT * FROM CHAT WHERE USER_ID = 'user222' OR USER_ID2 = 'user222' ) V1
WHERE U.USER_ID = V1.USER_ID (+)

SELECT *
FROM users u, ( SELECT * FROM CHAT WHERE USER_ID = 'user222' OR USER_ID2 = 'user222' ) V1
WHERE U.USER_ID (+) = V1.USER_ID2 AND U.USER_ID = 'user222'





select count(*) from ( select * from heart where trim(source) = 2 and source_no = 32 and user_id = 'user12')









INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT, UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (seq_pay_no.NEXTVAL, 'garam113', 2, '1', '2', 10000, SYSDATE, 0, 20, 'AIELF-WOHAS-2DJHE2')







UPDATE CLUB_POST_COMMENT SET DELETE_CONDITION = '1', DELETE_USER_ID = 'food1' WHERE PARENT = 38



SELECT *
FROM ( SELECT inner_table.* , ROWNUM AS row_seq
	  	FROM ( SELECT club_no , user_id , club_title , club_detail , club_reg_date, current_member, club_max_member, club_category, club_area, club_image
				FROM club
				ORDER BY club_no ) inner_table
		WHERE ROWNUM <= 12 )
WHERE row_seq BETWEEN 1 AND 12


SELECT V3.*
FROM ( SELECT V2.*
		FROM ( SELECT ROW_NUMBER() OVER( ORDER BY club_no DESC ) AS row_seq, V1.*
			  	FROM ( SELECT club_no , user_id , club_title , club_detail , club_reg_date, current_member, club_max_member, club_category, club_area, club_image
						FROM club
						ORDER BY club_no ) V1
			 ) V2
		) V3
WHERE row_seq BETWEEN 1 AND 4

SELECT *
FROM ( SELECT * FROM CLUB WHERE USER_ID = 'food1' ORDER BY CLUB_NO DESC )
WHERE ROWNUM = 1















		SELECT inner_table.*
		FROM ( 
				SELECT rownum AS row_seq, deep_table.*
				FROM (
						 SELECT
						  p.participant_no, 
						  p.participant_user_id, 
						  u.nickname ,
						  u.profile_image ,
						  m.meeting_title ,
						  m.meeting_place , 
						  m.meeting_time ,
						  m.meeting_date ,
						  m.club_no ,
						  m.meeting_no
						FROM participant p, users u, meeting m
						WHERE
							p.participant_user_id = u.user_id
							and p.meeting_no = m.meeting_no
								and u.user_id = 'garam113'
						) deep_table ) inner_table




SELECT COUNT(*) FROM PARTICIPANT WHERE MEETING_NO = 9 AND PARTICIPANT_USER_ID = 'garam113'


SELECT * FROM MEETING WHERE MEETING_NO = 9

UPDATE CLUB
SET DELETE_CONDITION = 1 
WHERE club_no = 1












SELECT V3.*
FROM ( SELECT V2.*
		FROM ( SELECT ROW_NUMBER() OVER( ORDER BY club_no DESC ) AS row_seq, V1.*
				FROM ( SELECT club_no , user_id , club_title , club_detail , club_reg_date, current_member, club_max_member, club_category, club_area, club_image
						FROM club
						WHERE delete_condition = 0
						ORDER BY club_no ) V1
			 ) V2
	 ) V3
WHERE row_seq BETWEEN 1 AND 12





SELECT V3.*
FROM ( SELECT V2.*
		FROM ( SELECT ROW_NUMBER() OVER( ORDER BY club_no DESC ) AS row_seq, V1.*
				FROM ( SELECT club_no , user_id , club_title , club_detail , club_reg_date, current_member, club_max_member, club_category, club_area, club_image
						FROM club
						WHERE delete_condition = 0                             WHERE  club_category = ?                            ORDER BY club_no ) V1          ) V2        ) V3   WHERE row_seq BETWEEN 1 AND 12




SELECT V3.* FROM ( SELECT V2.* FROM ( SELECT ROW_NUMBER() OVER( ORDER BY club_no DESC ) AS row_seq, V1.* FROM ( SELECT club_no , user_id , club_title , club_detail , club_reg_date, current_member, club_max_member, club_category, club_area, club_image FROM club WHERE delete_condition = 0 and club_category = ? ORDER BY club_no ) V1 ) V2 ) V3 WHERE row_seq BETWEEN 13 AND 24


delete from club_user where club_no = 19




select * from club_user where user_id = 'ash99' and club_no = 9


SELECT V3.* FROM ( SELECT V2.* FROM ( SELECT ROW_NUMBER() OVER( ORDER BY club_no DESC ) AS row_seq, V1.*
FROM ( SELECT club_no , user_id , club_title , club_detail , club_reg_date, current_member, club_max_member, club_category, club_area, club_image
FROM club WHERE delete_condition = 0 and club_category = ? ORDER BY club_no ) V1 ) V2 ) V3 WHERE row_seq BETWEEN 11 AND 20





SELECT *
FROM ( SELECT *
		FROM meeting
		WHERE add_meeting_user_id = 'alexash'
		order by meeting_no DESC )
WHERE ROWNUM = 1

SELECT *
FROM ( SELECT * FROM meeting WHERE add_meeting_user_id = 'alexash' order by meeting_no DESC )
WHERE ROWNUM = 1


INSERT into participant  (    participant_no ,    meeting_no ,    participant_user_id      )     VALUES (    seq_participant_no.nextval ,    ? ,    ?   )












