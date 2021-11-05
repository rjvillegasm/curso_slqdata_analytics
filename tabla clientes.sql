insert into Customer_table
values (1, 'bee' , 'cee', 32, 'bc@xyz.com');

insert into Customer_table(Cust_id, fisrt_name,age,email_id)
values (2, 'dee',23,'d@xyz.com');


insert into Customer_table values
(3,'ee','ef',27, 'ef@xyz.com'),
(4, 'gee','eh',35,'gh@xyz.com');

select * from Customer_table;

select distinct fisrt_name from Customer_table;

select distinct age, fisrt_name from Customer_table;

select fisrt_name from Customer_table where age = 25 ;

select distinct fisrt_name from Customer_table where age = 25 ;

select fisrt_name from Customer_table where age > 25 ;

select fisrt_name, age from Customer_table where age >= 25 ;

select* from Customer_table where fisrt_name = 'Gee';

select fisrt_name, last_name, age  from Customer_table where age>20 and age<30;

select fisrt_name, last_name, age  from Customer_table where age<20 or age>30; 

select * from Customer_table where not age = 25;

select * from Customer_table where not age = 25 and not fisrt_name = 'Jay';

# seccion update 

