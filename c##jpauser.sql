CREATE TABLE memo (mno NUMBER(15) PRIMARY KEY,
memo_text varchar2(200) NOT NULL);

-- 메모번호는 시퀀스(memo_seq)입력
CREATE SEQUENCE memo_seq;
SELECT * FROM MEMO m;

DROP TABLE memo;
DROP SEQUENCE memo_seq;

INSERT INTO values(memo_seq.nextval, '오늘의 할일');

-- 회원, 팀
-- 회원은 단 하나의 팀에 소속된다.
-- 하나의 팀에는 여러 회원들이 소속됨.

-- 회원 (아이디, 이름, 팀 정보)
-- 팀(아이디, 팀 명)

CREATE TABLE team(
	team_id varchar2(100) PRIMARY KEY,
	team_name varchar2(100) NOT NULL
);

CREATE TABLE team_member(
	member_id varchar2(100) PRIMARY KEY,
	username varchar2(100) NOT NULL,
	team_id varchar2(100) CONSTRAINT fk_member_team REFERENCES team(team_id) --외래키 제약조건
);

INSERT INTO TEAM values('team1', '팀1');
INSERT INTO TEAM values('team2', '팀2');

INSERT INTO TEAM_MEMBER values('user1', '홍길동', 'team1'); -- 무결성 제약조건(C##JPAUSER.FK_MEMBER_TEAM)이 위배되었습니다- 부모 키가 없습니다

-- 홍길동이 소속된(team_member->username) 팀명(team->team_name) 조회 (join 응용)
-- SQL 구문에선 왼쪽오른쪽 테이블 구문 상관 없지만 Entitiy로 들어오면 매우 상관있음
SELECT
	tm.USERNAME,
	tm.MEMBER_ID,
	t.TEAM_ID, 
	t.TEAM_NAME
FROM
	TEAM_MEMBER tm
	-- 왼쪽 테이블
JOIN TEAM t ON
	-- 오른쪽 테이블
	tm.TEAM_ID = t.TEAM_ID;

--(외부조인) Hibernate 가 꾸려준 SELECT 문 (@ManyToOne)
    SELECT
	m1_0.id,
	t1_0.id,
	t1_0.name,
	m1_0.user_name
FROM
	team_member m1_0 -- 왼쪽 테이블 기준으로(Left join (outer는 뺴도되는말)
LEFT JOIN
        team t1_0 
            ON
	t1_0.id = m1_0.team_id
WHERE
	m1_0.id ='user1';

-- 회원 조회시 같은 팀에 소속된 회원 조회
-- 팀1
SELECT
	tm.USER_NAME,
	tm.ID,
	t.ID,
	t.NAME
FROM
TEAM t
JOIN TEAM_MEMBER tm ON
	t.ID = tm.TEAM_ID WHERE t.NAME = '팀1';

-- PARENT 삭제
-- 무결성 제약조건 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM  PARENT p WHERE p.id = 3;
































