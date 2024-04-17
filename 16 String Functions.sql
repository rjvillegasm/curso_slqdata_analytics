-- Sección 16
-- String Functions


-- 65 Length
-- se aplica a la columna completa ó string
select customer_name , length(customer_name) as name_char
from customer 
where length(customer_name)>18;

-- 66 Upper and Lower
-- se aplica a la columna completa ó string
Select upper ('roberto');

select lower('ROBERTO');

-- 67 Replace
-- es case sensitive (dentro del paréntesis)

--sintaxis:
 replace ( string, from_substring, to_substring)

--ejemplo:

select customer_name,
        country,
        replace(country, 'United States', 'US' ) as new_country
from customer;

-- 68 Trim
-- 3 tipos: normal, izq y derecha

-- trim normal: quita espacios de un extremo ó ambos
-- de una columna o string( usar '')
trim( [ leading | trailing | both ] [ trim_character ] from string )
trim ( parámetro 'caracter objetivo' from string_objetivo)
-- leading: inicio
select trim(leading ' ' from ' Roberto  ');
Select trim (leading '@' from '@Roberto@' );

--trailing: final
select trim(trailing ' ' from '  Roberto ');
select trim (trailing '@' from '@Roberto@' );
-- both: ambos
select trim(both ' ' from '  Roberto ');
select trim('  Roberto ');
Select trim('@Roberto@', '@');

-- rtrim
rtrim( string, trim_character )
select rtrim(' Roberto ', ' ');
select rtrim( '@Roberto@', '@');
-- ltrim
ltrim( string, trim_character )
select ltrim(' Roberto ', ' ');
select ltrim( '@Roberto@', '@');

-- 69 Concat
-- usa doble pipes ||

--sintaxis:
 string_1 || string_2|| string_n

-- ejemplo:
select customer_name,
        city||','||state|| ','||country as address
from customer; 
-- las comas son para mejorar la legibilidad

--70 Substring
-- extrae parte de un string
-- sintaxis:
substring( string [from start_position] [for length] )
substring( string_objetivo [FROM 'desde'] [ FOR 'cuantos caracteres quiero'] )
-- por defecto FROM es desde el inicio

--ejemplo1:simple
select customer_id,
        customer_name,
        substring(customer_id for 2) as cust_group
from customer;
--ejemplo2: filtramos según el substring
select customer_id,
        customer_name,
        substring(customer_id for 2) as cust_group
from customer where substring(customer_id for 2)='AB';
--ejemplo3: doble substring 
select customer_id,
        customer_name,
        substring(customer_id from 4 for 5) as cust_number
from customer
where substring(customer_id for 2)='AB';

-- 71 List aggregator
-- concatena valores a un string 
-- separado por un delimitador

-- sintaxis: 
string_agg (expression, delimiter)
-- ejemplo agrupamos los productos a su orden de compra:
select order_id,
        STRING_AGG(product_id,',')
from sales group by order_id;
-- sin esta agrupación los productos se encuentran
-- en distintas filas en la tabla sales

-- fin sección 16