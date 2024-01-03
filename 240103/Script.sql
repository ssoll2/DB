insert into tb_customer(customer_id, name,address, tel,sign_up,grade_no) values(1000,'lee','서울시','1234-1234','2023-10-01',100)
insert into tb_customer(customer_id, name,address, tel,sign_up,grade_no) values(2000,'gang','대전시','5678-5578','2023-12-20',200)
insert into tb_customer(customer_id, name,address, tel,sign_up,grade_no) values(3000,'kim','천안시','7891-1232','2022-02-01',200)
insert into tb_customer(customer_id, name,address, tel,sign_up,grade_no) values(4000,'gu','안양시','6780-1457','2021-05-04',100)
insert into tb_customer(customer_id, name,address, tel,sign_up,grade_no) values(5000,'jo','김포시','3589-9087','2023-07-01',300)

insert into tb_product(product_id,product_name,price,product_sort,license,product_start_date,product_end_date) values(1001,'방한부츠',49900,'신발',2222-2222,'2023-11-01','2023-12-30')
insert into tb_product(product_id,product_name,price,product_sort,license,product_start_date,product_end_date) values(2002,'런닝화',70000,'신발',3333-3333,'2023-01-01','2023-12-30')
insert into tb_product(product_id,product_name,price,product_sort,license,product_start_date,product_end_date) values(3003,'맨투맨',49900,'상의',4444-4444,'2023-01-01','2023-11-30')
insert into tb_product(product_id,product_name,price,product_sort,license,product_start_date,product_end_date) values(4004,'청바지',50000,'하의',5555-2222,'2023-01-01','2024-12-30')
insert into tb_product(product_id,product_name,price,product_sort,license,product_start_date,product_end_date) values(5005,'안경',10000,'악세사리','3333-8888','2023-11-01','2023-12-30')

insert into tb_sales(customer_id,product_id,sales_date,amount,sales_status) values(1000,1001,'2023-11-09',1,true)
insert into tb_sales(customer_id,product_id,sales_date,amount,sales_status) values(2000,1001,'2023-10-09',2,false)

insert into tb_grade(grade_no,grade_sort,coupon) values(100,'브론즈', 50)
insert into tb_grade(grade_no,grade_sort,coupon) values(200,'실버', 100)
insert into tb_grade(grade_no,grade_sort,coupon) values(300,'골드', 150)


insert into supply(license,supply_name,represent_name,supply_tel,supply_email,foundation_date,supply_address) values('2222-2222','슈펜','최운식',77785578,'WEBMASTER@ELANDMALL.COM','2022-09-19','서울시')
insert into supply(license,supply_name,represent_name,supply_tel,supply_email,foundation_date,supply_address) values('107-18-37176','삭스신드롬','조은호',070-7604-1343,'hjdhfh@gmail.com','2020-07-03','김포시')


commit;

update tb_product 
set license = '2222-2222'
where product_id = 1001

update tb_product 
set license = '3333-3333'
where product_id = 2002

update tb_product 
set license = '4444-4444'
where product_id = 4004

update tb_sales
set product_id = 2002
where customer_id = 2000


-- 판매가 이뤄진 제품의 회사정보 조회 작성
-- product(제품), sales(판매), 회사(supply)
select 
	tp.product_name
	
from tb_product as tp
inner join tb_sales as s
on tp.product_id = s.product_id
where s.sales_status = true



