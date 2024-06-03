UPDATE F23_S003_T2_Stadium SET seatcapacity = 300 where StadiumId = 3;

UPDATE F23_S003_T2_Stadium SET seatcapacity = 350 where StadiumId = 4;

UPDATE F23_S003_T2_PLAYERS SET runs= 420 where ID = 1;

UPDATE F23_S003_T2_Match set tickets_sold=300 where matchid=3;

UPDATE F23_S003_T2_Players set wickets = 11 where id = 13;

UPDATE F23_S003_T2_PLAYERS SET role = batsman where playerid = 8;

Delete from F23_S003_T2_Fans where Age<18;
