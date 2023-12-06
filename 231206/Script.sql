-- SELECT 조회, FROM 테이블 이름이 온다.
-- 추가로 사원번호, 입사날짜 조회
-- 컬럼 == 변수명
select 
	ename,
	job,
	empno,
	hiredate
from emp
-- 부서이름과 부서번호를 조회
select
	dname,
	deptno
from dept
-- select 다음엔 컬럼이름이 오고, from 다음엔 테이블이름이 온다.

-- Q. 사원번호, 사원이름, 사원 사수번호, 직책을 조회하시오.
select 
	empno as "사원번호",
	ename as "사원이름",
	mgr as "사수번호",
	job as "맡은직책"
from emp 
-- as : 별칭

-- Q1. 사원이름만 조회
select 
	ename
from emp 
-- Q2. 사원번호, 사원이름을 조회, AS 이용해서 풀것
-- AS는 생략이 가능함
-- 실무에서는 생략하는 곳도 있고 다 작성하는 곳도 있음.(그 회사 규칙을 따르셈)
select
	empno as "사원번호",
	ename as "사원이름"
from emp
-- Q3. 사원테이블에 있는 모든 컬럼 조회
-- * (애스터리스크)를 사용하면 전체 컬럼을 조회할 수 있다.
-- 실무에서는 거의 99% 사용 x
select *
from emp

-- select, from ,as
-- where : 내가 원하는 데이터를 추출할 때 사용
-- 실무에서 where 사용률은 99.9%
-- ex) 사원이름이 SMITH인 사람의 급여를 알고 싶어~

-- JOB이 'SALESMAN'인 사원의 이름, 번호, 입사날짜 조회
select 
	ename,
	empno,
	hiredate,
	job
from emp
where job = 'SALESMAN'

-- Q. 사원번호가 7782인 사원의 번호, 이름, 직업 조회
select 
	empno,
	ename,
	job
from emp 
where empno = '7782' 

-- 급여가 2000 이상받는 사원이름, 직책 조회
select 
	ename,
	sal,
	job
from emp 
where sal >= '2000'

-- Q. 1981-12-03 이후에 입사한 사원 이름, 직책, 급여, 사수번호,입사날짜 조회
select 
	ename,
	job,
	sal,
	mgr,
	hiredate
from emp
where hiredate >= '1981-12-03'

-- Job이 Manager이고 급여가 2000이상인 사원의 이름, 직책, 급여, 입사날짜 조회
select 
	ename,
	job,
	sal,
	hiredate
from emp
where job = 'manager' and sal >= 2000

-- Q. 입사날짜가 1981-12-03이고 직업이 ANALYST인 사원의 이름, 직책, 입사날짜, 급여조회
select 
	ename,
	job,
	hiredate,
	sal
from emp 
where hiredate = '1981-12-03' and job = 'analyst'

/* 1.SELECT 컬럼(변수)조회
 * 2.FROM 테이블 조회
 * 3. AS 별칭(생략가능)
 * 4. WHERE (조건, 원하는 데이터 추출)
 * 5. AND, >=, <=, >,<, OR(연산식)
 * SELECT 
 * 		ename
 * from emp
 * where sal >= 2000
 * *** SQL 실행순서
 * 1. from
 * 2. where
 * 3. select*/































