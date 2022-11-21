
DROP TABLE FEED 					CASCADE CONSTRAINTS;
DROP TABLE FEED_COMMENT				CASCADE CONSTRAINTS;
SELECT * FROM users

DROP SEQUENCE seq_feed_no;
DROP SEQUENCE seq_feed_comment_no;


CREATE SEQUENCE seq_feed_no						INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE seq_feed_comment_no				INCREMENT BY 1 START WITH 1;


CREATE TABLE FEED (
	feed_no							NUMBER												NOT NULL,
	user_id							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	feed_open_condition				CHAR(3)												NOT NULL,
	feed_full_content				VARCHAR2(1680),
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



INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user01', '3', '첫글입니다#first', 'a.jpg', 'b.jpg', 'c.jpg', 'd.jpg', null, '#first', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user02', '3', '두번째글입니다#second', 'profile_image2clubPost.jpg', 'no_heart.jpg', 'user03flower11clubPost.jpg', null, null, '#second', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user03', '3', '세번째글입니다#third', 'heart.jpg', 'user005_User_2022-10-15_cccc.jpg', 'user03flower17clubPost.jpg', null, null, '#third', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user04', '3', '네번째글입니다#fourth', 'user03_User_2022-10-16_333.jpg', 'user03flower14clubPost.jpg','profile_image1clubPost.jpg', null, null, '#fourth', '0', '0', SYSDATE, null, '0', '0' );
INSERT INTO feed VALUES ( seq_feed_no.nextval, 'user05', '3', '다섯번째글입니다#fifth', 'q&a.jpg', '2018090516093218827_4.jpg', 'user03flower20clubPost.jpg', null, null, '#fifth', '3', '5', SYSDATE, null, '0', '0' );

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

SELECT * FROM FEED WHERE feed_no = 89 ORDER BY feed_no DESC;

SELECT * FROM FEED_COMMENT ORDER BY sequence ASC;

SELECT * FROM FEED_COMMENT WHERE feed_no = 89 ORDER BY sequence ASC;

SELECT * FROM HEART;


SELECT * FROM USERS;



INSERT INTO USERS (user_id, password, name, rrn, gender, phone_no, email, role, nickname, profile_image, profile_writing, 
	area1, area2, area3, category1, category2, category3, add_user_date)
VALUES	('user05', '1234', '박상기', '1111110000000', '남자', '01011113333', 'USER05@hotmail.com', '0', '회원', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, SYSDATE);

SELECT * FROM REPORT_PUSH


======================================================================================================================================

DROP TABLE HEART					CASCADE CONSTRAINTS;
DROP SEQUENCE seq_heart_no;
CREATE SEQUENCE seq_heart_no					INCREMENT BY 1 START WITH 1;


CREATE TABLE heart(
	heart_no						NUMBER												NOT NULL,
	user_id							VARCHAR2(20)										NOT NULL	REFERENCES users(user_id),
	source							CHAR(3)												NOT NULL,
	source_no						NUMBER												NOT NULL
);

======================================================================================================================================




DROP TABLE FEED_COMMENT				CASCADE CONSTRAINTS;
DROP SEQUENCE seq_feed_comment_no;
CREATE SEQUENCE seq_feed_comment_no				INCREMENT BY 1 START WITH 1;

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

INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user01', 'first', '5', '0', SYSDATE, null, '0', '0', null,'0', '0', '0');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user02', 'second', '0', '0', SYSDATE, null, '0', '0', null,'0', '0', '1');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user03', 'third', '0', '0', SYSDATE, null, '0', '0', null,'0', '0', '2');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user04', 'fourth', '0', '0', SYSDATE, null, '0', '0', null,'0', '0', '3');
INSERT INTO feed_comment VALUES ( seq_feed_comment_no.nextval, '5', 'user05', 'fifit', '0', '0', SYSDATE, null, '0', '0', null,'0', '0', '4');







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

SELECT * FROM heart

SELECT * FROM feed

SELECT
COUNT(*)
FROM FEED_COMMENT
WHERE feed_no	= 18
AND parent		= 101 


SELECT * FROM FEED_COMMENT WHERE FEED_NO = 136 ORDER BY feed_comment_no desc
SELECT * FROM USERS

SELECT * FROM REPORT_PUSH WHERE TYPE = 2 ORDER BY NO DESC
SELECT
		*
		FROM	(	SELECT
					*
					FROM FEED
					ORDER BY feed_no DESC)
		WHERE ROWNUM = 1



TYPE - 2가 알림

SELECT
		*
		FROM	(	SELECT
					*
					FROM FEED_COMMENT
					ORDER BY feed_comment_no DESC)
		WHERE ROWNUM = 1


SELECT 
f.feed_no, f.user_id, u.nickName, u.profile_image, f.feed_open_condition, f.feed_full_content, f.feed_content, 
f.feed_image1, f.feed_image2, f.feed_image3, f.feed_image4, f.feed_video, f.hashtag, f.feed_heart_count, f.feed_comment_count, 
f.feed_reg_date, f.feed_update_date, f.report_condition, f.delete_condition, isLike.EXIST 

FROM users u, feed f, (
							SELECT
							source_no as EXIST
							FROM HEART
							WHERE TRIM(source)		= '0'
							AND user_id				= 'user05'
																		) isLike

SELECT * FROM REPORT_PUSH rp WHERE TYPE = 2 AND feed_no IS NOT NULL OR club_post_no is NOT NULL AND rp.user_id1 IN ( SELECT recv_user_id AS NAME FROM FOLLOW_BLOCK WHERE send_user_id = 'user05' AND STATE = '1' AND TYPE = '1' )










SELECT inner_table.* FROM ( SELECT rownum AS row_seq , deep_table.* FROM ( SELECT f.send_user_Id , f.recv_user_id, f.state, f.type, u.nickname , u.profile_image FROM users u, follow_block f WHERE u.user_id = f.recv_user_id and f.send_user_id = 'user05' and f.type='1' and f.state='1' ) deep_table ) inner_table 




SELECT * FROM FEED_COMMENT WHERE FEED_NO = 142




SELECT feed_comment_no, feed_no, user_id, feed_comment_content, feed_comment_heart_count, feed_recomment_count, feed_comment_reg_date, feed_comment_update_date, report_condition, delete_condition, parent, depth, sequence FROM feed_comment WHERE feed_no = 142 AND sequence = 8


SELECT * FROM feed;
SELECT * FROM report_push;

SELECT
*
FROM FOLLOW_BLOCK
WHERE send_user_id = 'user05'
AND STATE = '1'
AND TYPE = '1'











SELECT
*
FROM (
	SELECT
	*
	FROM	(
				SELECT 
				f.feed_no, f.user_id, u.nickName, u.profile_image, 
				f.feed_open_condition, f.feed_full_content, f.feed_content, 
				f.feed_image1, f.feed_image2, f.feed_image3, f.feed_image4,
				f.feed_video, f.hashtag, f.feed_heart_count, f.feed_comment_count, 
				f.feed_reg_date, f.feed_update_date, f.report_condition, 
				f.delete_condition , isLike.EXIST FROM users u, feed f, (
																			SELECT
																			source_no as EXIST
																			FROM HEART
																			WHERE TRIM(source)		= '0'
																			AND user_id				= 'Link4813'
																												) isLike
				WHERE u.user_id = f.user_id
				AND f.feed_no = isLike.EXIST(+)
				AND f.feed_open_condition	=	'3'
				AND f.report_condition		=	'0'
				AND f.delete_condition		=	'0'
				ORDER BY feed_no DESC	) ff, (
												SELECT
												SUBSTR(XMLAGG(XMLELEMENT(X, ',', recv_user_id) ORDER BY recv_user_id).EXTRACT('//text()'), 2) AS NAME
												FROM FOLLOW_BLOCK
												WHERE send_user_id = 'Link4813'
												AND STATE = '1'
												AND TYPE = '2'
																) fb )

															
															
															
			SELECT f.send_user_Id , f.recv_user_id, f.state, f.type, u.nickname , u.profile_image FROM users u, follow_block f WHERE u.user_id = f.recv_user_id and f.send_user_id = 'meptael' and f.recv_user_id = 'garam113'												
		


SELECT
*
FROM	(
			SELECT 
			f.feed_no, f.user_id, u.nickName, u.profile_image, 
			f.feed_open_condition, f.feed_full_content, f.feed_content, 
			f.feed_image1, f.feed_image2, f.feed_image3, f.feed_image4,
			f.feed_video, f.hashtag, f.feed_heart_count, f.feed_comment_count, 
			f.feed_reg_date, f.feed_update_date, f.report_condition, 
			f.delete_condition , isLike.EXIST FROM users u, feed f, (
																		SELECT
																		source_no as EXIST
																		FROM HEART
																		WHERE TRIM(source)		= '0'
																		AND user_id				= 'Link4813'
																											) isLike
			WHERE u.user_id = f.user_id
			AND f.feed_no = isLike.EXIST(+)
			AND f.feed_open_condition	=	'3'
			AND f.report_condition		=	'0'
			AND f.delete_condition		=	'0'
			ORDER BY feed_no DESC	) ff
WHERE TRIM(user_id) NOT IN (
											SELECT
											SUBSTR(XMLAGG(XMLELEMENT(X, ' ', recv_user_id) ORDER BY recv_user_id).EXTRACT('//text()'), 2) AS NAME
											FROM FOLLOW_BLOCK
											WHERE send_user_id = 'Link4813'
											AND STATE = '1'
											AND TYPE = '2'
															)						
															
															
															
						


SELECT
*
FROM	(
			SELECT 
			f.feed_no, f.user_id, u.nickName, u.profile_image, 
			f.feed_open_condition, f.feed_full_content, f.feed_content, 
			f.feed_image1, f.feed_image2, f.feed_image3, f.feed_image4,
			f.feed_video, f.hashtag, f.feed_heart_count, f.feed_comment_count, 
			f.feed_reg_date, f.feed_update_date, f.report_condition, 
			f.delete_condition , isLike.EXIST FROM users u, feed f, (
																		SELECT
																		source_no as EXIST
																		FROM HEART
																		WHERE TRIM(source)		= '0'
																		AND user_id				= 'Link4813'
																											) isLike
			WHERE u.user_id = f.user_id
			AND f.feed_no = isLike.EXIST(+)
			AND f.feed_open_condition	=	'3'
			AND f.report_condition		=	'0'
			AND f.delete_condition		=	'0'
			ORDER BY feed_no DESC	) ff
WHERE TRIM(user_id) NOT IN (
											SELECT
											recv_user_id AS NAME
											FROM FOLLOW_BLOCK
											WHERE send_user_id = 'Link4813'
											AND STATE = '1'
											AND TYPE = '2'
															)						
															
															
SELECT * FROM club_Post
															
SELECT f.send_user_Id , f.recv_user_id, f.state, f.type, u.nickname , u.profile_image FROM users u, follow_block f WHERE u.user_id = f.recv_user_id and f.send_user_id = 'meptael' and f.recv_user_id = 'garam113'											
															
															
									SELECT    
	rownum AS row_seq,    
	deep_table.*    
	FROM (      
		SELECT    f.feed_reg_date, f.feed_update_date, f.report_condition, f.delete_condition               , isLike.EXIST 
		FROM users u, feed f, (                
					SELECT                
					source_no as EXIST                
					FROM HEART                
					WHERE TRIM(source)  = '0'                
					AND user_id    = 'Link4813'                           ) isLike         
		WHERE u.user_id = f.user_id        
		AND f.feed_no = isLike.EXIST(+)        
		AND f.feed_open_condition = '3'        
		AND f.report_condition  = '0'        
		AND f.delete_condition  = '0'                                           
		ORDER BY feed_no DESC  ) deep_table 						
															
															
															
															
															SELECT
XMLELEMENT(A, recv_user_id)
FROM FOLLOW_BLOCKㄴㅁㅇㅁㄴㅇㅁㅇㅁㄴㅇ




SELECT
SUBSTR(XMLAGG(XMLELEMENT(X, ',', recv_user_id) ORDER BY recv_user_id).EXTRACT('//text()'), 2) AS NAME
FROM FOLLOW_BLOCK
WHERE send_user_id = 'Link4813'







SELECT
*
FROM follow_block f




SELECT
uf.user_id,
deepInner.*
FROM users uf, (
					SELECT
					us.user_id,
					us.nickname,
					us.profile_image,
					NVL(innerTable.type, 1) AS TYPE,
					NVL(innerTable.state, 2) AS STATE
					FROM (
									SELECT f.send_user_Id , f.recv_user_id, f.state, f.type, u.nickname , u.profile_image 
									FROM users u, follow_block f 
									WHERE u.user_id = f.recv_user_id 
									and f.send_user_id = 'meptael' and f.recv_user_id = 'garam113'	) innerTable, users us
					WHERE us.user_id = 'garam113'
					and us.user_id = innerTable.recv_user_id (+)
																	) deepInner
where uf.user_id = 'meptael'


SELECT uf.user_id AS SEND_USER_ID, deepInner.* FROM users uf, ( SELECT us.user_id AS RECV_USER_ID, us.nickname, us.profile_image, NVL(innerTable.type, 1) AS TYPE, NVL(innerTable.state, 2) AS STATE FROM ( SELECT f.send_user_Id , f.recv_user_id, f.state, f.type, u.nickname , u.profile_image FROM users u, follow_block f WHERE u.user_id = f.recv_user_id and f.send_user_id = 'meptael'  and f.recv_user_id ='shinLee' ) innerTable, users us WHERE us.user_id = 'shinLee' and us.user_id = innerTable.recv_user_id (+) ) deepInner where uf.user_id = 'meptael' 



DELETE FROM FOLLOW_BLOCK where send_user_id = 'metael'
DELETE FROM heart where user_id = 'meptael'

SELECT * FROM follow_block where send_user_id = 'apayo'

DELETE from heart

SELECT * FROM FEED_COMMENT;
SELECT * FROM report_push;


DELETE FROM report_push where no = 168
DELETE FROM report_push where no = 167
DELETE FROM report_push where no = 166
DELETE FROM report_push where no = 165
DELETE FROM report_push where no = 164
DELETE FROM report_push where no = 163
DELETE FROM report_push where no = 158

SELECT f.feed_no, f.user_id, u.profile_image, u.nickName , f.feed_open_condition, f.feed_full_content, f.feed_content, f.feed_image1, f.feed_image2, f.feed_image3, f.feed_image4, f.feed_video, f.hashtag, f.feed_heart_count, f.feed_comment_count, TO_CHAR(f.feed_reg_date, 'YYYY-MM-DD HH24:MI:SS') as feed_reg_date, f.feed_update_date, f.report_condition, f.delete_condition , isLike.EXIST FROM feed f, users u, ( SELECT source_no as EXIST FROM HEART WHERE TRIM(source) = '0' AND user_id = 'meptael' ) isLike WHERE f.feed_no = isLike.EXIST(+) AND f.user_id = u.user_id AND f.feed_no = 17 
SELECT * FROM users

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

