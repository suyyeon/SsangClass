
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





