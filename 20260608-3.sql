-- 7강

-- 7-1
select sum(sal) from emp;

-- 7-4
select  sum(distinct sal),
        sum(all sal),
        sum(sal) from emp;

-- 7-6
select count(*) from emp;

-- 집계함수는 null 을 제외하므로
select sum(comm)/4, avg(comm), sum(comm)/14, avg(nvl(comm,0)) from emp;

select deptno, count(*), avg(sal) from emp group by deptno;

-- 부서별 평균급여(급여가 2000이상)
select deptno, count(*), avg(sal) from emp where sal>= 2000 group by deptno;
-- where: group by이전에 조건 

select deptno, count(*), avg(sal) from emp group by deptno having avg(sal) >= 2000;
-- heaving: group by 이후에 조건 
select deptno from emp;
