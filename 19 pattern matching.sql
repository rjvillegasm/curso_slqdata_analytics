-- Sección 19
-- Patter string matching


-- 83 pattern matching basics
-- 3 methods:

--1. LIKE statements 
--2. SIMILAR TO statements
--3. ~ (regular expressions)

-- like wildcards:
-- '%' permite coincidir con  cualquier string de cualquier largo ( incluso cero)
-- '_' permite coincidir un carácter individual

-- A% para buscar strings que comiencen con A
-- %A para buscar strings terminados en A
-- A%B para buscar string que comienzan con A y terminen en B

-- AB_C para buscar un string que comienza con AB y 
-- luego de un carácter continue con C 

--ejemplos prácticos 

-- nombre comienza con 
select customer_id, customer_name, age from customer where customer_name like 'Jo%';
-- nombre contiene 
select customer_id, customer_name, age from customer where customer_name like '%od%';
-- nombre comienza y contiene
select customer_id, customer_name, age from customer where customer_name like 'Jas_n';
-- nombre no comienza con 
select customer_id, customer_name, age from customer where customer_name not like 'J%';
-- contiene G y %
select customer_id, customer_name, age from customer where customer_name like 'G\%';
-- 

-- REG-EX wildcards

-- | :Denotes alternation (either of two alternatives).
-- * :Denotes repetition of the previous item zero or more times
-- + :Denotes repetition of the previous item one or more times.
-- ? Denotes repetition of the previous item zero or one time.
-- {m} :denotes repetition of the previous item exactly m times.
-- {m,} :denotes repetition of the previous item m or more times.
-- {m,n} :denotes repetition of the previous item at least m and not more
-- than n times
-- ^ y $ : ^ denotes start of the string, $ denotes end of the string
-- [chars] : a bracket expression, matching any one of the chars
-- ~* : ~ means case sensitive and ~* means case insensitive

-- 84 Advanced Reg-Ex 

-- todo case insensitive 
-- comienza con 'a' y  el segundo carácter 
-- puede ser de la A-Z ó un espacio , esto se puede repetir
select * from customer
where customer_name ~*'^a+[a-z\s]+$'; 

-- espacio : '\s' en teclado alt+92 más 's'

-- todo case insensitive
-- primer carácter comienza con a,b,c ó d
-- el segundo carácter puede ser de la A-Z ó un espacio , esto se puede repetir
select * from customer
where customer_name ~* '^(a|b|c|d)+[a-z\s]+$'; 

-- todo case insensitive
-- primer carácter comienza con a,b,c ó d
-- luego 3 caracteres de la a-z
-- un espacio y 4 caracteres de la a-z
select * from customer
where customer_name ~* '^(a|b|c|d)[a-z]{3}\s[a-z]{4}$'; 

-- creamos  user_table
create table users(id serial primary key, name character varying);
--insertamos datos
insert into users (name) VALUES ('Alex'), ('Jon Snow'), 
('Christopher'), ('Arya'),('Sandip Debnath'),
 ('Lakshmi'),('alex@gmail.com'),('@sandip5004'), ('lakshmi@gmail.com');

-- tabla users
select * from users;

-- email válido
-- case insensitive
-- caracteres alfanuméricos (de a-z y/ó 0-9)
--  puede contener un punto, guión ó guion bajo
-- una arroba 
-- más caracteres alfanuméricos y/o un guion 
-- más un punto
-- más 2 caracteres A-Z no mas de 5 veces
select * from users
where name ~*'[a-z0-9\.\-\_]+@[a-z0-9\-]+\.[a-z]{2,5}'; 

-- fin sección 19

