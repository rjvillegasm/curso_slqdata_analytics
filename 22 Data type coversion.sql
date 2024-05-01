-- Sección 22
-- Data type conversion functions

-- 97 Converting numbers: date to string 

-- To_char( value, format_mask)
-- convierte números o fechas a string

-- número to char
select sales,
to_char(sales, '9999.99') 
 from sales;
-- valor concatenado
select sales, 
'Total sales value for this order is'||to_char(sales, '9,999.99') 
as message 
 from sales;
--con signo peso
select sales, to_char(sales, 'L9,999.99') as valor
from sales;
-- fechas a string
select order_date , to_char(order_date, 'MMDDYY')
from sales;
-- fechas a string 2
select order_date , to_char(order_date, 'Month DD YYYY')
from sales;
-- MONTH para mayúsculas

-- To_date(string ,  format_mask)
-- convierte un string a fecha
-- utiliza el mismo formato de máscaras que el caso anterior 

select to_date('2022/01/15', 'YYYY/MM/DD');

select to_date('26122018','DDMMYYYY');

--To_number( string, Format_mask)
-- convierte un string a número

select To_number('1210.73', '9999.99');

select to_number('$1,210.73', 'L9,999.99');


-- fin sección 22