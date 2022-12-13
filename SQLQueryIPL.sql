Select * From PortfolioProject..IplMatches$ order by 3, 4

Select * From PortfolioProject..IplBalls$ order by 3, 4

select yr,count(distinct id) number_of_matches from
(select year(date) yr,id from PortfolioProject..IplMatches$)a
group by yr

select * from
(select player_of_match,yr,mom,rank() over(partition by yr order by mom desc) rnk from
(
select player_of_match,year(date) yr,count(player_of_match) mom from PortfolioProject..IplMatches$
group by player_of_match,year(date) 
)a)b
where rnk=1

select top 5 venue,count(venue) 
 from PortfolioProject..IplMatches$ 
 group by venue
 order by count(venue) desc

 select sum(total_runs) from
 (
 select  batsman,sum(total_runs) total_runs from PortfolioProject..IplBalls$ group by batsman 
 )a;

 select *,total_runs/sum(total_runs) over(order by total_runs rows between unbounded preceding and unbounded following) runs from
 (select  batsman,sum(total_runs) total_runs from PortfolioProject..IplBalls$ group by batsman )a;

 select * from PortfolioProject..IplBalls$;

 select top 1 batsman,count(batsman) from
( select * from PortfolioProject..IplBalls$ where batsman_runs=4)a
group by batsman
order by count(batsman) desc;

select top 1 batsman,batsman_runs,strike_rate from 
(select batsman ,batsman_runs,((batsman_runs*1.0)/total_balls)*100 strike_rate from
(select  batsman,sum(batsman_runs) batsman_runs,count(batsman) total_balls  from PortfolioProject..IplBalls$ group by batsman )a)b
where batsman_runs>=3000 order by strike_rate desc

select * from PortfolioProject..IplBalls$;


select top 1 bowler,(total_runs_conceded/(total_balls*1.0)) economy_rate from
(select bowler,count(bowler) total_balls,sum(total_runs) total_runs_conceded
from PortfolioProject..IplBalls$
group by bowler)a
where total_balls>300
order by (total_runs_conceded/(total_balls*1.0))

select winner,count(winner) from PortfolioProject..IplMatches$ group by winner;