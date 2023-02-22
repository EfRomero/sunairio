-- Find the warmest and coldest hour in Texaas in December 2022 along with lat and lon coordinates 

--Answer:
--datetime					|	latitude			|	longitude			|	t2m					| 	record_type
--2022-12-13 21:00:00.000	|	26.591000000000000	|	-100.147500000000120|	32.125390625000020	|	warmest
--2022-12-23 08:00:00.000	|	36.091000000000000	|	-93.647000000000000	|	-20.624288940429665	|	coldest

with warmest as
(
select
	datetime,
	latitude,
	longitude,
	t2m,
	'warmest' as record_type
from texas_t2m 
order by t2m desc
limit 1
)
, coldest as 
(
select
	datetime,
	latitude,
	longitude,
	t2m,
	'coldest' as record_type
from texas_t2m 
order by t2m asc
limit 1
)
select *
from warmest
union all
select *
from coldest




