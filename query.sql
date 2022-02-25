-- 1 

SELECT * FROM `students` WHERE YEAR (`date_of_birth`) = 1990

--2 

SELECT * FROM `courses` WHERE `cfu` > 10

--3 

SELECT * FROM `students` WHERE (YEAR(CURRENT_DATE) - YEAR(`date_of_birth`)) > 30

--4 

SELECT * FROM `courses` WHERE `period` = 'I semestre' AND `year` = 1

--5 

SELECT * FROM `exams` WHERE `hour` > '14:00:00' AND `date` = '2020-06-20'

--6

SELECT * FROM `degrees` WHERE `level` = 'magistrale'

--7

SELECT COUNT(`id`) FROM `departments`


-- 8

SELECT COUNT(`id`) FROM `teachers` WHERE `phone` IS NULL




---------------------------------------------------------------

-- JOIN


-- 1 

SELECT * FROM `students`
JOIN `degrees` 
	ON `students`.`degree_id` = degrees.id
    AND `degrees`.`name` = 'Corso di Laurea in Economia'

--2 

SELECT * FROM `departments`
JOIN `degrees` 
	ON `degrees`.`department_id`= `departments`.`id`
    WHERE `departments`.`name` = 'Dipartimento di Neuroscienze'

--3 

SELECT * FROM `courses`
JOIN `course_teacher` 
	ON `course_teacher`.`course_id` = `courses`.`id` 
JOIN `teachers` 
	ON `teachers`.`id` = `course_teacher`.`teacher_id`
    AND `teachers`.`name` = 'Fulvio'
    AND `teachers`.`surname` = 'Amato'



--4 

SELECT students.name, students.surname, degrees.name as 'Corso di Laurea' , departments.name AS 'Dipartimento'  FROM `students`
JOIN `degrees`
	ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`
	ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`name` , `students`.`surname` ASC


--5

SELECT teachers.name AS 'Nome Insegnante', teachers.surname AS 'Cognome Insegnante', courses.name AS 'Corso' ,degrees.name AS 'Corso di Laurea' 
FROM `courses`
JOIN `course_teacher` 
	ON `course_teacher`.`course_id` = `courses`.`id` 
JOIN `teachers` 
	ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `degrees`
	ON `degrees`.`id` = `courses`.`degree_id`



--6

    SELECT DISTINCT teachers.name AS 'Nome Insegnante', teachers.surname AS 'Cognome Insegnante', departments.name AS 'Dipartimento' ,degrees.name AS 'Corso di Laurea' 
FROM `courses`
JOIN `course_teacher` 
	ON `course_teacher`.`course_id` = `courses`.`id` 
JOIN `teachers` 
	ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `degrees`
	ON `degrees`.`id` = `courses`.`degree_id`
JOIN `departments` 
	ON `departments`.`id` = `degrees`.`department_id`
   	AND `departments`.`name` = 'Dipartimento di Matematica'



-- GROUP BY 


--1 


SELECT DISTINCT YEAR(enrolment_date),  COUNT(ID)
FROM `students`
GROUP BY YEAR(enrolment_date)

--2 

SELECT DISTINCT  COUNT(id) AS 'Numero Insegnanti', office_address
FROM `teachers`
GROUP BY office_address
HAVING COUNT(id) > 1


--3 

SELECT AVG(exam_student.vote), exams.date
FROM `exam_student`
JOIN `exams`
	ON `exams`.`id` = `exam_student`.`exam_id`
JOIN `students`
	ON `exam_student`.`student_id` = `students`.`id`
GROUP BY exams.date


SELECT `exam_id`, ROUND(avg('VOTE')) as `media_voti`
FROM `exam_student`
GROUP BY `exam_id`
HAVING `media_voti` > 20


--4 

SELECT DISTINCT  COUNT(department_id) AS 'Corsi di Laurea', departments.name
FROM `degrees`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
GROUP BY departments.name 