-- C-08 교사 Q&A
-- 프로시저
-- 1. 교육생 전체 조회
create or replace procedure procStudentQuestion
is
    cursor vcursor is select * from vwStudentQuestion;
    vrow vwStudentQuestion%rowtype;
begin
    dbms_output.put_line('=======================================================================================================================================================================================================================================================================');
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        dbms_output.put_line('No.' || vrow.질문번호);
        dbms_output.put_line('[질문] ' || vrow.질문);
        dbms_output.put_line('[이름] ' || vrow.교육생이름);
        dbms_output.put_line('[번호] '|| vrow.교육생번호);
        dbms_output.put_line('=======================================================================================================================================================================================================================================================================');
    end loop;
    close vcursor;
        exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end;
/


-- 2. 내가 남긴 답변들 조회
create or replace procedure procTeacherQuestion(
    pname in tblTeacher.name%type,
    pssn in tblTeacher.ssn%type
)
is
    cursor vcursor is select 
        qu.questionSeq as "질문번호",
        qu.content as "질문",
        qu.studentSeq as "교육생번호",
        an.content as "답변",
        an.teacherSeq as "교사번호"    
    from tblQuestion qu
        inner join tblAnswer an
            on qu.questionSeq = an.questionSeq
                where an.teacherSeq = (select teacherSeq from tblTeacher where name = pname and ssn = pssn);
    vrow vcursor%rowtype;
begin
    dbms_output.put_line('=======================================================================================================================================================================================================================================================================');
    for vrow in vcursor loop
        dbms_output.put_line('No.' || vrow.질문번호);
        dbms_output.put_line('[질문] ' || vrow.질문);
        dbms_output.put_line('[번호] '|| vrow.교육생번호);
        dbms_output.put_line('[답변] '|| vrow.답변);
        dbms_output.put_line('====================================================================================================================================================================================================================================================================');
    end loop;
        exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end;
/


-- 3. 입력
create or replace procedure procAnswerInsert (
    pcontent in varchar2,
    pqnaseq in number, -- 질문번호
    pteachseq in number -- 교사번호
)
is
begin
    insert into tblAnswer values((select max(answerSeq) +1 from tblAnswer), pcontent, pqnaseq, pteachseq);
    dbms_output.put_line('답변 입력이 완료되었습니다.');
    dbms_output.put_line('=================================================');
exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end procAnswerInsert;
/


-- 4. 수정
create or replace procedure procAnswerUpdate (
    pseq in number, -- 답변번호
    pcontent in varchar2, -- 답변
    pqnaseq in number, -- 질문번호
    pteachseq in number -- 교사번호
)
is
    pseqcheck number;
begin
    select answerSeq into pseqcheck from tblAnswer where answerSeq = pseq;
    update tblAnswer set content = pcontent, questionSeq = pqnaseq, teacherSeq = pteachseq where answerSeq = pseq;
    dbms_output.put_line('답변 수정이 완료되었습니다.');
    dbms_output.put_line('=================================================');
exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end procAnswerUpdate;
/



-- 5. 삭제
create or replace procedure procAnswerDelete (
    pseq in number -- 답변번호
)
is
    vrow tblAnswer%rowtype;
begin
    select * into vrow from tblAnswer where answerSeq = pseq;
    delete from tblAnswer where answerSeq = pseq;
    dbms_output.put_line('답변 삭제가 완료되었습니다.');
    dbms_output.put_line('=================================================');
exception
    when others then
        dbms_output.put_line('====================================================================================');
        dbms_output.put_line('잘못된 입력입니다.');
        dbms_output.put_line('====================================================================================');
end procAnswerDelete;
/

