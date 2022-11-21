select * from users;

select * from CLUB_POST;

select * from FEED;

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
VALUES (seq_meeting_no.nextval, 1, 'user01', '테스트일정제목', '테스트일정내용', '테스트일정날짜', '테스트일정장소', '테스트일정시간', '테스트날씨', sysdate, 1, 10);
INSERT INTO meeting (meeting_no, club_no, add_meeting_user_id, meeting_title, meeting_content, meeting_date, meeting_place, meeting_time, meeting_weather, meeting_reg_date, meeting_member, meeting_maximum_member)
VALUES (seq_meeting_no.nextval, 1, 'user02', '테스트일정제목', '테스트일정내용', '테스트일정날짜', '테스트일정장소3', '테스트일정시간3', '테스트날씨2', sysdate, 1, 10);


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
WHERE club_no=5;


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
	WHERE user_id = 'user04';
	

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
SELECT inner_table.*
				FROM ( SELECT rownum AS row_seq, deep_table.*
						FROM ( SELECT cU.club_user_no, cU.user_id, u.nickName, cU.member_role, u.logout_date, cU.join_reg_date, cU.approval_condition, u.profile_image, c.club_max_member, c.club_image
								FROM
								users u, club_User cU, club c
								WHERE cU.user_id = u.user_id
										and cU.club_no = c.club_no
										and cU.club_no = 1
										) deep_table
							) inner_table
									
									
									
										and cU.club_no = #{searchKeyword}


	

//모임일정 리스트
SELECT inner_table.*
		FROM (
			SELECT rownum AS row_seq, deep_table.*
			FROM (
				SELECT
					m.meeting_no ,
					m.club_no ,
					m.meeting_title ,
					m.meeting_date ,
					m.meeting_time ,
					m.meeting_place , 
					m.meeting_weather ,
					m.meeting_member ,
					u.user_id
			
					FROM meeting m, users u
					
					WHERE
						m.add_meeting_user_id = u.user_id
						and m.club_no = 103
						
						ORDER BY m.meeting_date ASC
							) deep_table
		) inner_table
		
		
		
		SELECT inner_table.*
		FROM     SELECT rownum AS row_seq, deep_table.*    FROM (     SELECT      m.meeting_no ,      m.club_no ,      m.meeting_title ,      m.meeting_date ,      m.meeting_time ,      m.meeting_place ,       m.meeting_weather ,      m.meeting_member ,      u.user_id          FROM meeting m, users u        WHERE m.add_meeting_user_id = u.user_id      and m.club_no = ?          ) deep_table   ) inner_table
						
					
					<if test="searchCondition == 0 and searchKeyword != '' ">
						and m.club_no = #{searchKeyword}
					</if>
					<!-- <if test="searchCondition == 1 and searchKeyword != '' ">
						and u.user_id = #{searchKeyword}
					</if> -->
			) deep_table
		) inner_table
		
		
//모임일정 참여자 리스트(조인해야함)
getMeetingmemberList()
SELECT
	participant_no, meeting_no, participant_user_id
	FROM participant
	WHERE meeting_no = 38;

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
DELETE FROM participant
WHERE meeting_no = 103 AND participant_user_id = 'user15';

SELECT * FROM participant;


DELETE FROM participant 
WHERE participant_user_id = 'user15';


SELECT * FROM participant;

//모임일정 삭제
deleteMeeting()
DELETE FROM meeting WHERE meeting_member = 1;

//모임원 직책 수정
updateMemberRole()
UPDATE club_user
	SET member_role = 2
	WHERE club_user_no = 68;

SELECT * from club_user;


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

	
	
	
	
	
	
	
	
	
	
SELECT inner_table.*
FROM ( SELECT rownum AS row_seq, deep_table.*
		FROM ( SELECT c.club_title , c.club_detail , c.club_category , c.current_member , c.club_max_member , c.club_area , c.club_image
				FROM club c, club_User cU
				WHERE c.club_no = cU.club_no and cU.user_id = 'user15' ) deep_table ) inner_table 



				
SELECT inner_table.*
FROM ( SELECT rownum AS row_seq, deep_table.*
		FROM ( SELECT u.nickname, cU.member_role, u.logout_date, cU.join_reg_date, cU.approval_condition
				FROM users u, club_User cU
				WHERE cU.user_id = u.user_id and cU.club_no = '2') deep_table ) inner_table
				

SELECT inner_table.*
FROM ( SELECT rownum AS row_seq, deep_table.*
		FROM ( SELECT p.participant_no, u.user_id, u.nickname, u.profile_image, m.meeting_title, m.meeting_place, m.meeting_time, m.meeting_date
				FROM participant p, users u, meeting m
				WHERE p.participant_user_id = u.user_id and p.meeting_no = m.meeting_no and p.meeting_no ='38' ) deep_table ) inner_table
				
				
SELECT inner_table.*
FROM ( SELECT rownum AS row_seq, deep_table.*
		FROM ( SELECT p.participant_no, u.user_id, u.nickname, u.profile_image, m.meeting_title, m.meeting_place, m.meeting_time, m.meeting_date, m.club_no, c.club_title
				FROM participant p, users u, meeting m, club c
				
				WHERE p.participant_user_id = u.user_id
				and p.meeting_no = m.meeting_no
				and m.club_no = c.club_no
				
						< if test="order == 0" >
							and p.meeting_no = #{searchKeyword}
						</if>
						< if test="order == 1" >
							and u.user_id = #{searchKeyword}
						</if>
						
						 ) deep_table ) inner_table

				
SELECT inner_table.*
FROM ( 
		SELECT rownum AS row_seq, deep_table.*
		FROM ( 
				SELECT 
				p.participant_no, 
				u.user_id, 
				u.nickname, 
				u.profile_image, 
				m.meeting_title, 
				m.meeting_place, 
				m.meeting_time, 
				m.meeting_date, 
				m.club_no, 
				m.meeting_no
				
				FROM participant p, users u, meeting m
				
				WHERE p.participant_user_id = u.user_id
				and p.meeting_no = m.meeting_no
				and u.user_id = 'user04'		
						 ) deep_table ) inner_table						 
						 
						and p.meeting_no = '65'
						and u.user_id = 'user04'
						and u.user_id = #{searchKeyword} 
						 
						 
						 
						 
						 
SELECT inner_table.*
FROM ( SELECT rownum AS row_seq, deep_table.*
		FROM ( SELECT p.participant_no, u.user_id, u.nickname, u.profile_image, m.meeting_title, m.meeting_place, m.meeting_time, m.meeting_date, m.club_no, c.club_title, m.meeting_no
				FROM participant p, users u, meeting m, club c
				WHERE p.participant_user_id = u.user_id and p.meeting_no = m.meeting_no and u.user_id ='user04' ) deep_table ) inner_table				
		

SELECT inner_table.*
FROM (SELECT rownum AS row_seq, deep_table.*
		FROM (SELECT 
			m.meeting_no ,
			m.club_no ,
			m.meeting_title ,
			m.meeting_date ,
			m.meeting_time ,
			m.meeting_place , 
			m.meeting_weather ,
			m.meeting_member ,
			u.user_id
				
			FROM meeting m, users u
			
			WHERE m.add_meeting_user_id = u.user_id
			and u.user_id = 'user01') deep_table ) inner_table


			
			
			
SELECT inner_table.*
	FROM ( SELECT rownum AS row_seq, deep_table.*
				FROM ( SELECT m.meeting_no , m.club_no , m.meeting_title , m.meeting_date , m.meeting_time , m.meeting_place , m.meeting_weather , m.meeting_member , u.user_id
					FROM meeting m, users u
					WHERE m.add_meeting_user_id = u.user_id and u.user_id = 'user01' ) deep_table ) inner_table 


	SELECT COUNT(*)
	  	FROM(	SELECT participant_no 
						FROM participant
						<if test="searchCondition != null">
							<where>
								<if test="searchCondition == 0 and searchKeyword !='' ">
						 			participant_no = #{searchKeyword}
								</if>								
							</where>
						</if> ) countTable		

	SELECT count(*)
	FROM ( SELECT
			participant_no
			FROM participant
			WHERE meeting_no = 84
	) countTable
	
SELECT * FROM participant;


	SELECT COUNT(*)
	  	FROM(	SELECT club_no 
						FROM club_user
						WHERE club_no = #{searchKeyword}								
			) countTable			

			
			
SELECT *
FROM ( SELECT inner_table.*, ROWNUM AS row_seq
		FROM ( SELECT club_no , user_id , club_title , club_detail , club_reg_date, current_member, club_max_member, club_category, club_area, club_image
				FROM club
				WHERE club_title LIKE '%'||?||'%'           club_category = ? and club_title LIKE '%'||?||'%'
				ORDER BY club_no ) inner_table
		WHERE ROWNUM <= ? )
WHERE row_seq BETWEEN ? AND ?




SELECT
inner_table.* 
FROM ( 
	SELECT rownum AS row_seq, deep_table.* 
	FROM ( 
		SELECT 
		c.club_no , 
		c.club_title , 
		c.club_detail , 
		c.club_category , 
		c.current_member , 
		c.club_max_member , 
		c.club_area , 
		c.club_image , 
		cU.approval_condition 
			FROM club c, club_User cU 
			WHERE c.club_no = cU.club_no and cU.user_id = ?
			) deep_table ) inner_table 




SELECT count(*)
FROM (	SELECT user_id
	FROM club_user
	WHERE user_id = 'user15' ) countTable
	
	
	
SELECT COUNT(*)
FROM( SELECT club_no 
	FROM club_user
	WHERE club_no = '2' and approval_condition = '1' ) countTable				

SELECT * FROM club;


