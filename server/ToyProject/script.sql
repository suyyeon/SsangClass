
-- C:\class\server\ToyProject\script.sql

drop table tblUser;

-- 회원 테이블
create table tblUser (
    id varchar2(30) primary key,                    --아이디(PK)
    pw varchar2(30) not null,                       --암호
    name varchar2(30) not null,                     --이름
    lv char(1) not null,                            --등급(1. 일반회원, 2. 관리자)
    pic varchar2(100) default 'pic.png' not null,   --회원 사진
    regdate date default sysdate not null,          --가입날짜
    active char(1) default 'y' not null             --탈퇴유무(y. 활동중, n. 탈퇴)
);

insert into tblUser (id, pw, name, lv, pic, regdate)
    values ('hong', '1111', '홍길동', '1', default, default);
insert into tblUser (id, pw, name, lv, pic, regdate)
    values ('admin', '1111', '관리자', '2', default, default);    
    
commit;

select * from tblUser;


alter table tblUser
    add (active char(1) default 'y' not null);
    
    
delete from tblUser where active = 'n';
commit;








-- 게시판
create table tblBoard (
    seq number primary key,                                 --번호(PK)
    subject varchar2(300) not null,                         --제목
    content varchar2(4000) not null,                        --내용
    id varchar2(30) not null references tblUser(id),        --아이디(FK)
    regdate date default sysdate not null,                  --작성시각
    readcount number default 0 not null                     --읽음
);

create sequence seqBoard;


select * from tblBoard;






-- 게시판 뷰
create or replace view vwBoard
as
select seq, subject, content, id, (select name from tblUser where id = tblBoard.id) as name, regdate, readcount,
    (select count(*) from tblComment where pseq = tblBoard.seq) as commentcount,
    depth, (sysdate - regdate) as isnew, filename
    from tblBoard order by thread desc;


select * from vwBoard;







-- 댓글 테이블
drop table tblComment;

create table tblComment (

    seq number primary key,                                     --댓글번호(PK)
    content varchar2(1000) not null,                            --내용
    id varchar2(30) not null references tblUser(id),            --아이디(FK)
    regdate date default sysdate not null,                      --날짜
    pseq number not null references tblBoard(seq)               --부모글번호(FK)

);

create sequence seqComment;



-- 페이징
select * from (select a.*, rownum as rnum from vwBoard a) where rnum between 1 and 10;
select * from (select a.*, rownum as rnum from vwBoard a) where rnum between 11 and 20;
select * from (select a.*, rownum as rnum from vwBoard a) where rnum between 21 and 30;

select * from (select a.*, rownum as rnum from vwBoard a ) where rnum between 1 and 10 ;






drop table tblComment;
drop table tblBoard;



-- 게시판
create table tblBoard (
    seq number primary key,                                 --번호(PK)
    subject varchar2(300) not null,                         --제목
    content varchar2(4000) not null,                        --내용
    id varchar2(30) not null references tblUser(id),        --아이디(FK)
    regdate date default sysdate not null,                  --작성시각
    readcount number default 0 not null,                    --읽음
    thread number not null,                                 --답변형 게시판
    depth number not null                                   --답변형 게시판
);






select nvl(max(thread), 0) as thread from tblBoard;

select * from tblBoard order by seq;








drop table tblComment;
drop table tblBoard;




-- 게시판
create table tblBoard (
    seq number primary key,                                 --번호(PK)
    subject varchar2(300) not null,                         --제목
    content varchar2(4000) not null,                        --내용
    id varchar2(30) not null references tblUser(id),        --아이디(FK)
    regdate date default sysdate not null,                  --작성시각
    readcount number default 0 not null,                    --읽음
    thread number not null,                                 --답변형 게시판
    depth number not null,                                  --답변형 게시판
    filename varchar2(100) null,                            --첨부파일
    orgfilename varchar2(100) null                          --첨부파일(다운로드)
);


select * from tblBoard;





-- 해시 태그 테이블
create table tblHashTag (
    
    seq number primary key,             --번호(PK)
    tag varchar2(100) unique not null   --해시 태그(UQ)
    
);

create sequence seqHashTag;


-- 게시판 < (연결) > 해시 태그
create table tblTagging (
    seq number primary key,                         --번호(PK)
    bseq number not null references tblBoard(seq),  --게시물(FK)
    hseq number not null references tblHashTag(seq) --해시 태그(FK)
);

create sequence seqTagging;


select * from tblBoard order by seq desc; --580

select * from tblHashTag; --1,2,3

select * from tblTagging;









select tag from tblHashTag h inner join tblTagging t on h.seq = t.hseq where bseq = 580;




select b.* from vwBoard b
    inner join tblTagging t
        on b.seq = t.bseq
            inner join tblHashTag h
                on h.seq = t.hseq
                    where h.tag = '수업';
        




--create table 테이블 (
--    번호
--    아이디  hong   test
--    좋아요  0      0
--    싫어요  1      1
--)


create table tblGoodBad (
    seq number primary key,                             --번호(PK)
    id varchar2(30) not null references tblUser(id),    --아이디(FK)
    bseq number not null references tblBoard(seq),      --글번호I(FK)
    good number default 0 not null,                     --좋아요
    bad number default 0 not null                       --싫어요
);

create sequence seqGoodBad;














