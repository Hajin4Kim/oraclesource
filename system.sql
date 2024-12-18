-- 사용자 생성 시 특정 문자열로 시작하는 user 생성을 안하겠음
-- hr(c##hr)
ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

-- 09/10 SCOTT 에게 뷰 권한 부여
GRANT CREATE VIEW TO scott;

-- 09/11 동의어 권한 부여
GRANT CREATE SYNONYM TO scott;

-- 사용자 생성
--	CREATE USER 사용자이름 IDENTIFIED BY 비밀번호
--	DEFAULT TABLESPACE 테이블스페이스명
--	TEMPORARY TABLESPACE 테이블스페이스 그룹명
--	QUOTA 테이블스페이스크기 ON 테이블스페이스명;

-- SQL Error 공통 사용자 또는 롤 이름이 부적합합니다.
-- 오라클 버전의 변화로 사용자를 생성 시, (PREFIX로) C## 붙이는 걸로 변경됨
CREATE USER c##jpauser IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP 
QUOTA 10M ON USERS;

-- 권한 부여 C##TEST1
GRANT CREATE SESSION TO C##TEST1;

-- 비밀번호 변경
ALTER USER C##TEST1 IDENTIFIED BY 54321;

-- 사용자 삭제
-- CASCADE: 해당 사용자와 객체를 같이 모두 삭제 (이 편이 깔끔하고 좋음)
DROP USER C##TEST1 CASCADE;  

-- 권한 권리
	-- 1) 시스템 권한 : 사용자 생성/ 수정/ 삭제, 데이터베이스 접근, 오라클 db 객체 생성 관리 권한
		-- EX) DB 접속 권한: GRANT CREATE SESSION TO C##TEST1;
	-- 2) 객체 권한 : 특정 사용자가 생성한 테이블/인덱스/뷰/시퀀스 등과 관련된 권한
		-- EX) DB접속권한 : GRANT SELECT,INSERT,DELETE ON BOARD TO C##TEST1;

-- 권한 취소
	-- REVOKE CREATE TABLE FROM C##TEST1;
	-- REVOKE SELECT,INSERT ON BOARD FROM C##TEST1;

-- C##TEST1: 접속, 테이블 권한 부여
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE TO c##test1;

-- ROLE: 여러 개의 권한이 묶여서 정의되어있음
	-- CREATE TABLE, CREATE VIEW, CREATE SESSION,... => 원 CONNECT 롤에 들어있었음 BUT 현재 버전에선 없어짐
	-- 1) CONNECT 롤: CREATE SESSION 만 가지고 있음
	-- 2) RESOURCE 롤: CREATE TABLE, CREATE SEQUENCE, CREATE TRIGGER, CREATE PROCEDURE 권한 들어있음
	-- 사용자 생성 후 CONNECT, RESOURCE 롤 두개를 부여함







-- c##jpauser 생성
CREATE USER c##jpauser IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP 
QUOTA 10M ON USERS;

GRANT CONNECT, RESOURCE TO c##jpauser;

-- c##movieuser 생성
CREATE USER c##movieuser IDENTIFIED BY 12345
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP 
QUOTA 10M ON USERS;

GRANT CONNECT, RESOURCE TO c##movieuser;




