
CREATE TABLE IMSI_MEMBER(
	MEM_ID VARCHAR(20) PRIMARY KEY
	, MEM_PW VARCHAR(20)
);

CREATE TABLE IMSI_SCORE(
	SCORE_NO INT PRIMARY KEY
	, KOR_SOCRE INT
	, MEM_ID VARCHAR(20) REFERENCES imsi_member (MEM_ID)
);

INSERT INTO imsi_member VALUES ('a', 'b');

CREATE TABLE IMSI_MEMBERS2(
	MEM_ID VARCHAR(20)
	, MEM_PW VARCHAR(20)
	, CONSTRAINT MEMBER_PK PRIMARY KEY (MEM_ID)
);

#CONSTRAINT MEMBER_PK PRIMARY KEY (MEM_ID) => CONSTRAINT MEMBER_PK[제약조건의 이름] /PRIMARY KEY (MEM_ID) [실제 제약조건]
INSERT INTO imsi_member VALUES ('a', 'b');
INSERT INTO IMSI_MEMBERS2 VALUES ('a', 'b');
INSERT INTO IMSI_SCORE2 VALUES (1, 80, 'C')

CREATE TABLE IMSI_SCORE2 (
	SCORE_NO INT PRIMARY KEY
	, KOR_SOCRE INT
	, MEM_ID VARCHAR(20)
	, CONSTRAINT MEMBER_FK FOREIGN KEY (MEM_ID) REFERENCES IMSI_MEMBERS2 (MEM_ID)
);


#-------------------------------------------------------------------

DROP TABLE IF EXISTS ORDERS;
DROP TABLE IF EXISTS PRODUCT;
DROP TABLE IF EXISTS MEMBER;

CREATE TABLE MEMBER (
    MEM_ID    CHAR(3)      PRIMARY KEY,
    MEM_NAME  VARCHAR(20)  NOT NULL,
    EMAIL     VARCHAR(50),
    PHONE     VARCHAR(20),          -- NULL 허용
    GENDER    CHAR(1),              -- 'M' / 'F'
    BIRTH     DATE,
    GRADE     VARCHAR(10),          -- VIP / GOLD / SILVER / BRONZE
    POINT     INT,
    JOIN_DATE DATE,
    CITY      VARCHAR(20)
);

CREATE TABLE PRODUCT (
    PROD_ID       CHAR(7)      PRIMARY KEY,   -- 예: EL-1001
    PROD_NAME     VARCHAR(40)  NOT NULL,
    CATEGORY      VARCHAR(10),
    PRICE         INT,
    STOCK         INT,
    DISCOUNT_RATE INT                          -- NULL 허용(%), NULL이면 할인 없음
);

CREATE TABLE ORDERS (
    ORDER_ID   CHAR(3)   PRIMARY KEY,
    MEM_ID     CHAR(3),
    PROD_ID    CHAR(7),
    ORDER_DATE DATE,
    QTY        INT,
    USED_POINT INT,
    CANCEL_YN  CHAR(1),                        -- 'Y' / 'N'
    CONSTRAINT FK_ORD_MEM  FOREIGN KEY (MEM_ID)  REFERENCES MEMBER(MEM_ID),
    CONSTRAINT FK_ORD_PROD FOREIGN KEY (PROD_ID) REFERENCES PRODUCT(PROD_ID)
);

INSERT INTO MEMBER VALUES
('M01','김민준','minjun@gmail.com'    ,'010-1234-5678','M','1990-05-14','VIP'   ,15000,'2021-03-02','서울'),
('M02','이서연','seoyeon91@naver.com' ,'010-2222-3333','F','1991-11-20','GOLD'  , 8200,'2021-07-15','부산'),
('M03','박도윤','doyoon@daum.net'     , NULL          ,'M','1988-02-09','SILVER', 3400,'2022-01-10','대구'),
('M04','최지우','jiwoo@gmail.com'     ,'010-4444-5555','F','1995-08-30','BRONZE',  500,'2022-05-21','서울'),
('M05','정하준','hajun2000@naver.com' ,'010-5555-6666','M','2000-12-01','GOLD'  , 6700,'2022-09-03','인천'),
('M06','강서윤','seoyun@kakao.com'    ,'010-6666-7777','F','1993-04-25','SILVER', 2900,'2023-02-14','서울'),
('M07','조은우','eunwoo@gmail.com'    , NULL          ,'M','1998-07-07','BRONZE',    0,'2023-06-30','부산'),
('M08','윤지호','jiho@naver.com'      ,'010-8888-9999','M','1985-10-18','VIP'   ,21000,'2020-11-11','대전'),
('M09','임하윤','hayoon@daum.net'     ,'010-9999-0000','F','1996-03-12','GOLD'  , 7100,'2023-08-25','서울'),
('M10','한소율','soyul@gmail.com'     ,'010-1010-2020','F','2001-01-29','BRONZE', 1200,'2024-01-05','인천');

INSERT INTO PRODUCT VALUES
('EL-1001','무선이어폰'      ,'전자', 89000, 40,  10),
('EL-1002','블루투스스피커'  ,'전자', 55000, 25, NULL),
('EL-1003','기계식키보드'    ,'전자',120000, 15,  15),
('EL-1004','USB허브'         ,'전자', 23000, 61, NULL),
('BK-2001','데이터베이스개론','도서', 32000,100,   5),
('BK-2002','자바프로그래밍'  ,'도서', 28000, 80, NULL),
('BK-2003','알고리즘문제집'  ,'도서', 26000, 51,  10),
('HM-3001','캠핑의자'        ,'생활', 45000, 30, NULL),
('HM-3002','스테인리스텀블러','생활', 18000,120,  20),
('HM-3003','극세사담요'      ,'생활', 33000, 45, NULL),
('FD-4001','유기농원두1kg'   ,'식품', 24000, 70, NULL),
('FD-4002','견과류선물세트'  ,'식품', 39000, 21,  25);

INSERT INTO ORDERS VALUES
('O01','M01','EL-1001','2024-03-02',1,1000,'N'),
('O02','M01','BK-2001','2024-03-10',2,   0,'N'),
('O03','M02','EL-1003','2024-03-15',1,2000,'N'),
('O04','M03','HM-3002','2024-03-18',3,   0,'N'),
('O05','M04','EL-1004','2024-03-20',1,   0,'Y'),
('O06','M05','EL-1002','2024-04-01',1, 500,'N'),
('O07','M02','FD-4002','2024-04-05',2,1000,'N'),
('O08','M06','HM-3001','2024-04-11',1,   0,'N'),
('O09','M01','EL-1004','2024-04-15',2,   0,'N'),
('O10','M08','EL-1003','2024-04-20',1,5000,'N'),
('O11','M08','BK-2003','2024-04-22',3,   0,'N'),
('O12','M07','FD-4001','2024-05-02',1,   0,'N'),
('O13','M09','HM-3003','2024-05-08',2,1000,'N'),
('O14','M05','BK-2001','2024-05-12',1,   0,'N'),
('O15','M10','HM-3002','2024-05-15',2,   0,'N'),
('O16','M02','EL-1001','2024-05-20',1,2000,'N'),
('O17','M03','BK-2003','2024-05-25',2,   0,'Y'),
('O18','M08','FD-4002','2024-06-01',1,3000,'N'),
('O19','M09','EL-1002','2024-06-10',1,   0,'N'),
('O20','M01','HM-3002','2024-06-15',4, 500,'N'),
('O21','M06','BK-2001','2024-06-20',1,   0,'N'),
('O22','M08','EL-1001','2024-06-25',2,4000,'N');

COMMIT;

#A-1. 아래 조회 쿼리 결과를 예측하시오
SELECT CEIL(30400.2) # 30401
, FLOOR(30400.9)     # 30400
, ROUND(28666.666, 1) # 28666.7
, TRUNCATE(28666.666, 2) # 28666.66
, ROUND(28666.666, -3)   # 29
, MOD(89000, 10000);		# 9000
# 30400, 30400, 28667, 28666.66, 28, 0

#A-2. PRODUCT에서 상품명, 정가, 할인율, 할인가(정가에 할인율 % 적용)를 조회. 할인율이 NULL이면 할인 없음(0%)으로 계산.
SELECT
 PROD_NAME AS 상품명
 , PRICE AS 정가
 , NVL(DISCOUNT_RATE, 0) AS 할인율
 , PRICE - (PRICE * (NVL(DISCOUNT_RATE, 0)/100)) AS 할인가
FROM PRODUCT;

#A-3. A-2의 할인가를 100원 단위로 버림해서 조회. (예: 80100 → 80100, 29250 → 29200)
SELECT TRUNCATE(PRICE - (PRICE * (NVL(DISCOUNT_RATE, 0)/100)), -2) AS 할인가 
FROM PRODUCT;

#A-4. PRODUCT에서 재고(STOCK)가 홀수인 상품만 상품명·재고를 조회.
SELECT PROD_NAME AS 상품명
	,STOCK AS 재고
FROM product
WHERE MOD(STOCK, 2) = 1; 

#A-5. ORDERS와 PRODUCT를 조인해 주문번호, 상품명, 수량, 주문금액(정가 × 수량) 을 조회.
SELECT
	ORDER_ID AS 주문번호
	, P. PROD_NAME AS 상품명
	, QTY AS 수량
	, (PRICE * QTY) AS 주문금액
FROM orders O 
INNER JOIN product P
ON O.PROD_ID = P.PROD_ID;
 

#B-1. 아래 조회 쿼리 결과를 예측하세요.
SELECT 
	UPPER('el-1001') #EL-1001
	, LOWER('Minjun@GMAIL.com') #minjun@gmail.com
	, CHAR_LENGTH('스테인리스텀블러') #8
	, LENGTHB('스테인리스텀블러') #24
	, SUBSTR('2024-03-02', 6, 2) #'03'
	, LPAD('7', 3, '0') #'007'
	, REPLACE('010-1234-5678', '-', ''); #'01012345678'

#B-2. MEMBER에서 이름, 이름 글자 수, 이름 바이트 길이를 조회. 컬럼명 이름, 글자수, 바이트수.
SELECT
	MEM_NAME AS 이름
	, LENGTH(MEM_NAME) AS 글자수
	, LENGTHB(MEM_NAME) AS 바이트수
FROM member;

#B-3. PRODUCT에서 상품코드(PROD_ID)를 앞 2자리(분류코드)와 뒤 4자리(일련번호)로 나눠서 조회.
SELECT
	SUBSTR(PROD_ID, 1, 2) AS 상품코드
	, SUBSTR(PROD_ID, -4) AS 일련번호
FROM product;

#B-4. MEMBER에서 이름과, 전화번호에서 - 를 제거한 값을 조회. 전화번호가 없으면 '미등록' 으로 표시.
SELECT
	MEM_NAME
	, NVL( REPLACE(PHONE, '-', ''), '미등록') AS PHONE
FROM member;


#B-5. MEMBER에서 이름, 생년월일에서 뽑은 출생연도(4자리), 출생월(2자리)을 조회. (BIRTH는 DATE 타입 — SUBSTR 로 잘라내면 됨)
SELECT
	MEM_NAME
	, SUBSTR(BIRTH, 1, 4) AS 출생연도
	, SUBSTR(BIRTH, 6, 2) AS 출생월
	, YEAR(BIRTH)
	, MONTH(BIRTH)
	, DAY(BIRTH)
FROM member;


#B-6. MEMBER에서 이름과 등급을 김민준 [VIP] 형태의 한 컬럼(회원표시)으로 조회.
SELECT
CONCAT(MEM_NAME, ' [', GRADE, ']') AS 회원표시
FROM member;

#B-7. (심화) EMAIL에서 도메인(@ 뒤 부분)만 뽑아 조회.
#힌트: INSTR(문자열, '@') 는 @ 의 위치를 숫자로 돌려준다.
SELECT
	SUBSTR(EMAIL, INSTR((EMAIL), '@') + 1)
FROM member;

#C-1. 아래 조회 쿼리 결과를 예측하시오. 
SELECT 
	IF(21000 >= 20000, 'VIP대상', '일반') #'VIP대상' 
	, IFNULL(NULL, 0) + 100 #  100
	, IF(3400 > 5000, '상', '하'); #'하'

#C-2. MEMBER에서 이름, 포인트, 그리고 포인트가 5000 이상이면 '우수', 아니면 '일반' 을 IF 로 조회.
SELECT
	MEM_NAME
	, IF(POINT >= 5000, '우수', '일반')
FROM member;

#C-3. (searched CASE) PRODUCT에서 상품명, 정가, 가격대를 조회.
#100000 이상 '고가', 30000 이상 '중가', 그 외 '저가'. 컬럼명 가격대.
SELECT
	PROD_NAME AS 상품명
	, PRICE AS 정가
	, CASE
			WHEN PRICE >= 100000 THEN '고가'
			WHEN PRICE >= 30000 THEN '중가'
			ELSE '저가'
			END AS 가격대
FROM product;


#C-4. (simple CASE) PRODUCT에서 상품명, 분류코드(코드 앞 2자리)를 이용해 분류명을 조회.
#'EL'→'전자제품', 'BK'→'도서', 'HM'→'생활용품', 그 외 '식품'. 컬럼명 분류.

SELECT
	PROD_ID
	, CASE SUBSTR(PROD_ID, 1, 2)
			WHEN 'EL' THEN '전자제품'
			WHEN 'BK' THEN '도서'
			WHEN 'HM' THEN '생활용품'
			ELSE '식품'
			END  AS 분류코드
FROM PRODUCT;

#C-5. ORDERS에서 주문번호와, 취소여부를 'Y'→'취소됨', 'N'→'정상' 으로 바꿔 조회.
SELECT
ORDER_ID AS 주문번호
, IF(CANCEL_YN = 'N', '정상', '취소됨') AS  취소여부
FROM orders;

#C-6. MEMBER에서 이름, 등급, 등급별 적립률을 조회.
#VIP 3%, GOLD 2%, SILVER 1%, BRONZE 0.5% (숫자 0.03 / 0.02 … 로).
SELECT
MEM_NAME
, GRADE
, CASE GRADE
	WHEN 'VIP' THEN 0.03
	WHEN 'GOLD' THEN 0.02
	WHEN 'SILVER' THEN 0.01
	ELSE 0.005
	END AS 적립율
FROM member;

#C-7. (응용) ORDERS와 PRODUCT를 조인해 주문번호, 상품명, 주문금액(정가×수량), 그리고 주문금액이 100000 이상이면 '고액주문', 아니면 '' 을 표시.
SELECT
	ORDER_ID
	, PROD_NAME
	, (PRICE * QTY) AS 주문금액
	, IF(PRICE * QTY >= 100000, '고액주문', '' )
FROM orders O
INNER JOIN product P
ON O.PROD_ID = P.PROD_ID;

##----------------------------------------------------------------------------------------------------------------##

#D-1. PRODUCT 전체의 정가 합계, 평균(소수 2자리 반올림), 최고가, 최저가를 한 번에 조회.

#D-2. 카테고리가 '전자' 인 상품의 평균 정가를 조회.

#D-3. (개념) COUNT(PHONE) 가 COUNT(*) 보다 작은 이유를 설명하고, "가입한 회원 수"를 셀 때 COUNT() 안에 어떤 컬럼을 쓰는 게 안전한지 답하라.

#D-4. 아래 쿼리가 "가장 비싼 상품의 이름"을 주지 못하는 이유는?
#SELECT PROD_NAME, MAX(PRICE) FROM PRODUCT;

#D-6. 전체 상품 수(12개)를 분모로 하는 할인율 평균을 소수 2자리 반올림으로 조회. (NULL은 0으로 취급)

#D-7. ORDERS에서 취소되지 않은 주문의 건수와 사용포인트(USED_POINT) 합계를 조회.

#E-1. 카테고리별 상품 수, 평균 정가, 최고 정가를 조회.

#E-2. 회원 등급별 회원 수와 평균 포인트를 조회.

#E-3. 성별·등급별 회원 수를 조회. (GROUP BY 컬럼 2개)

#E-4. 도시별 회원 수를 조회하되, 회원이 2명 이상인 도시만.

#E-5. 카테고리별 (최고 정가 − 최저 정가)가 50000 이상인 카테고리와 그 격차만 조회.

#E-6. (응용) ORDERS와 PRODUCT를 조인해 카테고리별 총 주문수량과 총 주문금액(정가×수량)을 조회.
#취소된 주문(CANCEL_YN='Y')은 제외하고, 총 주문금액이 200000 이상인 카테고리만, 총 주문금액 내림차순.

#E-7. (응용) ORDERS와 MEMBER를 조인해 회원별 이름과 주문 건수(취소 포함 전체)를 조회.
#주문을 3건 이상 한 회원만, 주문 건수 내림차순.

#F-1. MEMBER · ORDERS · PRODUCT를 조인해 주문번호, 회원명, 상품명, 카테고리, 수량, 주문금액(정가×수량)을 조회. 취소 주문 제외, 주문번호 순.

#F-2. 회원별 이름·등급·총 결제금액(정가×수량 합, 취소 제외)을 조회. 결제 이력이 있는 회원만, 총 결제금액 내림차순.

#F-3. F-2 결과에 등급별 적립률(VIP 3% / GOLD 2% / SILVER 1% / BRONZE 0.5%)을 적용한 적립예정포인트(반올림)를 추가로 조회.

#F-4. 주문 이력이 아예 없거나 모든 주문이 취소된 회원의 이름을 조회.

#F-5. PRODUCT를 기준으로 ORDERS를 LEFT JOIN 해서 상품명, 총 판매수량, 총 매출을 조회. 한 번도 안 팔린 상품도 0으로 표시. (취소 주문 제외)


