--Lab 15 Perform SQL queries to implement constraints 
--Part – A: 

--Create below table with following constraints 
CREATE TABLE STU_MASTER (
 Rno INT,
 Name VARCHAR(25),
 Branch VARCHAR(25),
 SPI DECIMAL(4,2) ,
 Bklog INT 
)
INSERT INTO STU_MASTER VALUES
(101 ,'Raju', 'CE', 8.80 ,5),
(102 ,'Amit', 'CE', 2.20 ,3),
(103 ,'Sanjay', 'ME', 1.5 ,6),
(104 ,'Neha', 'CE', 7.65 ,1),
(105 ,'Neha', 'EE',5.52 ,2),
(106 ,'Neha','', 4.50 ,3)

--1. Do not allow SPI more than 10 
CREATE TABLE STU_MASTER (
 Rno INT,
 Name VARCHAR(25),
 Branch VARCHAR(25),
 SPI DECIMAL(4,2) CHECK (SPI < 10),
 Bklog INT 
)
SELECT *
FROM STU_MASTER

ALTER TABLE STU_MASTER 
ADD CONSTRAINT CHECK_SPI CHECK (SPI <10)

--2. Do not allow Bklog less than 0. 
ALTER  TABLE STU_MASTER
ADD CONSTRAINT BKLOG_0  CHECK(BKLOG >0)

--3. Enter the default value as ‘General’ in branch to all new records IF no other value is specified. 
ALTER TABLE STU_MASTER
ADD CONSTRAINT DF_BRANCH
DEFAULT 'GENERAL' FOR BRANCH

--4. Try to update SPI of Raju from 8.80 to 12. 
UPDATE STU_MASTER
SET SPI =12
WHERE Name= 'Raju'
--ERROR OCUURED

--5. Try to update Bklog of Neha from 0 to -1
UPDATE STU_MASTER
SET BKLOG =-1
WHERE NAME = 'NEHA'
--ERROR OCUURED


--Part – B: Create table as per following schema with proper validation and try to insert data which violate your 
--validation. 
--1. Emp_details(Eid, Ename, Did, Cid, Salary, Experience) 
--Dept_details(Did, Dname) 
--City_details(Cid, Cname)


CREATE TABLE Dept_details (
    Did INT PRIMARY KEY,                 
    Dname VARCHAR(50) NOT NULL UNIQUE       
);


CREATE TABLE City_details (
    Cid INT PRIMARY KEY,                    
    Cname VARCHAR(50) NOT NULL UNIQUE       
);


CREATE TABLE Emp_details (
    Eid INT PRIMARY KEY ,    
    Ename VARCHAR(100) NOT NULL,            
    Did INT NOT NULL,                      
    Cid INT NOT NULL,                       
    Salary DECIMAL(10,2) CHECK (Salary > 0),
    Experience INT CHECK (Experience >= 0)


    CONSTRAINT fk_dept FOREIGN KEY (Did) REFERENCES Dept_details(Did),
    CONSTRAINT fk_city FOREIGN KEY (Cid) REFERENCES City_details(Cid)
);


-- Insert valid departments and cities
INSERT INTO Dept_details VALUES (1, 'IT'), (2, 'HR');
INSERT INTO City_details VALUES (1, 'New York'), (2, 'London');

--  Valid employee
INSERT INTO Emp_details (Ename, Did, Cid, Salary, Experience)
VALUES ('Alice Johnson', 1, 1, 50000, 5);

-- Invalid employee (Salary < 0 → violates CHECK)
INSERT INTO Emp_details (Ename, Did, Cid, Salary, Experience)
VALUES ('Bob Smith', 1, 2, -1000, 3);

--  Invalid employee (Department doesn’t exist → violates FK)
INSERT INTO Emp_details (Ename, Did, Cid, Salary, Experience)
VALUES ('Charlie Brown', 99, 1, 40000, 2);

--  Invalid employee (City doesn’t exist → violates FK)
INSERT INTO Emp_details (Ename, Did, Cid, Salary, Experience)
VALUES ('David Lee', 1, 99, 60000, 4);

--  Invalid employee (Experience < 0 → violates CHECK)
INSERT INTO Emp_details (Ename, Did, Cid, Salary, Experience)
VALUES ('Eve Adams', 2, 2, 45000, -2);

