-- Sección 7 
-- Selection commands: Ordering

-- Order by --

-- descendiente
select * from customer where state ='California' Order by customer_name desc;
-- ascendiente
select * from customer where state ='California' Order by customer_name asc;
-- con 2 condiciones
select * from customer Order by city asc, customer_name desc;
-- con filtros mas condiciones
select * from customer where age>25 order by city asc, customer_name desc;

--- Se puede ordenar por string y enteros
--  por posición en el eje: 2= customer_name
select * from customer order by 2 asc;
-- por string
select * from customer order by age desc;

-- Limit --
-- limita el máximo nro de filas a desplegar

select  * From customer where age>25 order by age desc limit 8;

select * from customer where age >25 order by age asc limit 10;

-- fin sección 7


