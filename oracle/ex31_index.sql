-- ex31_index - 5월16일

/*

인덱스, Index
- 검색을 빠른 속도로 하기 위해서 사용하는 도구
- SQL 명령 처리 속도를 바르게 하기 위해서 특정 컬럼에 대해 생성되는 검색 도구
- b-tree 구조

데이터베이스
- 테이블내의 레코드 순서는 우리가 원하는 정렬 상태가 아니다. > 정렬 개념 X
- 어떤 데이터 검색 > 처음 ~ 끝까지 차례대로 검색 > table full scan
- 특정 컬럼 선택 > 별도의 테이블에 복사 > 미리 정렬(***) >> 인덱스
- 원본 테이블 <- 참조 -> 인덱스


인덱스 장단점
- 처리 속도를 향상 시킨다.
- 너무 많은 인덱스 사용은 전체적인 DB의 성능을 저하시킨다.

자동으로 인덱스가 걸리는 컬럼
1. Primary key
2. Unique
**** 일반 테이블에서 PK를 검색하는 속도 >> 일반 테이블에서 PK가 아닌 컬럼을 검색하는 속도

인덱스를 사용해야 하는 경우
1. 테이블에 데이터(행)가 너무 많을 때
2. where절에 사용되는 횟수가 많은 컬럼에 적용(******)
3. join에 조건으로 사용되는 컬럼에 적용 PK-FK(******)
4. 인덱스의 손익분기점 > 검색 결과가 10~15% 이하인 경우
5. null을 포함하는 경우 > null 인덱스에서 제외


인덱스를 사용하지 말아야 하는 경우
1. 테이블에 데이터(행)가 적은 경우..(의미없음)
2. 인덱스의 손익분기점 > 검색 결과가 15% 이상인 경우 
3. 해당 테이블이 삽입, 수정, 삭제가 빈번할 경우(******************)

*/

-- 더미 데이터 테스트용으로 이렇게 많이 쓴다.
create table tblIndex
as
select * from tblInsa;



select * from tblIndex;

select count(*) from tblIndex; -- 7602176건

insert into tblIndex select * from tblIndex;


-- 시간 확인
set timing on;

-- SQL 실행
-- 1. Ctrl + Enter > 결과 > 테이블 출력
-- 2. F5           > 결과 > 텍스트 출력

-- 인덱스 없이 검색 00:00:00.597
select distinct name from tblIndex where name = '홍길동';

-- 인덱스 생성
create index idxName on tblIndex(name);

-- 인덱스 사용해서 검색 00:00:00.103
select distinct name from tblIndex where name = '홍길동';



/*

인덱스 종류
1. 고유 인덱스
2. 비고유 인덱스
3. 단일 인덱스
4. 복합 인덴스
5. 함수 기반 인덱스
6...

*/

-- 고유 인덱스
-- : 색인의 값이 중복이 불가능하다.
-- : PK, UNIQUE
create unique index idxBuseo on tblIndex(buseo); -- 동명이인(X)


-- 비고유 인덱스
-- : 색인의 값이 중복이 가능하다.
-- : 일반 컬럼
create index idxBuseo on tblIndex(buseo);

-- 단일 인덱스
-- : 컬럼 1개를 대상
create index idxBuseo on tblIndex(buseo);

select count(*) from tblIndex where buseo = '기획부'; -- 인덱스 효과 O

select count(*) from tblIndex where buseo = '기획부' and name = '홍길동'; -- 인덱스 효과 X

-- 복합(결합) 인덱스
-- : 컬럼 N개를 대상
create index idxBuseoName on tblIndex(buseo, name);

select count(*) from tblIndex where buseo = '기획부' and name = '홍길동'; -- 인덱스 효과 O
select count(*) from tblIndex where name = '홍길동' and buseo = '기획부'; -- 인덱스 효과 O

-- where절에 상태에 따라 달라짐

-- 함수 기반 인덱스
create index idxSsn on tblIndex(ssn); -- 인덱스 효과 X
create index idxSsn on tblIndex(substr(ssn, 8, 1)); 

select count(*) from tblIndex where substr(ssn, 8, 1) = '1'; 


-- 더미 데이터 확보 + 업무 SQL 테스트 -> 평균 시간 -> INDEX -> 검토 -> INDEX

-- 프로젝트 마무리 > 포인트 2~3군데 > index.. + 가장 반복 where + 가장 반복 join

