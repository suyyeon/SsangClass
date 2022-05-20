-- B-09 훈련비 관리 및 조회
/* 
관리자가 교육생을 선택하고 훈련비와 입금날짜를 입력할 수 있다.
관리자가 교육생 정보를 조회하고 입금 확인을 조회할 수 있다. 
*/

-- 1. 훈련비 등록
insert into tblTrainingFee values ((select max(trainingFeeSeq+1) from tblTrainingFee), 훈련비 금액, default, 교육생 번호);

-- 2. 훈련비 삭제
delete from tblTrainingFee where trainingFeeSeq = 훈련비번호;

-- 3. 훈련비 수정
update tblTrainingFee set trainingFee = 훈련비금액, depositDate = '입금날짜', studentSeq = 교육생번호 where trainingFeeSeq = 훈련비번호;

-- 4. 훈련비 조회
select
    tr.trainingFeeSeq as "훈련비번호",
    st.studentSeq as "교육생번호",
    st.name as "교육생이름",
    st.ssn as "주민번호 뒷자리",
    st.tel as "전화번호",
    TO_CHAR(tr.trainingFee, 'FM999,999') as "훈련비",
    tr.depositDate as "입금날짜"
from tblStudent st
    inner join tblTrainingFee tr
        on st.studentSeq = tr.studentSeq
           -- where st.studentSeq = 교육생 번호 
                order by tr.trainingFeeSeq; 

-----------------------------------------------------------------------------------------------------
-- view
create or replace view vwTrainingFee
as
select
    tr.trainingFeeSeq as "훈련비번호",
    st.studentSeq as "교육생번호",
    st.name as "교육생이름",
    st.ssn as "주민번호",
    st.tel as "전화번호",
    TO_CHAR(tr.trainingFee, 'FM999,999') as "훈련비",
    tr.depositDate as "입금날짜"
from tblStudent st
    inner join tblTrainingFee tr
        on st.studentSeq = tr.studentSeq
                order by tr.trainingFeeSeq;

-- 1. 전체조회  
select * from vwTrainingFee;
-- 2. 교육생 번호로 조회
select * from vwTrainingFee where 교육생번호 = 1;
-- drop view vwTrainingFee;

