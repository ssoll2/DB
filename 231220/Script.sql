 ### 12월 20일
 --- Mysql에서 가장 자주 사용하는 문자열 함수 정리
 -- 실무에서는 DB에서 내장함수는 잘 안씀
  
 -- 1. substring 
 -- substring 특정 범위 문자 자르기
 -- 사원이름 첫번째 부터 세번째까지만 출력하기
 select substring(ename, 1, 4) from emp
 -- 사원입사날짜 년-월 출력
 select substring_index(hiredate, '-', 2) from emp # 1: 년도 2: 월
  
-- left 왼쪽으로 3번째까지만 문자 추출
 select left(ename,3) from emp 
-- right 오른쪽으로 3번째까지만 문자 추출
 select right(ename,3) from emp
  
 -- 소문자 -> 대문자 자동 변환
 select upper(ename) from emp
  
 -- 대문자 -> 소문자 자동 변환
 select lower(ename) from emp
  
  -- 문자열 길이 반환
 select length(ename) from emp # 한글은 3바이트여서 한글자를 3글자로 인식 홍길동 -> 9
  -- 한글 문자열 길이 반환
 select char_length('홍길동') from dual 
 
 -- 문제) 프로그래머스 -> 카테고리 별 상품 개수 구하기 (LV2)
 
 -- datediff, 날짜와 날짜 사이 일 수 구하기
 select datediff('2023-12-25', '2023-12-20') from dual 
  
-- 문제) 프로그래머스 -> 자동차 평균 대여 기간 구하기
 
 -- DML (SELECT, INSERT, DELETE, UPDATE)
 -- DDL (CREATE, ALTER, DROP)
 -- 오늘은 테이블 생성 해보기
 
 -- 데이터 타입(자주 사용하는)
 -- 1. INTEGER(정수)
-- 2. bigint (==long)
-- 3. BOOL (BOOLEAN)
-- 4. DECIMAL
-- 5. DATE, TIMESTAMP
-- 6. VARCHAR(== STRING)
-- 7. BLOB (엄청 많은 문자열 저장할 때) ex) 게시판 글 내용 저장할 때
 
 -- 테이블 생성
 create table student(
 	student_id int comment '학생번호',
 	name varchar(20) comment '이름',
 	address varchar(50) comment '주소',
 	age int comment '나이',
 	create_at timestamp default current_timestamp comment '생성날짜'

 )
 
 -- varchar(20) : 20 길이 제한
 -- default(기본값) : insert할 때 해당 컬럼 값을 입력하지 않아도 자동으로 값이 세팅 됨.
 
 insert into student(student_id, name,address, age) values (100, '홍길동', '서울 강남구', 20)
 
 commit
 
 -- *****commit
 -- insert, delete, update 다음엔 commit 이라는 명령어를 실행해야 한다.
 -- commit은 최종 저장을 의미한다.
 -- 디비버 같은 데이터베이스 연동 프로그램은 자동으로 커밋명령어를 날려준다.
 
 -- 구글에 디비버 auto commit 해제 검색 꼭하기!!! (회사에서 디비버를 쓴다면)
 
 -- 테이블 삭제
 drop table student 
 
  -- 테이블 생성 (여러가지 옵션 추가)
 -- primary key는 고유한 값을 가진 컬럼에 지정 해준다.(중복 방지)
 -- primary key는 not null과 index 기능도 가지고 있다.
 create table student(
 	student_id int primary key comment '학생번호',
 	name varchar(20) not null comment '이름',
 	addr varchar(50) not null default '일본 도쿄' comment '주소',
 	age int default 20 comment '나이',
 	create_at timestamp default current_timestamp comment '생성날짜'

 )
 
 insert into student(student_id,name,addr) values(1,'홍길동', '서울 강남구')
 
 drop table student
 
 create table student(
 	student_id int auto_increment primary key comment '학생번호',
 	name varchar(20) not null comment '이름',
 	addr varchar(50) not null default '일본 도쿄' comment '주소',
 	age int default 20 comment '나이',
 	create_at timestamp default current_timestamp comment '생성날짜'

 )
 
 -- auto_increment : 증감연산자
 insert into student(name,addr) values('홍길동', '서울 강남구')
 
 -- 문제
 -- 테이블 이름 movie
 -- 컬럼이름 movie_id(int), movie_name(varchar), genre(varchar), move_time(timestamp)
 -- movie_id는 고유한 값이고 movie_name과 genre은 null이 올 수 없다.
 -- movie_time에 기본값은 현재 시각이다.
 -- 3개데이터 insert
 
 create table movie(
 	movie_id int auto_increment primary key comment '아이디',
 	movie_name varchar(50) not null comment '이름',
 	genre varchar(20) not null comment '장르',
 	movie_time timestamp default current_timestamp comment '개봉날짜'
 
 )
 
 insert into movie(movie_name, genre) values('서울의 봄', '드라마')
 insert into movie(movie_name, genre) values('아쿠아맨', '액션')
 insert into movie(movie_name, genre) values('노량', '액션')
 
-- 테이블 2개 만들기
 -- 선수 테이블
 -- foreign key(외래키 or 참조키): 교집합 할 수 있는 컬럼에 외래키 설정
 -- 참조키는 null이 올 수 있고, index 기능 없음
 -- *****primary key(pk)는 null이 올 수 없고, fk(참조키)는 null이 올 수 있다.
 create table player(
 	player_id int auto_increment primary key comment '선수 고유번호',
 	name varchar(20) not null comment '선수이름',
 	team_id int comment '팀 번호',
 	foreign key (team_id) references team(team_id)
 )

 -- 팀 테이블
 create table team (
 	team_id int auto_increment primary key comment '팀 번호',
 	team_name varchar(50) not null comment '팀 이름'
 )
 
 -- 팀 데이터 추가하기
 insert into team(team_name) values('한화이글스')
 insert into team(team_name) values('두산베어스')
 insert into team(team_name) values('롯데자이언츠')
 
 -- 선수 데이터 추가하기
 insert into player(name, team_id) values('문동주',1)
 insert into player(name, team_id) values('오재원',2)
 insert into player(name, team_id) values('오대호',3)
 
 -- 문제) 문동주 선수의 팀이름을 조회하는 sql문을 작성하시오
 select 
 	p.name as '선수이름',
 	t.team_name as '팀이름'
 from team as t
 inner join player as p
 on t.team_id = p.team_id 
 where p.name = '문동주'
 
 -- 왜? player 테이블에 team_id가 있어야 할까?
 -- 반대로 team테이블 player_id가 있어도 되지 않을까?...
 
 -- 한화이글스 선수 추가 영입
 insert into player(name, team_id) values('류현진',1)
 -- team_id 1번은 이미 한화 이글스가 사용하고 있기 때문에
 -- LG는 1번으로 팀을 등록할 수 없다.
 -- 왜냐? 팀아읻가 PK(중복될 수 없는 컬럼)이기 때문에
 insert into team(team_id, team_name) values(4, 'LG트윈스')
 
-- PLAYER 와 team 관계를 *****N:1 관계라고 정의하며, 실무에서 매우~~~ 중요합니다.
-- 한 팀에 선수 여러명, 한 부서에 여러 사원
-- JPA같은 기술을 다룰 때

-- 1:N (one to many)
-- ex) 선수와 팀관계, 사원과 부서 관계, 유저와 서버 관계
-- 1:1 (one to one)
-- ex) 결혼, 군인<->총
-- *****M:N (many to many)
-- ex) 학생과 수강관계(학생 테이블, 과목 테이블, 수강 테이블)
-- M:N는 3개 이상 테이블이 생긴다. 
 
  
  
  
  
  
    
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  