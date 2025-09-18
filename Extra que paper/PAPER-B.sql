CREATE DATABASE paper_b
use paper_b
CREATE TABLE Stadium (
    stadium_id INT PRIMARY KEY,
    stadium_name VARCHAR(100),
    stadium_city VARCHAR(50),
    stadium_capacity INT
);
-- Team Table
CREATE TABLE Team (
    team_id INT PRIMARY KEY,
    team_name VARCHAR(50),
    team_coach VARCHAR(50),
    team_wins INT,
    team_total_matches INT,
    home_stadium_id INT,
    FOREIGN KEY (home_stadium_id) REFERENCES Stadium(stadium_id)
);
-- Player Table
CREATE TABLE Player (
    player_id INT PRIMARY KEY,
    player_first_name VARCHAR(50),
    player_last_name VARCHAR(50),
    team_id INT,
    player_role VARCHAR(20),
    player_jersey_number INT,
    player_matches_played INT,
    FOREIGN KEY (team_id) REFERENCES Team(team_id)
);
-- Insert into Stadium
INSERT INTO Stadium VALUES
(1, 'Eden Gardens', 'Kolkata', 66000),
(3, 'M. A. Chidambaram Stadium', 'Chennai', 50000),
(4, 'M. Chinnaswamy Stadium', 'Bengaluru', 40000),
(5, 'Arun Jaitley Stadium', 'Delhi', 41000);
-- Insert into Team
INSERT INTO Team VALUES
(2, 'CSK', 'Stephen Fleming', 130, 210, 3),
(3, 'Royal Challengers Bangalore', 'Sanjay Bangar', 90, 200, 4),
(4, 'Kolkata Knight Riders', 'Chandrakant Pandit', 100, 190, 1),
(5, 'Delhi Capitals', 'Ricky Ponting', 85, 180, 5);
-- Insert into Player
INSERT INTO Player VALUES
(1, 'Virat', 'Kohli', 3, 'Batsman', 18, 220),
(3, 'MS', 'Dhoni', 2, 'Wicketkeeper', 7, 250),
(4, 'Andre', 'Russell', 4, 'All-rounder', 12, 150),
(5, 'David', 'Warner', 5, 'Batsman', 31, 210),
(6, 'Shikhar', 'Dhawan', 5, 'Batsman', 25, 220),
(7, 'Vijay', 'Shankar', 3, 'All-rounder', 28, 75),
(8, 'Aaron', 'Finch', 3, 'Batsman', 5, 80),
(10, 'Ravindra', 'Jadeja', 2, 'All-rounder', 8, 200);
-- FOR 15th query
INSERT INTO Stadium VALUES
(2, 'MOTERA', 'AHMDADBAD', 13200);

INSERT INTO Team VALUES
(1, 'Mumbai Indians', 'Mahela Jayawardene', 120, 200, 2);

INSERT INTO Player VALUES
(2, 'Rohit', 'Sharma', 1, 'Batsman', 45, 230),
(9, 'Ishan', 'Kishan', 1, 'Wicketkeeper', 23, 120);
--1.  Retrieve Unique Roles of Players. 
select distinct  player_role
from player
--2.  Calculate the winning percentage of each team.
select team_name ,(team_wins *100  /team_total_matches)
from Team

--3.  Insert a new record to Stadium Table. (2, Wankhede Stadium, Mumbai,33000) 
insert into Stadium values(6,'Wankhede Stadium','Mumbai',33000)

--4.  Update Team Coach Name of Team RCB to Ashish Nehra. 
update  team 
set team_coach  = 'Ashish Nehra'
where  team_name = 'Royal Challengers Bangalore'

select * from team
--5.  Delete All the Records of Player Shikhar Dhawan. 
delete  from player
where player_first_name = 'Shikhar' and player_last_name ='Dhawan'

select * from Player

--6.  Change the size of stadium_name column from VARCHAR (100) to VARCHAR (15). 
alter table Stadium 
alter column stadium_name varchar(200)

--7.  Remove Player Table. 
drop table Player

--8.  Display Top 30 Players Whose First Name Starts with Vowel. 
select top 30 player_first_name
from Player
where player_first_name like '[a,e,i,o,u]%'

--9.  Display City Whose Stadium Name does not Ends with ‘M’. 
select Stadium.stadium_city
from Stadium
where stadium_name not like '%M'

--10.  Generate Random Number between 0 to 100. 
select cast (rand()*101 as int )

--11.  Display 4th to 9th Character of ‘Virat Kohli’. 
select SUBSTRING('Virat Kohli',4,8)

--as 8 = length (11-4+1)

--12.  Display The Day of week on 2005-01-07. 
select datepart(day,'2005-01-07')

select day('2005-01-07')

--13.  Display City Wise Maximum Stadium Capacity. 
select max(stadium_capacity) ,stadium_city
from Stadium
group by stadium_city

--14.  Display City Whose Average Stadium Capacity is Above 20000. 
select Stadium.stadium_city,AVG(stadium_capacity)
from Stadium
group by stadium_city
having avg(stadium_capacity) > 20000

--15.  Display All Players Full Name, Jersey No and Role Who is Playing for Mumbai Indians. (Using Sub 
--query). 
select CONCAT_WS('',player_first_name,player_last_name) ,player_jersey_number,player_role
from player
where team_id in (select team_id from team where team_name= 'Mumbai Indians')

--16.  Display Team Name Having Home Stadium Capacity Over 50000. (Using Sub query )
select team_name 
from team
where home_stadium_id in (select stadium_id from stadium where stadium_capacity >50000  )

--17.  Create a View Players_Above_100_Matches of Players Who have Played More than 100 Matches. 
--create view Players_Above_100_Matches
--as 
--select player_first_name
--from Player
--where player_matches_played > 100

select *
from Players_Above_100_Matches
--18.  Get the Player name, Team name, and their Jersey number who have played Between than 50 to 
--100 matches. 
select player_first_name,team_name,player_jersey_number
from player 
join Team
on team.team_id = player.team_id
where player_matches_played between 50 and 100

--19.  Produce Output Like: <PlayerFirstName> Plays For <TeamName> and Has Played <PlayerMatches> 
--matches. (In single column) 
select player_first_name + 'Plays For' + team_name + 'and Has Played' +cast (player_matches_played as varchar)
from player 
join team 
on team.team_id = player.team_id

--20.  Display Stadium Capacity of Team CSK.
select stadium_capacity
from Stadium
join team
on Team.home_stadium_id = Stadium.stadium_id 
where team_name = 'CSK'
