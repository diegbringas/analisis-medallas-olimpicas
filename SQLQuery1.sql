--1. Averiguar que deportes fueron jugados siempre en las Olimpiadas de verano
SELECT * 
FROM OlympicsKaggle..athlete_events$;
--1. encontrar el numero total de juegos en las olimpiadas
WITH t1 AS (
    SELECT COUNT(DISTINCT Games) AS TotalSummerGames
    FROM OlympicsKaggle..athlete_events$
    WHERE Season = 'Summer'
)
,
--2. encontrar el numero total de participacione en Olympics
t2 AS (
    SELECT Sport, COUNT(DISTINCT Games) AS TotalOlympicsPerSport
    FROM OlympicsKaggle..athlete_events$
    WHERE Season = 'Summer'
    GROUP BY Sport
)
--3. Comparar resultados y ver que deportes cumplen la premisa
SELECT 
    t2.Sport,
	t1.TotalSummerGames,
    t2.TotalOlympicsPerSport
FROM t1
JOIN t2 ON t1.TotalSummerGames = t2.TotalOlympicsPerSport;





