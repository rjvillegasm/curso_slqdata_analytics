drop table Science_class;

CREATE TABLE Science_class (
    Enrollment_no INT PRIMARY KEY NOT NULL,
    Name_student VARCHAR(45),
    Science_marks INT
);



insert into Science_class (Enrollment_no, Name_student, Science_marks)
values ('1', 'Popeye' , '33'),
		(2, 'Olive',54),
        (3,'Brutus',98);
    
SELECT    * FROM    Science_class;

select name_student , Science_marks from Science_class;

# ejercicio 3 
select * from Science_class;

select Name_student from Science_class where Science_marks > 60;

select * from Science_class where Science_marks >35 and Science_marks < 60;

select	* from Science_class where Science_marks <= 35 or Science_marks >= 60; 

# fin ejercicio 3


