-- group by, having 
-- group by : 컬럼 그룹핑할 때
-- having : 그룹핑한 결과를 필터링할 때

select sum(sal) as "부서별 급여 합", deptno from emp group by deptno
having sum(sal) >= 9000

-- *****쿼리 순서*****
-- 실무 혹은 sql 시험 때 아래 순서에 쿼리를 읽으면 됨!
-- 1. from 2. where 3. group by 4. having 5. select 6. order by

-- 12월 13일 수업내용
-- round, truncate
-- round : 반올림
-- truncate : 특정 자리수 버림
-- dual : 가상 테이블(연습용)

select round(500.8) from dual

-- 4번째 소수점 반올림
select round(500.56789, 4) from dual

-- 특정 소수점 이하를 버림
select truncate(1234.56789,1) from dual

-- 실무에서 round와 truncate는 자주 사용하지 않는다. (이런게 있구나~ 정도 알면 됨)

-- if
-- 만약 sal이 3천 이하면 A를 출력하고 초과면 B를 출력해줘
select if(sal <=3000, 'A', 'B'), sal from emp

-- switch case ~
select case when(sal between 1000 and 2000) then 'A'
when (sal between 3000 and 5000) then 'B' else 'C' end, sal from emp

-- if, switch문은 실무에서 잘 사용 안함

-- 현재시각 출력하기********
select date_format(now(), '%Y-%m-%d') as '오늘은?' from dual
select now() from emp

-- join
-- 조인은 N개의 테이블을 서로 묶어서 하나의 결과를 만들어 내는 것을 의미.
-- 즉, dept(부서 테이블)과 emp(사원 테이블)을 묶어서 결과를 조회하고 싶을 때 join을 사용
-- 테이블을 한개로 관리하면 컬럼 수 가 늘어나고 이는 데이터베이스 성능저하로 이어짐.
-- 실무에선 여러 테이블을 나누어 관리하며, join을 이용해 테이블을 묶는다.
-- 이는 ******관계형데이터베이스(RDBMS) == MYSQL의 큰 특징 중 하나!
-- 번외) join이 있으면 관계형데이터베이스(Mysql, Oracle) join이 없으면 NoSQL(MongoDB, DynamoDB...)!
-- join을 하려면 교집합 컬럼을 찾아야 함.

-- 부서 테이블에서 부서번호 조회
select deptno from dept 
-- 사원 테이블에서 부서번호 조회
select deptno from emp

-- 사원들 부서 이름과 근무지 조회
-- 부서이름과 근무지는 dept 테이블에 존재
-- deptno를 이용해서 테이블을 묶을 예정
select 
	e.ename as "사원이름",
	e.job as "사원직책",
	d.dname as "부서이름",
	d.loc as "근무지",
	e.deptno as "부서번호"
from emp as e
inner join dept as d
on e.deptno = d.deptno 
-- inner join과 on도 from절에 속한다.
-- from(inner join, on) -> where -> group by....
-- 교집합 컬럼(deptno)은(는) 이름만 같다고 join이 되는게 아닌, 데이터타입이 같아야 한다.
-- emp에 있는 deptno와 dept에 있는 deptno는 데이터 타입이 같다.

-- 문제1. 부서번호가 10인 사원들의 이름, 입사날짜, 부서이름 조회
select
	e.ename as "이름",
	e.hiredate as "입사날짜", 
	d.dname as "부서이름",
	e.deptno as "부서번호"
from emp as e
inner join dept as d
on e.deptno = d.deptno
where e.deptno = 10
-- 문제2. JOB이 MANAGER인 사원의 번호, 근무지 조회
select 
	e.ename as "사원번호",
	d.loc as "근무지",
	e.job as "직책"
from emp as e
inner join dept as d
on e.deptno = d.deptno
where e.job = 'MANAGER'

-- 문제3. 급여가 2000이상인 사원의 번호, 이름, 부서번호, 부서이름, 근무지 조회
select 
	e.empno as '사원번호',
	e.ename as '사원이름',
	d.deptno as '부서번호',
	d.dname as '부서이름',
	d.loc as '근무지'
from emp as e
inner join dept as d
on e.deptno = d.deptno
where e.sal >= 2000
-- inner join(내부조인, 실무에선 조인이라고 함)

-- self join
-- emp 테이블에 사수번호 mgr와 사원번호는 교집합
-- from 먼저 실행하기 때문에 select절에 from절에 사용한 별칭을 사용할 수 있다. (매우 중요한 개념)

select 
	busasu.empno as '부사수 사원번호',
	busasu.ename as '부사수 이름',
	sasu.empno as '사수 사원번호',
	sasu.ename as '사수 이름'
from emp as busasu
inner join emp as sasu
on busasu.mgr = sasu.empno

-- 문제1. 사원보너스(부사수)가 null이 아닌 사원이름, 사원의 사수 이름 조회
select 
	busasu.ename as '부사수 이름',
	sasu.ename as '사수 이름'
from emp as busasu
inner join emp as sasu
on busasu.mgr = sasu.empno
where busasu.comm is not null
-- 문제2. 부서번호(부사수)가 20번인 부사수 사원의 사원번호, 사원이름, 사수이름 조회
select 
	busasu.empno,
	busasu.ename,
	sasu.ename
from emp as busasu
inner join emp as sasu
on busasu.mgr = sasu.empno
where busasu.deptno = 20

-- self join, inner join
-- *********여러 join 사용하기
-- 부사수 이름, 부서번호, 부서이름, 사수 이름 조회
-- join을 총 2번 사용함.
select
	busasu.ename as "부사수 이름",
	busasu.deptno as "부사수 부서번호",
	d.dname as "부사수 부서이름",
	sasu.ename as "사수이름"
from emp as busasu
inner join dept as d
on busasu.deptno = d.deptno
inner join emp as sasu 
on busasu.mgr = sasu.empno

-- inner join(여러 테이블 조인), self join(한 테이블에서 조인)
-- ******실무에서 상당히 많이 사용하는 조인
-- right join, left join => 둘을 아우터 조인이라고 함
-- 대형 IT프로젝트에서 외부조인(아우터조인)을 정말 많이 사용함

-- 문법
select 컬럼이름 from 테이블 이름 as 별칭
right join 테이블 이름 as 별칭
on 별칭.컬럼 = 별칭.컬럼

select 컬럼이름 from 테이블 이름 as 별칭
left join 테이블 이름 as 별칭
on 별칭.컬럼 = 별칭.컬럼

-- 언제 사용?
select deptno from dept
-- distinct : 중복제거
-- distinct와 group by
-- distinct는 중복제거
-- group by는 컬럼 그룹핑(중복제거)
-- 차이점? group by는 그룹핑 후 정렬함, distinct는 중복제거만 함
select distinct deptno from emp
-- 요구사항 => emp와 deptno 조인할 때 40번 부서도 이름과 위치를 알고싶다!
-- 이럴 때 아우터 조인을 사용함

-- select 
-- from dept as d left join emp as e

select 
	e.ename as '사원이름',
	d.dname as '부서이름',
	d.deptno as '부서번호'
from emp as e right join dept as d
on e.deptno = d.deptno
where e.ename is null
-- 위 join 상태에서 해당 부서에 사원이 없는 부서이름, 부서번호 조회

### 12월 13일 SQL 문제 🎅

-- 1. 사원이름, 사원직책, 사원급여 조회.
select ename, job, sal from emp
-- 
-- 2. 사수번호가 7839인 사원 번호, 이름, 입사날짜 조회.
select empno, ename, hiredate from emp 
from
where 
-- 
-- 3. 급여가 3000 이하인 사원의 모든 정보 조회.
select *from emp 
where sal <= 3000

-- 4. 사원이름, 부서번호, 부서이름, 부서 근무지 조회.
select 
	e.ename,
	e.deptno,
	d.dname,
	d.loc
from emp as e 
inner join dept as d
on e.deptno = d.deptno
-- 
-- 5. 부서별 급여합계, 부서이름 조회.
select sum(e.sal), d.dname 
from emp as e 
inner join dept as d
on e.deptno = d.deptno
group by d.dname

-- 
-- 6. 부서 근무지가 NEW YORK이고, 직책이 MANAGER인 사원의 이름, 급여 조회. ?
select 
	e.ename,
	e.sal
from emp as e 
inner join dept as d
on e.deptno = d.deptno
where d.loc = 'NEWYORK' and e.job = 'MANAGER'
-- 
-- 7. 1983년 이후 입사한 사원의 보너스가 null이면 100 주고, 사원의 이름, 부서이름, 직업 조회.
-- 
-- 8. 부서명이 RESEARCH인 사원의 이름, 급여, 근무 지역 조회. 
select 
	e.ename,
	e.sal,
	d.loc
from emp as e
inner join dept as d
on e.deptno = d.deptno
where d.dname = 'RESEARCH'
-- 
-- 9. 보너스를 받은 사원 이름, 직책, 급여, 부서명 조회.
select
	e.ename,
	e.job,
	e.sal,
	d.dname
from emp as e
inner join dept as d
on e.deptno = d.DEPTNO 
where e.comm is not null
--    ,
-- 10. 이름 첫글 A자를 가진 사원 이름, 직책, 부서명, 부서 위치 조회.
select 
	e.ename,
	e.job,
	d.dname,
	d.loc
from emp as e
inner join dept as d
on e.deptno = d.DEPTNO 
where e.ename like 'A%'
-- 
-- 11. 사원명, 사수번호, 사수 이름 조회. 단, 사수가 없는 사원도 포함
-- 
-- 12. 사원명, 사수번호, 사수 이름 조회. 단, 사수가 없는 사원만
-- 
-- 13. 상사번호가 7698인 사원의 이름, 사원번호, 상사번호, 상사이름 조회.
-- 
-- 14. 상사보다 먼저 입사한 사원의 사원이름, 사원의 입사일, 상사 이름, 상사 입사일 조회.
-- 
-- 15. 업무가 MANAGER이거나 CLERK고 입사날짜가 1982년에 입사한
--     사원의 사원번호, 이름, 급여, 직업, 부서명 조회.
select 
from emp as e
on dept as d

-- 
-- 16. 부서별 급여 총합 조회.
--     단, 사원이 존재하지 않는 부서도 포함해서 급여 순으로 내림차순 하시오.
-- 
-- 17. 사원 이름, 상사 이름, 사원 부서번호, 사원 부서명, 사원 근무지역 조회.
--     단, 사원이 존재하지 않는 부서번호와 부서명도 조회.
-- 
-- 18. 부서 위치가 CHICAGO이고 사수 급여가 5000 미만인
--     사원 번호,사원 이름,사수 번호, 사수 이름, 사수 급여, 부서명 조회.
--     단, 사원의 입사날짜로 오름차순.
-- 
-- 19. 입사날짜를 월별로 몇명이 입사했는지 카운트해서 조회.
-- 
-- 20. 부서번호, 부서이름, 부서 근무지, 사원 수 조회 단, 사원이 없는 부서도 조회할 수 있게
-- 
-- 21. 9월에 입사한 사원의 이름, 번호, 입사날짜 조회.
-- 
-- 22. 직업이 SALESMAN 이고 입사날짜가 1981-02-22 이후에 들어온 사원들의 급여 총합, 급여평균 조회.
-- 
-- 23. 사원번호 8080, 사원이름 홍길동, 직업 MANAGER, 입사날짜를 오늘날짜로 사원 추가하시오.
-- 
-- 24. 사원번호 8080인 사원 사수번호를 7839로 급여를 500으로 수정하시오.
-- 
-- 25. 사원번호 8080인 사원을 삭제하시오.
-- 
-- 26. 사원수가 4명 이상인 부서의 번호, 사원 수, 부서 이름, 부서 위치 조회.





















