-- Sección 13
-- Sub-queries 


--58 Sub queries

-- Sintaxis donde la sub query se encuentra en un WHERE

SELECT "column_name1" FROM "table_name1"
WHERE "column_name2" [Comparison Operator] /*  <---- importante */ 
(    SELECT "column_name3" FROM "table_name2" WHERE "condition"    ); 

-- ejemplo 
Select * from sales where customer_id in 
(select customer_id from customer where age>60);
-- en este caso la sub query solo puede tener una columna 
-- en este caso realizo un filtrado en la tabla clientes
-- para traer sólo sus ID´s y volver a filtrar en la tabla ventas

--Sub query en un  FROM
SELECT 
a.product_id ,
a.product_name ,
a.category,
b.quantity
FROM product AS a
LEFT JOIN (SELECT product_id,
SUM(quantity) AS quantity
FROM sales GROUP BY product_id) AS b
ON a.product_id = b.product_id
ORDER BY b.quantity desc;       
--véase el ejercicio 10. parte uno, semejanzas importantes
-- de esta forma realizo la agregación de los datos
-- en la sub query, antes de traerla al join

-- ejercicio 10 parte 2: 
select b.product_id, b.product_name , b.category,
sum(a.sales) as total_sales, sum(a.quantity) as total_units
from product as b left join sales as a 
on b.product_id = a.product_id 
group by b.product_id order by total_sales desc; 


--- Sub query en un select 
SELECT customer_id,
order_line,
(SELECT customer_name
FROM customer
WHERE sales.customer_id = customer.customer_id)
FROM sales
ORDER BY customer_id; 
-- de esta forma puedo traer los nombres de los clientes que 
-- se encuentran en la tabla customer a la tabla ventas
-- similar a una relación de un modelo de datos en Power Bi

-- Reglas aplicables a las sub queries 
/*
There are a few rules that sub queries must follow −
• Sub queries must be enclosed within parentheses.
• A sub query can have only one column in the SELECT clause, unless multiple
columns are in the main query for the sub query to compare its selected columns.
• An ORDER BY command cannot be used in a sub query, although the main
query can use an ORDER BY. The GROUP BY command can be used to
perform the same function as the ORDER BY in a sub query.
• Sub queries that return more than one row can only be used with multiple
value operators such as the IN operator.
• The SELECT list cannot include any references to values that evaluate to a
BLOB, ARRAY, CLOB, or NCLOB.
• A sub query cannot be immediately enclosed in a set function.
• The BETWEEN operator cannot be used with a sub query. However, the
BETWEEN operator can be used within the sub query.
*/

-- ejercicio 11

--revisamos las tablas
select * from sales;
select * from product;
select * from customer;
-- véase imagen "13 sub queries ERD"


select a.*, b.customer_name, b.age from sales as a 
left join customer as b
on a.customer_id = b.customer_id;

-- utilizando solo sub queries en el select 
select order_line, order_id, customer_id, product_id, sales, quantity , profit,
(select customer_name from customer where customer.customer_id = sales.customer_id ),
(select age from customer where customer.customer_id = sales.customer_id ),
(select product_name from product where product.product_id = sales.product_id ),
(select category from product where product.product_id = sales.product_id )
from sales order by order_line asc;

-- utilizando sub queries y join 
select 
a.product_name,
a.category,
b.product_id, 
b.order_id, 
b.sales,
b.cust_name,
b.cust_age
from product as a  left join 
( select order_id, sales, product_id,
(select customer_name from customer where customer.customer_id = sales.customer_id ) as cust_name,
(select age from customer where customer.customer_id = sales.customer_id ) as cust_age
from sales) as b on a.product_id = b.product_id;

-- alternativa
select 
a.product_name,
a.category,
b.*
from product as a  left join 
( select order_id, sales, product_id,
(select customer_name from customer where customer.customer_id = sales.customer_id ) as cust_name,
(select age from customer where customer.customer_id = sales.customer_id ) as cust_age
from sales) as b on a.product_id = b.product_id;



-- respuesta pdf
-- sp: sales-product
select c.customer_name, c.age, sp.* from
customer as c
right join (select s.*, p.product_name, p.category
from sales as s
left join product as p
on s.product_id = p.product_id) as sp
on c.customer_id = sp.customer_id;

-- simplificando la respuesta

-- primero creamos un join al cual asignamos un alias
select s.order_id, s.sales, p.product_name, p.category
from sales as s
left join product as p
on s.product_id = p.product_id;
-- asignamos un alias
(select s.order_id, s.sales, p.product_name, p.category
from sales as s
left join product as p
on s.product_id = p.product_id) as sp 
-- luego continúo con un right join entre sp y customer
select c.customer_name, c.age, sp.* from
customer as c
right join (/* tabla*/ ) as sp
on c.customer_id = sp.customer_id;


-- Sección 14
-- 60 solve murder mystery using sql
-- https://www.youtube.com/watch?v=-yDhHCm3248

--fin sección 14