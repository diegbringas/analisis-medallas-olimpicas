<<<<<<< HEAD
2. Top 5 de ranking de atletas con mas medallas (hasta el ranking 5)


with t1 as 
(select name,COUNT(1) as total_medals
from OlympicsKaggle..athlete_events$
where Medal= 'Gold'
group by name),
t2 as	
(select *, dense_rank() over(order by total_medals desc) as rnk
from t1)
select *
from t2
where rnk <=5;
=======
SELECT * 
FROM OlympicsKaggle..athlete_events$;

1. encontrar el numero total de juegos en las olimpiadas
2. encontrar para cada deporte, cuantos juegos hubieron
3. COMPARAR AMBOS, DEFINIR CUAL FUE EL DEPORTE 
QUE SE JUGO EN TODAS LAS OLIMPIADAS DE VERANO.

WITH t1 AS (
    SELECT COUNT(DISTINCT Games) AS TotalSummerGames
    FROM OlympicsKaggle..athlete_events$
    WHERE Season = 'Summer'
),
t2 AS (
    SELECT Sport, COUNT(DISTINCT Games) AS TotalGamesPerSport
    FROM OlympicsKaggle..athlete_events$
    WHERE Season = 'Summer'
    GROUP BY Sport
)
SELECT 
    t1.TotalSummerGames,
    t2.Sport,
    t2.TotalGamesPerSport
FROM t1
JOIN t2 ON t1.TotalSummerGames = t2.TotalGamesPerSport;





>>>>>>> b6e5643126193c4321129c4809141be2de8b3c1d
