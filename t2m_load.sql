create table TXDec2022 (
	datetime Timestamp,
	latitude float,
	longitude float,
	t2m float
);

--insert into TXDec2022 (datetime, latitude, longitude, t2m) 
--values ('2019-02-17T01:00', 1.1, 2.2, 3);

truncate table txdec2022 ;

select *
from txdec2022 t 


COPY txdec2022(datetime, latitude, longitude, t2m)
FROM '/home/ef/Documents/sunairio/t2m-texas-dec-2022.csv'
DELIMITER ','
CSV HEADER;


with warmest as
(
select
	datetime,
	latitude,
	longitude,
	t2m,
	'warmest' as record_type
from txdec2022 t 
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
from txdec2022 t 
order by t2m asc
limit 1
)
select *
from warmest
union all
select *
from coldest



select *
from txdec2022 t 
where t2m > 32
