-- 9-1
select sal from emp where ename='JONES';

-- 9-2
select * from emp where sal>2975;

-- 9-5
select e.empno, e.ename, e.job, e.sal, d.deptno, d.dname, d.loc
    from emp e, dept d
    where e.deptno = d.deptno
    and e.deptno =20
    and e.sal > (select avg(sal) from emp);
    
-- 9-6
select * from emp where deptno in (20,30);

-- 9-7
select * from emp where sal in (select max(sal) from emp group by deptno);

-- 9-9: in 이나 any 모두 하나라도 해당하면 조회하는 조건 
select * from emp where sal = any(select max(sal) from emp group by deptno);

-- 9-19
select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
    from (select * from emp where deptno = 10) e10,
         (select * from dept) d
where e10.deptno = d.deptno;

-- 9-20
with 
e10 as (select * from emp where deptno = 10),
d   as (select * from dept)
select e10.empno, e10.ename, e10.deptno, d.dname, d.loc
    from e10, d
where e10.deptno = d.deptno;

-- 직원명, 부서명 출력 
select ename, deptno from emp;
select ename, (select dname from dept where deptno=emp.deptno) from emp;

/*
1. 페이징 처리
- 1페이지당 10개씩 출력
- 총개수 → count(*)
- 총개수, 총페이지수 = 총개수 / 페이지당 개수
- 총개수: 101, → 총페이지수 10페이지 → 11페이지
*/

-- 해당페이지의 목록 조회
select b.rn,
       b.empno,
       b.ename
from (
    select rownum as rn,
           a.empno,
           a.ename
    from (
        select empno,
               ename,
               hiredate
        from emp
        order by hiredate desc
    ) a
) b
where b.rn between 11 and 20;

/*
1page: 1 and 10
2page: 11 and 20

start = (page-1)*페이지당개수+1
end = page*페이지당 개수 

*/

-- 되새김 1
select e.job, empno, ename, sal, e.deptno, dname
from emp e join dept d
on e.deptno = d.deptno
where e.job = (
    select job
    from emp
    where ename = 'ALLEN');

-- 되새김 2
select e.empno, e.ename, d.dname, e.hiredate, d.loc, e.sal, s.grade
from emp e
join dept d
  on e.deptno = d.deptno
join salgrade s
  on e.sal between s.losal and s.hisal
where e.sal > (
    select avg(sal)
    from emp
)
order by e.sal desc, e.empno asc;

-- 되새김 3
select e.empno,
       e.ename,
       e.job,
       e.deptno,
       d.dname,
       d.loc
from emp e join dept d 
on e.deptno = d.deptno
where e.deptno = 10
  and e.job not in (
      select job
      from emp
      where deptno = 30
  );

-- 되새김 4
-- 다중행 max()
select e.empno,
       e.ename,
       e.sal,
       s.grade
from emp e
join salgrade s
  on e.sal between s.losal and s.hisal
where e.sal > (
    select max(sal)
    from emp
    where job = 'SALESMAN'
);

-- all
select e.empno,
       e.ename,
       e.sal,
       s.grade
from emp e
join salgrade s
  on e.sal between s.losal and s.hisal
where e.sal > all (
    select sal
    from emp
    where job = 'SALESMAN'
);
