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























