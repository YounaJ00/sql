-- 11-1
create table dept_tcl as select * from dept;
select * from dept_tcl;

-- 11-2
insert into dept_tcl values(50, 'DATABASE', 'SEOUL');
update dept_tcl set loc = 'BUSAN' where deptno = 40;
delete from dept_tcl where dname = 'RESEARCH';
select * from dept_tcl;

-- 11-3
rollback;
select * from dept_tcl;

-- 11-4
insert into dept_tcl values(50, 'NETWORK', 'SEOUL');
update dept_tcl set loc = 'BUSAN' where deptno = 20;
delete from dept_tcl where deptno = 40;
select * from dept_tcl;


-- 11-5
commit;
select * from dept_tcl;
rollback; -- 커밋하면 롤백 소용 없음
select * from dept_tcl;

-- 11-6
select * from dept_tcl;
delete from dept_tcl where deptno = 20;

-- 11-7
update dept_tcl set loc = 'SEOUL' where deptno = 30;
select * from dept_tcl;
commit;

-- 12-1
create table emp_ddl(
    empno number(4),
    enmae VARCHAR2(10),
    ename varchar2(9),
    mgr number(4),
    hiredate date,
    sal number(7,2),
    comm number(7,2),
    deptno number(2)
    );
    
    desc emp_ddl;
    
-- 12-2
create table dept_ddl as select * from dept;
desc dept_ddl;
-- 12-3
select * from dept_ddl;

-- 12-4
create table emp_ddl_30 as select * from emp where deptno = 30;
select * from emp_ddl_30;

-- 12-6
create table emp_alter  as select * from emp;
select * from emp_alter;

-- 12-7
alter table emp_alter add hp VARCHAR2(20);
select * from emp_alter;

-- 13-1
select * from dict;
select * from dictionary;

-- 13-3
select * from user_tables order by table_name;

-- 13-8
select * from user_indexes;

-- 13-10
create index idx_emp_sal on emp(sal);
-- 13-11
select * from user_int_colums;

-- 실행 계획(explain plan)
explain plan for select * from emp where ename = 'JONES';
select * from table(dbms_xplan.display);

-- 인덱스 생성
create index idx_emp_ename on emp(ename);
explain plan for select * from emp where empno=7369;
select * from table(dbms_xplan.display);

/*
인덱스 적용 컬럼
- where 절에 자주 사용되는 컬럼
- 조인시 사용되는 컬럼
- 정렬시 사용되는 컬럼
- 날짜, 코드값(범주형)
- 타입: 정수, 날짜, char ... 가변 문자열
- 가공하기 전에 조건 지정
- 복합인덱스(두개 이상의 컬럼) - 앞에서부터 순서대로 적용
- 제약조건(PK, UNIQUE) 자동으로 인덱스 생성
* 설계(화면설계, 기능정의) -> DB설계 시 인덱스 고려 
*/

-- 13-15
create view vw_emp20 as (select empno, ename, job, deptno from emp where deptno=20);
select * from user_views;

-- 13-16
select * from vw_emp20;

-- 13-27
create table dept_sequence as select * from dept where 1 <> 1;
select * from dept_sequence;

-- 현재 시퀀스값 (current value) -> 현재 세션에서 발급받은 번호표 
select seq_dept_sequence.currval from dual;
-- 처음 했을 때 결과: ORA-08002: sequence SEQ_DEPT_SEQUENCE.CURRVAL is not yet defined in this session

-- 다음 시퀀스값 (next value) -> 번호발행기에서 다음번호를 뽑은거 
select seq_dept_sequence.nextval from dual;

-- 실제 사용 예시
-- PK 값을 저장할 때
insert into dept_sequence (deptno, dname, loc) values (seq_dept_sequence.nextval, '영업팀', '서울');
