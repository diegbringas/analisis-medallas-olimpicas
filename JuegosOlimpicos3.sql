SELECT country, 
       ISNULL([Gold], 0) AS gold, 
       ISNULL([Silver], 0) AS silver, 
       ISNULL([Bronze], 0) AS bronze
INTO tablefunc
FROM (
    SELECT nr.region AS country, 
           Medal, 
           COUNT(1) AS total_medals
    FROM OlympicsKaggle..athlete_events$ oh
    JOIN OlympicsKaggle..noc_regions$ nr 
        ON nr.NOC = oh.NOC
    WHERE Medal IN ('Gold', 'Silver', 'Bronze')  -- Filtramos solo medallas de oro, plata y bronce
    GROUP BY nr.region, Medal
) AS source
PIVOT (
    SUM(total_medals)  -- Agregamos la suma de las medallas
    FOR Medal IN ([Gold], [Silver], [Bronze])  -- Convertimos las medallas en columnas
) AS pvt
ORDER BY country;

SELECT*
from tablefunc
ORDER BY gold desc, silver desc, bronze desc;;