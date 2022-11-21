


USERS				회원
CLUB_POST			모임게시물
CLUB_POST_COMMENT	모임게시물댓글
PAY					결제
FEED				피드
FEED_COMMENT		피드댓글
HEART				좋아요
NOTICE				공지사항
QANDA				QandA
REPORT_PUSH			신고 및 알림
CLUB				모임
CLUB_USER			모임원
MEETING				모임일정
PARTICIPANT			모임참여자
LIVE				라이브
CHAT				채팅



DROP TABLE USERS					CASCADE CONSTRAINTS;
DROP TABLE CLUB_POST				CASCADE CONSTRAINTS;
DROP TABLE CLUB_POST_COMMENT		CASCADE CONSTRAINTS;
DROP TABLE PAY						CASCADE CONSTRAINTS;
DROP TABLE FEED 					CASCADE CONSTRAINTS;
DROP TABLE FEED_COMMENT				CASCADE CONSTRAINTS;
DROP TABLE HEART					CASCADE CONSTRAINTS;
DROP TABLE NOTICE					CASCADE CONSTRAINTS;
DROP TABLE QANDA					CASCADE CONSTRAINTS;
DROP TABLE REPORT_PUSH				CASCADE CONSTRAINTS;
DROP TABLE CLUB						CASCADE CONSTRAINTS;
DROP TABLE CLUB_USER				CASCADE CONSTRAINTS;
DROP TABLE MEETING					CASCADE CONSTRAINTS;
DROP TABLE PARTICIPANT				CASCADE CONSTRAINTS;
DROP TABLE FOLLOW_BLOCK				CASCADE CONSTRAINTS;
DROP TABLE LIVE						CASCADE CONSTRAINTS;
DROP TABLE CHAT						CASCADE CONSTRAINTS;



DROP SEQUENCE seq_club_post_no;
DROP SEQUENCE seq_club_post_comment_no;
DROP SEQUENCE seq_pay_no;
DROP SEQUENCE seq_feed_no;
DROP SEQUENCE seq_feed_comment_no;
DROP SEQUENCE seq_heart_no;
DROP SEQUENCE seq_notice_notice_no;
DROP SEQUENCE seq_qanda_no;
DROP SEQUENCE seq_report_push_no;
DROP SEQUENCE seq_club_no;
DROP SEQUENCE seq_club_user_no;
DROP SEQUENCE seq_meeting_no;
DROP SEQUENCE seq_participant_no;
DROP SEQUENCE seq_follow_block_no;
DROP SEQUENCE seq_live_no;
DROP SEQUENCE seq_chat_no;









여기부터 맨 밑까지 복사해서 사용하세요 (맨 아래 commit도 꼭!!!)
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////



CREATE SEQUENCE seq_club_post_no				INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_club_post_comment_no		INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_pay_no						INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_feed_no						INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_feed_comment_no				INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_heart_no					INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_notice_notice_no			INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_QANDA_NO					INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_REPORT_PUSH_NO				INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_club_no						INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_club_user_no				INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_meeting_no					INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_participant_no				INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_FOLLOW_BLOCK_NO				INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_live_no						INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_chat_no						INCREMENT BY 1 START WITH 1;






CREATE TABLE users	(
	user_id							VARCHAR2(20)										NOT NULL,
	password						VARCHAR2(50),
	name							VARCHAR2(50),
	rrn								VARCHAR2(20),
	gender							VARCHAR2(20),
	phone_no						VARCHAR2(20),
	email							VARCHAR2(50),
	role							CHAR(3)					DEFAULT	'0',
	nickname						VARCHAR2(30),
	profile_image					VARCHAR2(100)			DEFAULT 'default.png',
	profile_writing					VARCHAR2(200),
	area1							VARCHAR2(100),
	area2							VARCHAR2(100),
	area3							VARCHAR2(100),
	category1						VARCHAR2(100),
	category2						VARCHAR2(100),
	category3						VARCHAR2(100),
	penalty_type					CHAR(3)					DEFAULT	'0',
	report_count					NUMBER					DEFAULT	'0',
	stop_start_date					DATE,
	stop_end_date	 				DATE,
	out_user_state					CHAR(3)					DEFAULT	'0',
	out_user_date					DATE,
	add_user_type					CHAR(3)					DEFAULT	'0',
	logout_date						DATE,
	add_user_date					DATE												NOT NULL,
	total_visit_count				NUMBER(20)				DEFAULT	'0',
	open_condition					CHAR(3)					DEFAULT '3',
	push_condition					CHAR(3)					DEFAULT '0',
	join_club_count					NUMBER(20)				DEFAULT	'0',
	join_club_limit					NUMBER(20)				DEFAULT	'2',
	sns_user_id						VARCHAR2(50),
	PRIMARY	KEY(user_id)
);



CREATE TABLE club (
	club_no							NUMBER												NOT NULL,
	user_id							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	club_title						VARCHAR2(100)										NOT NULL,
	club_detail						VARCHAR2(500)										NOT NULL,
	club_reg_date					DATE,
	current_member					NUMBER(20)				DEFAULT 1,
	club_max_member					NUMBER(20)				DEFAULT 10,
	club_category					VARCHAR2(500)										NOT NULL,
	club_area						VARCHAR2(500)										NOT NULL,
	club_image         				VARCHAR2(500)          								NOT NULL,
	roomId							VARCHAR2(500),
	PRIMARY KEY(club_no)
);



CREATE TABLE club_user (
	club_user_no					NUMBER												NOT NULL,
	user_id							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	club_no							NUMBER(20)											NOT NULL	REFERENCES club(club_no),
	application_reg_date			DATE,
	join_reg_date					DATE,
	logout_date						DATE,
	member_role						CHAR(3),
	approval_condition				CHAR(3),	
	join_greeting					VARCHAR2(500)										NOT NULL,
	roomId							VARCHAR2(500),
	PRIMARY KEY(club_user_no)
);



CREATE TABLE meeting (
	meeting_no						NUMBER												NOT NULL,
	club_no							NUMBER												NOT NULL	REFERENCES club(club_no),
	add_meeting_user_id				VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	meeting_title					VARCHAR2(40)										NOT NULL,
	meeting_content					VARCHAR2(500)										NOT NULL,
	meeting_date					VARCHAR2(500),
	meeting_place					VARCHAR2(500)										NOT NULL,
	meeting_time					VARCHAR2(500),
	meeting_weather					VARCHAR2(100)										NOT NULL,
	meeting_reg_date				DATE,
	meeting_member					NUMBER(20)											NOT NULL,
	meeting_maximum_member			NUMBER(20)											NOT NULL,
	PRIMARY KEY(meeting_no)
);



CREATE TABLE participant (
	participant_no					NUMBER												NOT NULL,
	meeting_no						NUMBER												NOT NULL	REFERENCES meeting(meeting_no),
	participant_user_id				VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	PRIMARY KEY(participant_no)
);



CREATE TABLE CLUB_POST (
	CLUB_POST_NO					NUMBER(20)											NOT NULL,
	CLUB_NO							NUMBER(20)											NOT NULL	REFERENCES club(club_no),
	USER_ID							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	CLUB_POST_TITLE					VARCHAR2(100)										NOT NULL,
	CLUB_POST_CONTENT				VARCHAR2(1000),
	CLUB_POST_VIDEO1				VARCHAR2(100),
	CLUB_POST_VIDEO2				VARCHAR2(100),
	CLUB_POST_VIDEO3				VARCHAR2(100),
	CLUB_POST_REG_DATE				DATE												NOT NULL,
	CLUB_POST_COMMENT_COUNT			NUMBER(20)				DEFAULT 0					NOT NULL,
	IMAGE1							VARCHAR2(100)										NOT NULL,
	IMAGE2							VARCHAR2(100),
	IMAGE3							VARCHAR2(100),
	IMAGE4							VARCHAR2(100),
	IMAGE5							VARCHAR2(100),
	IMAGE6							VARCHAR2(100),
	IMAGE7							VARCHAR2(100),
	IMAGE8							VARCHAR2(100),
	IMAGE9							VARCHAR2(100),
	IMAGE10							VARCHAR2(100),
	CLUB_POST_UPDATE_DATE			DATE,
	REPORT_CONDITION				CHAR(3)					DEFAULT 0					NOT NULL,
	DELETE_CONDITION				CHAR(3)					DEFAULT 0					NOT NULL,
	DELETE_USER_ID					VARCHAR2(20)													REFERENCES users(user_id),
	DELETE_NAME						VARCHAR2(20),
	CLUB_POST_HEART_COUNT			NUMBER(20)				DEFAULT 0					NOT NULL,
	PRIMARY KEY(club_post_no)
);



CREATE TABLE CLUB_POST_COMMENT (
	CLUB_POST_COMMENT_NO			NUMBER(20)											NOT NULL,
	CLUB_POST_NO					NUMBER(20)											NOT NULL	REFERENCES club_post(club_post_no),
	USER_ID							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	COMMENT_CONTENT					VARCHAR(300)										NOT NULL,
	COMMENT_REG_DATE				DATE,
	COMMENT_UPDATE_DATE				DATE,
	REPORT_CONDITION				CHAR(3)					DEFAULT '0'					NOT NULL,
	DELETE_CONDITION				CHAR(3)					DEFAULT '0'					NOT NULL,
	PARENT							NUMBER(20)											NOT NULL,
	DEPTH							NUMBER(20)											NOT NULL,
	SEQUENCE						NUMBER(20)											NOT NULL,
	DELETE_USER_ID					VARCHAR2(20)													REFERENCES users(user_id),
	DELETE_NAME						VARCHAR2(20),
	COMMENT_HEART_COUNT				NUMBER(20)				DEFAULT 0					NOT NULL,
	COMMENT_COUNT					NUMBER(20)				DEFAULT 0					NOT NULL,
	PRIMARY KEY(club_post_comment_no)
);



CREATE TABLE PAY (
	PAY_NO							NUMBER(20)											NOT NULL,
	USER_ID							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	CLUB_NO							NUMBER(20)											NOT NULL,
	PAY_PRODUCT						VARCHAR2(100)										NOT NULL,
	PAY_OPTION						VARCHAR2(100)										NOT NULL,
	TOTAL_PRICE						NUMBER(20)											NOT NULL,
	PAY_REG_DATE					DATE												NOT NULL,
	UPDATE_CLUB_COUNT				NUMBER(20),
	UPDATE_CLUB_MEMBER_COUNT		NUMBER(20),
	MERCHANT_UID					VARCHAR2(100)										NOT NULL,
	PRIMARY KEY(pay_no)
);


CREATE TABLE FEED (
   feed_no                     NUMBER                                    NOT NULL,
   user_id                     VARCHAR2(20)                              NOT NULL   REFERENCES users(user_id),
   feed_open_condition            CHAR(3)                                    NOT NULL,
   feed_full_content            VARCHAR2(1680),
   feed_content               VARCHAR2(840),
   feed_image1                  VARCHAR2(100),
   feed_image2                  VARCHAR2(100),
   feed_image3                  VARCHAR2(100),
   feed_image4                  VARCHAR2(100),
   feed_video                  VARCHAR2(100),
   hashtag                     VARCHAR2(840),
   feed_heart_count            NUMBER                                    NOT NULL,
   feed_comment_count            NUMBER                                    NOT NULL,
   feed_reg_date               DATE                                    NOT NULL,
   feed_update_date            DATE,
   report_condition            CHAR(3)                                    NOT NULL,
   delete_condition            CHAR(3)                                    NOT NULL,
   PRIMARY KEY(feed_no)
);


CREATE TABLE feed_comment (
   feed_comment_no               NUMBER                                    NOT NULL,
   feed_no                     NUMBER                                    NOT NULL,
   user_id                     VARCHAR2(20)                              NOT NULL   REFERENCES users(user_id),
   feed_comment_content         VARCHAR2(210)                              NOT NULL,
   feed_comment_heart_count      NUMBER                                    NOT NULL,
   feed_recomment_count         NUMBER                                    NOT NULL,
   feed_comment_reg_date         DATE                                    NOT NULL,
   feed_comment_update_date      DATE,
   report_condition            CHAR(3)                                    NOT NULL,
   delete_condition            CHAR(3)                                    NOT NULL,
   delete_user_id               VARCHAR2(20)                                       REFERENCES users(user_id),
   parent                     NUMBER                                    NOT NULL,
   depth                     NUMBER                                    NOT NULL,
   sequence                  NUMBER                                    NOT NULL,
   PRIMARY KEY(feed_comment_no)
);



CREATE TABLE heart(
	heart_no						NUMBER												NOT NULL,
	user_id							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	source							CHAR(3)												NOT NULL,
	source_no						NUMBER												NOT NULL
);



CREATE TABLE NOTICE (
	notice_no						NUMBER(20)											NOT NULL,
	notice_title					VARCHAR2(200)										NOT NULL,
	notice_content					VARCHAR2(2000)										NOT NULL,
	notice_image1					VARCHAR(100),
	notice_image2					VARCHAR(100),
	notice_regdate					DATE												NOT NULL,
	NOTICE_COUNT					NUMBER(10)											NOT NULL,
	user_id							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	PRIMARY KEY(notice_no)
);



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


CREATE TABLE REPORT_PUSH (
	NO								NUMBER(20)											NOT NULL,
	CONTENT							VARCHAR2(2000)										NOT NULL,
	REPORT_SOURCE 					CHAR(3)												NOT NULL,
	CLUB_POST_NO					NUMBER(20)														REFERENCES club_post(club_post_no),
	CLUB_POST_COMMENT_NO			NUMBER(20)														REFERENCES club_post_comment(club_post_comment_no),
	CHAT_NO							NUMBER(20),
	FEED_NO							NUMBER(20)														REFERENCES feed(feed_no),
	FEED_COMMENT_NO					NUMBER(20)														REFERENCES feed_comment(feed_comment_no),
	LIVE_NO							NUMBER(20),
	USER_ID1						VARCHAR2(20)													REFERENCES users(user_id),
	USER_ID2						VARCHAR2(20),
	REPORT_REGDATE					DATE												NOT NULL,
	REPORT_IMAGE1					VARCHAR2(100),
	REPORT_IMAGE2					VARCHAR2(100),
	TYPE							CHAR(3)												NOT NULL,
	REPORT_REASON					CHAR(3),
	REPORT_CONDITION				CHAR(3)					DEFAULT '0'					NOT NULL,
	TITLE							VARCHAR2(200),
	CLUB_NO							NUMBER(20)														REFERENCES club(club_no),
	READING_STATUS   				CHAR(1)					DEFAULT '0',
	PRIMARY KEY(NO)
);



CREATE TABLE FOLLOW_BLOCK(
	NO								NUMBER(20)											NOT NULL ,
	SEND_USER_ID					VARCHAR(20)											NOT NULL	REFERENCES users(USER_ID), 
	RECV_USER_ID					VARCHAR(20)											NOT NULL	REFERENCES users(USER_ID),
	STATE							CHAR(3)					DEFAULT '0',
	TYPE							CHAR(3)					DEFAULT '0',
	PRIMARY KEY(NO)
);



CREATE TABLE LIVE(
	LIVE_NO							NUMBER(20),
	ROOMID							VARCHAR2(100),
	MEMBER							NUMBER(20),
	LIMIT							NUMBER(20),
	PROFILE_IMAGE					VARCHAR2(100),
	TYPE							CHAR(1),
	CLUB_NO							NUMBER(20),
	PRIMARY KEY(LIVE_NO)
);



CREATE TABLE CHAT(
	CHAT_NO							NUMBER(20)											NOT NULL,
	USER_ID							VARCHAR2(20)										NOT NULL	REFERENCES users(USER_ID),
	ROOMID							VARCHAR2(500)										NOT NULL,
	USER_ID2						VARCHAR2(20)										NOT NULL	REFERENCES users(USER_ID),
	PRIMARY KEY(CHAT_NO)
);



commit;











