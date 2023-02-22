
create or replace function texas_2m_time_series (lat float, lon float)
returns table (
	datetime timestamp,
	t2m float
)
as 
$$
begin
return query

select t.datetime as dt, t.t2m
from txdec2022 as t
where longitude = (select longitude from txdec2022 t order by abs(longitude - lon) limit 1)
	and latitude = (select latitude from txdec2022 t order by abs(latitude - lat) limit 1)
order by 1;
end;
$$
language 'plpgsql';

