-- 10-1
create table dept_temp
    as select * from dept;
    
-- 10-2
select * from dept_temp;

drop TABLE dept_temp;

-- 10-3
insert into dept_temp(deptno, dname, loc) values(50, 'DATABASE', 'SEOUL');
select * from dept_temp;

-- 10-4: 테이블 뒤에 (컬럼명,...) 생략 -> 모든 컬럼이 정의된 순서대로 값을 넣어야 함 
insert into dept_temp values(60, 'NETWORK', 'BUSAN');
select * from dept_temp;

-- 10-5: NULL 값 넣는 두가지 방법 -> 명시적 입력, '' 공백 입력 ->> 명시적 입력 선호
insert into dept_temp(deptno, dname, loc) values (70, 'WEB', null);
select * from dept_temp;

insert into dept_temp values(80, 'MOBILE', '');
select * from dept_temp;

-- 10-7: nullable 이 'yes' 인 값에 한해서 null 가능 ->> deptno 는 no 라서 (dname, loc) 하 에러뜸
insert into dept_temp(deptno, loc) values (90, 'INCHEON');
select * from dept_temp;

-- 10-8
create table emp_temp as select * from emp where 1<>1;
SELECT * FROM emp_temp;
-- 10-9
insert into emp_temp(empno, ename, job ,mgr, hiredate, sal, comm, deptno)
    values (9999, 'Kylie', 'PRESIDENT', NULL, '2001/01/01', 5000, 1000, 10);

select * from emp_temp;

-- 10-10
insert into emp_temp(empno, ename, job ,mgr, hiredate, sal, comm, deptno)
    values (1111, 'Kim', 'MANAGER', 9999, '2001-01-05', 4000, NULL, 20);
select * from emp_temp;

insert into emp_temp(empno, ename, job ,mgr, hiredate, sal, comm, deptno)
    values (2111, 'Kendal', 'MANAGER', 9999, sysdate, 4000, NULL, 30);
select * from emp_temp;

-- 10-15
create table dept_temp2 as select * from dept;
select * from dept_temp2;

-- 10-16
update dept_temp2 set loc = 'SEOUL';
select * from dept_temp2;

rollback; -- 작업 취소

-- 10-18
update dept_temp2
set dname = 'DATABASE',
loc = 'SEOUL'
where deptno = 40;

select * from dept_temp2 where deptno = 40;

-- 10-22
create table emp_temp2 as select * from emp;
select * from emp_temp2;

-- 10-23: 데이터 일부분 삭제하기 
delete from emp_temp2 
where job = 'MANAGER';

rollback;

select * from emp_temp2;

-- 모든 데이터 삭제
delete from emp temp2; -- 테이블 설정값 그대로 DML
truncate table emp_temp2; -- 테이블 설정값 초기화 DDL
