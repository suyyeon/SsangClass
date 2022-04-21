-- 문제03.sql

-- 1. tblCountry. 아시아(AS)와 유럽(EU)에 속한 나라의 개수?? -> 7개
SELECT
    *
FROM
    tblcountry;

SELECT
    COUNT(
        CASE
            WHEN continent IN('AS', 'EU') THEN
                1
        END
    ) AS 아시아와유럽
FROM
    tblcountry;

-- 2. 인구수가 7000 ~ 20000 사이인 나라의 개수?? -> 2개
SELECT
    COUNT(
        CASE
            WHEN population BETWEEN 7000 AND 20000 THEN
                1
        END
    )
FROM
    tblcountry;

-- 3. hr.employees. job_id > 'IT_PROG' 중에서 급여가 5000불이 넘는 직원이 몇명? -> 2명
SELECT
    *
FROM
    hr.employees;

SELECT
    COUNT(
        CASE
            WHEN job_id = 'IT_PROG'
                 AND salary >= 5000 THEN
                1
        END
    )
FROM
    hr.employees;


-- 4. tblInsa. tel. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) -> 42명
SELECT
    *
FROM
    tblinsa;

SELECT
    COUNT(tel) - COUNT(
        CASE
            WHEN tel LIKE '010%' THEN -- 15명
                1
        END
    )
FROM
    tblinsa;
    
-- 5. city. 서울, 경기, 인천빼고 -> 그 외의 지역 인원수? -> 18명
SELECT
    COUNT(*) - COUNT(
        CASE
            WHEN city IN('서울', '경기', '인천') THEN
                1
        END
    )
FROM
    tblinsa;
        
-- 6. 여름태생(7~9월) + 여자 직원 총 몇명? -> 7명
SELECT
    COUNT(
        CASE
            WHEN ssn LIKE '__07%-2%'
                 OR ssn LIKE '__08%-2%'
                 OR ssn LIKE '__09%-2%' THEN
                1
        END
    )
FROM
    tblinsa;
    
-- 7. 개발부 + 직위별 인원수? -> 부장 ?명, 과장 ?명, 대리 ?명, 사원 ?명
SELECT
    COUNT(
        CASE
            WHEN buseo = '개발부'
                 AND jikwi = '부장' THEN -- 1
                1
        END
    ) AS 부장,
    COUNT(
        CASE
            WHEN buseo = '개발부'
                 AND jikwi = '과장' THEN -- 2
                1
        END
    ) AS 과장,
    COUNT(
        CASE
            WHEN buseo = '개발부'
                 AND jikwi = '대리' THEN -- 2
                1
        END
    ) AS 대리,
    COUNT(
        CASE
            WHEN buseo = '개발부'
                 AND jikwi = '사원' THEN -- 9
                1
        END
    ) AS 사원
FROM
    tblinsa;