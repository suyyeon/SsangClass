-- D-06 훈련비 조회
/*
교육생은 훈련비를 조회할 수 있다.
*/

-- 훈련비 조회
select
    tr.depositDate as "입금날짜",
    TO_CHAR(tr.trainingFee, 'FM999,999') as "훈련비"
from tblStudent st
    inner join tblTrainingFee tr
        on st.studentSeq = tr.studentSeq
            where tr.studentSeq = (select studentSeq from tblStudent where name = '이름' and ssn = '주민번호뒷자리') -- 로그인한 교육생 번호
                order by tr.trainingFeeSeq; 

select * from tblTrainingFee;
                
-----------------------------------------------------------------------------------------------------
-- 뷰              
create or replace view vwStudentTrainingFee
as
select
    tr.studentSeq as "학생번호",
    tr.depositDate as "입금날짜",
    TO_CHAR(tr.trainingFee, 'FM999,999') as "훈련비"
from tblStudent st
    inner join tblTrainingFee tr
        on st.studentSeq = tr.studentSeq
             where tr.studentSeq = (select studentSeq from tblStudent where name = '김민영' and ssn = '1534541') -- 로그인한 교육생 번호
                order by tr.trainingFeeSeq;
                
select * from vwStudentTrainingFee;
-- drop view vwStudentTrainingFee;
