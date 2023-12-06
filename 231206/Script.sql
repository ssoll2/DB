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