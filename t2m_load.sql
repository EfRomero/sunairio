create table TXDec2022 (
	datetime Timestamp,
	latitude float,
	longitude float,
	t2m float
);

--insert into TXDec2022 (datetime, latitude, longitude, t2m) 
--values ('2019-02-17T01:00', 1.1, 2.2, 3);


select *
from txdec2022 t 


COPY txdec2022(datetime, latitude, longitude, t2m)
FROM '/home/ef/Documents/sunairio/t2m-texas-dec-2022.csv'
DELIMITER ','
CSV HEADER;