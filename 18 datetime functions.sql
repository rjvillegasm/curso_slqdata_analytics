-- Sección 18
-- Date-Time functions


-- 79 Current date & time

-- CURRENT_DATE : Retorna la fech actual
-- utiliza el formato 'YYYYT-MM-DD'
SELECT CURRENT_DATE;
--resultado: 2024-04-20

-- CURRRENT_TIME( n decimales de segundo)
-- retorna la hora actual y timezone
-- utiliza el formato 'HH:MM:SS.GMT+TZ' 
SELECT CURRENT_TIME;
-- resultado: 21:41:07.640362-04
--07.640362 segundos 
SELECT CURRENT_TIME(1);
--resultado 21:50:45.1-04
-- 45.1 segundos


-- CURRENT_TIMESTAMP(n decimales de segundo)
-- retorna la fecha actual, hora y timezone
-- utiliza el formato YYYYT-MM-DD HH:MM:SS.GMT+TZ' 
SELECT CURRENT_TIMESTAMP;
-- resultado: 2024-04-20 21:46:22.460009-04
SELECT CURRENT_TIMESTAMP(2);
-- resultado 2024-04-20 21:52:20.43-04


SELECT CURRENT_DATE, CURRENT_TIME, CURRENT_TIME(1), CURRENT_TIME(3), CURRENT_TIMESTAMP;


--80 Age
-- retorna el número de años, meses y días
-- entre dos fechas 
-- sintaxis: 
--  AGE ( date1, date2) 
-- si no se entrega date1 , se usará la fecha actual

SELECT AGE('2014-04-25' , '2014-01-01');

SELECT AGE('2023-04-20' , '1988-11-10');

SELECT order_line, order_date, ship_date,
		AGE(ship_Date, order_date) AS time_taken
FROM sales
ORDER BY  time_taken DESC;


-- 81 Extract
-- extrae partes de una fecha

-- sintaxis:
-- Extract ( 'unidad' from 'tipo de fecha' 'fecha objetivo') alias [opcional]
-- day,minute,year, month

--día actual
select Extract (day from CURRENT_DATE);
--día
SELECT EXTRACT ( DAY FROM date '2024-04-20') dia;
-- año
SELECT EXTRACT(YEAR FROM TIMESTAMP '2016-12-31 13:30:15') y;
--minuto
select Extract( minute from time '08:44:21');
-- hora desde un timestamp
select CURRENT_TIMESTAMP, Extract(hour from CURRENT_TIMESTAMP);

-- no funciona por que la resta genera un entero en algunas filas 
-- debe ser una expresión de tiempo para que funcione
select order_line, Extract (epoch from (ship_date - order_date))
from sales;
-- corrección
-- epoch convierte el tiempo en segundos
select order_line, (Extract(epoch from ship_date) - Extract( epoch from order_date)) 
as segundos
from sales;

-- fin sección 18