-- 8-1: corss join
select * from emp, dept order by empno;

-- 8-2: equi join
select * from emp, dept 
where emp.deptno = dept.deptno -- 내부조인(inner join)
order by empno;

-- ANSI SQL
-- , -> join
-- where -> on
-- inner join 에서 inner(or outer) 생략 가능
select * from emp join dept 
on emp.deptno = dept.deptno -- 내부조인(inner join)
order by empno;

-- 8-3
select * from emp e, dept d  -- 테이블 별칭 줄 때 as 쓰면 안된
where e.deptno = d.deptno
order by empno;

-- 8-7
select *
from emp e, salgrade s 
where e.sal between s.losal and s.hisal;

-- 되새김 1
select e.deptno, d.dname, e.empno, e.ename, e.sal
    from emp e join dept d
    on e.deptno = d.deptno
    where sal > 2000;
    
-- 되새김 2
select e.deptno, 
       d.dname,
       trunc(avg(e.sal)) as avg_sal,
       max(e.sal) as max_sal,
       min(e.sal) as min_sal,
       count(*) as cnt
from emp e, dept d
where e.deptno = d.deptno
group by e.deptno, d.dname
order by e.deptno;

-- 되새김 3
select d.deptno, dname, empno, ename, job, sal
from dept d left join emp e
on d.deptno = e.deptno 
order by d.deptno, ename;

-- 되새김 4 
-- oracle version
select d.deptno, dname, e.empno, e.ename, e.mgr, e.sal, losal, hisal, grade, e2.empno mgr_empno, e2.ename mgr_ename
from dept d, emp e, salgrade s, emp e2
where d.deptno = e.deptno(+)
and e.sal between s.losal(+) and s.hisal(+)
and e.mgr = e2.empno(+)
order by d.deptno, empno;

-- normal version
select d.deptno, dname, e.empno, e.ename, e.mgr, e.sal, losal, hisal, grade, e2.empno mgr_empno, e2.ename mgr_ename
from dept d left join emp e
on d.deptno = e.deptno
left join salgrade s
on e.sal between s.losal and s.hisal
left join emp e2
on e.mgr = e2.empno
order by d.deptno, empno;


