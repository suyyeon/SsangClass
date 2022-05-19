/*
D-06
교육생은 훈련비를 조회할 수 있다.
*/
    procStudentFeeSearch('김민영','1534541');
-- 1. 훈련비 조회
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

-- view
create or replace view vwStudentTrainingFee
as
select
    tr.depositDate as "입금날짜",
    TO_CHAR(tr.trainingFee, 'FM999,999') as "훈련비"
from tblStudent st
    inner join tblTrainingFee tr
        on st.studentSeq = tr.studentSeq
            where st.studentSeq = (select studentSeq from tblStudent where name = '이름' and ssn = '주민번호뒷자리') -- 로그인한 교육생 번호
                order by tr.trainingFeeSeq;
                
-- <전체조회>                
create or replace view vwStudentTrainingFee
as
select
    tr.depositDate as "입금날짜",
    TO_CHAR(tr.trainingFee, 'FM999,999') as "훈련비"
from tblStudent st
    inner join tblTrainingFee tr
        on st.studentSeq = tr.studentSeq
                order by tr.trainingFeeSeq;
                
                 
select * from vwStudentTrainingFee;
-- drop view vwStudentTrainingFee;

select * from tblTrainingFee;

-- 프로시저
-- 조회
-- procedure
set serverout on; 

select * from vwStudentTrainingFee;

create or replace procedure procStudentFeeSearch
is
    cursor vcursor is select * from vwStudentTrainingFee;
    vrow vwStudentTrainingFee%rowtype;
begin
    dbms_output.put_line('===================================================================================================================================');
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        dbms_output.put_line('[입금날짜] ' || vrow.입금날짜 ||' [훈련비] '|| vrow.훈련비);
        dbms_output.put_line('===================================================================================================================================');
    end loop;
    close vcursor;
        exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 접근으로 발생한 오류입니다.');
        dbms_output.put_line('====================================================================================');
end;
/


begin
    procStudentFeeSearch();
end;
/


