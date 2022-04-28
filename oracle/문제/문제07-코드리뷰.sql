-- 1. 코드 리뷰 - 4월27일

-- <쉬움>

-- tblVideo, tblRent, tblMember. '뽀뽀할까요' 라는 비디오를 빌려간 회원의 이름은?
-- 장르 <- 비디오 <- 대여 -> 고객

SELECT * from tblVideo; 
select * from tblRent;
select * from tblMember;


select 
    m.name
from tblVideo v
    inner join tblRent r
        on v.seq = r.video
            inner join tblMember m
                on m.seq = r.seq
where v.name = '뽀뽀할까요';



-- tblAddressBook. 남자 평균 나이보다 나이가 많은 서울 태생 + 직업을 가지고 있는 사람들을 가져오시오.
-- 남자 평균 나이보다 나이가 많고, 서울, 직업을 가지고 있는 사람.
select * from tblAddressBook;
select distinct job from tblAddressBook;

select 
    * 
from tblAddressBook
where age >= (select round(avg(age)) from tblAddressBook where gender = 'm') and
        hometown = '서울' and 
                job not in('백수','취업준비생');



-- tblAddressBook. gmail.com을 사용하는 사람들의 성별 > 세대별(10,20,30,40대) 인원수를 가져오시오.
-- 성별, 세대별 인원수

select
    decode(gender,'f','여자','m','남자') as "성별",
    count(case
        when age between 10 and 19 then 1
    end) as "10대",
    count(case
        when age between 20 and 29 then 1
    end) as "20대",
    count(case
        when age between 30 and 39 then 1
    end) as "30대",
    count(case
        when age between 40 and 49 then 1
    end) as "40대"
from tblAddressBook
where email like '%gmail.com'
group by gender;


-- tblVideo, tblRent, tblMember. 현재 반납을 안한 회원명과 비디오명, 대여날짜를 가져오시오.
-- 장르 <- 비디오 <- 대여 -> 고객
SELECT * from tblVideo; 
select * from tblRent;
select * from tblMember;

select 
    m.name,
    v.name,
    r.rentdate
from tblVideo v
    inner join tblRent r
        on v.seq = r.video
            inner join tblMember m
                on m.seq = r.member
                    where r.retdate is null;


-- tblVideo, tblRent, tblMember, tblGenre. 2007년 2월에 대여된 구매내역을 가져오시오. 회원명, 비디오명, 언제, 대여가격
-- 장르 <- 비디오 <- 대여 -> 고객
              
              
select
    m.name as "회원명",
    v.name as "비디오명",        
    r.rentdate as "대여날짜",    
    g.price as "대여가격"      
from tblGenre g
    inner join tblVideo v
        on g.seq = v.genre
            inner join tblRent r
                on r.video = v.seq
                    inner join tblMember m
                        on m.seq = r.member
                            where to_char(r.rentdate,'yy/mm') = '07/02';                    
  

  
select * from tblGenre; -- 대여가격
SELECT * from tblVideo; -- 비디오명
select * from tblRent; -- 언제
select * from tblMember; -- 회원명

-----------------------------------------

-- <조금 어려움>

-- employees, jobs. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 가져오시오. 
-- 년도를 기준으로 오름차순 정렬.

select * from employees;
select * from jobs;

select 
    to_char(e.hire_date,'yyyy') || '년' as "입사년도",
    avg(e.salary) as "평균 급여"
from employees e
    inner join jobs j
        on e.job_id = j.job_id
            where j.job_title = 'Sales Manager'
                group by to_char(e.hire_date, 'yyyy')
                    order by to_char(e.hire_date, 'yyyy');
                

-- tblAddressBook. 평균 나이가 가장 많은 출신(hometown)들이 가지고 있는 직업 중 가장 많은 직업은?
-- 평균 나이가 가장 많아 > 출신 > 직업

select
    max(avg(age))
from tbladdressBook
group by hometown; -- 38.68

select
    job
from tbladdressbook
    where hometown = (select hometown from tbladdressbook group by hometown having avg(age) = 
                        (select max(avg(age)) from tbladdressbook group by hometown)) -- 직업 명단
        group by job
            having count(job) = (select max(count(job)) from tbladdressbook 
                                where hometown = (select hometown from tbladdressbook group by hometown having avg(age) = 
                                    (select max(avg(age)) from tbladdressbook group by hometown)) group by job); -- max 직업




-- tblAddressBook.  동명이인이 여러명 있습니다. 이 중 가장 인원수가 많은 동명이인(모든 이도윤)의 명단을 가져오시오.

select
    *
from
    tbladdressbook
where
    name = (select name from tbladdressbook group by name having count(*) = 
                (select max(count(*)) from tbladdressbook group by name));


-- tblAddressBook. 가장 사람이 많은 직업의(332명) 세대별 비율을 구하시오.
-- 가장 많은 직업, 비율 * 100

select * from tblAddressBook;

select 
    job,
    round(count(case
        when age between 10 and 19 then 1
    end)/count(*) * 100, 1) || '%' as "10대",
    round(count(case
        when age between 20 and 29 then 1
    end)/count(*) * 100, 1) || '%' as "20대",
    round(count(case
        when age between 30 and 39 then 1
    end)/count(*) * 100, 1) || '%' as "30대",
    round(count(case
        when age between 40 and 49 then 1
    end)/count(*) * 100, 1) || '%' as "40대"
from tbladdressbook 
    group by job 
        having count(job) = (select max(count(job)) from tbladdressbook group by job);

-- employees, departments. locations.
-- 각 도시(city)에 있는 모든 부서 사원들의 평균급여가 가장 낮은 도시부터 
-- 도시명(city)과 평균연봉, '해당 도시의 사원수'를 가져오시오. 
-- 단, 도시에 근무하는 사원이 10명 이상인 곳은 제외하고 가져오시오.

-- 도시, 평균연봉, 도시의 사원수 > 급여 낮은 도시부터

select * from employees; -- department_id
select * from departments; -- location_id
select * from locations;

select
    l.city,
    avg(e.salary),
    count(e.department_id)
from employees e
    inner join departments d
        on e.department_id = d.department_id
            inner join locations l
                on l.location_id = d.location_id
                    group by l.city
                        having count(e.department_id) < 10
                            order by avg(e.salary);
                        
                            