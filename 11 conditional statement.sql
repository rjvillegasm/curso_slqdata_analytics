--- Sección 11
--- Conditional statement

-- 45 Case When:

--ejemplo
Select * , Case 
                when age <30 then 'Young'
                when age>60 then 'Senior Citizen'
                else 'Middle Aged'
                end as Age_cat
from customer;

--ejemplo 2:
Select customer_id,customer_name, age , Case 
                when age <30 then 'Young'
                when age>60 then 'Senior Citizen'
                else 'Middle Aged'
                end as Age_cat
from customer;






