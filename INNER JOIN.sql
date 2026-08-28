#조인(JOIN) : 2개 이상의 테이블에서 테이터를 조회하는 문법
SELECT * FROM emp;
SELECT * FROM dept;

#조인 학습 전 사전 내용
#사실  - (테이블명.컬럼명)
SELECT EMP.EMPNO , ENAME, SAL, JOB
FROM emp;

SELECT EMPNO, ENAME
FROM emp AS COMPANY;

#별칭 사용(컬럼명, 테이블명 사용 가능하나 테이블명 별칭사용시 조회할 때 별칭명.컬럼명으로 조회해야한다!/ 컬럼 지칭 시 별칭 생략 가능)
SELECT COMPANY.EMPNO, ENAME
FROM emp AS COMPANY;

#CROSS 조인 (조회된 테이블 나열 : 중복 컬럼은 테이블 지정 : 실제 유효한 데이터+불필요 데이터도 함께 조회된다!!!)
#사원들의 사번, 사원명, 부서번호, 부서명
SELECT EMPNO, ENAME, E.DEPTNO, D.DEPTNO, DNAME
FROM emp E, dept D;

#INNER 조인 (WHERE 절을 사용!) *두 테이블의 공통 컬럼값 조회
SELECT EMPNO, ENAME, E.DEPTNO, D.DEPTNO, DNAME
FROM emp E, dept D
WHERE E.DEPTNO = D.DEPTNO;

#ANSI-SQL(국제표준)
SELECT EMPNO, ENAME, E.DEPTNO, D.DEPTNO, DNAME
FROM emp E INNER JOIN dept D
ON E.DEPTNO = D.DEPTNO;

#직급이 '사원'이 아닌 직원의 사번, 사원명, 직급, 부서번호, 부서명 조회
#조회 시 ANSI-SQL, MARIA DB 문법 사용
SELECT
EMPNO, ENAME, JOB, D.DEPTNO, D.DNAME
FROM emp E INNER JOIN dept D
ON E.DEPTNO = D.DEPTNO
WHERE JOB NOT LIKE '사원';

SELECT
EMPNO, ENAME, JOB, D.DEPTNO, D.DNAME
FROM emp E, dept D
WHERE E.DEPTNO = D.DEPTNO
AND JOB != '사원';


#부서번호가 10, 20번인 부서에 소속된 직원의 사번, 사원명, 부서명, 부서지역 조회
SELECT
EMPNO, ENAME, DNAME, D.LOC
FROM emp E INNER JOIN dept D
ON E.DEPTNO = D.DEPTNO
WHERE
E.DEPTNO = '10' OR E.DEPTNO = '20';

SELECT
EMPNO, ENAME, DNAME, LOC
FROM emp INNER JOIN dept
ON emp.DEPTNO = dept.DEPTNO
WHERE emp.DEPTNO IN (10, 20);


