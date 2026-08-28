# emp테이블에서 급여가 300이상이면서 600이하인 사원들의 모든 정보 조회
SELECT * FROM emp 
WHERE SAL >= 300 AND SAL <= 600;  #사이값은 300, 600 포함

#범위 조건 : 컬럼 BTWEEN A AND B
SELECT * FROM emp
WHERE SAL BETWEEN 300 AND 600;   #같은 연산자이라면 실행속도가 빠른 연산자를 선호! 그래서 BETWEEN보다 비교연산자가 이득?

#급여가 300, 500, 600인 사원들의 사번, 사원명, 급여 조회
SELECT EMPNO, ENAME, SAL
FROM emp
WHERE SAL = 300 OR SAL = 500 OR SAL = 600;

#위 쿼리와 같은 내용을 IN 연산자로 사용하면,              # OR, IN연산자은 둘다 사용 가능! 속도 차이 없다!
SELECT EMPNO, ENAME, SAL
FROM emp
WHERE SAL IN (300, 500, 600);

#직급이 '사원'이거나 '과장'인 직원들의 모든 정보를 조회(IN연산자)
SELECT *
FROM EMP
WHERE JOB IN ('사원', '과장');     #IN연산자는 숫자, 문자 모두 가능!

#LIKE 연산자와 와이드카드('_', '%')
#사원명에 '이'라는 글자가 포함된 직원들의 모든 정보를 조회
#'_' : 랜덤한 한 글자
#'%' : 랜덤한 글자(글자수 제한 없음))
# EX1) '__이'   ->이로 끝나는 세 글자
# EX2) '_김_' 	->두 번째 글자가 '김'인 네 글자
# EX3) '%이'    ->'_'로 끝나는 모든 글자,  '1이', '12이' '123이', '이'도 가능
# EX4) '%이_' 	->끝에서 두 번째 글자가 '이'인 모든 글자
SELECT *
FROM emp
WHERE ENAME LIKE '%이%';

#중복 제거
#조회할 컬럼명 앞에 DISTINCT 키워드를 붙이면 중복 데이터를 제거 후 조회
#EMP 테이블에서 직급의 종류를 조회
SELECT DISTINCT JOB FROM emp;

#직급과 부서번호를 중복없이 조회
#컬럼이 여러개라도 DISTINCT 키워드는 한 번 만 붙인다.
SELECT DISTINCT JOB, DEPTNO FROM emp;

#조회 시 데이터 정렬하기
#정렬 문법(조회쿼리문의 마지막에 작성) :  ORDER BY 정렬기준컬럼 정렬방식;
#정렬방식 :  오름차순-ASC (생략가능), 내림차순-DESC
#EMP테이블에서 사번, 사원명, 급여를 조회하되, 급여 기준 오름차순 정렬
SELECT EMPNO, ENAME, SAL
FROM emp
ORDER BY SAL ASC;

#EMP테이블에서 사번, 사원명, 급여를 조회하되, 사원명기준 내림차순 정렬
SELECT EMPNO, ENAME, SAL
FROM emp
ORDER BY ENAME DESC;

#EMP테이블에서 모든 정보를 조회하되, 직급기준 내림차순 정렬 후 직급이 같아면 같을 땐 급여 기준 오름차순 정렬
SELECT *
FROM emp
ORDER BY JOB DESC, SAL ASC;

# 1. EMP 테이블에서 커미션이 NULL이 아닌 사원 중, 급여가 350에서 650 사이인 사원들의 사원명, 급여, 커미션을 조회하되, 쿼리문 작성 시 BETWEEN 연산자를 사용하여 작성하시오.
SELECT ENAME, SAL, COMM
FROM emp
WHERE SAL BETWEEN 350 AND 650
AND COMM IS NOT NULL;

# 2. 직급이 과장, 차장, 부장인 직원의 사번, 사원명, 직급을 조회하되, 직급 기준 오름차순으로 정렬하고, 쿼리 작성 시 IN 연산자를 사용하시오.
SELECT EMPNO, ENAME, JOB
FROM emp
WHERE JOB IN ('과장', '차장', '부장')
ORDER BY JOB;

# 3. 부서번호가 10, 20인 부서에 소속된 직원 중, 이름에 ‘이’가 포함된 직원의 사번, 사원명, 부서번호, 급여를 조회하되, 부서번호 기준 내림차순으로 정렬 후, 부서번호가 같다면 급여가 낮은 순부터 조회하는 쿼리문을 작성하시오.
SELECT EMPNO, ENAME, DEPTNO, SAL
FROM emp
WHERE DEPTNO IN (10, 20)
AND ENAME LIKE '%이%'
ORDER BY DEPTNO DESC, SAL;


# 4. 이름이 ‘기＇로 끝나는 직원 중, 커미션은 NULL이고 급여는 400에서 800 사이인 직원의 모든 컬럼 정보를 조회하시오.
SELECT *
FROM emp
WHERE ENAME LIKE '%기'
AND COMM IS NULL
AND SAL BETWEEN 400 AND 800;

# 5. 다음과 같은 데이터가 있는 CLASS_INFO 테이블에서 SELECT DISTINCT CLASS_NAME, TEACHAR FROM CLASS_INFO WHERE CLASS_NAME = ‘자바반’; 으로 작성한 쿼리 실행 결과 조회되는 튜플(Tuple)의 갯수는? 3행




