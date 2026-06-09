-- 7-17
select avg(sal), deptno from emp group by deptno;

-- 7-20
select deptno, job, avg(sal) from emp
group by deptno, job having avg(sal) >= 2000 
order by deptno, job;

-- 되새김 1
select deptno,
       trunc(avg(sal)) as avg_sal,
       max(sal) as max_sal,
       min(sal) as min_sal,
       count(*) as cnt
from emp
group by deptno
order by min(sal);

-- 되새김 2
select job, count(*)
from emp
group by job
having count(*) >= 3;

-- 되새김 3
select 
    to_char(hiredate, 'YYYY') as hire_year, 
    deptno, 
    count(*) as cnt
from emp
group by to_char(hiredate, 'YYYY'), deptno
order by hire_year, deptno;

-- 되새김 4
-- decode version
select 
    decode(comm, null, 'X', 'O') as exist_comm,
     count(*) as cnt
from emp
group by decode(comm, null, 'X', 'O');

-- nvl2 version
select nvl2(comm, 'O', 'X') as exist_comm,
       count(*) as cnt
from emp
group by nvl2(comm, 'O', 'X');

