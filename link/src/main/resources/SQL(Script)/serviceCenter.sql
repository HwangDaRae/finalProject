

// INSERT NOTICE    =  =  = addNotice()

	INSERT INTO NOTICE( NOTICE_NO, NOTICE_TITLE, NOTICE_CONTENT, NOTICE_IMAGE1, NOTICE_IMAGE2, NOTICE_REGDATE, NOTICE_COUNT, CLUB_NO, USER_ID)
	VALUES (seq_notice_notice_no.nextval, '공지사항ss', '내용ss', 'abc.jpg', 'cdf.jpg' , TO_CHAR(SYSDATE,'YY-MM-DD'),'1' , null, 'admin1');


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


	
INSERT 
INTO users (user_id, password, name, rrn, gender, phone_no, email, nickname, profile_writing, 
	area1, area2, area3, category1, category2, category3, add_user_date)
VALUES	('ssiroo4147', 'q123123', '조승우', '930505-1053553', '남자', '010-1993-5237', 'srnt3223@google.com', '날씬한오징어', 'pakbokum.jpg', NULL, NULL, NULL, NULL, NULL, NULL, SYSDATE);

update users
set profile_image ='admin.JPG'
where user_id='admin01';

select *
from users;

delete 
from report_push
where no='169';

//===============================================================여기까지 노티스	
//===============================================================밑부턴 Q&A

// INSERT QANDA = = = addQandA()

	INSERT INTO QANDA ( QANDA_NO, QANDA_TITLE, QANDA_CONTENT, QANDA_REGDATE, QANDA_IMAGE1,
						QANDA_IMAGE2, ANSWER_CONDITION, QANDA_OPEN_CONDITION,  USER_ID)
	VALUES (SEQ_QANDA_NO.NEXTVAL, '실험', '실험입니다', SYSDATE, 'ABC.JPG', 'JPS.JPG', '0', '0','admin1' );

// DELETE QANDA = = = deleteQandA()

	DELETE
	FROM QANDA
	WHERE QANDA_NO ='8';

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
		

DELETE report_push WHERE no='262';

SELECT * FROM QANDA;

SELECT * FROM report_push where no='73';



	SELECT
	N.NOTICE_NO , N.NOTICE_TITLE , N.NOTICE_CONTENT , N.NOTICE_IMAGE1 , 
	N.NOTICE_IMAGE2, N.NOTICE_REGDATE, N.NOTICE_COUNT, N.CLUB_NO, U.USER_ID, U.NICKNAME
	FROM NOTICE N , USERS U
	WHERE n.notice_no = 76 AND U.USER_ID= N.USER_ID AND U.USER_ID = 'admin1';





SELECT
TO_CHAR(
SYSDATE, 'YYYY-MM-DD')
FROM NOTICE N
WHERE n.notice_no = 41;



SELECT *
FROM USERS;






CREATE TABLE QANDA (
	QANDA_NO 						NUMBER(20)											NOT NULL,
	QANDA_TITLE 					VARCHAR2(200)										NOT NULL,
	QANDA_CONTENT					VARCHAR2(2000)										NOT NULL,
	QANDA_REGDATE					DATE												NOT NULL,
	QANDA_IMAGE1					VARCHAR2(100),
	QANDA_IMAGE2					VARCHAR2(100),
	ANSWER_CONTENT					VARCHAR2(2000),
	ANSWER_REGDATE					DATE,
	ANSWER_CONDITION				CHAR(3)					DEFAULT '0'					NOT NULL,
	QANDA_OPEN_CONDITION			CHAR(3)					DEFAULT '0'					NOT NULL ,
	USER_ID 						VARCHAR2(20)										NOT NULL	REFERENCES users(USER_ID),
	PRIMARY KEY(QANDA_NO)
);








//==========================================실험

DROP SEQUENCE seq_notice_notice_no;

CREATE SEQUENCE seq_notice_notice_no   INCREMENT BY 1 START WITH 1;

delete from notice;
select * from users;
select * from notice;

delete from notice where notice_no = '6';



//==================여기까지가 Notice ====//

DROP SEQUENCE seq_qanda_qanda_no;
DROP SEQUENCE seq_qanda_no;
DROP TABLE qanda;
CREATE SEQUENCE SEQ_QANDA_NO					INCREMENT BY 1 START WITH 1;

DELETE FROM QANDA;

select * from qanda;


//=================여기까지가 QandA

select * from users;

select * from report_push where type='1';
desc report_push;
select * from club_post;


select * from users;


DROP TABLE report_push;
================

CREATE TABLE REPORT_PUSH (
	NO				NUMBER(20)				NOT NULL,
	TITLE				VARCHAR2(200)				,
	CONTENT				VARCHAR2(2000)				NOT NULL,
	REPORT_SOURCE 			CHAR(3)					,
	CLUB_NO					NUMBER(20)				NULL REFERENCES club(club_no),
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
	REPORT_CONDITION		CHAR(3)			DEFAULT '0'	,
	REPORT_DUPLICATION		CHAR(3)			,
	PRIMARY KEY(NO)
);

//addReport() 
INSERT INTO report_push
( no, title, content, report_source, club_post_no, club_post_comment_no, feed_no, feed_comment_no, live_no, user_id1,
 user_id2, report_regdate, report_image1, report_image2, type, report_reason, report_condition)
VALUES (seq_report_push_no.nextval, '신고', '신고합니다' , NULL , NULL , NULL , NULL , NULL , NULL, 'user08' , 'user01' , SYSDATE, NULL , NULL ,
  '1' , '1' , '0'); 

DROP SEQUENCE seq_report_push_no;
CREATE SEQUENCE SEQ_REPORT_PUSH_NO  	INCREMENT BY 1 START WITH 1;

 SELECT * FROM REPORT_PUSH;
 
DROP TABLE REPORT_PUSH				CASCADE CONSTRAINTS; 
 
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

DESC REPORT_PUSH;

SELECT REPORT_COUNT, penalty_type, stop_start_date, stop_end_date
FROM USERS
WHERE user_id='user02';
	

UPDATE USERS
SET
REPORT_COUNT = '0',
PENALTY_TYPE = '0',
STOP_START_DATE = NULL,
STOP_END_DATE = NULL
WHERE USER_ID = 'user03';

DELETE FROM REPORT_PUSH;


 SELECT to_number(1) + to_number(1)
 FROM users; 
 
SELECT *
FROM report_push;
 
SELECT *
FROM REPORT_PUSH R
where no='182';

select *
from club_post_comment
where club_post_comment_no='81';

select *
from feed_comment
where feed_comment_no='362';


select *
from users;

update users
set rrn='111111-000000'
where user_id='user05';

SELECT R.*
FROM CLUB_POST R
WHERE club_post_no='45';

DELETE report_push
WHERE no='8';



UPDATE REPORT_PUSH
SET CLUB_POST_NO = '30'
WHERE No='45';

SELECT *
FROM REPORT_PUSH;
WHERE USER_ID1='admin1' AND USER_ID2='user01' AND REPORT_REGDATE < TO_CHAR(REPORT_REGDATE+7,'YYYYMMDD');

SELECT R.*   FROM REPORT_PUSH R      WHERE R.USER_ID1 = 'admin1' AND R.USER_ID2 = 'user01'   AND TO_CHAR(R.REPORT_REGDATE, 'YYYYMMDD') < TO_CHAR(R.REPORT_REGDATE+3, 'YYYYMMDD')





INSERT REPORT_PUSH
INTO 






















SELECT COUNT(*) FROM( SELECT notice_title , notice_content , notice_regdate FROM notice ) countTable





SELECT 
* 
FROM (	SELECT 
		inner_table.* ,
		ROWNUM AS row_seq 
		FROM 		( 
						SELECT N.NOTICE_NO , 
						N.NOTICE_TITLE , U.USER_ID, U.NICKNAME ,
						N.NOTICE_REGDATE , N.NOTICE_COUNT 
						FROM NOTICE N , USERS U 
						WHERE N.USER_ID = 'admin1'
						AND U.USER_ID = N.USER_ID
						ORDER BY N.notice_no ) inner_table 
		WHERE ROWNUM <= 10 )
WHERE row_seq BETWEEN 1 AND 10;


SELECT * FROM ( 
		SELECT inner_table.* , ROWNUM AS row_seq 
			FROM ( 
				SELECT Q.QANDA_NO , Q.QANDA_TITLE , Q.ANSWER_CONDITION , U.USER_ID , U.NICKNAME, 
						Q.QANDA_REGDATE , Q.QANDA_OPEN_CONDITION 
						FROM QANDA Q, USERS U WHERE Q.USER_ID=U.USER_ID ORDER BY qanda_no ) inner_table WHERE ROWNUM <= 10 ) 
WHERE row_seq BETWEEN 1 AND 10;



select * from qanda;














