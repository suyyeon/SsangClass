-- D-06 훈련비 조회
-- 프로시저
-- 조회
set serverout on; 
create or replace procedure procStudentFeeSearch (
    pname in tblStudent.name%type,
    pssn in tblStudent.ssn%type
)
is
    cursor vcursor 
        is select
         tr.studentSeq as "번호",
         tr.depositDate as "입금날짜",
                    TO_CHAR(tr.trainingFee, 'FM999,999') as "훈련비"
                from tblStudent st
                    inner join tblTrainingFee tr
                        on st.studentSeq = tr.studentSeq
                              where tr.studentSeq = (select studentSeq from tblStudent where name = pname and ssn = pssn)
                                order by tr.trainingFeeSeq; 
    vrow vcursor%rowtype; 
    
begin
    dbms_output.put_line('=============================================================================================================================');
    for vrow in vcursor
    loop 
    dbms_output.put_line('[입금날짜] ' || vrow.입금날짜 ||' [훈련비] '|| vrow.훈련비);
    dbms_output.put_line('=============================================================================================================================');
    end loop;
end procStudentFeeSearch;
/

