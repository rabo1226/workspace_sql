#집계함수(GROUP BY, HAVING)

#단일행함수(우리가 알고 있는 함수 : ROUND, CONCAT 등등)   VS 집계함수

#단일행함수 : 데이터의 갯수만큼 함수 실행 결과가 조회되는 함수
SELECT EMPNO, NVL(COMM, 0) FROM emp;
#조회되는 실행결과 : 한 행이마다 적용된 함수가 적용된 결과가 나온다. = NAVL(COMM, NULL이면 0) 적용

#집계함수 : 데이터 수에 상관없이 무조건 하나의 결과를 조회하는 함수    EX) COMM의 총 합계
#대표적인 집계함수 : SUM(), MIN(), MAX(), COUNT(), AVG()

SELECT  
	SUM(SAL) AS 합계
	, MIN(SAL)
	, MAX(SAL)
	, COUNT(SAL)
	, AVG(SAL)
FROM emp;

#집계함수 사용 시 NULL 데이터의 유무에 주의가 필요하다!
#COUNT() 함수는 NULL 테이터는 갯수에 포함하지 않는다!
SELECT 
	COUNT(EMPNO)
	, COUNT(SAL)
	, COUNT(COMM)
	, SUM(COMM)     #NULL 데이터 제외한 값들의 합계를 구한다.
	, MIN(COMM)
	, MAX(COMM)
	, AVG(COMM)    #SUM(COMM) / COUNT(COMM)    => NULL데이터는 빠져있는 연산!!!
	, COUNT(NVL(COMM, 0))  #전 사원 COMM 수
	, AVG(NVL(COMM,0)) 	  #전 사원 COMM 평균
FROM emp;

SELECT COMM, COMM + 10 FROM emp;   #NULL데이터는 연산되지 않는다. NULL 연산 = NULL -> 데이터베이스에서 NULL = '아직 데이터가 정해지지 않았다.'

#집계함수 사용 시 또다른 주의사항
#조회 쿼리의 기본 조건 : 조회 시 조회되는 모든 컬럼의 행 갯수는 동일하다
#아래 쿼리 예상 : 오라클 - 오류 발생! / MYSQL(MARIADB) - 잘못된 데이터 조회     :  집계함수는 집계함수끼리만 사용가능! 왜? 단일행함수가 아니니까!!!!! 
#																											다행으로 결과가 조회되어ㅑ하는 단일행과, 단행으로 조회되는 조회함수는 결과는 같이 조회할 수 없다!
SELECT 
	EMPNO
	, SAL
	, SUM(SAL)
FROM emp;

#집계 함수 사용 시 그룹핑하기

#부서별 집계
#GROUP BY절에 작성된 컬럼만 SELECT 절에 사용가능하다!
SELECT 
	DEPTNO
	, SUM(SAL)
	, MIN(SAL)
	, MAX(SAL)
	, COUNT(SAL)
FROM emp
GROUP BY DEPTNO;

#부서별 소속된 사원 수 조회
SELECT
	DEPTNO AS 부서명
	, COUNT(NVL(EMPNO, 0)) AS 사원수 
FROM emp
GROUP BY DEPTNO;

#직급별 최저 급여, 최고 급여 조회
SELECT
	JOB AS 직급별
	, MIN(NVL(SAL, 0))
	, MAX(NVL(SAL, 0))
FROM emp
GROUP BY JOB;

#사번이 짝수인 사원들을 대상으로, 
#부서별 급여의 합 및 평균을 조회 (단, 급여는 NULL이 없다라고 가정)
#조회 시, 부서 번호 기준 오름차순 정렬
SELECT
	DEPTNO
	, SUM(SAL)
	, AVG(SAL)
FROM emp
WHERE MOD(EMPNO, 2) = 0
GROUP BY DEPTNO;
ORDER BY EEPTNO;

#부서별 급여의 합 및 평균을 조회하되, 
#부서별 급여의 합이 1500이상인 데이터만 조회 -> 그룹핑 후 사용할 수 있는 조건은 HAVING 절에 작성한다.
SELECT
	DEPTNO
	, SUM(SAL)
	, AVG(SAL)
FROM emp
GROUP BY DEPTNO
HAVING SUM(SAL) >= 1500;

#최종 조회 쿼리 문법 (키워드 순서 중요~!!!!)
#쿼리 실행 순서
#FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY
SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY;

#'대리'를 제외한 직급을 갖는 직원들을 대상으로 직급별 사원수 및 평균 급여 조회한다. 
#단, 사원수가 2명 미만인 직급은 조회문에서 제외하고, 직급기준 내림차순 정렬하여 조회한다.
SELECT
	JOB AS 직급
	, COUNT(EMPNO) AS 사원수
	, AVG(SAL) AS '평균 급여'
FROM emp
WHERE JOB != '대리'
GROUP BY JOB
HAVING COUNT(EMPNO) > 2
ORDER BY JOB DESC;

#아래 쿼리는 실행이 가능할까?
#FROM -> WHERE -> GROUP BY -> HAVING -> SELECT(컬럼 동시 실행) -> ORDER BY (별칭 사용 가능!)
SELECT
	ENAME
	, SAL
	, (SAL * 12 + NVL(COMM, 0)) AS 연봉
	#, 연봉 * 1.1 AS '내년 연봉 인상률'     #칼럼 동시 실행이라서 별칭 적용 안된당!
FROM emp
#WHERE 연봉 >= 5000    #연봉이 5000 이상인 사람만 조회 
ORDER BY 연봉;

