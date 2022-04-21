-- 문제04.sql

--sum()
--1. 유럽과 아프리카에 속한 나라의 인구 수 합? tblCountry > 14,198
select * from tblcountry;
select 
    sum(population)
from tblcountry
where continent = 'AF' OR continent = 'EU';


--2. 매니저(108)이 관리하고 있는 직원들의 급여 총합? hr.employees > 39,600
SELECT sum(salary)
FROM hr.employees
where manager_id = 108;
    
 
--3. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합? hr.employees > 120,000
select sum(salary)
from hr.employees
where job_id IN ('ST_CLERK','SH_CLERK');



--4. 서울에 있는 직원들의 급여 합(급여 + 수당)? tblInsa > 33,812,400
SELECT * FROM tblinsa;
select sum(basicpay + sudang) from tblinsa where city = '서울';

--5. 장급(부장+과장)들의 급여 합? tblInsa > 36,289,000
select sum(basicpay) from tblinsa where jikwi in('부장','과장');


--avg()
--1. 아시아에 속한 국가의 평균 인구수? tblCountry > 39,165
select * from tblcountry;
select avg(population) from tblcountry where continent = 'AS';

--2. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분없이) hr.employees > 6,270.4
select * from HR.employees;
select avg(salary) from hr.employees where lower(first_name) like '%an%'; 

--3. 장급(부장+과장)의 평균 급여? tblInsa > 2,419,266.66
select avg(basicpay) from tblinsa where jikwi like '%장';


--4. 사원급(대리+사원)의 평균 급여? tblInsa > 1,268,946.66
select avg(basicpay) from tblinsa where jikwi in ('대리','사원');

--5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차액? tblInsa > 1,150,320
select 
    avg(case
        when jikwi like '%장' then basicpay
    end)
    - avg(case
        when jikwi in ('대리','사원') then basicpay
    end)  
from tblinsa;

--max(),min()
--1. 면적이 가장 넓은 나라의 면적은? tblCountry > 959
select max(area) from tblcountry;

--2. 급여(급여+수당)가 가장 적은 직원은 총 얼마를 받고 있는가? tblInsa > 988,000
select min(basicpay + sudang) from tblinsa;













