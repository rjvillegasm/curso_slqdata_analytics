-- Sección 15
-- Views & Indexes

-- 61 Views
-- No es una tabla , es una query que se comporta como tabla
-- Utiliza menos cantidad de memoria que una tabla real 
-- Útil para dar acceso a otros usuarios y equipos sólo a la info necesaria

-- Sintaxis 
CREATE [OR REPLACE] VIEW view_name AS
SELECT columns
FROM tables
[WHERE conditions];

-- ejemplo:
Create view logistics as 
select a.order_line,
        a.order_id,
        b.customer_name,
        b.city,
        b.state,
        b.country
From sales as a 
left join customer as b
on a.customer_id =b.customer_id
order by a.order_line;

select * from logistics;

drop view logistics;

-- coding exercise 30 :
create view HighValueCustomers as 
select a.CustomerName,
        a.city
from Customers as a left join
(select CustomerID, sum(Amount) as venta from Orders group by CustomerID) as b 
on a.CustomerID = b.CustomerID
where b.venta >150;

--62 Index 

-- Sintaxis:
CREATE [UNIQUE] INDEX index_name
ON table_name
(index_col1 [ASC | DESC],
index_col2 [ASC | DESC],
...
index_col_n [ASC | DESC]);

--A simple index is an index on a single column, while a composite
-- index is an index on two or more columns.

-- ejemplo:

 create index mon_idx on month_values (MM);

 select * from month_values;
 
 -- Ver en PG_admin en las propiedades de la tabla
 -- Drop or Rename index 
 
 Drop index [If Exist] index_name
 [Cascade|Restrict];
 
 --drop
 drop  index mon_idx;
 
 Alter Index [If Exists] index_name
 Rename To new_index_name;
 -- volvemos a crear y alteramos
 Alter index mon_idx rename to new_month_index;
 --drop
 drop index new_month_index;
 

 -- fin sección 15
 
 -- ejercicio 12

--revisamos la tabla
 select * from sales ;
--probamos el select
select order_line, product_id,sales, discount, order_date
from sales order by order_date asc limit 5 ;
-- ejecutamos la vista
create view Daily_Billing as 
select order_line, product_id,sales, discount
from sales order by order_date asc limit 1 ;
-- revisamos el resultado
select * from Daily_Billing;
--borramos
drop view Daily_Billing;
 

