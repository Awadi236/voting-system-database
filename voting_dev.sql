use master
drop database if exists voting_sys


create database voting_sys


create table elector(
elector_id int not null unique,
elector_first_name varchar(50) not null,
elector_last_name varchar(50) not null,
elector_email varchar(50),
date date not null,
CONSTRAINT pk_elector_id PRIMARY KEY(elector_id)
);
ALTER TABLE elector
ADD CONSTRAINT elector_email UNIQUE (elector_email);

insert into elector (elector_email)
values
('')

select elector_email from elector

drop table if exists elector_address
	create table elector_address(
	elector_id int not null,
	elector_street varchar(50),
	elector_address varchar(50),
	CONSTRAINT pk_elector_add PRIMARY KEY(elector_id,elector_street),
	CONSTRAINT fk_elector_id FOREIGN KEY (elector_id)
	REFERENCES elector(elector_id)
	 ON UPDATE CASCADE
	);


create table candidate(
candidate_id int not null unique,
candidate_first_name varchar(50),
candidate_last_name varchar(50),
candidate_profession varchar(50)
CONSTRAINT pk_candidate_id PRIMARY KEY(candidate_id)
);
alter table candidate 
add constraint check_id
check (candidate_id > 0)
ALTER TABLE candidate
ADD gender VARCHAR(10) DEFAULT 'Male';
use voting_sys


drop table if exists candidate_address
create table candidate_address(
candidate_id int not null,
candidate_street_name varchar(50),
candidate_city varchar(50),
constraint candidate_address_pk primary key(candidate_id,candidate_street_name),
CONSTRAINT FKvote_candidate_id FOREIGN KEY (candidate_id)
        REFERENCES candidate(candidate_id)
		 ON UPDATE CASCADE
);
drop table if exists vote
CREATE TABLE vote (
    elector_id INT NOT NULL,
    candidate_id INT NOT NULL,
    times_voted INT,
    date_of_vote DATE,
	CONSTRAINT PK_vote_id PRIMARY KEY (elector_id, candidate_id),
    CONSTRAINT fk_vote_elector_id FOREIGN KEY (elector_id)
        REFERENCES elector(elector_id),
    CONSTRAINT fk_vote_candidate_id FOREIGN KEY (candidate_id)
        REFERENCES candidate(candidate_id)
		ON UPDATE CASCADE 
);

drop table if exists candidate_contact
create table candidate_contact(
candidate_id int not null,
candidate_number int not null,
CONSTRAINT PK_candidate_contact primary key(candidate_id , candidate_number),
CONSTRAINT fk_contact_candidate_id FOREIGN KEY (candidate_id)
REFERENCES candidate(candidate_id)
ON UPDATE CASCADE
);
drop table if exists comittee
create table committee(
committee_id int not null unique,
comittee_name varchar(50),
constraint committee_id primary key (committee_id)
);

CREATE TABLE committee_members (
    mem_id INT NOT NULL UNIQUE,
    mem_first_name VARCHAR(50),
    mem_last_name VARCHAR(50),
    mem_number INT NOT NULL,
    mem_email VARCHAR(50),
    CONSTRAINT pk_mem_id PRIMARY KEY (mem_id)
);

 drop table if exists mem_address
CREATE TABLE mem_address (
mem_id INT NOT NULL,
mem_street_name VARCHAR(50),
mem_city VARCHAR(50),
CONSTRAINT fk_mem_address_mem_id FOREIGN KEY (mem_id)
REFERENCES committee_members(mem_id)
 ON UPDATE CASCADE
);

drop table if exists supervisor 
create table supervisor(
mem_id int not null,
committee_id int not null,
candidate_id int not null,
role varchar(40),

constraint pk_supervisor_id primary key(mem_id,committee_id,candidate_id),

constraint fk_mem_id foreign key (mem_id)
references committee_members(mem_id)
ON UPDATE CASCADE,

constraint fk_cand_id foreign key (candidate_id)
references candidate(candidate_id)
ON UPDATE CASCADE
,

constraint fk_comm_id foreign key (committee_id)
references committee(committee_id)
ON UPDATE CASCADE 

);
ALTER TABLE supervisor
ADD CONSTRAINT DF_Supervisor_Role DEFAULT 'integrity instructor' FOR role;


select * from supervisor
ALTER TABLE candidate_contact
ADD CONSTRAINT PKcandidate_id PRIMARY KEY (candidate_id);

ALTER TABLE supervisor
ADD CONSTRAINT PKsupervisor_id PRIMARY KEY (mem_id,candidate_id,committee_id);

ALTER TABLE candidate_address
ADD CONSTRAINT pkkcandidate_id PRIMARY KEY (candidate_id);

ALTER TABLE candidate
ADD CONSTRAINT candidate_id PRIMARY KEY (candidate_id);

ALTER TABLE vote
ADD CONSTRAINT pk_vote PRIMARY KEY (candidate_id,elector_id)
use voting_sys
select * from sys.tables




ALTER TABLE supervisor
DROP CONSTRAINT fk_comm_id;


CREATE VIEW e_view as
SELECT 
    e.elector_first_name + ' ' + e.elector_last_name AS 'name', e.elector_id, c.candidate_first_name + ' ' + c.candidate_last_name AS 'candidate name',
    c.candidate_id,v.times_voted
FROM vote v
JOIN elector e
ON v.elector_id = e.elector_id
JOIN candidate c
ON v.candidate_id = c.candidate_id


CREATE VIEW c_view AS
SELECT c.candidate_first_name + ' ' + c.candidate_last_name as 'name', c.candidate_id,
m.mem_first_name +' ' + m.mem_last_name as 'supervisor name', m.mem_id,s.role,
com.committee_id,com.comittee_name

FROM supervisor s
join candidate c
on s.candidate_id = c.candidate_id
join committee_members m
on s.mem_id = m.mem_id
join committee com
on s.committee_id = com.committee_id



select * from e_view

select * from c_view

CREATE PROCEDURE get_e_info
AS
SELECT 
    e.elector_first_name + ' ' + e.elector_last_name AS 'name', e.elector_id, c.candidate_first_name + ' ' + c.candidate_last_name AS 'candidate name',
    c.candidate_id,v.times_voted
FROM vote v
JOIN elector e
ON v.elector_id = e.elector_id
JOIN candidate c
ON v.candidate_id = c.candidate_id


CREATE PROCEDURE get_c_info as
SELECT c.candidate_first_name + ' ' + c.candidate_last_name as 'name', c.candidate_id,
m.mem_first_name +' ' + m.mem_last_name as 'supervisor name', m.mem_id,s.role,
com.committee_id,com.comittee_name

FROM supervisor s
join candidate c
on s.candidate_id = c.candidate_id
join committee_members m
on s.mem_id = m.mem_id
join committee com
on s.committee_id = com.committee_id




exec get_e_info

INSERT INTO elector (elector_id, elector_first_name, elector_last_name, elector_email, date)
VALUES 
(1, 'John', 'Doe', 'johndoe@example.com', '2024-01-01'),
(2, 'Jane', 'Smith', 'janesmith@example.com', '2024-01-02'),
(3, 'Michael', 'Johnson', 'michaelj@example.com', '2024-01-03'),
(4, 'Emily', 'Davis', 'emilyd@example.com', '2024-01-04'),
(5, 'David', 'Brown', 'davidb@example.com', '2024-01-05'),
(6, 'Sarah', 'Miller', 'sarahm@example.com', '2024-01-06'),
(7, 'James', 'Wilson', 'jamesw@example.com', '2024-01-07'),
(8, 'Olivia', 'Moore', 'oliviam@example.com', '2024-01-08'),
(9, 'Daniel', 'Taylor', 'danielt@example.com', '2024-01-09'),
(10, 'Sophia', 'Anderson', 'sophiaa@example.com', '2024-01-10'),
(11, 'Lucas', 'Thomas', 'lucast@example.com', '2024-01-11'),
(12, 'Ava', 'Jackson', 'avaj@example.com', '2024-01-12'),
(13, 'Liam', 'White', 'liamw@example.com', '2024-01-13'),
(14, 'Mia', 'Harris', 'miah@example.com', '2024-01-14'),
(15, 'Ethan', 'Martin', 'ethanm@example.com', '2024-01-15');


INSERT INTO elector_address (elector_id, elector_street, elector_address)
VALUES
(1, '123 Elm St', 'Apt 4B'),
(2, '456 Oak St', 'Apt 12A'),
(3, '789 Maple St', 'House 5'),
(4, '321 Pine St', 'Suite 100'),
(5, '654 Cedar St', 'Apt 2C'),
(6, '987 Birch St', 'Apt 10D'),
(7, '159 Spruce St', 'House 3'),
(8, '753 Walnut St', 'Apt 8A'),
(9, '258 Cherry St', 'House 7'),
(10, '147 Palm St', 'Apt 14C'),
(11, '369 Redwood St', 'Apt 9B'),
(12, '951 Aspen St', 'House 12'),
(13, '753 Fir St', 'Apt 2A'),
(14, '852 Poplar St', 'Apt 3B'),
(15, '159 Willow St', 'House 1'),
(15, '157 Willow St', 'House 2'),
(12, '158 Willow St', 'House 3');


INSERT INTO candidate (candidate_id, candidate_first_name, candidate_last_name, candidate_profession) VALUES
(1, 'John', 'Legend', 'Singer'),
(2, 'Scarlett', 'Johansson', 'Actor'),
(3, 'Steven', 'Spielberg', 'Director'),
(4, 'Ariana', 'Grande', 'Pop Star'),
(5, 'LeBron', 'James', 'Athlete'),
(6, 'Gordon', 'Ramsay', 'Chef'),
(7, 'Elon', 'Musk', 'Entrepreneur');
select * from candidate
INSERT INTO candidate (candidate_id, candidate_first_name, candidate_last_name, candidate_profession) VALUES
(189, 'Joan', 'Legend', 'Singer');

INSERT INTO candidate_address (candidate_id, candidate_street_name, candidate_city) VALUES
(1, 'Hollywood Blvd', 'Los Angeles'),
(2, 'Broadway', 'New York City'),
(3, 'Rodeo Drive', 'Beverly Hills'),
(4, 'Sunset Boulevard', 'Los Angeles'),
(5, '5th Avenue', 'New York City'),
(6, 'Park Lane', 'London'),
(7, 'Palm Jumeirah', 'Dubai'),
(5, 'Champs-Élysées', 'Paris'),
(4, 'Bond Street', 'London'),
(3, 'Ocean Drive', 'Miami');

INSERT INTO vote (elector_id, candidate_id, times_voted, date_of_vote) VALUES
(1, 1, 1, '2024-08-01'),
(2, 2, 1, '2024-08-02'),
(3, 3, 1, '2024-08-03'),
(4, 4, 1, '2024-08-04'),
(5, 5, 1, '2024-08-05'),
(6, 6, 1, '2024-08-06'),
(7, 7, 1, '2024-08-07'),
(8, 1, 1, '2024-08-08'),
(9, 2, 1, '2024-08-09'),
(10, 3, 1, '2024-08-10'),
(11, 4, 1, '2024-08-11'),
(12, 5, 1, '2024-08-12'),
(13, 6, 1, '2024-08-13'),
(14, 7, 1, '2024-08-14'),
(15, 1, 1, '2024-08-15'),
(1, 2, 2, '2024-08-16'),
(2, 3, 2, '2024-08-17'),
(3, 4, 2, '2024-08-18'),
(4, 5, 2, '2024-08-19'),
(5, 6, 2, '2024-08-20'),
(6, 7, 2, '2024-08-21'),
(7, 1, 2, '2024-08-22'),
(8, 3, 2, '2024-08-23'),
(9, 5, 2, '2024-08-24'),
(10, 7, 2, '2024-08-25');

INSERT INTO candidate_contact (candidate_id, candidate_number) VALUES
(1, 12345678),
(2, 23456789),
(3, 34567890),
(4, 45678901),
(5, 56789012),
(6, 67890123),
(7, 78901234);


INSERT INTO comittee (committee_id, comittee_name) VALUES
(1, 'Election Committee'),
(2, 'Fundraising Committee');

INSERT INTO committee_members (mem_id, mem_first_name, mem_last_name, mem_number, mem_email)
VALUES
(1, 'Alice', 'Johnson', 11122334, 'alice.johnson@example.com'),
(2, 'Bob', 'Smith', 11122374, 'bob.smith@example.com'),
(3, 'Carol', 'Williams', 11182334, 'carol.williams@example.com'),
(4, 'David', 'Brown', 11122344, 'david.brown@example.com'),
(5, 'Eve', 'Davis', 11122324, 'eve.davis@example.com'),
(6, 'Frank', 'Wilson', 22239445, 'frank.wilson@example.com'),
(7, 'Grace', 'Taylor', 22236445, 'grace.taylor@example.com'),
(8, 'Hannah', 'Moore', 22238445, 'hannah.moore@example.com'),
(9, 'Ian', 'Anderson', 22231445, 'ian.anderson@example.com'),
(10, 'Judy', 'Thomas', 22230445, 'judy.thomas@example.com'),
(11, 'adam','thompson',98767848,'adam.thompson@example.com');


INSERT INTO mem_address (mem_id, mem_street_name, mem_city)
VALUES
(1, '123 Elm Street', 'Springfield'),
(2, '456 Oak Avenue', 'Greenville'),
(3, '789 Pine Road', 'Fairview'),
(4, '101 Maple Lane', 'Riverside'),
(5, '202 Birch Boulevard', 'Lakeside'),
(6, '303 Cedar Street', 'Woodland'),
(7, '404 Willow Drive', 'Hilltown'),
(8, '505 Ash Circle', 'Meadowbrook'),
(9, '606 Spruce Way', 'Elmwood'),
(10, '707 Fir Place', 'Hillside'),
(1, '808 Redwood Court', 'Brookfield');


INSERT INTO supervisor (mem_id, committee_id, candidate_id, role) VALUES
(1, 1, 1, 'Chairperson'),
(2, 1, 2, 'Coordinator'),
(3, 1, 3, 'Assistant'),
(4, 1, 4, 'Advisor'),
(5, 1, 5, 'Secretary'),
(6, 2, 6, 'Chairperson'),
(7, 2, 7, 'Coordinator'),
(8, 2, 2, 'Assistant'),
(9, 2, 3, 'Advisor'),
(10, 2, 5, 'Secretary');

select * from elector_address
select * from elector
select * from candidate
select * from candidate_address
select * from candidate_contact
select * from committee_members
select * from mem_address
select * from supervisor
select * from vote

use voting_sys

select * from elector_address
where elector_id = 12


select * from elector


select elector_first_name  + ' ' + elector_last_name as 'Elector name'
from elector
where elector_id = 1

create login elector
with password = '123456789'

create user elec1
for login elector
GRANT SELECT ON e_view TO elec1


create login candidate
with password = '12345678'

create user cand1
for login candidate
GRANT SELECT ON c_view TO cand1
grant select on candidate to cand1
grant select on candidate_contact to cand1
grant select on candidate_address to cand1



ALTER TABLE elector
ADD CONSTRAINT elector_email UNIQUE (elector_email);

INSERT INTO elector (elector_id, elector_first_name, elector_last_name, elector_email, date)
VALUES 
(16, 'Miar', 'Harry', 'miam@example.com', null);




select * from elector

BACKUP DATABASE voting_sys
TO  DISK = 'C:\backup\voting_sys.bak'
WITH INIT,
NAME = 'voting_sys full';

RESTORE HEADERONLY   
FROM DISK ='C:\backup\voting_sys.bak';

BACKUP DATABASE voting_sys
TO  DISK = 'C:\backup\voting_sys.bak'
WITH differential;

INSERT INTO committee_members (mem_id, mem_first_name, mem_last_name, mem_number, mem_email)
VALUES
(289, 'Alec', 'benjamin', 11122976, 'alec.benjamin@example.com');

RESTORE DATABASE voting_sys
FROM  DISK = N'C:\backup\voting_sys.bak'
WITH FILE = 1;


BACKUP DATABASE voting_sys
TO  DISK = 'C:\backup\voting_sys.bak'
WITH NOINIT,
NAME = 'voting_sys full';


create login admin1 
with password = '1234567'
create user admin2
for admin1
grant select ,update, delete , insert on elector to admin2
grant select ,update, delete, insert on elector_address to admin2
grant select ,update, delete, insert on candidate to admin2

SELECT * FROM elector_address WHERE elector_id = 1;

insert into elector_address
values (100,'ali street','hasn safi apartment');

select * from elector_address

select * from sys.tables
 select * from candidate_address


 update elector
 set elector_id= 314
 where elector_id = 1

 select * from candidate