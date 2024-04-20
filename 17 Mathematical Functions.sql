-- Sección 17
-- Mathematical functions 

--73 Ceil & Floor

-- Ceil: retorna el menor valor entero 
-- que es mayor o igual a x número 

-- Floor: retorna el valor entero que es
-- igual o menor que un número x 

select Ceil(4.5),  floor(4.5);

--ejemplo: 
select order_line, 
       sales,
       Ceil(sales),
       floor(sales),
       ceil(sales)-floor(sales) as diff
from sales where discount>0;

-- 74 Random
-- genera un valor entre cero y uno
-- cero incluido, uno excluido
-- entonces x>=0 y x<1

--ejemplos:

-- Random decimal between range ( a included & b excluded)
select Random ()* (b-a)+a ;
-- 10 y 20 genera decimales entre [10-20)
select Random()*((20-10)+10);

-- Random integer between a range ( both boundaries included)
select floor ( Random () *(b-a+1))+a;
--10 y 20 genera enteros entre [10-20]
select floor (random()*(20-10+1) )+10;


--75 Setseed
-- genera una secuencia random de números
-- derivados de una semilla => seed
-- seed puede ser un valor entre -1 y 1
-- ambos incluidos
-- solo sirve para setear la semilla en la función random
-- al setear el seed la función random devolverá un número
-- relativamente cercano a la seed por un par de random
-- si usamos una seed entre cada random
-- no lograremos valores cercanos 

--sintax:
    SETSEDD (seed)

--primer bucle
select Setseed(0.5),
random(), -- 0.48060564
random(); -- 0.26775925

--segundo bucle
select Setseed(0.02),
Random(),--0.78901481
random();-- 0.96469897

select random(), random(), random(), random();

-- 76 Round
-- redondea un decimal al entero mas cercano

select order_line,
       sales,
       round(sales)
from sales order by sales desc;


--77 Power 
-- utilizado para escribir potencias 
-- m es la base
-- n es el exponente
-- utilizado dentro de funciones estadísticas (manuales)

--sintaxis:  POWER (m,n)

--ejemplo:

select Power(3,2);

select age, Power(age,2) 
from customer order by age ;


-- fin sección 17



