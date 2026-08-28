-- ===================================================
-- 실습용 테이블: player (선수 정보)
-- 아래 CREATE 쿼리문은 테이블을 생성하는 쿼리문입니다. 최초 한 번만 실행!
-- INSERT는 데이터를 테이블에 삽입하는 쿼리문입니다. 한 번만 실행!
-- ===================================================
 
 SELECT *
 FROM player;
 
 
CREATE TABLE player (
    PLAYER_ID   INT PRIMARY KEY,   -- 선수번호
    NAME        VARCHAR(20),         -- 선수명
    POSITION    VARCHAR(20),         -- 포지션
    TEAM        VARCHAR(20),         -- 소속팀
    SALARY      INT,               -- 연봉(단위: 만원)
    BONUS       INT                -- 보너스(없는 선수는 NULL)
);
 
-- 샘플 데이터 삽입
INSERT INTO player VALUES (1001, '김민준', '공격수', '서울FC', 8000, 500);
INSERT INTO player VALUES (1002, '이서연', '수비수', '부산FC', 5000, NULL);
INSERT INTO player VALUES (1003, '박도윤', '골키퍼', '서울FC', 4500, NULL);
INSERT INTO player VALUES (1004, '최지우', '미드필더', '대구FC', 6000, 300);
INSERT INTO player VALUES (1005, '정하은', '공격수', '대구FC', 9500, 1000);
INSERT INTO player VALUES (1006, '강시우', '수비수', '부산FC', 3000, NULL);
INSERT INTO player VALUES (1007, '윤서준', '미드필더', '서울FC', 5500, 200);
INSERT INTO player VALUES (1008, '한지호', '공격수', '대구FC', 2500, NULL);
 
COMMIT;
 
 
-- ===================================================
-- 실습 문제 8개
-- ===================================================
 
-- 1. player 테이블에서 선수들의 이름(NAME)만 조회하세요.
SELECT 
NAME 
FROM player;
 
 
-- 2. player 테이블에서 선수번호(PLAYER_ID), 이름(NAME), 소속팀(TEAM)을 조회하세요.
SELECT 
PLAYER_ID, NAME, TEAM 
FROM player;
 
 
-- 3. player 테이블의 모든 컬럼 정보를 조회하세요.
SELECT *
FROM player;
 
 
-- 4. 선수번호는 '번호', 이름은 '이름', 연봉은 '연봉'이라는 별칭을 사용해서 조회하세요.
--    (AS 키워드는 생략 가능)
SELECT
player_ID 번호, NAME 이름, SALARY 연봉
FROM player;
 
 
-- 5. 연봉이 5000 이상인 선수의 선수번호, 이름, 연봉을 조회하세요.
SELECT
PLAYER_ID, NAME, SALARY
FROM player
WHERE SALARY >= 5000;
 
 
-- 6. 포지션이 '공격수'인 선수들의 모든 정보를 조회하세요.
SELECT *
FROM player
WHERE POSITION='공격수';
 
 
-- 7. 연봉이 3000 이상 6000 이하인 선수들의 이름과 연봉을 조회하세요.
SELECT
NAME, SALARY
FROM player
WHERE SALARY >= 3000 AND SALARY <= 6000;

 
 
-- 8. 포지션이 '공격수'가 아니면서 보너스(BONUS)가 NULL인 선수의 모든 정보를 조회하세요.
SELECT *
FROM player
WHERE POSITION !='공격수' AND BONUS IS NULL;

#9.연봉이 3000 이상 8000 이하인 선수들의 이름과 연봉을 BETWEEN 연산자를 사용해서 조회하세요.  단, 조회하는 두 컬럼은 각각 '이름', '포지션'이라는 별칭으로 조회하세요.
SELECT NAME 이름, POSITION 포지션 
FROM player
WHERE SALARY BETWEEN 3000 AND 8000;

#10.player 테이블에서 소속팀의 종류를 중복 없이 조회하세요.
SELECT DISTINCT TEAM
FROM player;

#11.연봉이 2500, 5000, 9500 중 하나인 선수들의 선수번호, 이름, 연봉을 IN 연산자로 조회하되, 연봉 기준 오름차순으로 정렬하세요.
SELECT PLAYER_ID, NAME, SALARY
FROM player
WHERE SALARY IN (2500, 5000, 9500)
ORDER BY SALARY;

#12.포지션이 '공격수'가 아니면서 보너스(BONUS)가 NULL이 아닌 선수들의 모든 정보를 조회하되 소속팀 기준 오름차순 정렬 후 같은 팀 내에서는 연봉 기준 내림차순으로 정렬하세요.
SELECT *
FROM player
WHERE POSITION != '공격수'
AND BONUS IS NOT NULL
ORDER BY TEAM, SALARY DESC;

#13.포지션이 '공격수'이거나 '미드필더'이면서, 연봉이 5000 미만이거나 보너스가 NULL인  선수들의 이름, 포지션, 연봉, 보너스를 조회하세요.
SELECT NAME, POSITION, SALARY, BONUS
FROM player
WHERE POSITION IN ('공격수', '미드필더')
AND (SALARY < 5000
OR BONUS IS NULL);

#14.포지션이 '수비수'가 아니고, 연봉이 2500, 4500, 6000 중 하나가 아니면서, 이름에 '우' 또는 '준'이 들어간 선수들의 모든 정보를 조회하되, 
#연봉 기준 오름차순으로 정렬하고 연봉이 같으면 이름 기준 오름차순으로 정렬하세요.(힌트: NOT IN)
SELECT *
FROM player
WHERE POSITION != '수비수'
AND SALARY NOT IN (2500, 4500, 6000)
AND (NAME LIKE '%우%' OR NAME LIKE '%준%')
ORDER BY SALARY ASC, NAME ASC;







