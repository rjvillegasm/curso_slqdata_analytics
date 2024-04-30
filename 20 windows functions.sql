-- Sección 20
-- Windows functions



-- 86 introduction to windows functions

-- row functions vs win functions
-- w.f. permite conservar la modularidad de los datos 
-- y agregar los valores de otra tabla
-- por ejemplo un total general 
-- lo que no es posible con group by al crear agregación

SELECT <column_1>, <column_2>,
<window_function>() OVER (
PARTITION BY <...>
ORDER BY <...>
FROM <table_name>;

-- 87 intro to row number
-- permite crear un pequeño indice, basado en condiciones 
-- ideal para crear un ranking
-- partition by es opcional
-- en caso de empate va primero la fila 
-- que estaba primero en el orden inicial 

--sintaxis: 

SELECT Cust, Store, Orders,
row_number() OVER (
PARTITION BY Store -- ó estado 
ORDER BY orders desc) as 'row'
FROM <table_name>;

-- ejercicio
-- crear una lista de top 3 clientes con las ordenes máx
-- por cada estado

-- 88 implementando row number

-- resolución del ejercicio
-- 1er combinar la tabla de clientes y la de ordenes
-- 2do add row numbers por cada estado
-- 3er filtrar el row number hasta 3

--revisamos las tablas
SELECT * from sales limit 10;
select * from customer limit 10;
--necesitamos customer_id , customer_name y state ( podría ser región)

-- 1ro:
-- customer será la tabla izquierda y sales la derecha
select c.*, s.order_num, s.customer_total, s.total_profit, s.total_units 
from customer as c 
left join (
    select customer_id,
    count(distinct order_id) as order_num,
    sum(sales) as customer_total,
    sum(quantity) as total_units,
    sum(profit) as total_profit
    from sales group by customer_id
     ) as s 
on c.customer_id = s.customer_id;

-- revisamos al primer cliente AA-10315
select order_id,customer_id , sum(sales) from sales where customer_id ='AA-10315'
group by order_id, customer_id order by order_id;

-- creamos la vista
create view customer_order as (
    select c.*, s.order_num, s.customer_total, s.total_profit, s.total_units 
from customer as c 
left join (
    select customer_id,
    count(distinct order_id) as order_num,
    sum(sales) as customer_total,
    sum(quantity) as total_units,
    sum(profit) as total_profit
    from sales group by customer_id
     ) as s 
on c.customer_id = s.customer_id
);
-- revisamos
select * from customer_order;

--2do:
-- asignamos row numbers y filtramos 

-- opción con cte
with ranking_cliente ( customer_id, customer_name, state,
 region,  order_num, rank_n) as (
select customer_id, customer_name, state,
 region,  order_num,
row_number() over(
    partition by state 
    order by order_num desc
                ) as rank_n
from customer_order
 )
select customer_name, rank_n, state, order_num 
from ranking_cliente where rank_n <4;

-- opción con sub query
select * from (

select customer_id, customer_name, state,  order_num,
row_number() over(
    partition by state
    order by order_num desc
                ) as rank_n
from customer_order

)
where rank_n <=3;


-- 89 Rank
-- similar a row functions() pero en casos de empate
-- les entrega el mismo ranking saltándose la posición 
-- pudiendo tener dos ranking 2do sin 3ro 




-- sintaxis: 
SELECT Cust, Store, Orders,
rank() OVER (
PARTITION BY Store
ORDER BY Orders desc) as row
FROM <table_name>

--ejemplo

select customer_id, customer_name, state,
 region,  order_num,
rank() over(
    partition by state 
    order by order_num desc) as rank_n
from customer_order;


-- Dense rank
-- similar a los casos anteriores pero en casos de empate
-- les entrega el mismo ranking sin saltarse la posición 
-- pudiendo tener dos ranking 2do y después 3ro


select customer_id, customer_name, state,
 region,  order_num,
dense_rank() over(
    partition by state 
    order by order_num desc) as dense_n
from customer_order;

-- ejemplo combinado
select customer_id, customer_name, state,  order_num,
row_number() over(  partition by state
    order by order_num desc
                ) as row_n,
rank() over(
    partition by state
    order by order_num desc
                ) as rank_n,
dense_rank() over(
    partition by state
    order by order_num desc
                ) as dense_rn
from customer_order;

-- 90 Ntile(n)
-- crea n grupos ó tile's (baldosas) en una partición (opcional)
-- asignando a cada tile un número de grupo 
-- utiliza el parámetro n para definir cuantos elementos por grupo
-- útil para crear percentiles 

--sintaxis:
SELECT Cust, Store, Orders,
ntile(2) OVER (PARTITION BY Store
ORDER BY Orders desc) as group
FROM <table_name>;

-- ya que existen mas clientes en California que en Alabama
-- deseamos seleccionar el 20% de clientes de cada estado
select * from
(select customer_id, customer_name, state,  order_num,
ntile(5) over(
    partition by state
    order by order_num desc
) as group_n
from customer_order)
where group_n=1;
-- se selecciona 1, ya que representa al 1er 20%
-- de los clientes con más ordenes
-- si selecciono 5 serían el 20% con menos ordenes

-- Windows Functions: Aggregate 

-- 91 Average 
-- obtiene el promedio de las filas dentro de un rango
-- el rango lo definimos mediante un partition by 

select * from customer_order;

-- crearemos el promedio de compras por estado
select customer_id, customer_name , state, customer_total,
avg(customer_total) over(partition by state) as avg_sales
from customer_order;

-- ahora buscaremos clientes que han comprado menos
-- el promedio con una sub query
select * from 
(select customer_id, customer_name , state, customer_total,
avg(customer_total) over(partition by state) as avg_sales
from customer_order)
where customer_total<avg_sales;


-- 92 Count 
-- permite contar los elementos de un subconjunto
-- que creamos con partition by 

--sintaxis: 
SELECT Cust, Store,
count(Customer) OVER (PARTITION BY Store)
as N_Cust
FROM <table_name>;

-- creamos una columna con el nro de clientes por cada estado
select customer_id, customer_name, state,
count(customer_id) over(partition by state) as count_cust
from customer_order;

-- 93 Sum Total
-- suma los valores de un subconjunto 
-- creado con partition by

-- nos permitiría crear un total acumulado por cliente


--sintaxis:
SELECT Cust, Date, Revenue,
sum(revenue) OVER (PARTITION BY Cust )
as Total
FROM <table_name>;

-- revisamos sales
select * from sales;
-- en la tablas las ordenes se encuentran en mas de una línea
-- debido a los productos y necesitamos agruparlos
-- la fecha es única para cada order_id
-- por lo que agruparemos order_id según fecha
-- creamos una tabla 
create table order_rollup as 
select order_id, max(order_date) as order_date, max(customer_id) as customer_id,
sum(sales) as sales from sales group by order_id;
-- seleccionamos
select * from order_rollup;
-- agregamos el estado del cliente con un left join
create table order_rollup_state  as 
select  a.*, b.state
from order_rollup as a 
left join customer as b 
on a.customer_id=b.customer_id;
--revisamos
select* from order_rollup_state order by state;

-- creamos el sum total por estado
select * , sum(sales) over(partition by state) as state_total_sales
from order_rollup_state;

-- 94 Running Total
-- suma los valores dentro de un subconjunto
-- pero creando un acumulado según ocurren
-- útil para crear una frecuencia acumulada
-- misma sintaxis que el caso anterior pero
-- es necesaria un Order By 
-- para darle contexto a la suma
-- generalmente por fecha 

-- sintaxis:
SELECT Cust, Date, Revenue,
sum(revenue) OVER (PARTITION BY Cust
ORDER BY Date desc) as Total
FROM <table_name>;


-- running total de cada estado según fecha
select * ,
sum(sales) over(partition by state) as state_total_sales,
sum(sales) over(partition by state order by order_date asc) as running_total
from order_rollup_state;



-- 95 Lag/lead
-- retorna el valor de una fila anterior (para LAG) 
-- retorna el valor de una fila siguiente (para LEAD) 
-- según el offset entregado
-- lead( columna_objetivo, offset)
-- necesita un order by para tener contexto

--sintaxis:
select Cust, Date, Revenue,
lag(revenue,1) OVER (PARTITION BY Cust
ORDER BY Date desc) as Last_r
FROM <table_name>;

-- agregaremos el valor monetario de la orden previa de mi cliente
select customer_id, order_date, order_id, sales, 
lag(sales,1) over(partition by customer_id order by order_date) as previous_sales,
lag(order_id,1) over(partition by customer_id order by order_date) as previous_order_id
from order_rollup_state;


select customer_id, order_date, order_id, sales, 
lag(sales,1) over(partition by customer_id order by order_date) as previous_sales,
lag(order_id,1) over(partition by customer_id order by order_date) as previous_order_id,
lead(sales,1) over(partition by customer_id order by order_date) as next_sales,
lead(order_id,1) over(partition by customer_id order by order_date) as next_order_id
from order_rollup_state;


--96 Coalesce
-- retorna el primer valor no-null de una lista de valores
-- cuando todos los valores son nulos retorna 'N/A'
-- útil al realizar limpieza de datos y recuperar valores desde la fila equivocada
-- puedo entregar un string para crear la excepción como si fuese un IfNull()
--ej: Coalesce( columna_objetivo, 'el_valor_es_nulo' )

-- creamos la tabla 
create table emp_name(
S_No int,
First_Name varchar(255),
Middle_Name varchar(255),
Last_Name varchar(255)
);
-- importamos desde csv
copy emp_name from 'C:\misrepositorios\curso_sqldata_analytics\Data\emp_name.csv' delimiter ';' CSV HEADER;
-- revisamos
select * from emp_name;

--aplicamos y comparamos vs concat
select *,
Coalesce(first_name,middle_name, last_name) as name_corr,
concat(first_name,middle_name, last_name) as name_concat 
from emp_name;

