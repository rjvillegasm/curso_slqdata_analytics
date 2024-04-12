--- Sección 10
--- Group By commands


-- 42 Group by:
-- generalmente se utiliza junto a una función de agregación y alias

-- clientes por región:
select region, count(customer_id) as costumer_count 
from customer group by region;

-- productos mas vendidos
select product_id, sum(quantity) as quantity_sold from sales
group by product_id order by quantity_sold desc;
-- si agrego un limit puede obtener los 10 más vendidos

-- obtener estadísticas de los 5 mejores clientes
select customer_id,
MIN(sales) as min_sale, 
MAX(sales) as max_sale,
AVG(sales) as average_sale,
SUM(sales) as total_sales
from sales group by customer_id 
order by total_sales desc limit 5;

--NOTA: "la columna objetivo del select debe ser la misma del group by
--      cualquier otra columna que NO sea un identificador único provocará error."
-- en el ejemplo anterior no podríamos usar "age", debemos aplicar un "avg" ó similar 

-- desarrollando lo anterior, agregamos "state" que también se incluye en el "groupby"
select region, state, avg(age), count(customer_id) as costumer_count 
from customer group by region, state;

-- 43 Having
-- se utiliza para agregar una condición al groupby
-- donde no se puede usar where

-- obtener regiones donde existan mas de 200 clientes:
select region, count (customer_id) as customer_count 
from customer group by region Having count(customer_id)>200;

-- nota; la diferencia con where radica en que where se aplica a columnas
-- no agregadas, por otra lado having siempre se aplica a la columna agregada. 

-- cuantos clientes de nombres que comienzen con 'A' en cada region:
select region, count(customer_id) as costumer_count 
from customer where customer_name like 'A%' group by region ;

-- al ejemplo anterior aplicamos having:
select region, count(customer_id) as costumer_count 
from customer where customer_name like 'A%'
group by region having count (customer_id)>15 ;


