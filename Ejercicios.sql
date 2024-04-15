
-- Exercise 1

drop table Science_class;
CREATE TABLE Science_class (
    Enrollment_no INT PRIMARY KEY NOT NULL,
    Name_student VARCHAR(45),
    Science_marks INT
);

-- Ejercicio 2 

insert into Science_class (Enrollment_no, Name_student, Science_marks)
values ('1', 'Popeye' , '33'),
		(2, 'Olive',54),
        (3,'Brutus',98);

    
copy Science_class from 'C:\misrepositorios\curso_sqldata_analytics\Data\Student.csv' delimiter ',' csv header;

-- fin ejercicio 2 

SELECT * FROM  Science_class;

select name_student , Science_marks from Science_class;

-- ejercicio 3 
select * from Science_class;

select Name_student from Science_class where Science_marks > 60;

select * from Science_class where Science_marks >35 and Science_marks < 60;

select	* from Science_class where Science_marks <= 35 or Science_marks >= 60; 


-- ejercicio 4 

Update Science_class set Science_marks= 45 where name_student='Popeye';

delete from Science_class where name_student='Robb';

alter table Science_class rename name_student to student_name;

-- ejercicio 5

select distinct city  from  customer  where region    in  ( 'North', 'East');

select * from sales where sales between 100 and 500;

select * from customer where customer_name like '% ____';

-- ejercicio 7
select * from sales where discount >0 Order by discount desc limit 10;

-- ejercicio 8

select sum(sales) from sales;

-- revisamos la tabla
select * from customer;

select count(customer_id) from customer where  age between 20 and 30;

select avg(age) from customer where region = 'East';

select  min(age), max(age) from customer where city='Philadelphia';

-- ejercicio 9

select * from sales;

select product_id, 
sum(sales) as total_sales,
sum(quantity) as total_units,
count(order_id) as number_of_orders,
max(sales) as max_sale,
min(sales) as min_sale,
avg(sales) as avg_sale
from sales group by product_id order by total_sales desc; 

select product_id , sum(quantity) as total_units
from sales group by product_id 
having sum(quantity)>50 order by total_units desc;    

-- ejercicio 10

--1
-- revisamos las tablas 
select * from sales_2015;
select * from customer_20_60;

select b.state, sum(a.sales) as total_sales 
from sales_2015 as a left join customer_20_60 as b
on a.customer_id = b.customer_id 
group by b.state order by total_sales desc;

--2
-- revisamos las tablas 
select * from sales;
select * from product;

select b.product_id, b.product_name , b.category,
sum(a.sales) as total_sales, sum(a.quantity) as total_units
from product as b left join sales as a 
on b.product_id = a.product_id 
group by b.product_id order by total_sales desc;   
-- nota: la columna mencionada en el group by debe ser exactamente la misma del select inicial,
-- incluyendo el alias de su tabla de origen

-- solo para revisar
select product_id , sum (sales) as total_sales, sum(quantity) as total_units
from sales  group by product_id order by total_sales desc; 