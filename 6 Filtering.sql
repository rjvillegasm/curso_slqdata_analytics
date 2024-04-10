-- Section 6 - Selection commands: Filtering 

-- comenzamos con 3 tablas
select * from customer;

select * from sales;

select * from product;

--  28 operador IN  , simplifica queries
-- Es una alternativa a usar multiples AND y OR

select  *  from  customer  where city in  ('Philadelphia', 'Seattle');

--29  operador between
--  útil para rangos, funciona con NOT
select * from customer where age between 20 and  30 ;
-- alternativa: 
select * from customer where age>=  20 and age <=30; 

-- NOT BETWEEN   excluye un rango  

select * from customer where age not between 20 and 30;

select * from sales where ship_date between '2015-04-01' and '2016-04-01';

-- 30  operador LIKE , se ocupa entregando una condición
--  "pattern" > ejemplos o modelos 
--( caracteres al inicio o fin de una palabra ) 

-- nombre inicia con:
select * from customer where customer_name like 'J%' ; 

-- nombre exacto
select * from customer where customer_name like '%Nelson%';

-- seleccionar nombres de 4 caracteres:
select * from customer where customer_name like '____ %'; 
-- nota: espacio antes del % 

-- ciudades que no comienzan con S
select distinct city from customer where city  not like 'S%';

-- encontrar el caracter % 
select * from customer where customer_name like '\%' ;  
-- nota: el backslash anula el pattern y se considera caracter 


-- ejercicio 5

select distinct city  from  customer  where region    in  ( 'North', 'East');

select * from sales where sales between 100 and 500;

select * from customer where customer_name like '% ____';
-- fin ejercicio 5

--fin seccion 6


