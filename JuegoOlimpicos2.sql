2. Top 5 de ranking de atletas con mas medallas (hasta el ranking 5)


with t1 as 
(select name,COUNT(1) as total_medals
from OlympicsKaggle..athlete_events$
where Medal= 'Gold'
group by name),
t2 as	
(select *, dense_rank() over(order by total_medals desc) as rnk   --el dense rank ayuda a mostrar los resultados de rank sin saltarse los numeros.
from t1)
select *
from t2
where rnk <=5;
