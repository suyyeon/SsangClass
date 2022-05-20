-- C-08 교사 Q&A
/*
교사는 교육생이 등록한 질문을 조회, 답변할 수 있다.
교사가 질문을 조회시 질문을 등록한 교육생의 번호를 확인 할 수 있다.
*/

--1. Q&A 등록
insert into tblAnswer values ((select max(answerSeq + 1) from tblAnswer), '답변내용', 질문번호, (select teacherSeq from tblTeacher where name = '이름' and ssn = '주민번호뒷자리')); -- 로그인한 교사 번호

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
from tblQuestion qu 
    inner join tblStudent st
        on qu.studentSeq = st.studentSeq
           -- where qu.studentSeq = 교육생번호 -- 2. 특정 교육생만 조회
                order by questionSeq; -- 1. 질문 전체 조회

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
-- 1. 학생이 등록한 Q&A 조회
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


-- 2. 교사가 등록한 Q&A 조회
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

select * from vwTeacherQuestion;

