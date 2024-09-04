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
	DEPTNO = 10;