-- Eliminar la tabla si ya existe
IF OBJECT_ID('tablefunc', 'U') IS NOT NULL
    DROP TABLE tablefunc;

-- Crear la tabla 'tablefunc' y llenarla con los datos
SELECT 
    -- Extraer el nombre del juego (antes del guion '-')
    CASE 
        WHEN CHARINDEX('-', games_country) > 0 
        THEN SUBSTRING(games_country, 1, CHARINDEX('-', games_country) - 1)
        ELSE games_country  -- Si no existe el guion, devuelve el valor completo (como juego)
    END AS games, 

    -- Extraer el país (después del guion '-')
    CASE 
        WHEN CHARINDEX('-', games_country) > 0 
        THEN SUBSTRING(games_country, CHARINDEX('-', games_country) + 1, LEN(games_country)) 
        ELSE NULL  -- Si no existe el guion, asigna NULL a la columna de país
    END AS country, 

    -- Contar medallas de oro, plata y bronce
    ISNULL([Gold], 0) AS gold, 
    ISNULL([Silver], 0) AS silver, 
    ISNULL([Bronze], 0) AS bronze
INTO tablefunc
FROM (
    SELECT 
        CONCAT(games, '-', nr.region) AS games_country,  -- Concatenación de juegos y país
        Medal, 
        COUNT(1) AS total_medals
    FROM OlympicsKaggle..athlete_events$ oh
    JOIN OlympicsKaggle..noc_regions$ nr 
        ON nr.NOC = oh.NOC
    WHERE Medal IN ('Gold', 'Silver', 'Bronze')  -- Filtramos solo medallas de oro, plata y bronce
    GROUP BY games, nr.region, Medal
) AS source
PIVOT (
    SUM(total_medals)  -- Agregamos la suma de las medallas
    FOR Medal IN ([Gold], [Silver], [Bronze])  -- Convertimos las medallas en columnas
) AS pvt
ORDER BY games_country;  

-- Consulta final para obtener el país con más medallas de oro por cada juego
SELECT DISTINCT 
    games,
    CONCAT(
        FIRST_VALUE(country) OVER (PARTITION BY games ORDER BY gold DESC), 
        ' - ', 
        FIRST_VALUE(gold) OVER (PARTITION BY games ORDER BY gold DESC)
    ) AS gold ,
	 CONCAT(
        FIRST_VALUE(country) OVER (PARTITION BY games ORDER BY silver DESC), 
        ' - ', 
        FIRST_VALUE(silver) OVER (PARTITION BY games ORDER BY silver DESC)
    ) AS silver ,
	 CONCAT(
        FIRST_VALUE(country) OVER (PARTITION BY games ORDER BY bronze DESC), 
        ' - ', 
        FIRST_VALUE(bronze) OVER (PARTITION BY games ORDER BY bronze DESC)
    ) AS gold
FROM tablefunc
ORDER BY games;
