-- 4월28일
-- 패턴
-- rownum + group by

-- 1, 2, 3, 9, 10

-- 1. tblInsa. 남자 급여(기본급+수당)을 (내림차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
SELECT
    a.*,
    ROWNUM
FROM
    (
        SELECT
            name,
            buseo,
            jikwi,
            (basicpay + sudang) as salray
        FROM
            tblinsa
        WHERE
            substr(ssn, 8, 1) = '1'
        ORDER BY
            (basicpay + sudang) DESC
    ) a;


-- 2. tblInsa. 여자 급여(기본급+수당)을 (오름차순)순위대로 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
SELECT
    a.*,
    ROWNUM
FROM
    (
        SELECT
            name,
            buseo,
            jikwi,
            basicpay + sudang
        FROM
            tblinsa
        WHERE
            substr(ssn, 8, 1) = '2'
        ORDER BY
            basicpay + sudang
    ) a;


-- 3. tblInsa. 여자 인원수가 (가장 많은 부서 및 인원수) 가져오시오.
select buseo, count(*) from tblInsa where substr(ssn, 8, 1) = 2 group by buseo order by count(*) desc;

SELECT
    buseo, cnt, rownum
FROM
    (
        SELECT
            buseo,
            COUNT(*) as cnt
        FROM
            tblinsa
        WHERE
            substr(ssn, 8, 1) = '2'
        GROUP BY
            buseo
        ORDER BY
            COUNT(*) DESC
    )
WHERE
    ROWNUM = 1;


-- 4. tblInsa. 지역별 인원수 (내림차순)순위를 가져오시오.(city, 인원수)
select * from tblInsa;

SELECT
    ROWNUM AS "순위",
    a.*
FROM
    (
        SELECT
            city,
            COUNT(*) AS 인원수
        FROM
            tblinsa
        GROUP BY
            city
        ORDER BY
            "인원수" DESC
    ) a;


-- 5. tblInsa. 부서별 인원수가 가장 많은 부서 및 인원수 출력.
select buseo, count(*) from tblInsa group by buseo order by count(*) desc;

SELECT
    buseo, 인원수
FROM
    (
        SELECT
            buseo,
            COUNT(*) AS 인원수
        FROM
            tblinsa
        GROUP BY
            buseo
        ORDER BY
            인원수 DESC
    )
WHERE
    ROWNUM = 1;


    
-- 6. tblInsa. 남자 급여(기본급+수당)을 (내림차순) 3~5등까지 가져오시오. (이름, 부서, 직위, 급여, 순위 출력)
select a.*, rownum as rnum from (select name, buseo, jikwi, basicpay+sudang from tblInsa where substr(ssn, 8, 1) = 1 order by basicpay + sudang desc) a;

SELECT
    *
FROM
    (
        SELECT
            a.*,
            ROWNUM AS rnum
        FROM
            (
                SELECT
                    name,
                    buseo,
                    jikwi,
                    basicpay + sudang
                FROM
                    tblinsa
                WHERE
                    substr(ssn, 8, 1) = '1'
                ORDER BY
                    basicpay + sudang DESC
            ) a
    )
                where rnum between 3 and 5;


-- 7. tblInsa. 입사일이 빠른 순서로 5순위까지만 가져오시오.

SELECT
    ROWNUM,
    a.*
FROM
    (
        SELECT
            *
        FROM
            tblinsa
        ORDER BY
            ibsadate
    ) a
WHERE
    ROWNUM <= 5;


-- 8. tblhousekeeping. 지출 내역(가격 * 수량) 중 가장 많은 금액을 지출한 내역 3가지를 가져오시오.

SELECT
    *
FROM
    (
        SELECT
            *
        FROM
            tblhousekeeping
        ORDER BY
            ( price * qty ) DESC
    )
WHERE
    ROWNUM <= 3;


-- 9. tblinsa. 평균 급여 2위인 부서에 속한 직원들을 가져오시오.

select * from (select name from tblInsa order by avg(basicpay) desc) where rownum = 2;

select a.*, rownum as rnum from (select buseo, avg(basicpay) from tblInsa group by buseo order by avg(basicpay) desc) a;

select * from (select a.*, rownum as rnum from (select buseo, round(avg(basicpay)) from tblInsa group by buseo order by avg(basicpay) desc) a)
    where rnum = 2;


SELECT
    *
FROM
    tblinsa
WHERE
    buseo = (
        SELECT
            b.buseo
        FROM
            (
                SELECT
                    a.*,
                    ROWNUM AS rnum
                FROM
                    (
                        SELECT
                            buseo
                        FROM
                            tblinsa
                        GROUP BY
                            buseo
                        ORDER BY
                            AVG(basicpay) DESC
                    ) a
            ) b
        WHERE
            rnum = 2
    );



-- 10. tbltodo. 등록 후 가장 빠르게 완료한 할일을 순서대로 5개 가져오시오.
select title, completedate - adddate from tblTodo where completedate is not null order by (completedate - adddate);

SELECT
    title,
    ROWNUM
FROM
    (
        SELECT
            title,
            completedate - adddate
        FROM
            tbltodo
        WHERE
            completedate IS NOT NULL
        ORDER BY
            ( completedate - adddate )
    ) where rownum <= 5;


-- 11. tblinsa. 남자 직원 중에서 급여를 3번째로 많이 받는 직원과 9번째로 많이 받는 직원의 '급여 차액'은 얼마인가?

SELECT
    (
        SELECT
            basicpay
        FROM
            (
                SELECT
                    basicpay,
                    ROWNUM AS rnum
                FROM
                    (
                        SELECT
                            *
                        FROM
                            tblinsa
                        WHERE
                            substr(ssn, 8, 1) = '1'
                        ORDER BY
                            basicpay DESC
                    )
            )
        WHERE
            rnum = 3
    ) - (
        SELECT
            basicpay
        FROM
            (
                SELECT
                    basicpay,
                    ROWNUM AS rnum
                FROM
                    (
                        SELECT
                            *
                        FROM
                            tblinsa
                        WHERE
                            substr(ssn, 8, 1) = '1'
                        ORDER BY
                            basicpay DESC
                    )
            )
        WHERE
            rnum = 9
    ) AS "급여 차액"
FROM
    dual;


/*
2540000	3
2300000	9
*/