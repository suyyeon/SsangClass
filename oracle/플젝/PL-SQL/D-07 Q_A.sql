--D-07 Q&A
-- 프로시저
-- 1. 전체 조회
create or replace procedure procQuestionSerch
is
    cursor vcursor is select * from vwQuestion;
    vrow vwQuestion%rowtype;
begin
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        dbms_output.put_line('No.' || vrow.질문번호);
        dbms_output.put_line('[질문] ' || vrow.질문);
        dbms_output.put_line('[답변] ' || vrow.답변);
        dbms_output.put_line('[교사번호] '|| vrow.교사번호);
        dbms_output.put_line('=======================================================================================================================================================================================================================================================================');
    end loop;
    close vcursor;
end procQuestionSerch;
/


-- 2. 자기것만
create or replace procedure procMyQuestionSerch (
    pname in tblStudent.name%type,
    pssn in tblStudent.ssn%type
)
is
    cursor vcursor is select
        qn.qnaSeq as "질문번호",
        qu.content as "질문",
        nvl(an.content, '아직 답변이 등록되지 않았습니다.') as "답변",
        an.teacherSeq as "교사번호"    
    from tblQna qn
    inner join tblQuestion qu
        on qn.questionSeq = qu.questionSeq
            left outer join tblAnswer an
                on qu.questionSeq = an.questionSeq
                    where qu.studentSeq = (select studentSeq from tblStudent where name = pname and ssn = pssn);
    vrow vcursor%rowtype;
begin
    dbms_output.put_line('=======================================================================================================================================================================================================================================================================');
    for vrow in vcursor loop
        dbms_output.put_line('No.' || vrow.질문번호);
        dbms_output.put_line('[질문] ' || vrow.질문);
        dbms_output.put_line('[답변] ' || vrow.답변);
        dbms_output.put_line('[교사번호] '|| vrow.교사번호);
        dbms_output.put_line('=======================================================================================================================================================================================================================================================================');
    end loop;
        exception
    when others then
            dbms_output.put_line('잘못된 입력입니다.');
            dbms_output.put_line('====================================================================================');
end procMyQuestionSerch;
/



-- 3. 입력
create or replace procedure procQuestionInsert ( 
    pcontent in tblquestion.content%type,
    pstuseq in tblquestion.studentseq%type
)
is
    pstuseqcheck number;
begin
    select studentseq into pstuseqcheck from tblStudent where studentseq = pstuseq;
    insert into tblQuestion values((select max(questionseq) + 1 from tblQuestion), pcontent, pstuseq);
    insert into tblQna values((select max(qnaSeq) + 1 from tblQna), (select max(questionSeq) + 1 from tblQna) );
    dbms_output.put_line('질문 입력이 완료되었습니다.');
    dbms_output.put_line('=================================================');
exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end procQuestionInsert;
/


-- 4. 수정
create or replace procedure procQuestionUpdate ( 
    pseq in tblquestion.questionseq%type,
    pcontent in tblquestion.content%type,
    pstuseq in tblquestion.studentseq%type
)
is
begin
    update tblQuestion set content = pcontent, studentSeq = pstuseq where questionSeq = pseq;
    dbms_output.put_line('질문 수정이 완료되었습니다.');
    dbms_output.put_line('=================================================');
exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end procQuestionUpdate;
/
