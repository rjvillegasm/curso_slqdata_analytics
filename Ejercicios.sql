
-- Exercise 1

drop table Science_class;
CREATE TABLE Science_class (
    Enrollment_no INT PRIMARY KEY NOT NULL,
    Name_student VARCHAR(45),
    Science_marks INT
);

-- Ejercicio 2 

insert into Science_class (Enrollment_no, Name_student, Science_marks)
values ('1', 'Popeye' , '33'),
		(2, 'Olive',54),
        (3,'Brutus',98);

    
copy Science_class from 'C:\misrepositorios\curso_sqldata_analytics\Data\Student.csv' delimiter ',' csv header;

-- fin ejercicio 2 

SELECT * FROM  Science_class;

select name_student , Science_marks from Science_class;

-- ejercicio 3 
select * from Science_class;

select Name_student from Science_class where Science_marks > 60;

select * from Science_class where Science_marks >35 and Science_marks < 60;

select	* from Science_class where Science_marks <= 35 or Science_marks >= 60; 


-- ejercicio 4 

Update Science_class set Science_marks= 45 where name_student='Popeye';

delete from Science_class where name_student='Robb';

alter table Science_class rename name_student to student_name;

