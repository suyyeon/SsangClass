-- 문제05.sql



-- employees
-- 1. 전체 이름(first_name + last_name)이 가장 긴 -> 짧은 사람 순으로 정렬해서 가져오기
--    > 컬럼 리스트 > fullname(first_name + last_name), length(fullname)
SELECT
    first_name
    || ' '
    || last_name  AS fullname,
    length(first_name
           || ' '
           || last_name) AS namelength
FROM
    employees
ORDER BY
    namelength DESC;


-- 2. 전체 이름(first_name + last_name)이 가장 긴 사람은 몇글자? 가장 짧은 사람은 몇글자? 평균 몇글자?
--    > 컬럼 리스트 > 숫자 3개 컬럼
SELECT
    MAX(length(first_name
               || ' '
               || last_name))  AS maxlength,
    MIN(length(first_name
               || ' '
               || last_name))  AS minlength,
    round(AVG(length(first_name
                     || ' '
                     || last_name))) AS avglength
FROM
    employees;


-- 3. last_name이 4자인 사람들의 first_name을 가져오기
--    > 컬럼 리스트 > first_name, last_name
--    > 정렬(first_name, 오름차순)
SELECT
    first_name,
    last_name
FROM
    employees
WHERE
    length(last_name) = 4
ORDER BY
    first_name;

-- decode
-- 4. tblInsa. 부장 몇명? 과장 몇명? 대리 몇명? 사원 몇명?
SELECT
    COUNT(decode(jikwi, '부장', 1)) "부장",
    COUNT(decode(jikwi, '과장', 1)) "과장",
    COUNT(decode(jikwi, '대리', 1)) "대리",
    COUNT(decode(jikwi, '사원', 1)) "사원"
FROM
    tblinsa;

SELECT
    *
FROM
    tblinsa;
-- 5. tblInsa. 간부(부장, 과장) 몇명? 사원(대리, 사원) 몇명?
SELECT
    COUNT(decode(jikwi, '부장', 1, '과장', 1)) "간부",
    COUNT(decode(jikwi, '대리', 1, '사원', 1)) "사원"
FROM
    tblinsa;

-- 6. tblInsa. 기획부, 영업부, 총무부, 개발부의 각각 평균 급여?
SELECT
    round(AVG(decode(buseo, '기획부', basicpay))) "기획부",
    round(AVG(decode(buseo, '영업부', basicpay))) "영업부",
    round(AVG(decode(buseo, '총무부', basicpay))) "총무부",
    round(AVG(decode(buseo, '개발부', basicpay))) "개발부"
FROM
    tblinsa;

-- 7. tblInsa. 남자 직원 가장 나이가 많은 사람이 몇년도 태생? 여자 직원 가장 나이가 어린 사람이 몇년도 태생?
SELECT
    '19'
    || MIN(decode(substr(ssn, 8, 1), '1', substr(ssn, 1, 2))) "남자",
    '19'
    || MAX(decode(substr(ssn, 8, 1), '2', substr(ssn, 1, 2))) "여자"
FROM
    tblinsa;