
-- 8 Create 

-- Crear customer table 
create table Customer_table (
    Cust_id int,
    First_name varchar,
    Last_name varchar,
    age int,
    email_id varchar);

--  11 Insert 

-- Insertar una row simple
insert into Customer_table values 
(1, 'bee' , 'cee', 32, 'bc@xyz.com');

-- Insertar seleccionando las columnas
insert into Customer_table(Cust_id, First_name,age,email_id)
values (2, 'dee',23,'d@xyz.com');

-- Insertar multiples rows
insert into Customer_table values
(3,'ee','ef',27, 'ef@xyz.com'),
(4, 'gee','eh',35,'gh@xyz.com');

-- 12 Import  data from file
-- desde csv
Copy Customer_table from 'C:\misrepositorios\curso_sqldata_analytics\Data\copy.csv' delimiter ',' csv header;

-- desde txt
Copy Customer_table from 'C:\misrepositorios\curso_sqldata_analytics\Data\copytext.txt' delimiter ',' ;

-- 13 Seleccionar 

-- Seleccionar todas  las columnas
select * from Customer_table;

-- Seleccionar columnas específicas
select First_name from Customer_table;
select First_name, Last_name from Customer_table;

-- 15 Select Distinct:seleccionar distinto 

Select Distinct First_name from Customer_table;
Select Distinct Last_name from Customer_table;
Select Distinct First_name, age from Customer_table;

--16 Where permite utilizar condiciones

select First_name from Customer_table where age=25
select Distinct First_name from Customer_table where age=25
Select * from Customer_table where First_name ='Gee'

-- 17 logical operators: AND & OR & NOT

SELECT First_name, Last_name, age FROM Customer_table WHERE age >20 AND age<30;

SELECT First_name, Last_name, age FROM Customer_table WHERE age <20 or age>=30;

SELECT First_name, Last_name, age FROM Customer_table WHERE NOT age=20;

select * from Customer_table where not age=25 and not First_name = 'Jay';

-- 19 Update

--single row
Update Customer_table SET Last_name='Pe', age=17 where Cust_id =2;

--multiple rows
Update Customer_table set email_id= 'gee@xyz.com' where First_name ='gee' or First_name='Gee'

--20 Delete

delete from Customer_table where Cust_id=6;
delete from Customer_table where age>30;

--borrar todos los registros
delete from Customer_table;

-- 21 alter 

alter table Customer_table  add test_column varchar(255);

alter table Customer_table drop test_column;

alter table Customer_table alter column age type varchar(255);

alter table  Customer_table rename column email_id to customer_email;

alter table Customer_table alter column Cust_id set not null;

-- Se produce un error ya que cust_id no puede ser null 
insert into Customer_table(First_name, Last_name,age,customer_email)
values ( 'aa','bb', 25,'ab@xyz.com');
-- primero debemos quitar la restricción 
alter table Customer_table alter column cust_id drop not null;
-- volvemos a correr la query

-- ejemplo constraints, primero creamos la restricción
alter table Customer_table add constraint Cust_id check (Cust_id>0);
-- intentamos insertar un id negativo
insert into Customer_table values ( -1 ,'cc','dd', 67,'cd@xyz.com');

-- agregar condición de primary key
alter table Customer_table add primary key (Cust_id) ;
-- se genera un error ya que una llave primaria no debe contener valores null
-- borramos las tablas para insertar nuevos valores
delete from Customer_table;
insert into Customer_table values ( 1 ,'cc','dd', 67,'cd@xyz.com');
-- volvemos a agregar la condición primary key
alter table Customer_table add primary key (Cust_id) ;
