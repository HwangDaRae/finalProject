SELECT * FROM USERS;
SELECT * FROM CLUB;
SELECT * FROM CLUB_USER;
SELECT * FROM MEETING;
SELECT * FROM PARTICIPANT;
SELECT * FROM CLUB_POST;
SELECT * FROM CLUB_POST_COMMENT;
SELECT * FROM CHAT;
SELECT * FROM CLUB_CHAT;
SELECT * FROM FEED;
SELECT * FROM FEED_COMMENT;
SELECT * FROM HEART;
SELECT * FROM PAY;
SELECT * FROM NOTICE;
SELECT * FROM QANDA;
SELECT * FROM REPORT_PUSH;
SELECT * FROM FOLLOW_BLOCK;
SELECT * FROM LIVE;
SELECT * FROM LIVE_CHAT;
SELECT * FROM VIEWER;





ALTER TABLE REPORT_PUSH ADD PARENT CAHR(3) DEFAULT '0' NOT NULL;
ALTER TABLE REPORT_PUSH DROP COLUMN REPORT_REASON;





















INSERT INTO USERS (user_id, password, name, rrn, gender, phone_no, email, role, nickname, profile_image, profile_writing, 
	area1, area2, area3, category1, category2, category3, add_user_date)
VALUES	('admin1', 'q123123', '관리자', '111111-0000000', '남자', '010-1111-3333', 'admin@hotmail.com', '1', '관리자', 'admin.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO USERS (user_id, password, name, rrn, gender, phone_no, email, role, nickname, profile_image, profile_writing, 
	area1, area2, area3, category1, category2, category3, add_user_date)
VALUES	('user01', '1234', '홍길동', '1111110000000', '남자', '01011113333', 'USER01@hotmail.com', '0', '회원', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO USERS (user_id, password, name, rrn, gender, phone_no, email, role, nickname, profile_image, profile_writing, 
	area1, area2, area3, category1, category2, category3, add_user_date)
VALUES	('user02', '1234', '홍길순', '1111110000000', '남자', '01011113333', 'USER02@hotmail.com', '0', '회원', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO USERS (user_id, password, name, rrn, gender, phone_no, email, role, nickname, profile_image, profile_writing, 
	area1, area2, area3, category1, category2, category3, add_user_date)
VALUES	('user03', '1234', '박보영', '1111110000000', '남자', '01011113333', 'USER03@hotmail.com', '0', '회원', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO USERS (user_id, password, name, rrn, gender, phone_no, email, role, nickname, profile_image, profile_writing, 
	area1, area2, area3, category1, category2, category3, add_user_date)
VALUES	('user04', '1234', '박수현', '1111110000000', '남자', '01011113333', 'USER04@hotmail.com', '0', '회원', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SYSDATE);

INSERT INTO USERS (user_id, password, name, rrn, gender, phone_no, email, role, nickname, profile_image, profile_writing, 
	area1, area2, area3, category1, category2, category3, add_user_date)
VALUES	('user05', '1234', '박상기', '1111110000000', '남자', '01011113333', 'USER05@hotmail.com', '0', '회원', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SYSDATE);

















INSERT INTO CLUB (CLUB_NO, USER_ID, CLUB_TITLE, CLUB_DETAIL, CLUB_REG_DATE, CURRENT_MEMBER, CLUB_MAX_MEMBER, 
CLUB_CATEGORY, CLUB_AREA, CLUB_IMAGE) VALUES (2, 'user03', 'CLUB1TITLE', 'CLUB1DETAIL', sysdate, 1, 10, '운동', '서울시 동작구', 'heart.jpg');

INSERT INTO club (club_no, user_id, club_title, club_detail, club_reg_date, current_member, club_max_member, club_category, club_area, club_image)
VALUES (seq_club_no.nextval, 'user01', 'testClub', 'testDetail', sysdate, 1, 10, '봉사활동', '서울시 강남구', 'b.jpg');




















INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 1, 'user333', 'clubposttitle1',
null, null, null, null, sysdate, 0, 0, 'a.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', 'clubposttitle2',
null, null, null, null, sysdate, 0, 0, 'a.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user04', 'clubposttitle3',
null, null, null, null, sysdate, 0, 0, 'a.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user05', 'clubposttitle4',
null, null, null, null, sysdate, 0, 0, 'a.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user05', 'clubposttitle5',
null, null, null, null, sysdate, 0, 0, 'a.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', 'clubposttitle6',
null, null, null, null, sysdate, 0, 0, 'a.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user02', 'clubposttitle7',
null, null, null, null, sysdate, 0, 0, 'a.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user02', 'clubposttitle8',
null, null, null, null, sysdate, 0, 0, 'a.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user02', 'clubposttitle9',
null, null, null, null, sysdate, 0, 0, 'a.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', '제목이다1',
'내용이다1', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user01', '제목이다2',
'내용이다2', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user01', '제목이다3',
'내용이다3', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user01', '제목이다4',
'내용이다4', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user01', '제목이다5',
'내용이다5', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user01', '제목이다6',
'내용이다6', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', '제목이다7',
'내용이다7', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user01', '제목이다8',
'내용이다8', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user02', '제목이다9',
'내용이다9', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', '제목이다10',
'내용이다10', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', '제목이다11',
'내용이다11', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', '제목이다12',
'내용이다12', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', '제목이다13',
'내용이다13', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', '제목이다14',
'내용이다14', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', '제목이다15',
'내용이다15', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);

INSERT INTO CLUB_POST (CLUB_POST_NO, CLUB_NO, USER_ID, CLUB_POST_TITLE, CLUB_POST_CONTENT, CLUB_POST_VIDEO1, CLUB_POST_VIDEO2, 
CLUB_POST_VIDEO3, CLUB_POST_REG_DATE, CLUB_POST_HEART_COUNT, CLUB_POST_COMMENT_COUNT, IMAGE1, IMAGE2, IMAGE3, IMAGE4, 
IMAGE5, IMAGE6, IMAGE7, IMAGE8, IMAGE9, IMAGE10) VALUES (seq_club_post_no.NEXTVAL, 2, 'user03', '제목이다16',
'내용이다16', null, null, null, sysdate, 0, 0, 'flower.jpg', null, null, null, null, null, null, null, null, null);









INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT,UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (seq_pay_no.NEXTVAL, 'user02', 2, 0, 0, 10000, SYSDATE, 4, 0, 0);
INSERT INTO PAY (PAY_NO, USER_ID, CLUB_NO, PAY_PRODUCT, PAY_OPTION, TOTAL_PRICE, PAY_REG_DATE, UPDATE_CLUB_COUNT,UPDATE_CLUB_MEMBER_COUNT, MERCHANT_UID)
VALUES (seq_pay_no.NEXTVAL, 'user02', 2, 1, 0, 10000, SYSDATE, 0, 20, 0);









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








INSERT INTO CLUB_POST_COMMENT (CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_HEART_COUNT, COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE)
VALUES (seq_club_post_comment_no.NEXTVAL, 74, 'user01', '댓글내용1 입니다', sysdate, null, 0, 0, '0', '0', '74', 0, 0);
INSERT INTO CLUB_POST_COMMENT (CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_HEART_COUNT, COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE)
VALUES (seq_club_post_comment_no.NEXTVAL, 74, 'user03', '댓글내용2 입니다', sysdate, null, 0, 1, '0', '0', '74', 0, 1);
INSERT INTO CLUB_POST_COMMENT (CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_HEART_COUNT, COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE)
VALUES (seq_club_post_comment_no.NEXTVAL, 74, 'user15', '댓글내용3 입니다', sysdate, null, 0, 0, '0', '0', '20', 1, 0);
INSERT INTO CLUB_POST_COMMENT (CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_HEART_COUNT, COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE)
VALUES (seq_club_post_comment_no.NEXTVAL, 74, 'user04', '댓글내용4 입니다', sysdate, null, 0, 5, '0', '0', '74', 0, 2);
INSERT INTO CLUB_POST_COMMENT (CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_HEART_COUNT, COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE)
VALUES (seq_club_post_comment_no.NEXTVAL, 74, 'user03', '댓글내용5 입니다', sysdate, null, 0, 2, '0', '0', '22', 1, 0);
INSERT INTO CLUB_POST_COMMENT (CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_HEART_COUNT, COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE)
VALUES (seq_club_post_comment_no.NEXTVAL, 74, 'user01', '댓글내용6 입니다', sysdate, null, 0, 0, '0', '0', '22', 1, 1);
INSERT INTO CLUB_POST_COMMENT (CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_HEART_COUNT, COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE)
VALUES (seq_club_post_comment_no.NEXTVAL, 74, 'user03', '댓글내용7 입니다', sysdate, null, 0, 0, '0', '0', '23', 2, 0);
INSERT INTO CLUB_POST_COMMENT (CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_HEART_COUNT, COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE)
VALUES (seq_club_post_comment_no.NEXTVAL, 74, 'user05', '댓글내용8 입니다', sysdate, null, 0, 0, '0', '0', '23', 2, 1);
INSERT INTO CLUB_POST_COMMENT (CLUB_POST_COMMENT_NO, CLUB_POST_NO, USER_ID, COMMENT_CONTENT, COMMENT_REG_DATE, COMMENT_UPDATE_DATE, COMMENT_HEART_COUNT, COMMENT_COUNT, REPORT_CONDITION, DELETE_CONDITION, PARENT, DEPTH, SEQUENCE)
VALUES (seq_club_post_comment_no.NEXTVAL, 74, 'user04', '댓글내용9 입니다', sysdate, null, 0, 0, '0', '0', '22', 1, 2);

UPDATE CLUB_POST SET CLUB_POST_COMMENT_COUNT = 9 WHERE CLUB_POST_NO = 74;

SELECT * FROM CLUB_POST_COMMENT WHERE CLUB_POST_NO = 74 ORDER BY COMMENT_REG_DATE ASC;









commit;

