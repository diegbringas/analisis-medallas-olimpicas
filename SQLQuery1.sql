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





