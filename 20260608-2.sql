-- 6-1: upper, lower, initcap
select ename, upper(ename), lower(ename), initcap(ename) from emp;

-- 6-2: upper 함수로 문자열 비교하기 
select * from emp where upper(ename) = upper('scott');

-- 6-4
select ename, length(ename) from emp;

-- dual: 그냥 값 조회하고 싶을 때, 한 행으로 나오는
select length('한글'), lengthb('한글') from dual; -- lengthb: 문자열의 길이를 byte 기준으로 세는 함수(한글) 

select * from dual;

select sysdate from dual;

-- 6-7: orcale sql의 인덱스 시작은 1 부터
select job, substr(job, 1, 2), substr(job, 3, 2), substr(job, 5) from emp;

select substr('abcdef', 3, 3) from dual;

select avg(sal) from emp;

-- 6-8: (-) 는 끝부터 센다
select job, 
        substr(job, -length(job)),
        substr(job, -length(job), 2),
        substr(job, -3)
from emp;

-- 6-9: 특정 문자열 위치 찾기 instr
select instr('hello, oracle!', 'l') as instr_1,
       instr('hello, oracle!', 'l', 5) as instr_2,
       instr('hello, oracle!', 'l', 2, 2) as instr_3
from dual;

-- 6-12
select '010-1234-5678' as replace_before,
        replace('010-1234-5678', '-', ' ') as replace_1,
        replace('010-1234-5678', '-') as replace_2 -- ''이 된다  
        from dual;

-- 6-13: l/rpad -> 어떤걸로 채울것인가 
select 'Oracle',
        lpad('Oracle', 10, '#') as lpad_1,
        rpad('Oracle', 10, '*') as rpad_1,
        lpad('Oracle', 10) as lpad_2,
        rpad('Oracle', 10) as rpad_2
from dual;

-- 6-14
select  rpad('970702-', 14, '*') as rpad_jmno,
        rpad('010-1234-', 13, '*') as rpad_phone from dual;
        
-- 6-23
select  sysdate as now,
        sysdate-1 as yesterday,
        sysdate+1 as tomorrow from dual;       
        
-- 6-24: 특정 날짜 데이터에 입력한 개월 수만큼 이후의 날짜 출력(년도 계산은 안되고 개월로만 계산된다)
select sysdate, add_months(sysdate, 12), add_months(sysdate, -13) from dual;

-- 6-25
select empno, ename, hiredate, add_months(hiredate, 120) as work10year from emp;

-- 6-27
select empno, ename, hiredate, sysdate, months_between(hiredate,sysdate) as months1,
                                        months_between(sysdate,hiredate) as months2,
                                        trunc(months_between(sysdate,hiredate)) as month3 from emp;
                                        
 -- 6-28
 select sysdate, next_day(sysdate, '월요일'),
                last_day(sysdate) from dual;
                
-- 2026년 06월 08일
-- 날짜 -> 문자 변환 
select to_char(sysdate, 'YYYY"년" MM"월" DD"일"') from dual;

select * from emp;

-- 6-31: 숫자/날짜 -> 문자열 
select empno, ename, empno + '500' from emp where ename = 'SCOTT';
select empno, ename, empno + to_number('500') from emp where ename = 'SCOTT';

select replace('1,500', ',', '') - 500 from dual;

-- 6-42: to_date -> 문자열 데이터를 날짜 데이터로 반환 
select to_date('2024-08-14', 'YYYY-MM-DD') as todate1,
       to_date('2024/08/14', 'YYYY-MM-DD') as todate2 from dual;
       
select to_date('2024-08-14') as todate1 from dual;

-- 6-45
select empno, ename, sal, comm, sal+comm,
        nvl(comm,0), sal+nvl(comm,0) from emp;

select nvl2(null,1,2) from dual;

-- 6-46
select empno, ename, comm, nvl2(comm, '0', 'x'),
                           nvl2(comm, sal*12+comm, sal*12) as annsal from emp;

-- 6-47: decode
select empno, ename, job, sal,
        decode(job,
        'manager', sal*1.1, 
        'salesman', sal*1.05,
        'analyst', sal,
        sal*1.03) as upsal from emp;

-- 6-48: case 조건형식 -> decode 업그레이드 형식 
select empno, ename, job, sal,
    case job
        when 'manager' then sal*1.1
        when 'salesman' then sal*1.05
        when 'anlyst' then sal
        else sal*1.03
    end as upsal from emp;
                        
-- 6-49
select empno, ename, comm,
    case
    when comm is null then '해당 사항 없음'
    when comm = 0 then '수당 없음'
    when comm > 0 then '수당 : ' || comm
    end as comm_text
    from emp;
    
select comm from emp;

-- 되새김 문제 1
select  empno,  
        -- substr(to_char(empno),1, 2) || '**' as masking_empno,
        rpad(substr(to_char(empno),1, 2), length(empno), '*') as masking_empno,
        ename,
        rpad(substr(ename,1,1), length(ename), '*') as masking_ename from emp
        where length(ename) >= 5 and length(ename) < 6;

-- 되새김 문제 2
select empno, ename, sal, 
       trunc(sal / 21.5, 2) as day_pay, 
       round(sal /21.5 /8, 1)  as time_pay from emp;

-- 되새김 문제 3
select empno, ename, hiredate,
        to_char(next_day(add_months(hiredate, 3), '월요일'), 'YYYY-MM-DD') as r_job,
        nvl(to_char(comm), 'N/A') as comm from emp;
    -- decode(comm, null, 'N/A', to_char(comm)) comm from emp; => comm이 null 이면 'N/A' 아니면 to_char 문자열로 반환해라 (하나의 타입으로 안하며 에러)

-- 되새김 문제 4
select empno, ename, mgr,
        case
        when mgr is null then '0000'
        when substr(to_char(mgr), 1, 2) = '75' then '5555'
        when substr(to_char(mgr), 1, 2) = '76' then '6666' 
        when substr(to_char(mgr), 1, 2) = '77' then '7777'
        when substr(to_char(mgr), 1, 2) = '78' then '8888'
        else to_char(empno)
    end as chg_mgr from emp;

-- like version
select empno,
       ename,
       mgr,
       case
         when mgr is null then '0000'
         when to_char(mgr) like '75%' then '5555'
         when to_char(mgr) like '76%' then '6666'
         when to_char(mgr) like '77%' then '7777'
         when to_char(mgr) like '78%' then '8888'
         else to_char(mgr)
       end as chg_mgr
from emp;
      

