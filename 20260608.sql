-- 1
select * from emp where ename like '%S%';

-- 2
select empno, ename, job, sal, deptno from emp where deptno = 30 and job = 'SALESMAN';

-- 3
-- 집합연산자 X
select empno, ename, job, sal, deptno from emp where (deptno = 30 or deptno = 20) and (sal > 2000);
-- 집한연산자 O
select empno, ename, job, sal, deptno from emp where deptno = 20 and sal > 2000
union all
select empno, ename, job, sal, deptno from emp where deptno = 30 and sal > 2000 
order by empno;

-- 4
select * from emp where sal >= 2000 and sal <= 3000;

-- 5
select ename, empno, sal, deptno  from emp where ename like '%E%' and (deptno = 30) and (sal not between 1000 and 2000);

-- 6
select * from emp where (ename not like '_L%') and (job in ('MANAGER','CLERK')) and (comm is null);
