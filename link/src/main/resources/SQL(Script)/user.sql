SELECT user_id, password, name, gender, rrn, phone_no, email, role, nickname, 
					profile_image, profile_writing, area1, area2, area3, category1, category2, 
					category3, penalty_type,  report_count, stop_start_date, stop_end_date,
					out_user_state, out_user_date, add_user_type, logout_date, add_user_date,
					total_visit_count, open_condition, push_condition, join_club_count, join_club_limit, sns_user_id
FROM users;
WHERE sns_user_id = 'bymin1992@naver.com' and add_user_type = '1';

DELETE users
WHERE phone_no = 'admin01';

DELETE users
WHERE user_id = 'gkgk4915';

INSERT
INTO users (user_id, add_user_type ,add_user_date)
VALUES ('user06', '1', SYSDATE);

INSERT 
INTO users (user_id, password, name, rrn, gender, phone_no, email, nickname, profile_writing, 
	area1, area2, area3, category1, category2, category3, add_user_date)
VALUES	('admin01', '1234', '박경수', 123456-0234567, '여자', 010-3333-6666, 'bitcamp@bitcamp.com', '나락', NULL, NULL, NULL, NULL, NULL, NULL, NULL, SYSDATE);
 
UPDATE users
SET role='1'
WHERE user_id = 'admin01';

UPDATE users
SET password= ''
WHERE user_id = '';

UPDATE users
SET out_user_state = '0'
WHERE user_id = 'gkgk4915';

UPDATE users
SET out_user_date = SYSDATE
WHERE user_id = 'user01';

UPDATE users
SET phone_no = '010-2222-5555'
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
SET stop_start_date = '2022-10-01', stop_end_date = '2022-10-12'
WHERE user_id = 'user001';

UPDATE users
SET penalty_type = '0'
WHERE user_id = 'user555';

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

UPDATE users
SET rrn = 9001212054211
WHERE user_id = 'user03';




SELECT user_id , password , name , gender, rrn, phone_no , email, role, nickname , profile_image,
profile_writing, area1, area2, area3, category1, category2, category3, penalty_type, report_count,
stop_start_date, stop_end_date, out_user_state, out_user_date, add_user_type, logout_date, add_user_date,
total_visit_count, open_condition, push_condition, join_club_count, join_club_limit, sns_user_Id
FROM users WHERE name = '방진수' and rrn = '9212101001005'

SELECT *
	  	FROM (	
	  			SELECT
	  			inner_table.* 				,
	  			ROWNUM 			AS row_seq	
	  			FROM		(SELECT
								user_id		, password 	, name	 	, gender, rrn, phone_no	, email, role, nickname	, profile_image, 
								profile_writing, area1, area2, area3, category1, category2, category3, penalty_type, report_count, 
								stop_start_date, stop_end_date, out_user_state, out_user_date, add_user_type, logout_date, add_user_date, 
								total_visit_count, open_condition, push_condition, join_club_count, join_club_limit, sns_user_Id
								FROM users
								WHERE user_id LIKE 'user%'
								) inner_table
				WHERE ROWNUM <= 10 )					
		WHERE row_seq BETWEEN 1 AND 10 ;

