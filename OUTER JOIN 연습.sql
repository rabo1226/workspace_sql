-- 기존 테이블 제거 (실습 재시작 시)
DROP TABLE IF EXISTS enrollment;
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS course;

-- 1. 학생 테이블
CREATE TABLE student (
    student_id   INT          PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(20)  NOT NULL,
    grade        INT          NOT NULL COMMENT '학년 (1~3)',
    phone        VARCHAR(15)
);

-- 2. 과목 테이블
CREATE TABLE course (
    course_id    INT         PRIMARY KEY AUTO_INCREMENT,
    course_name  VARCHAR(30) NOT NULL,
    teacher      VARCHAR(20) NOT NULL,
    max_students INT         DEFAULT 10
);

-- 3. 수강신청 테이블 (중간 테이블)
CREATE TABLE enrollment (
    enroll_id   INT  PRIMARY KEY AUTO_INCREMENT,
    student_id  INT  NOT NULL,
    course_id   INT  NOT NULL,
    enroll_date DATE NOT NULL,
    score       INT  COMMENT '시험 점수 (0~100)',
    FOREIGN KEY (student_id) REFERENCES student(student_id),
    FOREIGN KEY (course_id)  REFERENCES course(course_id)
);

-- ============================================
-- 테스트 데이터 INSERT
-- ============================================

-- 학생 데이터 (일부러 수강 안 한 학생 포함)
INSERT INTO student (student_name, grade, phone) VALUES
('김민준', 1, '010-1111-0001'),
('이서연', 1, '010-1111-0002'),
('박지훈', 2, '010-1111-0003'),
('최수아', 2, '010-1111-0004'),
('정태양', 3, '010-1111-0005'),
('한지민', 3, NULL);          -- 수강신청을 아직 안 한 학생

-- 과목 데이터 (일부러 수강생 없는 과목 포함)
INSERT INTO course (course_name, teacher, max_students) VALUES
('Java 기초',     '김강사', 10),
('Spring Boot',  '이강사', 8),
('React',        '박강사', 12),
('Python 데이터', '최강사', 10),  -- 아직 수강생 없는 과목
('데이터베이스',  '정강사', 15);  -- 아직 수강생 없는 과목

-- 수강신청 데이터
INSERT INTO enrollment (student_id, course_id, enroll_date, score) VALUES
(1, 1, '2025-03-02', 88),   -- 김민준 → Java 기초
(1, 2, '2025-03-02', 75),   -- 김민준 → Spring Boot
(2, 1, '2025-03-02', 92),   -- 이서연 → Java 기초
(3, 2, '2025-03-05', 81),   -- 박지훈 → Spring Boot
(3, 3, '2025-03-05', 67),   -- 박지훈 → React
(4, 1, '2025-03-07', 95),   -- 최수아 → Java 기초
(4, 3, '2025-03-07', NULL), -- 최수아 → React (아직 점수 없음)
(5, 2, '2025-03-10', 70);   -- 정태양 → Spring Boot
-- 한지민(6번)은 수강신청 없음
-- Python 데이터(4번), 데이터베이스(5번)는 수강생 없음

COMMIT;


# ============================================================
# [연습 문제] - 서브쿼리 사용 금지, JOIN 절만으로 작성하세요.
# ============================================================
 
#   1. 모든 학생의 이름, 학년, 수강 신청 건수를 조회하시오.
#      수강 신청을 한 번도 하지 않은 학생도 포함하고, 이 경우 신청 건수는 0으로 표시되어야 한다.

SELECT	
	STUDENT_NAME
	, GRADE
	, E.course_id AS 수강신청건수
FROM STUDENT S
LEFT OUTER JOIN ENROLLMENT E
ON S.student_id = S.student_id;

SELECT
	STUDENT_NAME
	, GRADE
	, COUNT(enroll_id) #수강신청 아이디
FROM STUDENT S
LEFT OUTER JOIN ENROLLMENT E
ON S.STUDENT_ID = E.STUDENT_ID
GROUP BY S.STUDENT_ID;
 
#   2. 수강 신청을 한 번도 하지 않은 학생의 이름과 학년만 조회하시오.
SELECT
	S.STUDENT_ID
	, STUDENT_NAME
	, GRADE
	, ENROLL_ID
FROM STUDENT S
LEFT OUTER JOIN ENROLLMENT E
ON S.STUDENT_ID = E.STUDENT_ID
GROUP BY STUDENT_ID;
HAVING ENROLL_ID IS NULL;

SELECT
	STUDENT_NAME
	, GRADE
	, enroll_id
FROM STUDENT S
LEFT OUTER JOIN ENROLLMENT E
ON S.STUDENT_ID = E.STUDENT_ID
WHERE ENROLL_ID IS NULL;

 
#   3. 1번과 같은 결과를, 이번에는 RIGHT OUTER JOIN을 사용해서
#      (FROM 절 순서를 enrollment, student로 바꿔서) 작성해보시오.
SELECT
	STUDENT_NAME
	, GRADE
	, COUNT(enroll_id) #수강신청 아이디
FROM ENROLLMENT E
RIGHT OUTER JOIN  STUDENT S 
ON S.STUDENT_ID = E.STUDENT_ID
GROUP BY S.STUDENT_ID;

  
#   4. 모든 과목의 이름, 강사, 수강 신청한 학생 수를 조회하시오.
#      수강생이 없는 과목도 포함하고, 이 경우 학생 수는 0으로 표시되어야 한다.
SELECT
	 course_name
	, teacher
	, COUNT(enroll_id)
FROM course C
LEFT OUTER JOIN enrollment E
ON C.course_id = E.course_id
GROUP BY C.course_id;

  
#   5. 정원(max_students)이 아직 다 차지 않은 과목의 이름과 남은 자리 수를 조회하시오.
#      (남은 자리 수 = max_students - 현재 수강 신청 인원)
#      수강생이 한 명도 없는 과목도 결과에 포함되어야 한다.
SELECT
	C.COURSE_ID
	, course_name
	, max_students - COUNT(ENROLL_ID) AS '남은 자리 수'
FROM course C
LEFT OUTER JOIN enrollment E
ON C.course_id = E.course_id
GROUP BY course_id, MAX_STUDENTS
HAVING (max_students - COUNT(ENROLL_ID)) > 0;  

SELECT
	 course_name
	, max_students - COUNT(ENROLL_ID) AS '남은 자리 수'
	, MAX_STUDENTS
FROM course C
LEFT OUTER JOIN enrollment E
ON C.course_id = E.course_id
GROUP BY C.course_id
HAVING (max_students - COUNT(ENROLL_ID)) > 0;    #HAVING절은 GROUP BY 절에 참여한 조건만 가능
  
#   6. 수강 신청은 했지만 아직 점수(score)가 입력되지 않은 학생-과목 조합을 조회하시오.
#      (학생 이름, 과목명, 점수를 출력)
SELECT
	 STUDENT_NAME
	, course_name
	, SCORE
FROM ENROLLMENT E
LEFT OUTER JOIN STUDENT S
ON E.STUDENT_ID = S.STUDENT_ID
RIGHT OUTER JOIN COURSE C
ON E.COURSE_ID = C.COURSE_ID
WHERE SCORE IS NULL
GROUP BY SCORE;

SELECT
	 STUDENT_NAME
	, course_name
	, SCORE
FROM STUDENT S
INNER JOIN ENROLLMENT E
ON S.STUDENT_ID = E.STUDENT_ID
INNER JOIN COURSE C
ON E.COURSE_ID = C.COURSE_ID
WHERE SCORE IS NULL;                 #수강신처 PK는 존재하지만, 점수 컬럼의 자료가 없는 것 뿐이므로 OUTER JOIN 은 필요없다.

#   7. (심화) 1학년 또는 2학년이면서, 아직 수강 신청을 하지 않은 학생의 이름과 학년을 조회하시오.
SELECT
	STUDENT_NAME
	, GRADE
	, ENROLL_ID
FROM STUDENT S
LEFT OUTER JOIN ENROLLMENT E
ON S.STUDENT_ID = E.STUDENT_ID
WHERE GRADE IN (1 ,2) AND ENROLL_ID IS NULL;

#--------------------------------------------------------------------------------------------------------------------------
# SUB QEURY (서브 쿼리) - 쿼리 안에 또 다른 쿼리가 들어있는 구조
# 조인과 서브쿼리는 대부분 서로 변경이 가능
# 조인으로 작성된 쿼리 -> 서브쿼리로 작성
# 서브쿼리로 작성된 쿼리 -> 조인으로 작성
# 서브쿼리는 SELECT절, FROM절, WHERE절 등 다양한 곳에 작성할 수 있다.

# 서브쿼리는 크게 단일행 서브쿼리와 그렇지 않은 서브쿼리 두 가지로 구분한다.
# 단일행 서브쿼리 - 조회 시 데이터가 하나만 조회되는 서브쿼리
# 단일행 서브쿼리가 아닐 경우 '=' 대신 IN, ANY, ALL 과 같은 키워드와 함께 사용

#'김사랑' 사원과 같은 부서에 소속된 직원들의 사번, 사원명, 부서번호를 조회

SELECT * FROM emp;
SELECT * FROM dept;

# 1. '김사랑' 사원이 소속된 부서 번호
SELECT DEPTNO
FROM emp
WHERE ENAME = '김사랑';

# 2. 20번 부서의 사원정보 조회
SELECT
	EMPNO
	, ENAME
	, DEPTNO
FROM emp
WHERE DEPTNO = (SELECT DEPTNO
						FROM emp
						WHERE ENAME = '김사랑');
						
# '강혜정' 사원보다 급여를 더 많이 받는 사원들의 사번, 사원명, 급여를 조회
SELECT
	EMPNO
	, ENAME
	, SAL
FROM emp
WHERE SAL > (SELECT
						SAL
					FROM emp
					WHERE ENAME = '강혜정');

# '김사랑' 사원의 사번, 사원명, 직급, 부서번호, 부서명을 조회 (서브쿼리)
SELECT 
 DNAME
 , DEPTNO
FROM DEPT
WHERE DEPTNO = (SELECT DEPTNO, ENAME, JOB FROM emp WHERE ENAME = '김사랑');

SELECT
	ENAME
	, EMPNO
	, JOB
	, DEPTNO
	, (SELECT DNAME
		FROM dept 
		WHERE DEPTNO = emp.DEPTNO) AS 부서명
FROM emp;


# 인사부에 소속된 직원들의 평균 급여보다 더 높은 급여를 받는 사원들의 사번, 사원명, 급여, 부서명을 조회 (서브쿼리)
SELECT
	EMPNO
	, ENAME
	, SAL
	, (SELECT DNAME FROM dept WHERE DEPTNO = E.DEPTNO) AS 부서명
FROM emp E
WHERE SAL > (SELECT
					AVG(SAL)
				FROM emp
				WHERE DEPTNO = (SELECT 
										DEPTNO 
									FROM dept 
									WHERE DNAME = '인사부'));



#FROM절에 사용되는 서브쿼리
SELECT
	EMPNO
	, ENAME
	, SAL
FROM emp
WHERE EMPNO >= 1005;

# FROM절에 서브쿼리가 들어오면 반드시 별칭을 지정해야 함!
# FROM 절에 작성한 조회결과 데이터를 기반으로 데이터를 조호힌다!!!!!
# FROM (FROM 조회결과에서 조회를 하겠다!)   TABLE을 지칭하는게 아니다!

SELECT EMPNO, 급여 # JON, SAL 컬럼은 조회 불가0
FROM 
(
	SELECT
		EMPNO
		, ENAME
		, SAL  AS '급여'
	FROM emp
	WHERE EMPNO >= 1005
) AA ;

# '과장'직급을 가진 사원들이 소속된 부서와 동일한 부서에 속한 사원들의 사번, 사원명, 부서명을 조회하세요
SELECT
	EMPNO
	, ENAME
	, DEPTNO
FROM EMP
WHERE DEPTNO IN (SELECT DISTINCT
						DEPTNO 
					FROM emp 
					WHERE JOB = '과장');
					
# 30번 부서에 속한 사원의 어느 한명 보다도, 급여를 더 많이 받는 사원의 사번, 사원명, 급여 조회
SELECT
	EMPNO
	, ENAME
	, SAL
FROM emp
WHERE SAL > ANY (SELECT 
							SAL 
						FROM emp 
						WHERE DEPTNO = 30);

SELECT
	EMPNO
	, ENAME
	, SAL
FROM emp
WHERE SAL > (SELECT 
					MIN(SAL) 
				FROM emp 
				WHERE DEPTNO = 30);
				

# ANY (조건 하나 만족) / ALL (조건 전체 만족)
				
# 30번 부서에 속한 사원의 어느 누구보다, 급여를 더 많이 받는 사원의 사번, 사원명, 급여 조회
SELECT
	EMPNO
	, ENAME
	, SAL
FROM emp
WHERE SAL > ALL (SELECT 
						SAL
					FROM emp 
					WHERE DEPTNO = 30);
				
SELECT
	EMPNO
	, ENAME
	, SAL
FROM emp
WHERE SAL > (SELECT 
					MAX(SAL) 
				FROM emp 
				WHERE DEPTNO = 30);

#------------------- 문제------------------------------------
#1. 전체 수강신청 시험 점수의 평균보다 높은 점수를 받은 수강신청 내역을 조회하시오. (학생 이름, 과목명, 점수)

SELECT
STUDENT_NAME
, (SELECT 
	COURSE_ID
	, SCORE 
	FROM enrollment
	WHERE SCORE > (SELECT
						AVG(SCORE)
						FROM enrollment))
FROM student;


SELECT
	STUDENT_NAME
	, COURSE_NAME
	, SCORE
FROM student S
INNER JOIN enrollment E
ON S.student_id = E.student_id
INNER JOIN course C
ON E.COURSE_ID = C.course_id
WHERE SCORE > (SELECT
						AVG(SCORE)
					FROM enrollment);

#2. 가장 높은 점수를 받은 수강신청 내역을 조회하시오. (학생 이름, 과목명, 점수)
SELECT
	STUDENT_NAME
	, COURSE_NAME
	, SCORE
FROM student S
INNER JOIN enrollment E
ON S.student_id = E.student_id
INNER JOIN course C
ON E.COURSE_ID = C.course_id
WHERE SCORE = (SELECT MAX(SCORE) FROM enrollment);


#3. 정원(max_students)이 가장 큰 과목의 이름, 강사, 정원을 조회하시오.
SELECT 
	COURSE_NAME
	, TEACHER
	, MAX_STUDENTS
FROM course
WHERE MAX_STUDENTS = (SELECT MAX(MAX_STUDENTS) FROM COURSE);

#4.'이서연' 학생과 같은 학년인 학생의 이름과 학년을 조회하시오. (단, 이서연 본인은 결과에서 제외)
SELECT
	student_NAME
	, GRADE
FROM student
WHERE GRADE = (SELECT GRADE FROM student WHERE STUDENT_NAME = '이서연')
AND STUDENT_NAME != '이서연';

#5. 모든 학생의 이름, 학년과 함께 그 학생의 평균 점수를 조회하시오. 수강 신청이 없는 학생은 평균 점수가 NULL로 나와야 한다.
SELECT
STUDENT_NAME
, GRADE
, AVG(SCORE)
, ENROLL_ID
FROM student S
LEFT OUTER JOIN enrollment E
ON S.student_id = E.student_id
GROUP BY STUDENT_NAME;

SELECT
	STUDENT_NAME
	, GRADE
	, (SELECT AVG(SCORE) FROM enrollment WHERE STUDENT_ID = S.STUDENT_ID) AS '평균점수'
FROM student S; 


#6. 모든 과목의 이름, 강사와 함께 그 과목의 수강 신청 인원수를 조회하시오. 수강생이 없는 과목은 인원수가 0으로 나와야 한다.
SELECT
	COURSE_NAME
	, TEACHER
	, COUNT(E.ENROLL_ID)
FROM COURSE, (SELECT ENROLL_ID FROM enrollment) E
GROUP BY COURSE_NAME;

SELECT
	COURSE_NAME
	, TEACHER
	, COURSE_ID
	, (SELECT COUNT(ENROLL_ID) FROM enrollment WHERE COURSE_ID = C.course_id) AS '수강 신청 인원'
FROM course C;

#7. 과목별 평균 점수를 구한 결과를 파생 테이블(FROM절 안의 쿼리)로 만들고, 그중 평균 점수가 80점 이상인 과목의 이름과 평균 점수를 조회하시오.
SELECT
	과목명
	, 평균점수
FROM (SELECT
			COURSE_ID
			, (SELECT COURSE_NAME FROM course WHERE COURSE_ID = E.COURSE_ID) AS '과목명'
			, AVG(SCORE) AS '평균점수'
		FROM enrollment E
		GROUP BY COURSE_ID) AS AA
WHERE 평균점수 >= 80;


# -----------------------------------------------------------------------------------

-- 1. 회원 테이블
CREATE TABLE SUB_MEMBER (
    MEM_ID INT PRIMARY KEY,
    MEM_NAME VARCHAR(20),
    MEM_TYPE VARCHAR(10) -- 'VIP', '일반'
);

-- 2. 도서 테이블
CREATE TABLE SUB_BOOK (
    BOOK_ID INT PRIMARY KEY,
    TITLE VARCHAR(50),
    PRICE INT,
    CATEGORY VARCHAR(20)
);

-- 3. 대여 기록 테이블
CREATE TABLE SUB_RENTAL (
    RENT_ID INT PRIMARY KEY,
    MEM_ID INT,
    BOOK_ID INT,
    RENT_DATE DATE
);

-- 데이터 삽입
INSERT INTO SUB_MEMBER VALUES (1, '유재석', 'VIP'), (2, '박명수', '일반'), (3, '노홍철', '일반'), (4, '정형돈', 'VIP');
INSERT INTO SUB_BOOK VALUES (101, 'SQL 완성', 25000, 'IT'), (102, '자바 마스터', 30000, 'IT'), (103, '소설가 구보씨', 15000, '문학'), (104, '경제의 이해', 20000, '경제');
INSERT INTO SUB_RENTAL VALUES (1, 1, 101, '2024-01-01'), (2, 1, 102, '2024-01-05'), (3, 2, 103, '2024-02-01'), (4, 3, 101, '2024-02-10');

COMMIT;

#1. 대여 기록이 한 번이라도 있는 책의 제목을 조회하세요. (IN)
SELECT
	TITLE
FROM SUB_BOOK
WHERE BOOK_ID IN (SELECT DISTINCT BOOK_ID FROM SUB_RENTAL);


#2. 대여 기록이 한 번도 없는 책의 제목을 조회하세요.
SELECT
	TITLE
	, R.RENT_ID
FROM SUB_BOOK B
LEFT OUTER JOIN SUB_RENTAL R
ON B.BOOK_ID = R.BOOK_ID
WHERE R.RENT_ID IS NULL;

SELECT
	TITLE
FROM SUB_BOOK
WHERE BOOK_ID NOT IN (SELECT DISTINCT BOOK_ID FROM SUB_RENTAL);

#3. 'IT' 카테고리에 속한 그 어떤 책보다도 가격이 비싼 도서의 제목과 가격을 조회하세요
SELECT
	TITLE
	, PRICE
FROM SUB_BOOK
WHERE PRICE > ALL(SELECT 
							PRICE 
						FROM SUB_BOOK 
						WHERE CATEGORY = 'IT');

SELECT
	TITLE
	, PRICE
FROM SUB_BOOK
WHERE PRICE > (SELECT 
						MAX(PRICE) 
					FROM SUB_BOOK 
					WHERE CATEGORY = 'IT');

#4. 'IT' 카테고리 도서 중 가장 저렴한 책보다만 비싸면 되는 도서의 제목과 가격을 조회하세요.
SELECT
	TITLE
	, PRICE
FROM SUB_BOOK
WHERE PRICE > ANY (SELECT 
							PRICE 
						FROM SUB_BOOK 
						WHERE CATEGORY = 'IT');


SELECT
	TITLE
	, PRICE
FROM SUB_BOOK
WHERE PRICE > (SELECT 
						MIN(PRICE) 
					FROM SUB_BOOK 
					WHERE CATEGORY = 'IT');













