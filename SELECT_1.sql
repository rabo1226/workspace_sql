-- (한칸띄어쓰기)주석입니다!
#주석입니다^^
#쿼리문은 대소문자를 구분하지 않는다.
#단, 대부분의 개발자가 쿼리문은 대문자로 작성함.

#SQL문 실행 단축키
#실행 (F9) 			            	-  현재 열린 쿼리 탭의 모든 쿼리를 한 번에 실행
#선택실행 (Ctrl+F9) 				    -  드래그 한 영역의 퀴리를 실행   
#현재 쿼리 실행 (Ctrl+Shift+F9)	  -  커서가 올라가 있는 쿼리문을 실행

#데이터 조회 SQL 문 - SELECT
#기본문법 -[대괄호] 필요할 때만 작성
#SELECT 조회활컬럼명 FROM 테이블명 [WHERE 조회조건];

#1. EMP테이블에서 사원들의 사원명을 조회
SELECT ENAME FROM emp;

#2. EMP테이블에서 사원들의 사번, 사원명을 조회
SELECT EMPNO, ENAME FROM emp;

#3. EMP테이블에서 사원들의 모든 컬럼(열)정보 조회
SELECT * FROM emp;

#4. EMP테이블에서 사원들의 사번, 사원명, 직급, 급여 정보를 조회
SELECT EMPNO, ENAME, JOB, SAL FROM emp;

#데이터 조회 시 별칭 사용
SELECT EMPNO, EMPNO AS 사번  FROM emp;

#사번은 'NO', 사원명은 'NAME', 급여는 'SALARY' 라는 별칭을 이용해서 조회
#별칭 사용 시 'AS' 키워드 생략 가능
SELECT EMPNO NO, ENAME AS NAME, SAL AS SALARY FROM emp;

#조회 시 조건 추가
#같다(=) 다르다(!=, <>) , 그리고(AND), 이거(OR)

#1.급여가 500 이산인 사원의 사번, 사원명, 급여를 조회
SELECT EMPNO, ENAME, SAL 
FROM emp
WHERE SAL >= 500;

#2.직급이 사원인 직원들의 모든 정보를 조회
SELECT * 
FROM emp 
WHERE JOB = '사원'; #문자열 자바("문자열"), JS,DB('문자열')

#3. 급여가 300이상, 700이하인 사원들의 사번, 사원명, 급여 정보를 조회
SELECT EMPNO, ENAME, SAL
FROM emp
WHERE SAL >= 300 AND SAL <= 700;

#4.직급이 사원이 아닌 직원 중에서 커미션(인센티브)이 NULL인 사원의 모든 정보 조회
#NULL 데이터는 '=' 기호로 판단하지 않는다.
#데이터가 NULL이다 -> 데이터 IS NULL
#데이터가 NULL이 아니다 -> 데이터 IS NO NULL
SELECT *
FROM emp
WHERE JOB != '사원' 
AND COMM IS NULL;