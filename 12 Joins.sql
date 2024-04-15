-- Sección 12
-- JOINS

--- nota: Buscar sobre cross joins or cartesian  join


-- 48 Preparing the data

-- creamos 2 nuevas tablas (sub-querys) para trabajar las siguientes secciones:
--Creating sales table of year 2015

Create table sales_2015 as select * from sales where ship_date between '2015-01-01' and '2015-12-31';
select count(*) from sales_2015; --2131
select count(distinct customer_id) from sales_2015;--578
--Customers with age between 20 and 60 
create table customer_20_60 as select * from customer where age between 20 and 60;
select count (*) from customer_20_60;--597


-- 49 inner joins 
-- realiza un cruse a partir de los datos compartidos en la columna objetivo
-- donde no exista coincidencia, esta fila es descartada
-- solo se mantienen aquellas filas donde exista coincidencia


select 
        a.order_line,
        a.product_id,
        a.customer_id,
        a.sales,
        b.customer_name,
        b.age
from sales_2015 as a 
inner join customer_20_60 as b 
on a.customer_id = b.customer_id
order by customer_id; 

-- revisando con customer id que no están en ambas tablas
select customer_id from customer_20_60 order by customer_id;
select customer_id from sales_2015 order by customer_id;
-- el cliente AA-10315 solo se encuentra en la tabla sales_2015
-- A su vez AA-10480 solo se encuentra en la tabla customer_20_60
-- por lo tanto no son parte del resultado del inner join


-- 50 Left Join 
-- mantiene todas las columnas de la primera tabla 
-- y trae las filas donde exista coincidencia con la columna objetivo
-- símil a un buscar valor en excel 
-- misma sintaxis que un inner join

select 
    a.order_line,
    a.product_id,
    a.customer_id,
    a.sales,
    b.customer_name,
    b.age
from sales_2015 as a 
left join customer_20_60 as b 
on a.customer_id = b.customer_id
order by customer_id;
-- En este caso es evidente que existen clientes en la tabla customer_20_60
-- que no han realizado compras durante el 2015,
-- por lo cual no se encuentras registros de sus compras en la tabla sales_2015


-- 51 Right Join
-- similar a un left join, se lleva los datos a la tabla B
-- donde exista coincidencia en la columna objetivo
-- comparte sintaxis 

select 
    a.order_line,
    a.product_id,
    a.customer_id,
    a.sales,
    b.customer_name,
    b.age
from sales_2015 as a 
right join customer_20_60 as b 
on a.customer_id = b.customer_id
order by customer_id desc;
-- si aplicamos un order by id desc veremos los valores null
-- de modo que tenemos información de clientes 
-- que no han realizado compras en 2015 por distintas razones

-- también podemos correr la query cambiando a.customer_id > b.customer_id
-- de este modo usamos todos los clientes de los que tenemos registro en customers_20_60
select 
    a.order_line,
    a.product_id,
    b.customer_id,
    a.sales,
    b.customer_name,
    b.age
from sales_2015 as a right join customer_20_60 as b 
on a.customer_id = b.customer_id order by customer_id;
-- podemos ver que el cliente AA-10480 solo se encuentra en la tabla customer_20_60
-- ya que sale solo tiene info del 2015


-- 52 Full Outer join
-- combina los resultados de left and right sin importar coincidencias 
-- es similar a copiar y pegar todos los datos de ambas tablas en excel 
-- misma sintaxis 

select
    a.order_line,
    a.product_id,
    a.customer_id,
    a.sales,
    b.customer_name,
    b.age,
    b.customer_id
from sales_2015 as a full join customer_20_60 as b 
on a.customer_id=b.customer_id order by a.customer_id, b.customer_id;
-- se observan valores faltantes en ambas columnas customer_id
-- pero en este caso sabemos el origen de los datos 

-- 53 Cross Join
-- crea un producto cartesiano entre dos set de datos
-- útil para crear combinaciones de datos por ej: meses x años
-- distinta sintaxis 

-- Sintaxis:   
--            Select table1.column1, table2.column2...
--            from table1, table2,[table3] 
-- Ejemplo:
--            Select a.YYYY, b.MM
--            From year_values as a, month_values as b
--            order by a.YYYY, b.MM


--  creamos las tablas 
create table month_values (MM integer);
create table year_values (YYYY integer);
-- insertamos valores
insert into month_values values (1),(2), (3), (4),(5),(6),(7),(8),(9),(10),(11),(12);
insert into year_values values (2018),(2019),(2020),(2021),(2022),(2023),(2024),(2025);
-- revisamos  
select * from month_values;
select * from year_values;
-- corremos la query
Select a.YYYY, b.MM
From year_values as a, month_values as b
order by a.YYYY, b.MM;

-- 54 Combining Queries
-- compara el resultado de 2 queries 
-- utiliza los comandos:  Intersect - Except - Union
-- la estructura de las queries debe ser similar
-- el parámetro ALl ( de allow) permite mantener los duplicados en Intersect y Union

-- 54 Intersect 
-- retorna sólo los valores que se encuentran en ambas queries
-- similar a un inner join
-- útil para identificar duplicados 
-- el parámetro ALl ( de allow) permite mantener los duplicados
select customer_id from sales_2015
Intersect
select customer_id from customer_20_60;


--55 Except 
-- retorna los valores  que sólo se encuentran en el primer set de datos
-- útil para identificar valores que no se encuentran duplicados en el segundo set de datos

-- ejemplo buscamos los clientes que sólo se encuentran en sales_2015 vs customer_20_60
select customer_id from sales_2015
Except
select customer_id from customer_20_60
order by customer_id;


-- 56 Union 
-- retorna los valores de ambos set de datos pero sin duplicados
-- similar a SELECT DISTINCT  
--  en excel equivale a pegar datos y luego borrar duplicados 
-- el parámetro ALl ( de allow) permite mantener los duplicados
-- es necesario que las columnas seleccionadas de ambos set compartan 
-- campos similares y mismo tipo de datos

select customer_id from sales_2015 
Union
select customer_id from customer_20_60
order by customer_id;
-- de este modo obtenemos un listado de todos los clientes 
-- de los que se tiene registro hasta el momento

-- fin de la sección 12











