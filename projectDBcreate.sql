create table F23_S003_T2_Teams(
TeamID number primary key not null,
TName varchar2(50) not null,
Captain varchar2(50) not null);

create table F23_S003_T2_Players(
Id number primary key not null, 
Runs number, 
Wickets number, 
PName varchar2(50) not null ,
DOB Date not null,
Role varchar2(50) not null, 
TeamID number not null,
CONSTRAINT Players_TeamID_FK FOREIGN KEY (TeamID) REFERENCES F23_S003_T2_Teams (TeamID));

create table F23_S003_T2_Stadium(
StadiumId number primary key not null, 
Sname varchar2(50) not null,
Seatcapacity number not null);

Create table F23_S003_T2_Match(
MatchId number primary key not null, 
Date_time Timestamp(0) not null,
Team1 varchar2(50) not null,
Team2 varchar2(50) not null,
Winner varchar2(50) not null,
Tickets_sold number, 
StadiumId number not null, 
Mlocation varchar(50)not null,
constraint StadiumId_FK foreign key(StadiumId)references F23_S003_T2_Stadium (StadiumId));

create table F23_S003_T2_Fans(
Seatnum number primary key not null,
Age number,
FName varchar(50) not null);

create table F23_S003_T2_Involves(
Id number not null, 
MatchId number not null, 
constraint Player_Match_Details primary key (Id, MatchId),
constraint Player_Match_FK foreign key(Id) references F23_S003_T2_Players (Id),
constraint Player_Match_FK1 foreign key(MatchId) references F23_S003_T2_Match (MatchId));


create table F23_S003_T2_Supports(
seatnum number not null, 
teamid number not null,
constraint Fans_support_details primary key (seatnum, teamid),
constraint seatnum_support_fk foreign key(seatnum) references F23_S003_T2_Fans(seatnum) on delete cascade,
constraint teamid_fk foreign key(TeamId) references F23_S003_T2_Teams(TeamId));

create table F23_S003_T2_Fans_email(
seatnum number not null, 
email varchar2(50) not null, 
constraint Seatnum_email primary key(seatnum,email),
constraint seatnum_fk foreign key(seatnum) references F23_S003_T2_Fans(seatnum) on delete cascade);

create table F23_S003_T2_Fans_TicketPrice(
Seatnum number primary key not null, 
ticket_price number not null,
constraint seatnum_ticketprice_fk foreign key(seatnum) references F23_S003_T2_Fans(seatnum) on delete cascade);

create table F23_S003_T2_Fans_Entering(
Seatnum number not null, 
MatchId number not null, 
constraint Fans_Watching_Match Primary key(seatnum,MatchId),
constraint Seatnum_fk1 foreign key (Seatnum) references F23_S003_T2_Fans(seatnum) on delete cascade,
constraint Matchid_fk foreign key (MatchId) references F23_S003_T2_Match(MatchId));




