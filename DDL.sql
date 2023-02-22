-- Use precise numeric data type to avoid non-deterministic shenanigans
-- related to floating points
create table if not exists texas_t2m (
	datetime Timestamp,
	latitude numeric(20, 15),
	longitude numeric(20, 15),
	t2m numeric(20, 15)
);


-- Return unbounded time series of Texas t2m data based on lat lon of nearest
-- coordinates provided as arguments
create or replace function texas_2m_time_series (lat numeric(20,15), lon numeric(20,15))
returns table (
	datetime timestamp,
	t2m numeric(20,15)
)
as 
$$
begin
return query

select t.datetime as dt, t.t2m
from texas_t2m as t
-- Predicate based on nearest lat and lon to given arguments
where longitude = (select longitude from texas_t2m t order by abs(longitude - lon) limit 1)
	and latitude = (select latitude from texas_t2m t order by abs(latitude - lat) limit 1)
order by 1;
end;
$$
language 'plpgsql';


-- Stored procedure to delete monthly data from texas_t2m to allow reloads
create or replace procedure delete_monthly_t2m( 
	year_param int,
	month_param int
)
language plpgsql
as $$
begin 
	
	delete from texas_t2m
	where date_part('Year', datetime) = year_param
		and date_part('Month', datetime) = month_param;
		
end; $$
