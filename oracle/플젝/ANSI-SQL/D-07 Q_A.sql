--D-07 Q&A
/*
교육생은 과정에 관계없이 질문을 남길 수 있다.
교사가 답변을 남겼을 경우 답변을 확인 할 수 있다.
질문 등록 후 수정만 가능하고, 삭제는 할 수 없다.
다른 교육생이 남긴 Q&A도 조회할 수 있고, 자신이 남긴 질문들만 따로 조회 할 수 있다.
*/

-- 1. Q&A 등록
insert all
    into tblQuestion values ((select max(questionSeq + 1) from tblQuestion), '질문내용', (select studentSeq from tblStudent where name = '이름' and ssn = '주민번호뒷자리')) -- 로그인한 교육생 번호
    into tblQna values((select max(qnaSeq + 1) from tblQna),(select max(questionSeq + 1) from tblQna))
select *
from dual;

-- 2. Q&A 수정
update tblQuestion
set 
    content = '질문내용',
    studentSeq = (select studentSeq from tblStudent where name = '이름' and ssn = '주민번호뒷자리') -- 로그인한 교육생 번호
where 
    questionSeq = 질문번호;

-- 3. Q&A 조회
select
    qn.qnaSeq as "질문번호",
    qu.content as "질문",
    qu.studentSeq as "학생번호",
    nvl(an.content, '아직 답변이 등록되지 않았습니다.') as "답변",
    an.teacherSeq as "교사번호"    
from tblQna qn
    inner join tblQuestion qu
        on qn.questionSeq = qu.questionSeq
            left outer join tblAnswer an
                on qu.questionSeq = an.questionSeq; -- 1. 질문 전체 조회
                    -- where qu.studentSeq = (select studentSeq from tblStudent where name = '이름' and ssn = '주민번호뒷자리');-- 2. 로그인한 교육생 질문만 조회;

-----------------------------------------------------------------------------------------------------
-- view
-- 1. 전체조회
create or replace view vwQuestion
as
select
    qn.qnaSeq as "질문번호",
    qu.content as "질문",
    qu.studentSeq as "학생번호",
    nvl(an.content, '아직 답변이 등록되지 않았습니다.') as "답변",
    an.teacherSeq as "교사번호"    
from tblQna qn
    inner join tblQuestion qu
        on qn.questionSeq = qu.questionSeq
            left outer join tblAnswer an
                on qu.questionSeq = an.questionSeq;
                
select * from vwQuestion;
