#COMMIT, ROLLBACK

# - 데이터의 신뢰도를 확보할 수 있는 안전 장치
# - 데이터가 변할 때 한번 더 확인할 수 있도록 함.
# -> 데이터가 변할 때 (INSERT, UPDATE, DELETE)       /TABLE - 테이블이 변할 때(CRETAE, DROP)XXX

#COMMIT : 데이터 변화 확정시키겠다.
#ROLLBACK : 데이터 변화를 취소시키겠다.

#mariaDB는 기본적으로 AUTO CMMIT이 성정되어 있음.

#현재 AOTU COMMIT 설정 확인
SHOW VARIABLES LIKE 'autocommit%';

#AUTO COMMTI 설정 해제하는 명령어
SET AUTOCOMMIT = FALSE;   #TURE : AUTO COMMIT 활성화

SELECT * FROM dept;

INSERT INTO dept(DEPTNO, DNAME, LOC) 
VALUES (50, '회계부', '울산시');
INSERT INTO dept(DEPTNO, DNAME, LOC) 
VALUES (60, '생산부', '대구시');         #COMMIT 전이므로 임시저장 개념!   -> 데이터 신뢰성 확보!

ROLLBACK;                                #COMMIT 전 ROLLBACK 가능

COMMIT;                                  #COMMIT 후 ROLLBACK 불가

#-----------------------------------------------------------------------------------------------------

#자주 사용하는 함수

#CEIL : 올림 / FLOOR : 내림 / TRUNCATE : 내림(숫자, 내림자리)
SELECT 
	CEIL(123.456)
	, FLOOR(123.956)
	, TRUNCATE(123.456, 1)
	, TRUNCATE(123.456, 2)
	, ROUND(123.456)
	, ROUND(123.456, 1);
	
#나머지 연산
SELECT MOD(10, 4);

#문자 관련 함수
#SUBSTR : 문자열 일부분 추출
SELECT SUBSTR('ABCDEF', 3);    #3번째부터 문자 추출
SELECT SUBSTR('ABCDEF', 2, 4);   #('문자열', 시작INDEX, 출력 글자수);

#대소문자 변경
SELECT UPPER('MariaDB'), LOWER('MariaDB');

#공백제거 함수(왼공백, 좌공백, 좌우공백))   -> ID : TRIM( #{MEMID} )   :좌우공백만 관여, 중간 공백은NONO
SELECT LTRIM('         DB         '), RTRIM('         DB         '), TRIM('         DB         ');

#자릿수 맞추는 함수.
SELECT LPAD('DB', 5, '0'), RPAD('DB', 5, '0');

#CHAR_LENGTH() : 문자의 길이    -  LENGTH() : 문자의 길이 : ORACLE
#LENGTHB() : 문자의 바이트 길이  영어 및 숫자 : 1 바이트 / 한글 : 3바이트
SELECT CHAR_LENGTH('JA VA'), LENGTHB('JAVA'), LENGTHB('파이썬');

#문자열 나열
#오라클 문자열 나열 : CONCAT('문자열 매개변수 1', ''매개변수2), 
					   # :  /'\\' : SELECT 'JAVA'\\'PATHON'
SELECT CONCAT('자바', '파이썬', 'C++');

#문자열 교체
SELECT REPLACE('저는 20살 입니다', '20살', '40살');

#논리 함수
#I() = 삼항연산자와 같음
SELECT IF(10 > 2, '참', '거짓');

#NULL 데이터 치환               - NVL() : SQL시험 문제!
SELECT COMM,  IFNULL(COMM, 0), NVL(COMM, 10) FROM EMP;

#CASE 조회문
#EMP 테이블 사원번호, 사원명, 부서번호, 부서명 조회
#부서번호 : 부서번호 10 -> '인사부', 부서번호 20 -> '개발부' /  나머지 -> '영업부'
SELECT EMPNO
	, ENAME
	, DEPTNO
	, (CASE DEPTNO 
			 WHEN 10 THEN '인사부'
			 WHEN 20 THEN '개발부'
			 ELSE '영업부' 
			 END ) AS DNAME;
FROM emp;





