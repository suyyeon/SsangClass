/*
C-08
교사는 교육생이 등록한 질문을 조회, 답변할 수 있다.
교사가 질문을 조회시 질문을 등록한 교육생의 번호를 확인 할 수 있다.
*/

--1. Q&A 등록
insert into tblAnswer values ((select max(answerSeq + 1) from tblAnswer), '답변내용', 질문번호, (select teacherSeq from tblTeacher where name = '이름' and ssn = '주민번호뒷자리')); -- 로그인한 교사 번호

select * from tblanswer;
select * from tblQuestion;
delete from tblAnswer where answerSeq = 37;

--create or replace procedure procInsertAnswer (
--    pAnswerSeq in number,
--    pContent in varchar2,
--    pQuestionSeq in number,
--    pTeacherSeq in number
--)
--is
--begin
--    insert into tblanswer(answerSeq, content, questionSeq, teacherSeq) 
--        values (pAnswerSeq, pContent, pQuestionSeq, pTeacherSeq);
--        dbms_output.put_line('======================================================');
--        dbms_output.put_line('완료');
--        dbms_output.put_line('======================================================');
--end;
--
--exec procInsertAnswer (37,'테스트내용',37,2);


--2. Q&A 수정
update tblAnswer 
set
    content = '답변내용',
    questionSeq = 질문번호,
    teacherSeq = (select teacherSeq from tblTeacher where name = '이름' and ssn = '주민번호뒷자리')
where
    answerSeq = 답변번호;

--3. Q&A 삭제
delete from tblAnswer where answerSeq = 답변번호;

--4. Q&A 조회
-- 교육생이 등록한 Q&A 조회
select 
    qu.questionSeq as "질문번호",
    qu.content as "질문",
    qu.studentSeq as "교육생번호",
    st.name as "교육생이름"
from tblQuestion qu -- 1. 질문 전체 조회
    inner join tblStudent st
        on qu.studentSeq = st.studentSeq
           -- where qu.studentSeq = 교육생번호 -- 2. 특정 교육생만 조회
                order by questionSeq;

-- 교사가 등록한 Q&A 조회
select
    qu.questionSeq as "질문번호",
    qu.content as "질문",
    qu.studentSeq as "교육생번호",
    an.content as "답변",
    an.teacherSeq as "교사번호"    
from tblQuestion qu
    inner join tblAnswer an
        on qu.questionSeq = an.questionSeq
            where an.teacherSeq = (select teacherSeq from tblTeacher where name = '이름' and ssn = '주민번호뒷자리');


-----------------------------------------------------------------------------------------------------
-- view
-- 학생이 등록한 Q&A 조회
create or replace view vwStudentQuestion
as
select
    qu.questionSeq as "질문번호",
    qu.content as "질문",
    qu.studentSeq as "교육생번호",
    st.name as "교육생이름"
from tblQuestion qu 
    inner join tblStudent st
        on qu.studentSeq = st.studentSeq
                order by questionSeq;


select * from tblStudent;
-- 교육생 전체 조회
select * from vwStudentQuestion;
-- 특정 교육생만 조회
select * from vwStudentQuestion where "교육생번호" = 1;


-- 교사가 등록한 Q&A 조회
create or replace view vwTeacherQuestion
as
select
    qu.questionSeq as "질문번호",
    qu.content as "질문",
    qu.studentSeq as "교육생번호",
    an.content as "답변",
    an.teacherSeq as "교사번호"    
from tblQuestion qu
    inner join tblAnswer an
        on qu.questionSeq = an.questionSeq
            where an.teacherSeq = (select teacherSeq from tblTeacher where name = '이름' and ssn = '주민번호뒷자리');

select * from tblteacher;
select * from vwTeacherQuestion;

---------------------------------------------------------------------------------------------------------------------------------------
-- 조회프로시저

select * from vwStudentQuestion;
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
        dbms_output.put_line(vrow.질문번호 ||'번 질문: ' || vrow.질문 || '   교육생이름: ' || vrow.교육생이름 || '   교육생번호: ' || vrow.교육생번호);
        dbms_output.put_line('=======================================================================================================================================================================================================================================================================');
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
    procStudentQuestion();
end;
/

select * from vwTeacherQuestion;

create or replace procedure procTeacherQuestion
is
    cursor vcursor is select * from vwTeacherQuestion;
    vrow vwTeacherQuestion%rowtype;
begin
    dbms_output.put_line('=======================================================================================================================================================================================================================================================================');
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        dbms_output.put_line(vrow.질문번호 ||'번 질문: ' || vrow.질문 || '   교육생번호: ' || vrow.교육생번호);
        dbms_output.put_line('답    변: ' || vrow.답변);
        dbms_output.put_line('=======================================================================================================================================================================================================================================================================');
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
    procTeacherQuestion();
end;
/





-- 조회프로시저
create or replace procedure procQuestion
is
    vqnaSeq 
    vrow vwOpenCourse%rowtype;
begin
    procSetOpenCourse(vresult);
    loop
        fetch vresult into vrow;
        exit when vresult%notfound;
        dbms_output.put_line('| ' || to_char(vrow.oc_seq, '00') || '|' || vrow.course_name || chr(9)
                                || '|' || vrow.oc_startdate || '~' || vrow.oc_enddate 
                                || '|' || vrow.room_name || '|' || vrow.room_capacity || '명|');
        dbms_output.put_line('--------------------------------------------------------------------');
    end loop;
end procGetOpenCourse;


















