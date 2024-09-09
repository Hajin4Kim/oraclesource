-- SQL 쿼리문은 대소문자를 구별하지 않음
-- 단, 비밀번호는 구별 함
-- ctrl+enter = 실행
-- ctrl+shift+f = 마우스커서 해당하는 줄 자동정렬
-- 숫자같은 경우에 , 가 들어있지 않음 => dbeaver 가 보기 편하도록 세팅해준 것
-- DML : 데이터 조작어(CRUD - Create / Read / Update / Delete)

-- 1) 조회
-- SELECT 컬럼명 ---⑤
-- FROM 테이블명 ---①
-- ORDER BY 컬럼명 ---⑥
-- WHERE 조건절 ---② 까지9/4 
-- GROUP BY 컬럼명 ---③
-- HAVING 집계함수 조건절 ---④


-- EMP(employee 사원정보테이블)
-- DEPT(department 부서테이블)
-- SALGRAGE (salary grade 급여테이블)

-- 전체 조회
SELECT * FROM EMP;

-- 선택 조회
-- 1) 컬럼 지정
SELECT
	EMPNO,
	ENAME,
	MGR
FROM
	EMP e;

-- 중복 조회 : distinct
SELECT DISTINCT DEPTNO 
FROM EMP e;

-- 별칭 조회 : as (필수는 아님) (별칭 "" 도 필수는 아니지만, 별칭에 공백이 들어가는 경우엔 에러남 그냥 "" 쓰자)
SELECT EMPNO AS "사원번호"
FROM  EMP e;

SELECT EMPNO "사원번호"
FROM  EMP e;

SELECT EMPNO AS "사원 번호"
FROM  EMP e;

-- 연봉 계산 및 계산식 필드명 변경
SELECT EMPNO, ENAME, SAL, COMM, SAL*12+COMM AS "연봉"
FROM EMP e;

-- 조회 후 정렬 : ORDER BY 오름 ASC / 내림 DESC
-- sal 내림차순
SELECT ENAME, SAL
FROM EMP e
ORDER BY SAL DESC;

-- sal 오름차순(default 차순 = asc 생략가능)
SELECT ENAME, SAL
FROM EMP e
ORDER BY SAL;

-- empno 내림차순
SELECT * 
FROM EMP e 
ORDER BY EMPNO DESC;

-- deptno 는 오름차순, sal 내림차순
SELECT *
FROM EMP e 
ORDER BY DEPTNO ASC, SAL DESC;

-- 실습
SELECT
	EMPNO AS "EMPLOYEE_NO",
	ENAME AS "EMPLOYEE_NAME",
	MGR AS "MANAGER",
	SAL AS "SALARY",
	COMM AS "COMMISSION",
	DEPTNO AS "DEPARTMENT_NO"
FROM
	EMP e
ORDER BY DEPTNO DESC, ENAME ASC;

-- 선택 조회
-- 2) 조건 지정 : WHERE
-- 부서번호가 30번인 사원 전체 조회
-- SQL 에서는 = 이 동일하다는 뜻 (== 안씀)
SELECT *FROM EMP e WHERE DEPTNO = 30;

-- 사원번호가 7839인 사원 조회
-- 사원번호는 중복되지 않음
-- WHERE 절 조건으로 중복되지 않는 값이 사용된다면 결과는 하나만 조회됨
SELECT *FROM EMP e WHERE e.EMPNO = 7839;

-- 부서번호가 30이고(AND), 직책이 SALESMAN인 사원 조회
--TODO: 값 자체는 대소문자 구별됨 & 문자열은 홑따옴표만 사용
SELECT *FROM EMP e WHERE e.DEPTNO = 30 AND JOB = 'SALESMAN';

-- 사원번호가 7698이고 부서번호가 30인 사원조회
SELECT * FROM EMP e WHERE e.EMPNO = 7698 AND DEPTNO = 30;

-- 부서번호가 30 이거나(OR) 직책이 CLERK 인 사원 조회
SELECT * FROM EMP e WHERE e.DEPTNO = 30 OR JOB = 'CLERK';

-- 연봉이 36000 인 사원조회
-- SAL(월급)
SELECT * FROM EMP e WHERE e.SAL*12 = 36000;

-- 급여가 3000 보다 큰 사원 조회
SELECT * FROM EMP e WHERE e.SAL > 3000;
-- 급여가 3000 이상인 사원 조회
SELECT * FROM EMP e WHERE e.SAL >= 3000;

--ENAME 가 F로 시작하는 것보다 큰 사원들을 조회
SELECT * FROM EMP e WHERE e.ENAME >= 'F' ORDER BY ENAME ASC;

-- 급여가 2500 이상이고 직업이 ANALYST 인 사원 조회
SELECT * FROM EMP e WHERE e.SAL >= 2500 AND e.JOB = 'ANALYST';
-- JOB 이 MANAGER, SALESMAN, CLERK 인 사원 조회
SELECT * FROM EMP e WHERE e.JOB = 'MANAGER' OR e.JOB = 'SALESMAN' OR e.JOB = 'CLERK';
--TODO: IN 연산자
SELECT * FROM EMP e WHERE e.JOB IN ('MANAGER','SALESMAN','CLERK');

--TODO: SAL 이 3000 이 아닌(!= 또는 <> 또는 ^=) 사원 조회
SELECT * FROM EMP e WHERE e.SAL != 3000 ORDER BY SAL ASC;
SELECT * FROM EMP e WHERE e.SAL <> 3000 ORDER BY SAL ASC;
SELECT * FROM EMP e WHERE e.SAL ^= 3000 ORDER BY SAL ASC;

--TODO: JOB 이 MANAGER, SALESMAN, CLERK 이 아닌(NOT IN) 사원 조회
SELECT * FROM EMP e WHERE e.JOB != 'MANAGER' AND e.JOB <> 'SALESMAN' AND e.JOB ^= 'CLERK';
SELECT * FROM EMP e WHERE e.JOB NOT IN ('MANAGER','SALESMAN','CLERK');

-- 부서번호가 10 이거나 20 인 사람 조회
SELECT * FROM EMP e WHERE e.DEPTNO IN (10, 20);

--TODO: BETWEEN A AND B : 일정 범위 내의 데이터 조회시 사용
-- 급여가 2000 이상 그리고 3000 이하인 직원 조회
SELECT * FROM EMP e WHERE e.SAL BETWEEN 2000 AND 3000;

--TODO: NOT BETWEEN A AND B : 일정 범위 내 가 아닌 데이터 조회시 사용
-- 급여가 2000 이상 그리고 3000 이하가 아닌 직원 조회
SELECT * FROM EMP e WHERE e.SAL NOT BETWEEN 2000 AND 3000;

--TODO: LIKE 연산자 그리고 와일드카드(%, _)
-- ENAME = 'JONES' : 전체 일치하는 경우
-- ENAME LIKE 'J%' : 부분일치(LIKE)

-- ENAME 이 J로 시작하면 그 뒤에 어떤 문자가 몇 개가 오던지 상관없음
SELECT  * FROM EMP e WHERE e.ENAME LIKE 'J%';

-- __J% : 어떤 문자로 시작해도 상관은 없지만 갯수는 하나 (시작문자 하나만, 두번째 문자는 무조건 J, 뒤로는 어떤 문자 몇개 오던지 상관없음)
SELECT  * FROM EMP e WHERE e.ENAME LIKE '_J%';

SELECT  * FROM EMP e WHERE e.ENAME LIKE '_L%';

-- 사원명에 AM 문자가 포함된 사원 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '%AM%';

-- 사원명에 AM 문자가 포함되지 않는 사원 조회
SELECT * FROM EMP e WHERE e.ENAME NOT LIKE '%AM%';

--TODO: IS NULL / IS NOT NULL
SELECT * FROM EMP WHERE COMM IS NULL;
SELECT * FROM EMP WHERE COMM IS NOT NULL;

-- 집합 연산자
-- UNION : 합집합(결과값의 중복은 제거됨)
-- UNION ALL : 합집합 (결과값의 중복)
-- MINUS : 차집합
-- INTERSECT : 교집합

-- 부서번호 10인 사원 조회 (사번, 이름, 급여, 부서번호 조회)
-- 부서번호 20인 사원 조회 (사번, 이름, 급여 조회, 부서번호 조회) => 컬럼 갯수 안맞추면 에러남 / 타입도 동일해야 함
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	DEPTNO = 10
UNION
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	DEPTNO = 20;

-- UNION ALL
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	DEPTNO = 10
UNION ALL
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	DEPTNO = 10;

-- MINUS (전체에서 10번인 것들 뺀 나머지) (WHERE 절 하나만)
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
MINUS
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	DEPTNO = 10;

-- INTERSECT (WHERE 절 하나만)
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
INTERSECT
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.DEPTNO = 10;

-- ############################# TODO: 09/05
-- 함수
-- 1. 오라클 내장 함수
-- 2. 사용자 정의 함수(PL/SQL)

-- 오라클 내장 함수
-- 1. 단일행 함수 : 데이터가 한 행씩 입력되고 입력된 한 행당 결과가 하나씩 나오는 함수
-- 2. 다중행 함수: 여러 행이 입력되고 결과가 하나의 행으로 반환되는 함수
 
-- 1. 문자함수
-- UPPER(문자열) : 괄호 안 문자열을 모두 대문자로
-- LOWER(문자열) : 괄호 안 문자열을 모두 소문자로
-- INITCAP(문자열) : 괄호 안 문자 데이터 중 첫문자만 대문자, 나머지는 소문자로
-- LENGTH(문자열) : 문자열 길이
-- LENGTHB(문자열) : 문자열 바이트 수
-- SUBSTR(문자열, 시작위치) / SUBSTR(문자열, 시작위치, 추출길이) : 문자열 일부 추출
-- INSTR(문자열, 찾으려는문자) : 특정 문자나 문자열이 어디에 포함되어 있는지
-- INSTR(문자열, 찾으려는문자, 위치 찾기를 시작할 대상 문자열 데이터 위치, 시작위치에서 찾으려는 문자가 몇 번째 인지)
-- REPLACE(문자열, 찾는문자, 대체문자) : 문자열 중 찾아 대체할 문자로 대체한다
-- CONCAT(문자열1, 문자열2) : 문자열 연결
-- TRIM / LTRIM / RTRIM : 특정 문자를 제거 (공백만이 아닌)

-- 데이터는 대소문자 구분 함

SELECT e.ENAME, UPPER(e.ENAME), LOWER(e.ENAME), INITCAP(e.ENAME) 
FROM EMP e;

-- smith 가 포함된 사람 찾기
SELECT * FROM EMP e WHERE UPPER(ENAME) = UPPER('smith');

-- smith 라는 단어가 포함된 사람 찾기
SELECT * FROM EMP e WHERE UPPER(ENAME) LIKE UPPER('%smith%');

-- DUAL : 오라클에서 제공하는 기본 테이블(함수 적용 결과 보는 용도로 씀)
-- LENGTH / LENGTHB
SELECT LENGTH('한글'), LENGTHB('한글'), LENGTH('AB'), LENGTHB('AB') FROM DUAL;

SELECT JOB, SUBSTR(JOB, 1,2), SUBSTR(JOB, 3,2), SUBSTR(JOB,5) FROM EMP e; 

-- -마이너스 : 오른쪽 끝을 의미
SELECT JOB, SUBSTR(JOB, -LENGTH(JOB)), SUBSTR(JOB,-LENGTH(JOB),2), SUBSTR(JOB,-3) 
FROM EMP e; 

SELECT
	INSTR('HELLO, ORACLE!', 'L') AS INSTR_1,
	INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,
	INSTR('HELLO, ORACLE!', 'L',2,2) AS INSTR_3
FROM DUAL;

-- 사원 이름에 S가 있는 행 구하기
-- LIKE 쓰기
SELECT e.ENAME FROM EMP e WHERE e.ENAME LIKE '%S%';
-- INSTR 쓰기
SELECT * FROM EMP e WHERE INSTR(e.ENAME ,'S') > 0;

-- 010-1234-1535 대쉬 또는 빈공간 없애기 REPLACE로
SELECT '010-1234-1535' AS "변경 전",
	REPLACE ('010-1234-1535', '-',' ') AS "공백",
	REPLACE ('010-1234-1535', '-') AS "-제거"
FROM DUAL;

-- EMPNO, ENAME 연결 조회
-- CONCAT(EMPNO, CONCAT(':', ENAME)) :2개 이상 연결하기 불편함
SELECT CONCAT(EMPNO,ENAME),CONCAT(EMPNO,CONCAT(':', ENAME)) 
FROM EMP e;

--TODO: || == CONCAT 여러 문자 CONCAT은 || 가 훨 편함
SELECT EMPNO || ENAME, EMPNO || ':' || ENAME 
FROM EMP e;

SELECT 
'[' || TRIM(' _ORACLE_ ') || ']' AS TRIM, -- 일반 트림 = 양쪽 공백 제거함
'[' || LTRIM(' _ORACLE_ ') || ']' AS LTRIM, -- 제거문자 안쓰면 기본 공백 제거함 BUT LTRIM 이라 왼쪽 한정으로 제거
'[' || LTRIM('<_ORACLE_>', '_<') || ']' AS LTRIM2, -- 제거문자 사용하면 해당 제거문자를 LTRIM 왼쪽 한정으로 제거
'[' || RTRIM(' _ORACLE_ ') || ']' AS RTRIM, -- 제거문자 안쓰면 기본 공백 제거함 BUT RTRIM 이라 오른쪽 한정으로 제거
'[' || RTRIM('<_ORACLE_>','>_') || ']' AS RTRIM2 -- 제거문자 사용하면 해당 제거문자를 RTRIM 오른쪽 한정으로 제거
FROM DUAL;

-- 숫자함수
-- ROUND(숫자, [반올림위치])
-- TRUNC(숫자, [버림위치])
-- CEIL (숫자) : 지정한 숫자와 가장 가까운 큰 정수 찾기
-- FLOOR(숫자) : 지정한 숫자와 가장 가까운 작은 정수 찾기
-- MOD(숫자, 나눌숫자) == %

SELECT 
ROUND(1234.5678) AS ROUND,
ROUND(1234.5678, 0)AS ROUND_0, 
ROUND(1234.5678, 1)AS ROUND_1,
ROUND(1234.5678, 2)AS ROUND_2, 
ROUND(1234.5678, -1)AS ROUND_MINUS1, 
ROUND(1234.5678, -2)AS ROUND_MINUS2
FROM DUAL;

SELECT 
TRUNC(1234.5678) AS TRUNC,
TRUNC(1234.5678, 0)AS TRUNC_0, 
TRUNC(1234.5678, 1)AS TRUNC_1,
TRUNC(1234.5678, 2)AS TRUNC_2, 
TRUNC(1234.5678, -1)AS TRUNC_MINUS1, 
TRUNC(1234.5678, -2)AS TRUNC_MINUS2
FROM DUAL;

SELECT CEIL(3.14), FLOOR(3.14), CEIL (-3.14), FLOOR(-3.14) 
FROM DUAL;

SELECT MOD(15,6)
FROM DUAL;

-- 날짜함수
-- SYSDATE: 오라클 서버가 설치된 OS 의 현재 날짜와 시간 사용
-- 날짜데이터 + 숫자 : 날짜 데이터와 숫자만큼 일수 이후의 날짜
-- 날짜데이터 - 날짜데이터 : 일수차이
-- 날짜데이터 + 날짜데이터 : 안됨
-- ADD_MONTHS(날짜데이터, 더할 개월 수)
-- MONTHS_BETWEEN(날짜데이터, 날짜데이터) : 두 날짜 데이터 간의 차이를 개월 수로 계산
-- NEXT_DAY(날짜데이터, 요일문자) : 날짜 데이터에서 돌아오는 요일의 날짜 반환
-- LAST_DAY(날짜데이터) : 특정 날짜가 속한 달의 마지막 날짜 조회

SELECT SYSDATE FROM DUAL;

SELECT SYSDATE, SYSDATE-1, SYSDATE+1 FROM DUAL;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) FROM DUAL;

-- 입사 20주년 조회
SELECT e.EMPNO, e.ENAME, e.HIREDATE, ADD_MONTHS(e.HIREDATE, 240) 
FROM EMP e;

SELECT
	EMPNO,
	ENAME,
	HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
FROM EMP e 

SELECT SYSDATE, NEXT_DAY(SYSDATE, '월요일'), LAST_DAY(SYSDATE) FROM DUAL; 

-- 형변환 함수
-- TO_CHAR(날짜데이터, '출력되길 원하는 문자형태')
-- TO_NUMBER(문자데이터, '인식되길 원하는 숫자형태')
-- TO_DATE(문자데이터, '인식되길 원하는 날짜형태')

-- NUMBER + '문자숫자' : 연산해줌
SELECT e.EMPNO, e.ENAME, e.EMPNO + '500'
FROM EMP e;+

-- SQL Error [1722] [42000]: ORA-01722: 수치가 부적합합니다
--SELECT e.EMPNO, e.ENAME, e.EMPNO + 'ABCD' FROM EMP e;+

-- 날짜데이터를 문자데이터로 변경
-- 자바 : 월 mm / 분 MM
--TODO: 오라클 : 월 MM / 분 MI
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS 현재날짜
FROM DUAL;

SELECT 
TO_CHAR(SYSDATE, 'MM') AS 현재월,
TO_CHAR(SYSDATE, 'MON') AS 현재월2, --영어로는 SEP
TO_CHAR(SYSDATE, 'MONTH') AS 현재월3 -- 영어로는 SEPTEMBER
FROM DUAL;

-- DD, DDD, DAY
SELECT 
TO_CHAR(SYSDATE, 'DD') AS 일자, --현재 일자
TO_CHAR(SYSDATE, 'DDD') AS 현재일자2, -- 1년중 현재날짜수
TO_CHAR(SYSDATE, 'DAY') AS 현재일자3 -- 현재 요일
FROM DUAL;

SELECT 
SYSDATE,
TO_CHAR(SYSDATE, 'HH:MI:SS') AS 현재시간1,
TO_CHAR(SYSDATE, 'HH12:MI:SS') AS 현재시간2, -- 오후로 넘어가는시간부터 12시간제
TO_CHAR(SYSDATE, 'HH24:MI:SS') AS 현재시간3, -- 오후로 넘어가는시간부터 24시간제
TO_CHAR(SYSDATE, 'HH24:MI:SS AM') AS 현재시간4 -- 오전 또는 오후 추가
FROM DUAL;

-- 문자데이터 => 숫자데이터로 
SELECT 1300 - '1500', '1300' - 1500
FROM DUAL;

--SQL Error [1722] [42000]: ORA-01722: 수치가 부적합합니다
--SELECT 1300 - '1,500', '1,300' - 1500 FROM DUAL;

-- 9(숫자 한자리를 의미: 빈자리는 채우지 않음) OR 0(숫자 한자리를 의미: 빈자리는 채움 : 소수점)
SELECT TO_NUMBER('1,300', '999,999') + TO_NUMBER('1,500','999,999') FROM DUAL;

-- 문자데이터 => 날짜데이터로 (대쉬 유무 상관 없음, 데이터 형식과 갯수만 맞으면 됨)
SELECT TO_DATE('2024-09-05', 'YYYY-MM-DD') AS TODATE1, TO_DATE('20240905', 'YYYY-MM-DD') AS TODATE2 FROM DUAL;

-- EMP 테이블에서 1981-06-01 이후에 입사한 사원 조회
SELECT * 
FROM EMP e
WHERE e.HIREDATE >= '1981-06-01' ;

SELECT * 
FROM EMP e
WHERE e.HIREDATE >= TO_DATE('1981-06-01', 'YYYY-MM-DD');

-- 날짜와 날짜의 가산은 불가함
-- 날짜데이터 + 날짜데이터
SELECT TO_DATE('2024-09-05') - TO_DATE('2024-01-02')
FROM DUAL;

-- NULL 처리 함수
-- NULL 과 산술연산이 안됨 => NULL 을 다른 값으로 변경해야 연산 가능해짐
-- NVL(널값, 대체할값)
-- NVL2(널값, 널이 아닌경우 반환값, 널인 경우 반환값)
-- SAL = NULL (X) IS (O)
SELECT e.EMPNO, e.ENAME, e.SAL, e.COMM, e.SAL + NVL(e.COMM, 0)
FROM EMP e;


SELECT e.EMPNO, e.ENAME, e.SAL, e.COMM, NVL2(e.COMM, 'O', 'X') 
FROM EMP e;
-- NULL이아니면 SAL*12+COMM
-- NULL이면 SAL*12
SELECT e.EMPNO, e.ENAME, e.SAL, e.COMM, NVL2(e.COMM, e.SAL*12+e.COMM, SAL*12) 
FROM EMP e;

-- DECODE 함수 / CASE 문
--DECODE(데이터, 
--		조건1, 조건1을 만족할 때 해야할 것,
--		조건2, 조건2을 만족할 때 해야할 것,
--		) AS 별칭

-- JOB이 MANAGER 라면 e.SAL * 1.1
-- JOB이 SALESMAN 라면 e.SAL * 1.5
-- JOB이 ANALYST 라면 e.SAL 
-- 그 외라면 e.SAL * 1.03
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	DECODE(JOB, 'MANAGER', e.SAL * 1.1, 'SALESMAN', e.SAL * 1.5, 'ANALYST', e.SAL, e.SAL * 1.03) AS UPSAL 
FROM EMP e ;

SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.SAL,
	CASE
		JOB WHEN 'MANAGER' THEN e.SAL * 1.1
		WHEN 'SALESMAN' THEN e.SAL * 1.5
		WHEN 'ANALYST' THEN e.SAL
		ELSE e.SAL* 1.03 
		END AS UPSAL
	FROM EMP e ;

-- COMM 널일때 '해당사항없음'
--  COMM = 0 일때 '수당없음'
--  COMM > 0 일때 '수당 : COMM'
SELECT
	e.EMPNO,
	e.ENAME,
	e.COMM,
	CASE
		WHEN e.COMM IS NULL THEN '해당사항없음'
		WHEN e.COMM = 0 THEN '수당없음'
		WHEN e.COMM > 0 THEN '수당 :' || e.COMM
		END AS COMM_TEXT
	FROM EMP e ;

-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다. 하루 근무시간을 8시간으로 봤을 때 사원들의 하루 급여(DAY_PAY) 와 시급(TIME_PAY) 를 계산하여 결과를 출력한다
-- 사번, 이름, SAL, DAY_PAY, TIME_PAY 출력
-- 단, 하루 급여는 소수점 셋째자리에서 버리고, 시급은 두번째 소수점에서 반올림하기
SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	TRUNC(e.SAL / 21.5, 2) AS DAY_PAY,
	ROUND(e.SAL / 21.5 / 8, 1) AS TIME_PAY
FROM
	EMP e;

-- EMP 테이블에서 사원들은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 사원들의 정직원이 되는 날짜(R_JOB)를 YYYY-MM-DD 형식으로 출력
-- 사번, 이름, 고용일, R_JOB출력
-- +추가수당 : COMM이 없으면 'N/A', 있으면 COMM 출력
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	NEXT_DAY( ADD_MONTHS(e.HIREDATE, 3),'월요일')AS R_JOB,
	CASE 
		WHEN e.COMM IS NULL THEN 'N/A'
		WHEN e.COMM IS NOT NULL THEN e.COMM || ''
	END COMM
FROM EMP e;

--NVL 사용하면?
SELECT
	e.EMPNO,
	e.ENAME,
	e.HIREDATE,
	NEXT_DAY( ADD_MONTHS(e.HIREDATE, 3),'월요일')AS R_JOB,
--	NVL(COMM, 'N/A') -- QL Error [1722] [42000]: ORA-01722: 수치가 부적합합니다
	NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM EMP e;

-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)를 변환해서 CHG_MGR에 출력
-- 사번, 이름, MGR, CHG_MGR 출력
-- 조건: MGR이 NULL 이면 '0000'/MGR 의 앞 두자리가 75이면 '5555'/ 76이면 '6666' / 77이면 '7777'/ 78이면 '8888' 출력 / 79면 MGR 그대로

SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	DECODE(SUBSTR(TO_CHAR(e.MGR), 1, 2),
	NULL, '0000', 
	'75', '5555', 
	'76', '6666', 
	'77', '7777', 
	'78', '8888', 
	SUBSTR(TO_CHAR(e.MGR), 1) 
	) AS CHG_MGR	
FROM EMP e; 

-- CASE WHEN버전
SELECT
	e.EMPNO,
	e.ENAME,
	e.MGR,
	CASE
		WHEN e.MGR IS NULL THEN '0000'
		WHEN TO_CHAR(e.MGR) LIKE '75%' THEN '5555'
		WHEN TO_CHAR(e.MGR) LIKE '76%' THEN '6666'
		WHEN TO_CHAR(e.MGR) LIKE '77%' THEN '7777'
		WHEN TO_CHAR(e.MGR) LIKE '78%' THEN '8888'
		ELSE SUBSTR(TO_CHAR(e.MGR),1)
	END AS CHG_MGR
FROM EMP e; 

-- 다중행 함수
-- SUM(합계를 낼 열), COUNT(갯수셀 것을 지정), MAX(), MIN(), AVG()
--DISTINCT : 중복제거
SELECT SUM(SAL), 
FROM EMP e; 

SELECT SUM(DISTINCT SAL), SUM(ALL SAL), SUM(SAL) 
FROM EMP e; 

SELECT COUNT(DISTINCT SAL), COUNT(ALL SAL), COUNT(SAL) 
FROM EMP e; 

SELECT MAX(SAL), MIN(SAL) 
FROM EMP e;

SELECT MAX(SAL), MIN(SAL) 
FROM EMP e
WHERE DEPTNO =10;

-- 부서번호가 20인 사원의 최근(날짜가최근일수록크니) 입사일 조회
SELECT MAX(HIREDATE) 
FROM EMP e
WHERE DEPTNO =20;

SELECT MIN(HIREDATE) 
FROM EMP e
WHERE DEPTNO =20;

SELECT AVG(DISTINCT SAL), AVG(ALL SAL), AVG(SAL) 
FROM EMP e; 

-- 부서번호가 30인 사원들의 추가수당
SELECT AVG(COMM) 
FROM EMP e
WHERE DEPTNO =30; 

-- GROUP BY: 결과값을 원하는 열로 묶어 출력
-- GROUP BY 그룹화할 열
-- 각 부서별 평균 급여 출력
SELECT DEPTNO, AVG(SAL) 
FROM EMP e 
GROUP BY DEPTNO
ORDER BY DEPTNO; 

-- 각 부서별, 직책별 평균 급여 출력
SELECT DEPTNO, JOB, AVG(SAL) 
FROM EMP e 
GROUP BY DEPTNO, JOB 
ORDER BY DEPTNO, JOB; 

--TODO: SQL Error [979] [42000]: ORA-00979: GROUP BY 표현식이 아닙니다.
-- GROUP BY 절 사용시 SELECT절에서 사용할 수 있는 열이 제한됨
-- SELECT 가능 : GROUP BY 쓰여진 열, 다중행함수
--SELECT ENAME, AVG(COMM) 
--FROM EMP e 
--GROUP BY DEPTNO; 

--GROUP BY ~ HAVING: 그룹바이절에 조건을 줄 때 사용
-- 각 부서의 직책별 평균 급여 (평균 급여가 2000 이상인 그룹만 조회)
SELECT DEPTNO, JOB, AVG(SAL) 
FROM EMP e 
GROUP BY DEPTNO, JOB 
HAVING AVG(SAL) >= 2000 
ORDER BY DEPTNO, JOB; 
-- WHERE 절로 바꾼다면
-- SQL Error [934] [42000]: ORA-00934: 그룹 함수는 허가되지 않습니다
--SELECT DEPTNO, JOB, AVG(SAL) 
--FROM EMP e 
--WHERE AVG(SAL) >= 2000 
--GROUP BY DEPTNO, JOB 
--ORDER BY DEPTNO, JOB; 


-- 부서별, 평균급여,최고급여,최저급여,사원 수 출력
-- FLOOR (): 가장 가까운 정수중 작은 정수
-- 평균급여 출력 시 소수점을 제외하고 출력
SELECT DEPTNO, FLOOR(AVG(SAL)), MAX(SAL), MIN(SAL), COUNT(DEPTNO) 
FROM EMP e 
GROUP BY DEPTNO 
ORDER BY DEPTNO; 
-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
--TODO: 하나만 있는데 그걸로 COUNT 할거라면 COUNT(*)가능
SELECT JOB, COUNT(*) 
FROM EMP e 
GROUP BY JOB 
HAVING COUNT(*) >= 3; 
-- 사원들의 입사년도를 기준으로 부서별로 몇 명의 입사인원이 있는지 출력
-- 1987 20 2 (1987년도 20번 부서에 2명 입사)
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR, DEPTNO, COUNT(*) AS CNT 
FROM EMP e 
GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO
ORDER BY HIRE_YEAR, DEPTNO;

--TODO: JOIN(조인) : 2개 이상의 테이블을 연결하여 하나의 테이블처럼 출력
-- 내부조인
	-- 등가조인(★) : 테이블 연결 후 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정
	-- 비등가조인
-- 외부조인


--SELECT * FROM EMP e, DEPT d; 

-- 1) 내부조인
-- 등가조인: EMP 테이블의 DEPTNO와 DEPT테이블의 DEPTNO가 일치 시 연결
SELECT e.EMPNO, e.ENAME, DEPTNO, d.DNAME, d.LOC --TODO: JOIN시, 별칭(d.)을 쓰지 않고 출력하려 하면 둘 다 해당하기때문에 다음과 같은 에러 발생 SQL Error [918] [42000]: ORA-00918: 열의 정의가 애매합니다
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO;

--TODO: JOIN(조인) : 2개 이상의 테이블을 연결하여 하나의 테이블처럼 출력 
-- 내부조인 (Inner JOIN)
	-- 등가조인(★) : 테이블 연결 후 출력 행을 각 테이블의 특정 열에 일치한 데이터를 기준으로 선정
	-- 비등가조인
-- 외부조인 (Outer JOIN) 9/6
	-- 왼쪽외부조인 (Left Outer Join) : 오른쪽 테이블에 + 기호
	-- 오른쪽외부조인 (Right Outer Join) : 왼쪽 테이블에 + 기호
	-- 전체외부조인 (Full Outer Join) : 잘 안씀

--SELECT * FROM EMP e, DEPT d; 

-- 1) 내부조인
-- 등가조인: EMP 테이블의 DEPTNO와 DEPT테이블의 DEPTNO가 일치 시 연결
SELECT e.EMPNO, e.ENAME, DEPTNO, d.DNAME, d.LOC 
--TODO: JOIN시, 별칭(d.)을 쓰지 않고 출력하려 하면 둘 다 해당하기때문에 다음과 같은 에러 발생 SQL Error [918] [42000]: ORA-00918: 열의 정의가 애매합니다
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO;

-- SAL이 3000 이상인 사원 조회
SELECT e.EMPNO, e.ENAME, d.DEPTNO, d.DNAME, d.LOC 
FROM EMP e, DEPT d 
WHERE e.DEPTNO = d.DEPTNO AND e.SAL >=3000;

--TODO: 비등가조인: 등가조인 이외의 방식
-- EMP / e.SAL + s.GRADE
SELECT *
FROM EMP e, SALGRADE s 
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL;

--TODO: 자체조인
-- MGR의 이름 조회
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.EMPNO AS MGR_EMPNO, e2.ENAME AS MGR_ENAME
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO; 

-- 외부조인 
-- Left Outer Join
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.EMPNO AS MGR_EMPNO, e2.ENAME AS MGR_ENAME
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO(+); 

-- Right Outer Join
SELECT e1.EMPNO, e1.ENAME, e1.MGR, e2.EMPNO AS MGR_EMPNO, e2.ENAME AS MGR_ENAME
FROM EMP e1, EMP e2
WHERE e1.MGR(+) = e2.EMPNO; 

--TODO 쿼리문 변화:: 표준안 개선
-- 내부조인: join ~ on
-- 외부조인: (LEFT) OUTER JOIN ~ ON / right OUTER JOIN ~ ON 
SELECT
	e.EMPNO,
	e.ENAME,
	d.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e
JOIN DEPT d 
ON
	e.DEPTNO = d.DEPTNO;

SELECT
	e.EMPNO,
	e.ENAME,
	d.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	EMP e
JOIN DEPT d 
ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.SAL >= 3000;

SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.EMPNO AS MGR_EMPNO,
	e2.ENAME AS MGR_ENAME
FROM
	EMP e1
LEFT OUTER JOIN EMP e2
ON
	e1.MGR = e2.EMPNO;

SELECT
	e1.EMPNO,
	e1.ENAME,
	e1.MGR,
	e2.EMPNO AS MGR_EMPNO,
	e2.ENAME AS MGR_ENAME
FROM
	EMP e1
RIGHT OUTER JOIN EMP e2
ON
	e1.MGR = e2.EMPNO;

-- TABLE 3개 조인
SELECT * FROM EMP e1 JOIN EMP e2 ON e1.MGR = e2.EMPNO JOIN EMP e3 ON e1.MGR = e3.EMPNO;

-- 각 부서별 평균 급여, 최대급여, 최소급여, 사원수를 조회
-- 부서번호, 부서명, 평균급여(AVG_SAL), 최대급여(MAX_SAL), 최소급여(MIN_SAL), 사원수(CNT)
SELECT e.DEPTNO, d.DNAME, AVG(e.SAL) AS AVG_SAL, MAX(e.SAL) AS MAX_SAL, MIN(e.SAL) AS MIN_SAL, COUNT(*) AS CNT
FROM EMP e JOIN DEPT d ON e.DEPTNO = d.DEPTNO
GROUP BY e.DEPTNO, d.DNAME -- d.DNAME 추가 -- SQL Error [979] [42000]: ORA-00979: GROUP BY 표현식이 아닙니다. 
ORDER BY e.DEPTNO; 

-- 모든 부서정보와 사원정보를 조회 (한명도 누락없이)
-- 부서번호, 부서명, 사원번호, 사원명, 직무(JOB), 급여
SELECT d.DEPTNO, d.DNAME, e.EMPNO, e.ENAME, e.JOB, e.SAL
FROM  DEPT d LEFT OUTER JOIN EMP e ON d.DEPTNO = e.DEPTNO 
ORDER BY d.DEPTNO, e.EMPNO;

--TODO: 서브쿼리 : 쿼리문 안에 또 다른 쿼리문(SELECT, UPDATE, DELETE,INSERT)이 포함
	--SELECT 
	--FROM 
	--WHERE (SELECT FROM WHERE)

	--SELECT 
	--FROM (SELECT FROM WHERE)
	--WHERE 

	--SELECT (SELECT FROM WHERE)
	--FROM 
	--WHERE 

-- JONES의 월급보다 많은 월급을 받는 사원 조회
SELECT *
FROM EMP e 
WHERE e.SAL > 2975;

SELECT
	*
FROM
	EMP e
WHERE
	e.SAL > (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.ENAME = 'JONES');

-- 서브쿼리 와 연산자
	-- 실행결과가 하나인 단일행 서브쿼리
	-- >, >=, =, <, <=, <>, !=, ^=

-- KING 보다 빠른 입사자 조회
SELECT * 
FROM EMP e 
WHERE e.HIREDATE < (SELECT e2.HIREDATE FROM EMP e2 WHERE e2.ENAME = 'KING');	

-- ALLEN 보다 추가수당 많이 받는 사원 조회
SELECT * FROM EMP e WHERE e.COMM > (SELECT e2.COMM FROM EMP e2 WHERE e2.ENAME = 'ALLEN' )

-- 20번 부서에 근무하는 사원 중 전체 사원의 평균 급여보다 높은 급여를 받은 사원 조회
SELECT * FROM EMP e WHERE e.DEPTNO= 20 AND e.SAL > (SELECT AVG(e2.SAL) FROM EMP e2 );

-- 20번 부서에 근무하는 사원 중 전체 사원의 평균 급여보다 높은 급여를 받은 사원 조회 + 부서명, 부서위치
SELECT
	e.*, d.DNAME, d.LOC 
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.DEPTNO = 20
	AND e.SAL > (
	SELECT
		AVG(e2.SAL)
	FROM
		EMP e2 );

--TODO:  실행 결과가 여러 개인 다중행 서브쿼리 (연산기호 쓰면 안됨 =>단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.)
	-- IN : 메인 쿼리의 데이터가 서브쿼리의 결과 중 하나라도 일치한 데이터가 있다면 TRUE
	-- ANY(SOME) : 메인 쿼리의 조건식을 만족하는 서브쿼리의 결과가 하나 이상이면 TRUE
	-- ALL : 메인 쿼리의 조건식을 서브 쿼리의 결과 모두가 만족하면 TRUE
	-- EXISTS : 서브 쿼리의 결과가 존재하면 (즉, 행이 1개 이상일 경우) TRUE

-- 각 부서별 최고  급여와 동일하거나 큰 급여를 받는 사원 조회
SELECT *
FROM EMP e 
WHERE e.SAL >= (SELECT MAX(e2.SAL) FROM EMP e2 GROUP BY e2.DEPTNO); -- SQL Error [1427] [21000]: ORA-01427: 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.

SELECT *
FROM EMP e 
WHERE e.SAL IN (SELECT MAX(e2.SAL) FROM EMP e2 GROUP BY e2.DEPTNO);

--TODO: IN : =ANY 둘이 같은 결과
SELECT *
FROM EMP e 
WHERE e.SAL  = ANY (SELECT MAX(e2.SAL) FROM EMP e2 GROUP BY e2.DEPTNO);

SELECT *
FROM EMP e 
WHERE e.SAL  = SOME (SELECT MAX(e2.SAL) FROM EMP e2 GROUP BY e2.DEPTNO);

-- 30번 부서의 급여보다 적은 급여를 받는 사원 조회
-- 30번 부서의 최대급여 보다 적은 사원 조회하는 결과와 같아짐
-- 다중행 서브쿼리로 할때
SELECT *
FROM EMP e 
WHERE e.SAL  < ANY (SELECT e2.SAL FROM EMP e2 WHERE e2.DEPTNO = 30)
ORDER BY e.SAL, e.EMPNO;

-- 단일행 서브쿼리로 할때
SELECT *
FROM EMP e 
WHERE e.SAL  < (SELECT MAX(e2.SAL) FROM EMP e2 WHERE e2.DEPTNO = 30)
ORDER BY e.SAL, e.EMPNO;

-- 30번 부서의 급여보다 적은 급여를 받는 사원 조회
-- 30번 부서의 최대급여 보다 적은 사원 조회하는 결과와 같아짐
-- 다중행 서브쿼리로 할때
SELECT *
FROM EMP e 
WHERE e.SAL  < ANY (SELECT e2.SAL FROM EMP e2 WHERE e2.DEPTNO = 30)
ORDER BY e.SAL, e.EMPNO;

-- 단일행 서브쿼리로 할때
SELECT *
FROM EMP e 
WHERE e.SAL  < (SELECT MAX(e2.SAL) FROM EMP e2 WHERE e2.DEPTNO = 30)
ORDER BY e.SAL, e.EMPNO;

-- 30번 부서의 급여보다 많은 급여를 받는 사원 조회
-- 30번 부서의 최대급여 보다 최소 급여 보다 많은 사원 조회하는 결과와 같아짐
-- 다중행 서브쿼리로 할때
SELECT *
FROM EMP e 
WHERE e.SAL  > ANY (SELECT e2.SAL FROM EMP e2 WHERE e2.DEPTNO = 30)
ORDER BY e.SAL, e.EMPNO;

-- 단일행 서브쿼리로 할때
SELECT *
FROM EMP e 
WHERE e.SAL > (SELECT MIN(e2.SAL) FROM EMP e2 WHERE e2.DEPTNO = 30)
ORDER BY e.SAL, e.EMPNO;

-- 부서번호가 30번인 사원들의 최소 급여보다 더 적은 사원 조회 (ALL 다 만족해야하기 때문)
-- ALL
SELECT *
FROM EMP e 
WHERE e.SAL < ALL (SELECT e2.SAL FROM EMP e2 WHERE e2.DEPTNO = 30)
ORDER BY e.SAL, e.EMPNO;

-- EXISTS
SELECT *
FROM EMP e 
WHERE EXISTS (SELECT DNAME FROM DEPT d WHERE DEPTNO = 10);

SELECT *
FROM EMP e 
WHERE EXISTS (SELECT DNAME FROM DEPT d WHERE DEPTNO = 50);

-- 비교할 열이 여러 개인 다중열 서브쿼리
SELECT *
FROM EMP e 
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP e2 GROUP BY DEPTNO);

-- FROM절에 작성하는 서브쿼리(==인라인뷰) 작성
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10, (SELECT* FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

--TODO: SELECT 절에 작성하는 서브쿼리(== 스칼라 서브쿼리)
-- SELECT 절에 사용하는 서브쿼리는 단 하나의 결과만 반환해야 함
SELECT
	E.EMPNO,
	E.JOB,
	E.SAL,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.SAL BETWEEN s.LOSAL AND s.HISAL) AS SALGRADE,
	E.DEPTNO,
	(SELECT d.DNAME FROM DEPT d WHERE e.DEPTNO = d.DEPTNO) AS DNAME	
FROM EMP e;

SELECT * FROM emp;

-- 9/9 TODO: DDL INSERT(삽입)

-- 테이블 복사 후 사용 (원본 놔두기)
CREATE TABLE dept_temp AS SELECT * FROM DEPT;

SELECT * FROM DEPT_TEMP dt;

--INSERT INTO 테이블명(열이름1, 열이름2,...) TODO: 열 이름 생략 가능
--VALUES (열이름에 맞춰 값 나열)

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(50, 'DATABASE', 'SEOUL');

INSERT INTO DEPT_TEMP
VALUES(60, 'DATABASE', 'SEOUL');

-- SQL Error [947] [42000]: ORA-00947: 값의 수가 충분하지 않습니다
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(70, 'DATABASE', NULL); --TODO: 안넣을거면 VALUES 에 (NULL) 이라도 넣던가

--TODO: 안넣을거면 해당 열 명시하지 않던가 (LOC열 빼기)
INSERT INTO DEPT_TEMP(DEPTNO, DNAME)
VALUES(80, 'DATABASE');

CREATE TABLE EMP_temp AS SELECT * FROM EMP;
SELECT * FROM EMP_temp;
-- 전체 필드에 값을 추가할 때
-- 날짜데이터 : 홑따옴표 안에 - OR / 로 입력하면 됨
INSERT INTO EMP_temp VALUES(9999, '홍길동', 'PRESIDENT', NULL, '2001-01-01', 5000, 1000, 10);
-- 부분적으로 값을 추가 시
INSERT INTO EMP_temp(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO) 
VALUES(8888, '성춘향','SALESMAN',SYSDATE,3000,20);

-- 날짜를 일/월/년 순으로 입력하면?
-- SQL Error [1830] [22008]: ORA-01830: 날짜 형식의 지정에 불필요한 데이터가 포함되어 있습니다
INSERT INTO EMP_temp(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO) 
VALUES(7777, '이순신','SALESMAN','07/08/2023',3000,20);

-- TO_DATE('날짜', '형식') 알려주기
INSERT INTO EMP_temp(EMPNO,ENAME,JOB,HIREDATE,SAL,DEPTNO) 
VALUES(7777, '이순신','SALESMAN',TO_DATE('07/08/2023', 'DD/MM/YYYY'),3000,20);


-- 테이블 제거
DROP TABLE EMP_temp;
-- 테이블 복사 시, 테이블 구조만 복사하고 데이터는 복사안하기
CREATE TABLE EMP_temp AS SELECT * FROM EMP WHERE 1<>1;
SELECT * FROM EMP_temp;

-- EMP 테이블과 SALGRADE 조인 후 급여등급이 1인 사원들만 EMP_temp 에 삽입 (서브쿼리)
-- 비등가조인
--TODO: 데이터가 추가되는 테이블의 열 개수와 서브쿼리 열 개수 일치 & 자료형 일치
INSERT INTO EMP_temp(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
SELECT e.EMPNO, e.ENAME, e.JOB, e.MGR, e.HIREDATE, e.SAL, e.COMM, e.DEPTNO
FROM EMP e JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL 
WHERE (s.GRADE = 1);

-- UPDATE(수정)
	--UPDATE 변경테이블명
	--SET 변경할열=값, 변경할열=값,...
	--WHERE 변경할 대상 행 조건

SELECT * FROM DEPT_TEMP dt;

-- 모든 행의 LOC 를 SEOUL 로 변경
UPDATE DEPT_TEMP 
SET LOC = 'SEOUL';

CREATE TABLE dept_temp2 AS SELECT * FROM DEPT;

-- 40번 부서의 DNAME DATABASE, LOC SEOUL 로 변경
UPDATE DEPT_TEMP2
SET DNAME='DATABASE', LOC='SEOUL'
WHERE DEPTNO=40;
SELECT * FROM DEPT_TEMP2;
-- EMP_TEMP 의 사원들 중 급여가 2500 이하인 사원들의 추가수당을 50으로 수정
UPDATE EMP_TEMP
SET COMM = 50
WHERE SAL <= 2500;
SELECT * FROM EMP_TEMP;

-- DEPT 테이블의 DEPTNO = 40 부서의 DNAME, LOC 를 추출하여 DEPT_TEMP2의 DNAME, LOC 수정
UPDATE
	DEPT_TEMP2
SET
	(DNAME,
	LOC) = 
(
	SELECT
		DNAME,
		LOC
	FROM
		DEPT d
	WHERE
		DEPTNO = 40)
WHERE DEPTNO = 40;

SELECT * FROM DEPT_TEMP2;

-- DELETE : 데이터 삭제
--DELETE 테이블명 WHERE 삭제할조건 (FROM 이 필수가 아님)
--DELETE FROM 테이블명 WHERE 삭제할조건
-- DELETE 테이블명; (전체데이터삭제)

CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP;
SELECT * FROM EMP_TEMP2;

-- JOB = 'MANAGER' 인 사원삭제
DELETE EMP_TEMP2 WHERE JOB='MANAGER';

DELETE FROM EMP_TEMP2;

-- EMP 테이블 행 전부 추출 후 EMP_TEMP2 에 삽입
INSERT INTO EMP_TEMP2(EMPNO, ENAME, JOB,MGR, HIREDATE, SAL, COMM,DEPTNO)
(SELECT EMPNO, ENAME, JOB,MGR, HIREDATE, SAL, COMM,DEPTNO FROM EMP e);
SELECT *FROM EMP_TEMP2;

-- 서브쿼리
-- 급여 등급이 3등급이고, 부서번호가 30번인 사원 삭제
DELETE
FROM
	EMP_TEMP2
WHERE
	EMPNO IN(
	SELECT
		E.EMPNO
	FROM
		EMP_TEMP2 E
	JOIN SALGRADE s ON
		E.SAL BETWEEN S.LOSAL AND S.HISAL
		AND S.GRADE = 3
		AND E.DEPTNO = 30);

-- 테이블복사
	-- EMP, DEPT, SALGRADE 테이블 복사
	-- EXAM_EMP, EXAM_DEPT, EXAM_SALGRADE 로 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP e;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT d;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE s;
-- INSERT
	-- EXAM_DEPT 테이블에 50,60,70,80 부서 등록
	-- 50: ORACLE,BUSAN / 60: SQL,ILSAN / 70: SELECT,INCHEON / 80: DML,BUNDANG
INSERT INTO EXAM_DEPT VALUES (50, 'ORACLE', 'BUSAN');
INSERT INTO EXAM_DEPT VALUES (60, 'SQL', 'ILSAN');
INSERT INTO EXAM_DEPT VALUES (70, 'SELECT', 'INCHEON');
INSERT INTO EXAM_DEPT VALUES (80,'DML', 'BUNDANG');

SELECT * FROM EXAM_DEPT;
-- EXAM_EMP 사원등록
	-- 7201, TEST_USER1, MANAGER, 7788, 2016-01-02, 4500, NULL, 50
	-- 7202, TEST_USER2, CLERK, 7201, 2016-02-21, 1800, NULL, 50
	-- 7203, TEST_USER3, ANALYST, 7201, 2016-04-11, 3400, NULL, 60
	-- 7204, TEST_USER4, SALESMAN, 7201, 2016-05-31, 2700, NULL, 60
	-- 7205, TEST_USER5, CLERK, 7201, 2016-07-20, 2600, NULL, 70
	-- 7206, TEST_USER6, CLERK, 7201, 2016-09-08, 2300, NULL, 70
	-- 7207, TEST_USER7, LECTURER, 7201, 2016-10-28, 4500, NULL, 80
INSERT INTO EXAM_EMP VALUES(7201, 'TEST_USER1', 'MANAGER', 7788, '2016-01-02', 4500, NULL, 50);
INSERT INTO EXAM_EMP VALUES(7202, 'TEST_USER2', 'CLERK', 7201, '2016-02-21', 1800, NULL, 50);
INSERT INTO EXAM_EMP VALUES(7203, 'TEST_USER3', 'ANALYST', 7201, '2016-04-11', 3400, NULL, 60);
INSERT INTO EXAM_EMP VALUES(7204, 'TEST_USER4', 'SALESMAN', 7201, '2016-05-31', 2700, NULL, 60);
INSERT INTO EXAM_EMP
VALUES(7205, 'TEST_USER5', 'CLERK', 7201, '2016-07-20', 2600, NULL, 70);
INSERT INTO EXAM_EMP
VALUES(7206, 'TEST_USER6', 'CLERK', 7201, '2016-09-08', 2300, NULL, 70);
INSERT INTO EXAM_EMP
VALUES(7207, 'TEST_USER7', 'LECTURER', 7201, '2016-10-28', 4500, NULL, 80);

SELECT * FROM EXAM_EMP;
-- UPDATE
	-- EXAM_EMP 에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은 급여를 받고있는 사원들을 70번 부서로 변경
UPDATE EXAM_EMP  SET DEPTNO = 70
WHERE SAL >= (SELECT MAX(SAL) FROM EXAM_EMP WHERE DEPTNO=50);
	-- EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게입사한 사원의 급여를 10% 인상하고 80번 부서로 변경
UPDATE EXAM_EMP SET SAL=SAL*1.1, DEPTNO = 80
WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM EXAM_EMP WHERE DEPTNO = 60);

SELECT * FROM EXAM_EMP;
-- DELETE
-- EXAM_EMP 에 속한 사원 중 급여 등급이 5인 사원 삭제
DELETE
FROM
	EXAM_EMP
WHERE
	EMPNO IN(
	SELECT
		EMPNO
	FROM
		EXAM_EMP e
	JOIN SALGRADE s
	ON
		e.SAL BETWEEN s.LOSAL AND s.HISAL
		AND s.GRADE = 5);

SELECT * FROM EXAM_EMP;

-- 트랜잭션 : 최소 수행단위
-- 		은행계좌이체()
--		COMMIT(반영), ROLLBACK(취소)
-- INSERT, DELETE, UPDATE => 데이터 변화

-- AUTO-COMMIT : 자동반영	

-- 취소 불가한 트랜잭션 시작
CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
-- 트랜잭션 종료

-- 트랜잭션 시작
INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
SELECT * FROM DEPT_TCL; -- (SELECT 어차피 영향 안끼침)
-- 트랜잭션 종료

-- 트랜잭션 취소
ROLLBACK;

SELECT * FROM DEPT_TCL;
	
-- 트랜잭션 시작
INSERT INTO DEPT_TCL VALUES(50, 'DATABASE', 'SEOUL');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';	
	
SELECT * FROM DEPT_TCL;

-- 트랜잭션 반영
COMMIT;
-- 트랜잭션 종료

SELECT * FROM DEPT_TCL;
	
DELETE FROM DEPT_TCL WHERE DEPTNO = 50;
COMMIT;

UPDATE DEPT_TCL SET LOC = 'SEOUL' WHERE DEPTNO = 30;
COMMIT; -- COMMIT 안한 상태로 SQLPLUS 에서 SELECT문 이외에 실행하면 LOCK 된 상태가 된다.













