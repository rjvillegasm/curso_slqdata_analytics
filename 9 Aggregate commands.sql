-- Sección 9
-- Aggregate commands

-- Count
-- se selecciona la columna entre paréntesis

-- contar todas las columnas
select count(*) from sales;
-- se recomienda usar un alias 
select count(*) as "TotalRows" from sales;

-- ejemplo cliente CG-12520:
select count(order_line) as "number of product ordered", count(distinct order_id) as "number of orders"
 from sales where customer_id ='CG-12520'; 


--Sum
select sum(profit) as "total profit" from sales ;

-- total de unidades vendidas del producto: FUR-TA-10000577
select sum(quantity) as"Total_quantity" from sales where product_id='FUR-TA-10000577';


-- Avg
-- promedio ó mean
select avg(age) as "Avg customer age" from customer;

-- calcular comisión promedio
select avg(sales*0.10) as "comisión promedio" from sales; 

-- Min and Max

-- minima orden dentro del periodo
select min(sales) as "min sales" from sales  where order_date between '2015-06-01' and '2015-06-30';
-- mayor orden dentro del periodo
select max(sales) as "min sales" from sales  where order_date between '2015-06-01' and '2015-06-30';

--fin sección 9 
