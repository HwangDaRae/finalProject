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
select * from club_Post;
SELECT
	 	inner_table.* 
	 	FROM (
	 			SELECT
	 			rownum AS row_seq						, 
	 			deep_table.*
	 			FROM (
	 					SELECT
	 					f.send_user_Id   , 
	 					f.recv_user_id, 
	 					f.state, 
	 					f.type, 
	 					u.nickname  , 
	 					u.profile_image
	 					
	 					
	 					
	 					 
	 					FROM users u, follow_block f
	 					where u.user_id = f.send_user_id
	 					) deep_table
	 					) inner_table;
	 					
SELECT
	 	inner_table.* 
	 	FROM (
	 			SELECT
	 			rownum AS row_seq						, 
	 			deep_table.*
	 			FROM (
	 					SELECT
	 					f.send_user_Id   , 
	 					f.recv_user_id, 
	 					f.state, 
	 					f.type, 
	 					u.nickname  , 
	 					u.profile_image
	 					
	 					
	 					
	 					 
	 					FROM users u, follow_block f
	 					where u.user_id = f.send_user_id and f.recv_user_id = 'user555'
	 					) deep_table
	 					) inner_table;
	 						 					
DELETE FROM Follow_Block
     WHERE send_user_id = recv_user_id;	 					
	 					
	 					
SELECT
		f.send_user_Id ,
		f.recv_user_id,
		f.state,
		f.type,
		u.nickname ,
		u.profile_image




		FROM users u, follow_block f

		WHERE	u.user_id = f.recv_user_id
				and f.send_user_id = 'user03' and f.recv_user_id
				='user01' and f.type = '2';