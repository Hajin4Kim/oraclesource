CREATE TABLE usertbl(
	userid varchar2(20) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	age number(3) NOT NULL,
	email varchar2(20)  NOT NULL
);

INSERT INTO usertbl  values('hong123', '홍길동', 'hong123', 25, 'hong123@gmail.com');

SELECT * FROM usertbl;

-- email 열 크기 50으로 변경
ALTER TABLE usertbl MODIFY email VARCHAR2(50);

-- userid(hong123) 와 password(hong123) 가 일치하는 회원 조회
SELECT USERID, NAME FROM USERTBL u WHERE USERID ='hong123' AND PASSWORD = 'hong123';

-- 회원 전체 조회
SELECT USERID,NAME,AGE,EMAIL FROM USERTBL;

-- 비밀번호 변경
-- 아이디와 현재 비번이 일치하면 새 비밀번호로 변경

UPDATE USERTBL 
SET PASSWORD = 'hong456'
WHERE USERID = 'hong123' AND PASSWORD  = 'hong123';

SELECT  * FROM USERTBL u;

-- 회원삭제
-- 아이디와 비밀번호 일치 시 삭제
DELETE FROM USERTBL WHERE userid = 'hhh' AND password = '123';

-- 2024/10/15 book (dynamic web project)
-- booktbl
-- code number(4) pk
-- title 텍스트(50)
-- writer 텍스트 (30)
-- price number(10)

-- 1000 자바의정석 신용균 25000
-- 1001 자바의신 강신용 29000
-- 1002 자바1000제 남궁성 32000
-- 1003 오라클 박응용 33000
-- 1004 점프투파이썬 신기성 35000

CREATE TABLE booktbl(
code NUMBER(4) PRIMARY KEY,
title varchar2(50) NOT NULL,
writer varchar2(30) NOT null,
price NUMBER(10) NOT null
);

ALTER TABLE BOOKTBL ADD description varchar2(1000);

INSERT INTO booktbl(code, title, writer, price)  values(1000, '자바의 정석', '신용균', 25000);
INSERT INTO booktbl(code, title, writer, price)  values(1001, '자바의 신', '강신용', 29000);
INSERT INTO booktbl(code, title, writer, price)  values(1002, '자바 1000제', '남궁성', 32000);
INSERT INTO booktbl(code, title, writer, price)  values(1003, '오라클', '박응용', 33000);
INSERT INTO booktbl(code, title, writer, price)  values(1004, '점프투파이썬', '신기성', 35000);

-- 전체 조회
SELECT * FROM booktbl ORDER BY CODE;

-- 도서번호 1000 번인 도서 조회(상세조회 = WHERE 절에 PK 넣어서 작업)
SELECT * FROM BOOKTBL b WHERE b.CODE = 1000;

-- 도서번호 1001 번인 도서 가격 수정
UPDATE BOOKTBL b SET b.PRICE = 45000 WHERE code = 1001;

-- 도서번호 1001 번인 도서 가격 및 상세설명 수정
UPDATE BOOKTBL b SET PRICE = 45000 , description='상세 설명' WHERE code = 1001;

-- 도서번호 1004 번 도서 삭제
DELETE FROM BOOKTBL b WHERE b.code = 1004;

-- 도서명 '자바' 키워드가 들어있는 도서 조회
SELECT * FROM BOOKTBL b WHERE b.title LIKE '%자바%';

-- 더미 데이터 삽입(2024-10-18 검색결과용)
CREATE SEQUENCE book_seq
START WITH 2000;

INSERT INTO BOOKTBL(code, title, writer, price)
(SELECT book_seq.nextval, title, writer, price FROM BOOKTBL);

SELECT COUNT(*) FROM BOOKTBL b; 

-- 검색 (조회)
-- title 에 자바 키워드가 포함된 도서 조회 후 도서코드로 내림차순 정렬
-- 키워드가 안오면 전체 조회
SELECT * FROM BOOKTBL b WHERE b.TITLE LIKE '%자바%' ORDER BY CODE DESC;

-- 도서 회원
CREATE TABLE MEMBERTBL(
	userid varchar2(20) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL
);

INSERT INTO MEMBERTBL(USERID, NAME, PASSWORD)
values('hong123', '홍길동', 'hong123');

-- 아이디와 비밀번호가 일치하는 회원 조회(로그인)
SELECT * FROM MEMBERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong123';
SELECT * FROM MEMBERTBL;

-- 중복 아이디 검사하는 select문
SELECT * FROM MEMBERTBL WHERE USERID = 'hong123';

-- 비밀번호 변경
UPDATE MEMBERTBL SET PASSWORD = '' WHERE USERID = '' AND PASSWORD = '';

SELECT * FROM MEMBERTBL m ;

-- BOARD 프로젝트 (2024-10-18)
-- bno(number, pk), name(varchar2)-20, password(varchar2)-20, title(varchar2)-100, 
-- content(varchar2)-2000, file(varchar2)-100, re_ref, re_lev, re_seq, readcnt, regdate(date-sysdate)
CREATE TABLE board (
	bno NUMBER(8) PRIMARY KEY,
	name varchar2(20) NOT NULL,
	password varchar2(20) NOT NULL,
	title varchar2(100) NOT NULL,
	content varchar2(2000) NOT NULL,
	attach varchar2(100) NOT NULL,
	re_ref NUMBER(8) NOT NULL,
	re_lev NUMBER(8) NOT NULL,
	re_seq NUMBER(8) NOT NULL,
	readcnt NUMBER(8) DEFAULT 0,
	regdate DATE DEFAULT sysdate
);
-- 시퀀스 생성 board_seq
CREATE SEQUENCE board_seq;

SELECT * FROM board;
SELECT bno, name, title, readcnt, regdate FROM board ORDER BY BNO DESC;

-- board attach not null ==> null 가능하게 바꾸기
ALTER TABLE "C##JAVA".BOARD MODIFY ATTACH VARCHAR2(100) NULL;

-- insert 10번 실행
INSERT INTO BOARD(BNO, NAME, PASSWORD, TITLE, CONTENT, RE_REF, RE_LEV, RE_SEQ) 
VALUES(board_seq.nextval, 'hong', '12345', 'board 작성', 'board 작성', board_seq.currval,0,0)

-- 상세조회 페이지 (Read.jsp getRow)
SELECT * FROM BOARD WHERE BNO =3;

-- 수정 update
-- bno 와 password 가 일치 시, title, content 수정가능
UPDATE BOARD SET TITLE='변경타이틀', CONTENT='변경내용' WHERE BNO ='1' AND PASSWORD ='12345';

-- 삭제 delete
-- bno 값이 일치하면 삭제
DELETE FROM BOARD WHERE bno = '1' AND password = '12345';

-- 조회수 업데이트
UPDATE BOARD SET READCNT = READCNT + 1 WHERE bno = 3;

-- 댓글처리 (더미데이터)
INSERT INTO BOARD(BNO, NAME, PASSWORD, TITLE, CONTENT, RE_REF, RE_LEV, RE_SEQ) 
(SELECT board_seq.nextval, NAME, PASSWORD, TITLE, CONTENT, board_seq.currval, RE_LEV, RE_SEQ FROM BOARD);

SELECT COUNT(*) FROM BOARD b; 

-- 댓글처리 (계층형)
-- 가장 최근bno번호의 데이터 선택(가장최신글)
SELECT *
FROM BOARD
where
bno = (SELECT MAX(bno) FROM BOARD); 

-- 그룹 개념(re_ref : 부모글의 re_ref 넣어주기)
-- 댓글 추가 insert (board_seq.currval 가 아닌, 부모의 bno 가져오기)
-- re_lev: 부모글 re_lev + 1
-- re_seq: 부모글 re_seq + 1
INSERT INTO BOARD(BNO, NAME, PASSWORD, TITLE, CONTENT, RE_REF, RE_LEV, RE_SEQ) 
VALUES(board_seq.nextval, 'hong', '12345', 'board 작성', 'board 작성', 577,1,1)

-- 원본글과 댓글 함께 조회 (re_ref)
SELECT * FROM BOARD WHERE RE_REF = 577;

-- 두번째 댓글추가 (최신순 조회 : re_seq)
-- re_seq 가 낮을수록 최신글

-- 원본글
-- ㄴ댓글2
--		ㄴ댓글2의 댓글
-- ㄴ댓글1


-- 댓글2 추가
-- (re_seq값 1이상)먼저 들어간 댓글이 있다면,먼저 들어간 댓글의 re_seq 값을 + 1 해야함
-- UPDATE BOARD SET RE_SEQ +1 WHERE RE_REF = (부모글bno) AND RE_SEQ > (부모글 re_seq값);
UPDATE BOARD SET RE_SEQ = RE_SEQ +1 WHERE RE_REF = 577 AND RE_SEQ > 0;

INSERT INTO BOARD(BNO, NAME, PASSWORD, TITLE, CONTENT, RE_REF, RE_LEV, RE_SEQ) 
VALUES(board_seq.nextval, 'hong', '12345', '댓글 board 작성', '댓글 board 작성', 577,1,1)

SELECT * FROM BOARD WHERE RE_REF = 577 ORDER BY RE_REF DESC, RE_SEQ ASC;

-- 검색
-- 조건 title or content or name
-- 검색어
SELECT BNO, NAME, TITLE, READCNT, REGDATE, RE_LEV 
FROM BOARD WHERE title -- criteria 에 담길 값
LIKE '%추가%' -- keyword 에 담길 값
ORDER BY RE_REF DESC, RE_SEQ ASC;

SELECT BNO, NAME, TITLE, READCNT, REGDATE, RE_LEV 
FROM BOARD WHERE content LIKE '%추가%'
ORDER BY RE_REF DESC, RE_SEQ ASC;

SELECT BNO, NAME, TITLE, READCNT, REGDATE, RE_LEV 
FROM BOARD WHERE name LIKE '%홍길동%'
ORDER BY RE_REF DESC, RE_SEQ ASC;

-- Pagination ( 오라클 페이지 나누기)
-- 정렬이 완료된 후 번호를 매겨서 일부분 추출
SELECT rownum, BNO, NAME, TITLE, READCNT, REGDATE, RE_LEV FROM BOARD ORDER BY RE_REF DESC, RE_SEQ ASC;
SELECT rownum, BNO, NAME, TITLE, READCNT, REGDATE, RE_LEV FROM BOARD ORDER BY bno DESC;



-- 1~10번 갖고오기
SELECT rownum rnum, BNO, NAME, TITLE, READCNT, REGDATE, RE_LEV 
		FROM (SELECT BNO, NAME, TITLE, READCNT, REGDATE, RE_LEV FROM BOARD ORDER BY RE_REF DESC, RE_SEQ ASC)
		WHERE rownum <= 20);
-- 11 ~ 20번 갖고오기
SELECT rnum, BNO, NAME, TITLE, READCNT, REGDATE, RE_LEV
FROM (SELECT rownum rnum, BNO, NAME, TITLE, READCNT, REGDATE, RE_LEV 
		FROM (SELECT BNO, NAME, TITLE, READCNT, REGDATE, RE_LEV FROM BOARD ORDER BY RE_REF DESC, RE_SEQ ASC)
		WHERE rownum <= 20)
WHERE rnum > 10;

-- 1 page 요청 : rownum <= 10		rnum >0
-- 2 page 요청 : rownum <= 20		rnum > 10
-- 3 page 요청 : rownum <= 30		rnum > 20

-- --  -- page 값 이용하여 계산
-- rownum : 1page * 10 = 10
-- rnum : (1page - 1) * 10;




