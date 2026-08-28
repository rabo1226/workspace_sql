#테이블 생성
#기본키(Primary Key, PK) : 행 하나하나를 구분지을 수 있는 열 : 주민등록번호 같은?
#기본키(PK 컬럼)가 되면 중복데이터 허용 안함, NUMLL도 안된다. (NOT NULL 설정하면 NULL허용XXX)
CREATE TABLE TEST_MEMBER(
	MEM_NUMBER INT PRIMARY KEY
	, NAME VARCHAR(50) NOT NULL
	, AGE INT
	, ADDR VARCHAR(100)
);

#테이블 제거  테이블(+데이터) 전체삭제 / (데이터 제거는 테이블 속 데이터 삭제)
DROP TABLE test_member;

SELECT * FROM test_member;

#데이터 추가
#문법
#IINSERT INTO 테이블명(컬럼들) VALUES (값들);    *컬럼 순서에 맞게 값 입력해야함!!
INSERT INTO test_member(NAME, AGE, ADDR, MEM_NUMBER) 
VALUES('KIM', 30, '울산', 1);

INSERT INTO test_member(NAME, AGE, ADDR, MEM_NUMBER) 
VALUES('KIM', 30, '울산', 2);

INSERT INTO test_member(NAME, MEM_NUMBER) 
VALUES('LEE', 3);

INSERT INTO test_member(MEM_NUMBER, AGE, ADDR) 
VALUES(4, 50, '제주도');


#데이터 삭제
#문법
#DELETE FROM 테이블명 [WHERE 조건]
DELETE FROM test_member
WHERE MEM_NUMBER = 2;


#데이터 수정
#문법
#UPDATE 테이블명 SET 컬럼=값, 컬럼=값 [WHERE 조건];
UPDATE test_member
SET 
AGE = 80
, ADDR = '울산'
WHERE MEM_NUMBER = 3;