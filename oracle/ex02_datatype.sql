/*

ex02_datatype.sql


ANSI-SQL 자료형
- 오라클 자료형

1. 숫자형
    - 정수, 실수
    a. number
        - (유효자리)38자리 이하의 숫자를 표현하는 자료형
        - 12345678901234567890123456789012345678
        - 5~22byte
        - 1x10^-130 ~ 9.9999x10^125
        
        - number
        - number(precision)
        - number(precision, scale)
        
        
2. 문자형
    - 문자, 문자열

3. 날짜/시간형

4. 이진 데이터형


*/


-- 테이블 선언(생성)
/*
create table 테이블명 (
    컬럼 선언
    컬럼명 자료형,
    컬럼명 자료형,
    컬럼명 자료형
);
*/

-- *** 오라클은 사용자가 정의한 모든 식별자를 DB에 저장할때 항상 대문자로 변환해서 저장한다.(*****)

-- 식별자: 접두어
create table tblType (
    num number
);

-- 테이블 삭제
-- drop table 테이블명;

drop table tblType;


-- ? 확인
select * from tabs; --tables > 현재 계정이 소유하고 있는 테이블 정보

select * from tabs where table_name = 'tblType'; 
select * from tabs where table_name = 'TBLTYPE'; 


-- 데이터 추가하기
insert into tblType (num) values (100);
insert into tblType (num) values (3.14); 


-- 데이터 가져오기
select * from tblType;


































