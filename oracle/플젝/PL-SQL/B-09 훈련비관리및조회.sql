-- B-09 훈련비 관리 및 조회
-- 프로시저
-- 1. 조회
set serverout on; 
create or replace procedure procFeeSearch
is
    cursor vcursor is select * from vwTrainingFee;
    vrow vwTrainingFee%rowtype;
begin
    dbms_output.put_line('===================================================================================================================================');
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        dbms_output.put_line('[교육생번호] ' || vrow.교육생번호 ||
                            ' [이름] '|| vrow.교육생이름 ||
                            ' [주민번호 뒷자리] '|| vrow.주민번호||
                            ' [전화번호] '||vrow.전화번호||
                            ' [훈련비] '|| vrow.훈련비 || 
                            ' [입금날짜] ' || vrow.입금날짜);
        dbms_output.put_line('===================================================================================================================================');
    end loop;
    close vcursor;
        exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end;
/



-- 2. 입력
create or replace procedure procFeeInsert (
    pfee  in tbltrainingfee.trainingfee%type,
    pdate  in tbltrainingfee.depositdate%type,  
    pstuseq in tbltrainingfee.studentseq%type
)
is
begin
    insert into tblTrainingFee values((select max(trainingFeeSeq) +1 from tblTrainingFee), pFee, pDate, pStuSeq);
    dbms_output.put_line('훈련비 입력이 완료되었습니다.');
    dbms_output.put_line('=================================================');
exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end procFeeInsert;
/


-- 3. 수정
create or replace procedure procFeeUpdate (
    pseq in tbltrainingfee.trainingfeeseq%type,
    pfee  in tbltrainingfee.trainingfee%type,
    pdate  in tbltrainingfee.depositdate%type,  
    pstuseq in tbltrainingfee.studentseq%type
    
)
is
    vrow tblTrainingFee%rowtype;
begin
    select * into vrow from tblTrainingFee where trainingfeeseq = pseq;
    update tblTrainingFee set trainingFee = pfee, depositDate = pdate, studentSeq = pstuseq where trainingFeeSeq = pseq;
    dbms_output.put_line('훈련비 수정이 완료되었습니다.');
    dbms_output.put_line('=================================================');
exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end procFeeUpdate;
/


-- 4. 삭제
create or replace procedure procFeeDelete (
    pseq number
)
is
    vrow tblTrainingFee%rowtype;
begin
    select * into vrow from tblTrainingFee where trainingfeeseq = pseq;
    delete from tblTrainingFee where trainingFeeSeq = pseq;
    dbms_output.put_line('훈련비 삭제가 완료되었습니다.');
    dbms_output.put_line('=================================================');
exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end procFeeDelete;
/

