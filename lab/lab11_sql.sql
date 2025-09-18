--Lab 11 Implement SQL Joins  
USE CSE_3A_127
CREATE TABLE STU_INFO (
RNO INT ,
NAME  VARCHAR (10),
BRANCH VARCHAR(10)
)

INSERT INTO STU_INFO VALUES
(101,'RAJU','CE'),
(102,'AMIT','CE '),
(103,'SANJAY','ME'),
(104,'NEHA','EC'),
(105,'MEERA','EE'),
(106,'Mahesh','ME');

SELECT *
FROM STU_INFO


CREATE TABLE RESULT (
RNO INT ,
SPI DECIMAL(2,1)
)

INSERT INTO RESULT VALUES
(101,8.8),
(102,9.2),
(103,7.6),
(104,8.2),
(105,7.0),
(107,8.9);

DROP TABLE RESULT
SELECT *
FROM RESULT

CREATE TABLE EMPLOYEE_MASTER(
EmployeeNo VARCHAR(5),
NAME VARCHAR(10),
MANAGERNO VARCHAR(5),
)

INSERT INTO EMPLOYEE_MASTER VALUES
('E01','Tarun',NULL),
('E02','Rohan','E02'),
('E03','Priya','E01'),
('E04','Milan','E03'),
('E05','Jay','E01'),
('E06','Anjana','E04');

SELECT * 
FROM EMPLOYEE_MASTER
--Part � A: 
--1. Combine information from student and result table using cross join or Cartesian product. 
SELECT *
FROM STU_INFO
CROSS JOIN RESULT

--2. Perform inner join on Student and Result tables. 
SELECT *
FROM STU_INFO
INNER JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO

--3. Perform the left outer join on Student and Result tables. 
SELECT *
FROM STU_INFO
LEFT JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO

--4. Perform the right outer join on Student and Result tables. 
SELECT *
FROM STU_INFO
RIGHT JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO

--5. Perform the full outer join on Student and Result tables.  
SELECT *
FROM STU_INFO
FULL JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO

--6. Display Rno, Name, Branch and SPI of all students. 
SELECT STU_INFO.Rno,NAME,Branch,SPI
FROM STU_INFO
LEFT JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO
--ALSO WE CAN USE FULL JOIN IN THIS CONDITION

--7. Display Rno, Name, Branch and SPI of CE branch�s student only. 
SELECT STU_INFO.Rno,NAME,Branch,SPI
FROM STU_INFO
INNER JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO
WHERE BRANCH='CE'

--8. Display Rno, Name, Branch and SPI of other than EC branch�s student only. 
SELECT STU_INFO.Rno,NAME,Branch,SPI
FROM STU_INFO
INNER JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO
WHERE BRANCH='EE'

--9. Display average result of each branch. 
SELECT AVG(RESULT.SPI) AS AVG_SPI,BRANCH
FROM STU_INFO
INNER JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO
GROUP BY BRANCH

--10. Display average result of CE and ME branch. 
SELECT AVG(RESULT.SPI) AS  AVG_SPI,BRANCH
FROM STU_INFO
INNER JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO
GROUP BY BRANCH
HAVING BRANCH = 'CE' OR BRANCH= 'ME'

--11. Display Maximum and Minimum SPI of each branch. 
SELECT MAX(RESULT.SPI)AS MAX_SPI,MIN(RESULT.SPI) AS MIN_SPI,BRANCH
FROM STU_INFO
INNER JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO
GROUP BY BRANCH

--12. Display branch wise student�s count in descending order. 
SELECT COUNT(RNO) AS  COUNT_STU,BRANCH
FROM STU_INFO
GROUP BY BRANCH
ORDER BY COUNT(RNO) DESC
--Part � B: 

--1. Display average result of each branch and sort them in ascending order by SPI. 
SELECT AVG(RESULT.SPI) AS  AVG_SPI,BRANCH
FROM STU_INFO
FULL JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO
GROUP BY BRANCH
ORDER BY AVG(RESULT.SPI)

--2. Display highest SPI from each branch and sort them in descending order.
SELECT MAX(RESULT.SPI) AS HIGHEST_SPI,BRANCH
FROM STU_INFO
FULL JOIN RESULT
ON STU_INFO.RNO = RESULT.RNO
GROUP BY BRANCH
ORDER BY MAX(RESULT.SPI) DESC

--Part � C: 

--1. Retrieve the names of employee along with their manager�s name from the Employee table.
SELECT E.NAME AS EmployeeNAME,M.NAME AS MANAGERNAME
FROM EMPLOYEE_MASTER E
INNER JOIN EMPLOYEE_MASTER M
ON E.MANAGERNO =  M.EmployeeNo
-- NOT VALID 2ND CONDITION
--ON E.EmployeeNo = M.MANAGERNO



