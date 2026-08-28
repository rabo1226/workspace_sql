#게시판 웹 프로젝트에서 사용하는 테이블 생성
#테이블 생성 문법
#CREATE TABLE 테이블명 (
#컬럼명 자료형 [제약조건들]
#, 컬럼명 자료형 [제약조건들]
#, ...
#);

#컬럼 : 글번호, 제목, 내용, 작성자, 작성일, 조회수
DROP TABLE basic_board;
CREATE TABLE basic_board(
			#기본키 제약조건(PK : 일련번호 개념, (중복불허용, NULL 불허용))/ AUTO_INCREMENT : 자동증감
	BOARD_NUM INT PRIMARY KEY AUTO_INCREMENT
	, TITLE VARCHAR(50) NOT NULL
	, CONTENT VARCHAR(100)
	, WRITER VARCHAR(30) NOT NULL
	, CREATE_DATE DATETIME DEFAULT SYSDATE()   #(SYSTEAM DATE : INSERT 시킨 컴퓨터 시간으로 입력)
	, READ_CNT INT DEFAULT 0   #(정수 입력이 가능하지만, 입력이 없으면 0으로 입력)
);

SELECT * FROM basic_board;

INSERT INTO basic_board (BOARD_NUM, CONTENT, TITLE, WRITER)
VALUES (1, '내용입니다', '첫 번째 글', '홍길동');

INSERT INTO basic_board (BOARD_NUM, CONTENT, TITLE, WRITER, READ_CNT)
VALUES (2, NULL, '첫 번째 글', '홍길동', 3);

INSERT INTO basic_board (CONTENT, TITLE, WRITER)
VALUES ('내용입니다', '첫 번째 글', '홍길동');

#게시글 목록 조회
SELECT
BOARD_NUM
, TITLE
, WRITER
, CREATE_DATE
, READ_CNT
FROM basic_board
ORDER BY CREATE_DATE DESC;

SELECT
*
FROM basic_board
WHERE BOARD_NUM = ${BOARDNUM};


UPDATE basic_board
SET
READ_CNT = READ_CNT + 1
WHERE BOARD_NUM = 2;

SELECT
	BOARD_NUM
	, TITLE
	, WRITER
	, CREATE_DATE
	, READ_CNT
FROM basic_board
WHERE WRITER LIKE '%마%';

SELECT EMPNO
	, ENAME
	, CONCAT(EMPNO, ENAME)
	, CONCAT(EMPNO, ENAME, JOB)
	, CONCAT('A', 'B', 'C')
FROM EMP;






#--------------------------------------------------------------------------------------------

#상품 정보 테이블 - 상품번호, 상품명, 가격, 상품등록자, 상품등록일, 상품소개
CREATE TABLE basic_item(
 ITEM_NUM INT PRIMARY KEY AUTO_INCREMENT
 , ITEM_NAME VARCHAR(50) NOT NULL UNIQUE
 , ITEM_PRICE INT NOT NULL CHECK(ITEM_PRICE > 0)
 , SELLER VARCHAR(10) NOT NULL
 , REG_DATE DATETIME DEFAULT SYSDATE()
 , ITEM_INTRO VARCHAR(100) 
);



#기본테이터
INSERT INTO basic_item(ITEM_NAME, ITEM_PRICE, SELLER, ITEM_INTRO) 
VALUES ('청바지', 20000, '홍길동', '4계절 청바지');
INSERT INTO basic_item(ITEM_NAME, ITEM_PRICE, SELLER, ITEM_INTRO) 
VALUES ('선풍기', 30000, '이순신', '무소음 모터');
INSERT INTO basic_item(ITEM_NAME, ITEM_PRICE, SELLER, ITEM_INTRO) 
VALUES ('러닝화', 70000, '유관순', '러닝 입문자용');

SELECT *
FROM basic_item;

SELECT 
	ITEM_NUM
	, ITEM_NAME
	, ITEM_PRICE
	, SELLER
	, REG_DATE
FROM basic_item
ORDER BY ITEM_NUM DESC;

#특정 상품 조회!
SELECT
	ITEM_NUM
	, ITEM_NAME
	, ITEM_PRICE
	, SELLER
	, REG_DATE
	, ITEM_INTRO
FROM basic_item
WHERE ITEM_NUM = ${ITEMNUM};

SELECT
 ITEM_NUM
 , ITEM_NAME
 , ITEM_PRICE
 , SELLER
 , REG_DATE
 , ITEM_INTRO
FROM basic_item
WHERE ITEM_NUM = '2';

UPDATE basic_item
SET
 , ITEM_NAME = ${itemName}
 , ITEM_PRICE = ${itemPrice}
 , SELLER = ${seller}
 , REG_DATE = ${regDate}
 , ITEM_INTRO = ${itemIntro}
WHERE ITEM_NUM = 2;



#-------------------------------------------
CREATE TABLE basic_student (
	STU_NUM INT PRIMARY KEY AUTO_INCREMENT
	, STU_NAME VARCHAR(50) NOT NULL
	, STU_AGE INT NOT NULL
	, STU_TEL VARCHAR(20)
	, STU_ADDR VARCHAR(50)
	, KOR_SCORE INT
	, ENG_SCORE INT
	, MATH_SCORE INT
);

INSERT INTO basic_student (
	STU_NAME
	, STU_AGE
	, STU_TEL
	, STU_ADDR
	, KOR_SCORE
	, ENG_SCORE
	, MATH_SCORE
	)
VALUES 
	('홍길동', 20, '010-1111-2222', '울산시', 80, 70, 70)
	, ('이순신', 30, '010-1111-3333', '부산시', 80, 90, 90)
	, ('유관순', 40, '010-1111-4444', '대구시', 60, 100, 80);
	
SELECT * FROM basic_student;


CREATE TABLE BASIC_MEMBER(
	MEM_ID VARCHAR(30) PRIMARY KEY
	, MEM_PW VARCHAR(30) NOT NULL
	, MEM_NAME VARCHAR(10) NOT NULL
	, GENDER VARCHAR(5) NOT NULL
	, MEM_TEL VARCHAR(20) #'010-1111-2222'
	, MEM_ADDR VARCHAR(50)
	, ADDR_DETAIL VARCHAR(50)
);

SELECT * FROM basic_member;
