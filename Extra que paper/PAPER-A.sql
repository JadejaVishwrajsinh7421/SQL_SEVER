CREATE DATABASE Paper_extra
use  Paper_extra


CREATE TABLE Astronauts (
    astronaut_id INT IDENTITY(1,1) PRIMARY KEY,
    astronaut_name VARCHAR(100) NOT NULL,
    age INT,
    nationality VARCHAR(50),
    total_space_missions INT
);
CREATE TABLE Missions (
    mission_id INT IDENTITY(1,1) PRIMARY KEY,
    mission_name VARCHAR(100) NOT NULL,
    launch_date DATE NOT NULL,
    duration_days INT ,
    mission_type VARCHAR(50)
);
CREATE TABLE Spacecrafts (
    spacecraft_id INT IDENTITY(1,1) PRIMARY KEY,
    spacecraft_name VARCHAR(100) NOT NULL,
    capacity INT,
    manufacturer VARCHAR(100)
);
CREATE TABLE Participation (
    participation_id INT IDENTITY(1,1) PRIMARY KEY,
    astronaut_id INT NOT NULL,
    mission_id INT NOT NULL,
    spacecraft_id INT NOT NULL,
    role VARCHAR(50),
    FOREIGN KEY (astronaut_id) REFERENCES Astronauts(astronaut_id),
    FOREIGN KEY (mission_id) REFERENCES Missions(mission_id),
    FOREIGN KEY (spacecraft_id) REFERENCES Spacecrafts(spacecraft_id)
);

INSERT INTO Astronauts (astronaut_name, age, nationality, total_space_missions) VALUES
('Neil Armstrong', 39, 'USA', 2),
('Buzz Aldrin', 41, 'USA', 2),
('Yuri Gagarin', 34, 'Russia', 1),
('Valentina Tereshkova', 36, 'Russia', 1),
('Chris Hadfield', 55, 'Canada', 3),
('Samantha Cristoforetti', 44, 'Italy', 2),
('Koichi Wakata', 50, 'Japan', 4),
('Sunita Williams', 49, 'India-USA', 3),
('Elon Vega', 38, 'USA', 6),
('Rajesh Kumar', 42, 'India', 4);
INSERT INTO Missions (mission_name, launch_date, duration_days, mission_type) VALUES
('Apollo 11', '1969-07-16', 8, 'Exploration'),
('Vostok 1', '1961-04-12', 1, 'Exploration'),
('Mars Research Alpha', '2023-03-15', 120, 'Research'),
('Expedition 35', '2013-03-13', 146, 'Research'),
('Expedition 46', '2015-12-15', 172, 'Research'),
('STS-118', '2007-08-08', 13, 'Repair'),
('Kibo Test Flight', '2008-03-11', 14, 'Research'),
('Jupiter Exploration', '2024-11-01', 365, 'Exploration'),
('Mars Exploration Beta', '2022-06-20', 200, 'Exploration'),
('Lunar Exploration Zeta', '2021-09-05', 45, 'Exploration');
INSERT INTO Spacecrafts (spacecraft_name, capacity, manufacturer) VALUES
('Columbia', 7, 'NASA'),
('Soyuz TMA-08M', 3, 'Roscosmos'),
('Vostok 3KA', 1, 'Soviet Union'),
('Endeavour', 7, 'NASA'),
('Dragon', 7, 'SpaceX'),
('Kibo', 2, 'JAXA'),
('Falcon Heavy', 8, 'SpaceX');
INSERT INTO Participation (astronaut_id, mission_id, spacecraft_id, role) VALUES
(1, 1, 1, 'Commander'),
(2, 1, 1, 'Lunar Module Pilot'),
(3, 2, 3, 'Pilot'),
(5, 3, 5, 'Commander'),
(8, 3, 5, 'Engineer'),
(9, 3, 5, 'Mission Specialist'),
(5, 4, 2, 'Commander'),
(6, 4, 2, 'Flight Engineer'),
(6, 5, 2, 'Flight Engineer'),
(8, 5, 5, 'Commander'),
(8, 6, 4, 'Engineer'),
(7, 7, 6, 'Mission Specialist'),
(9, 8, 7, 'Commander'),
(10, 8, 7, 'Engineer'),
(5, 9, 5, 'Commander'),
(9, 9, 5, 'Engineer'),
(1, 10, 4, 'Commander'),
(2, 10, 4, 'Engineer'),
(9, 10, 7, 'Commander');

--1.  Retrieve the distinct mission names where the mission lasted more than 30 days. 
select distinct mission_name,duration_days 
from Missions
where duration_days >30

--2.  Retrieve the top 3 astronauts who participated in the most missions, ensuring no duplicates. 
select top 3   astronaut_name
from Astronauts
order by total_space_missions desc

--3.  Insert a new space mission called "Jupiter Exploration" that is scheduled to launch on '2024-11
--01', lasting 365 days, and classified as an exploration mission. 
Insert into Missions (mission_name, launch_date, duration_days, mission_type) VALUES('Jupiter Exploration','2024-11-01',365,'Exploration')

--4.  Update the total space missions count for astronaut with ID = 5, increasing it by 1. 
update   Astronauts
set total_space_missions  = total_space_missions  +1
where astronaut_id = 5

--5.  Delete participation record for astronaut ID 3 in mission ID 2. 
delete from Participation 
where astronaut_id=3 and mission_id=2

--6.  Add a new column experience_level (VARCHAR(50)) to the Astronauts table to store the 
--astronaut's experience level.
alter table Astronauts
add   experience_level varchar(50)

--7.  Clear all the data from the Participation table.(Truncate)
Truncate table Participation
--8.  Retrieve all mission names where the mission type contains 'exploration'. 
select mission_name
from Missions
where mission_type like '%exploration%'
--9.  Retrieve all missions that contain the word "Mars" and lasted more than 100 days. 
select *
from Missions
where mission_name like '%mars%' and duration_days >100
--10.  Retrieve the square root of the total number of missions for astronaut ID 102 
select sqrt(total_space_missions)
from Astronauts
where astronaut_id =2

--11.  Retrieve the first 3 characters of each astronaut's name. 
select substring(astronaut_name,1,3)
from Astronauts

--12.  Retrieve the astronauts who participated in missions launched in the current year. 
select astronaut_name,launch_date
from Astronauts

join Participation
on Astronauts.astronaut_id=Participation.astronaut_id

join Missions
on Missions.mission_id= Participation.mission_id

where Year(launch_date) = year(GETDATE())
--13.  Count the number of astronauts from each nationality who have participated in more than 2 
--space missions. 
select count(Astronauts.astronaut_id),nationality,total_space_missions
from Astronauts
group by nationality,total_space_missions
having total_space_missions >2

--14.  Retrieve the total number of missions and the average mission duration for each mission type, 
--but only include mission types that have been involved in more than 3 missions. 
select avg(duration_days),count(Missions.mission_id),mission_type
from Missions
group by mission_type
having count(Missions.mission_id) >3

--15.  Find the number of missions commanded by astronauts for each nationality where more than 5 
--missions were commanded 
<<<<<<< HEAD
select 
--16.  Retrieve the name of the spacecraft used in the mission "Apollo 11" (Use sub Query) 

--17.  Create a view that shows all active missions (those that launched after 2020). 

--18.  List all astronauts and their respective spacecraft for each mission they participated in. 
=======
select count( Missions.mission_id),nationality
from Astronauts

join Participation
on Astronauts.astronaut_id=Participation.astronaut_id

join Missions
on Missions.mission_id= Participation.mission_id
where role = 'commander'
group by nationality
having count( Missions.mission_id)>5

--16.  Retrieve the name of the spacecraft used in the mission "Apollo 11" (Use sub Query) 
select spacecraft_name
from Spacecrafts
where spacecraft_id in
    (select spacecraft_id 
    from Participation 
    where mission_id =(
        select mission_id 
        from Missions 
        where mission_name = 'Apollo 11'))
--17.  Create a view that shows all active missions (those that launched after 2020). 
create view vm_mission
as 
select *
from Missions
where year(launch_date)  > datepart(yy,'2020-01-01')
drop view vm_mission
select *
from vm_mission

--18.  List all astronauts and their respective spacecraft for each mission they participated in. 
select astronaut_name,spacecraft_name,mission_name
from Astronauts
join Participation
on Participation.astronaut_id = Astronauts.astronaut_id
join Spacecrafts
on Spacecrafts.spacecraft_id=Participation.spacecraft_id
join Missions
on Participation.mission_id=Missions.mission_id
>>>>>>> "EXTRA PAPER ARE SOLVED AND LAB 15 UPDATED""LAB 15 UPDATED"

--19.  Retrieve the names of astronauts who participated in missions using spacecrafts manufactured by 
--"SpaceX", along with the names of those missions and the duration of each mission. Include only 
--astronauts who have participated in more than 2 missions. 
<<<<<<< HEAD

--20.  Retrieve the names of astronauts, the names of missions they participated in, the names of 
--spacecraft used in those missions, and the manufacturers of those spacecraft, for missions where 
--the mission duration is greater than the average duration of all missions conducted by astronauts 
--from the "USA".
=======
select astronaut_name,spacecraft_name,mission_name,duration_days
from Astronauts
join Participation
on Participation.astronaut_id=Astronauts.astronaut_id
join Missions
on Missions.mission_id= Participation.mission_id
join Spacecrafts
on Spacecrafts.spacecraft_id=Participation.spacecraft_id
where manufacturer = 'SpaceX' and Participation.astronaut_id in(
      select astronaut_id
      from Participation
      group by Participation.astronaut_id
      having count(distinct mission_id) > 2)

------------------------vip que harder-----------------
--20.  Retrieve the names of astronauts, the names of missions they participated in, the names of 
--spacecraft used in those missions, and the manufacturers of those spacecraft, for missions where 
--the mission duration is greater than the average duration of all missions conducted by astronauts 
--from the "USA".
select astronaut_name,spacecraft_name,mission_name,nationality
from Astronauts
join Participation
on Participation.astronaut_id=Astronauts.astronaut_id
join Missions
on Missions.mission_id= Participation.mission_id
join Spacecrafts
on Spacecrafts.spacecraft_id=Participation.spacecraft_id
where  duration_days > (
            select avg(duration_days)
            from Missions
           join Participation
on Participation.astronaut_id=Missions.mission_id
join Astronauts
on Astronauts.astronaut_id= Participation.astronaut_id
            WHERE
            Astronauts.nationality = 'USA')
                                       






>>>>>>> "EXTRA PAPER ARE SOLVED AND LAB 15 UPDATED""LAB 15 UPDATED"
