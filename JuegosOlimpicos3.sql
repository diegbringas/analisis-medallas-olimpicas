3. Averiguar el total de medallas de oro, plata y bronce ganado por cada pais en las Olimpiadas.

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
    WHERE Medal IN ('Gold', 'Silver', 'Bronze')  
    GROUP BY nr.region, Medal
) AS source
       
PIVOT (
    SUM(total_medals)  
    FOR Medal IN ([Gold], [Silver], [Bronze])  
) AS pvt
ORDER BY country;

SELECT*
from tablefunc
ORDER BY gold desc, silver desc, bronze desc;;
