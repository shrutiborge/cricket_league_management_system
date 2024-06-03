---Query 1: At which stadium does the seating reach full capacity during games involving which teams?
SELECT S.SName, M.Team1, M.Team2
FROM F23_S003_T2_Match M, F23_S003_T2_Stadium S
where M.StadiumId=S.StadiumId and M.tickets_sold=S.seatcapacity
group by S.SName, M.Team1, M.team2;

---Query Question 2: Find which team has scored more than 2000 runs, in the league.
SELECT T.TeamID, T.TName, SUM(P.Runs) AS TotalRuns
FROM F23_S003_T2_Teams T
JOIN F23_S003_T2_Players P ON T.TeamID = P.TeamID
GROUP BY T.TeamID, T.TName
having SUM(P.Runs)>2000
order by TotalRuns desc;

---Query 3: Retrieve the top 3 teams with the highest fanbase
SELECT T.TeamID, T.TName, Count(F.Seatnum) AS No_of_Fans
FROM F23_S003_T2_Teams T
JOIN F23_S003_T2_Supports S ON T.TeamID = S.TeamID
JOIN F23_S003_T2_Fans F ON S.Seatnum = F.Seatnum
GROUP BY T.TeamID, T.TName
ORDER BY No_of_Fans DESC
FETCH FIRST 3 ROWS ONLY;

---Query 4: Provide a summary of the total ticket sales per team, including subtotals
SELECT T.TeamID, T.TName, SUM(M.Tickets_sold) AS TotalTickets
FROM F23_S003_T2_Teams T
JOIN F23_S003_T2_Match M ON T.TName = M.Team1 OR T.TName = M.Team2
GROUP BY CUBE(T.TeamID, T.TName)
order by T.Teamid;

--Division query 5: Find out the fans who are attending all the matches
Select Seatnum, Fname from F23_S003_T2_Fans where Seatnum in(
SELECT Seatnum 
FROM F23_S003_T2_Fans
MINUS
SELECT F.Seatnum
FROM F23_S003_T2_Fans_Entering F
WHERE  EXISTS (
    SELECT DISTINCT MatchId
    FROM F23_S003_T2_Match M
    WHERE NOT EXISTS (
        SELECT 1
        FROM F23_S003_T2_Fans_Entering FE
        WHERE FE.Seatnum = F.Seatnum AND FE.MatchId = M.MatchId)
));

---Query 6: Using Over clause: Find out the average number of wickets within each team. 
SELECT P.Pname, T.Teamid, P.Wickets, T.Tname,
  ROUND(AVG(P.Wickets) OVER (PARTITION BY P.TeamID), 2) AS Avg_wickets_per_team
FROM F23_S003_T2_Players P, F23_S003_T2_teams T where P.Teamid= T.Teamid
order by T.Teamid;

--query 7:Identify the batsman or wicketkeeper with the highest run total in each team  and who has achieved a score exceeding 200
SELECT T.TeamID, T.TName, MAX(P.Runs) AS HighestRuns
FROM F23_S003_T2_Teams T
JOIN F23_S003_T2_Players P ON T.TeamID = P.TeamID
WHERE P.Role LIKE '%Batsman%' or P.role like '%Wicket-Keeper%'
GROUP BY T.TeamID, T.TName
Having MAX(P.Runs)>200
order by highestruns desc;

--query 8: Determine the age group of adults with over 100 attendance at matches.
--(Hint: We need to count the fan even if they are attending a single match)
SELECT F.Age, COUNT(FE.Seatnum) AS AttendanceCount
FROM F23_S003_T2_Fans F
JOIN F23_S003_T2_Fans_Entering FE ON F.Seatnum = FE.Seatnum
WHERE F.Age > 18
group by F.Age
having COUNT(FE.Seatnum)>100
order by AttendanceCount desc;

----Query 9:Generate a report showing the total number of tickets sold, subtotals by match location and stadium, and a grand total.
SELECT M.Mlocation,S.Sname AS StadiumName, M.MatchId,SUM(M.Tickets_sold) AS TotalTicketsSold
FROM F23_S003_T2_Match M
JOIN F23_S003_T2_Stadium S ON M.StadiumId = S.StadiumId
GROUP BY ROLLUP(M.Mlocation, S.Sname, M.MatchId)
order by TotalTicketsSold;

---Query 10: Find out the player who has taken the maximum wickets in the league.
Select Pname from F23_S003_T2_Players where wickets = (Select max(wickets) from F23_S003_T2_Players)
group by pname;

--Query 11:Find out the player who has scored the maximum runs in the league.
Select Pname from F23_S003_T2_Players where runs = (Select max(runs) from F23_S003_T2_Players)
group by pname;










