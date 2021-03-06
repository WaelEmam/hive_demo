drop database if exists stg_airline cascade;
create database stg_airline;
use stg_airline;

DROP TABLE IF EXISTS stg_airline.onTimePerf;

create external table stg_airline.onTimePerf
(Year INT ,
Month INT ,
DayofMonth INT ,
DayOfWeek INT ,
DepTime INT ,
CRSDepTime INT ,
ArrTime INT ,
CRSArrTime INT ,
UniqueCarrier STRING ,
FlightNum INT ,
TailNum STRING ,
ActualElapsedTime INT ,
CRSElapsedTime INT ,
AirTime STRING ,
ArrDelay INT ,
DepDelay INT ,
Origin STRING ,
Dest STRING ,
Distance INT ,
TaxiIn STRING ,
TaxiOut STRING ,
Cancelled INT ,
CancellationCode STRING ,
Diverted INT ,
CarrierDelay STRING ,
WeatherDelay STRING ,
NASDelay STRING ,
SecurityDelay STRING ,
LateAircraftDelay STRING)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE
LOCATION '/user/erwin/stg_airline/onTimePerf';

drop database if exists airline cascade;

create database airline;
use airline;

DROP TABLE IF EXISTS airline.onTimePerf;

create table airline.onTimePerf
(DayofMonth INT ,
DayOfWeek INT ,
DepTime INT ,
CRSDepTime INT ,
ArrTime INT ,
CRSArrTime INT ,
UniqueCarrier STRING ,
FlightNum INT ,
TailNum STRING ,
ActualElapsedTime INT ,
CRSElapsedTime INT ,
AirTime STRING ,
ArrDelay INT ,
DepDelay INT ,
Origin STRING ,
Dest STRING ,
Distance INT ,
TaxiIn STRING ,
TaxiOut STRING ,
Cancelled INT ,
CancellationCode STRING ,
Diverted INT ,
CarrierDelay STRING ,
WeatherDelay STRING ,
NASDelay STRING ,
SecurityDelay STRING ,
LateAircraftDelay STRING)
PARTITIONED BY (Year INT, Month INT )
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' 
STORED AS TEXTFILE;

SET hive.exec.dynamic.partition = true;

SET hive.exec.dynamic.partition.mode = nonstrict;

INSERT OVERWRITE TABLE airline.onTimePerf PARTITION(Year, Month) SELECT DayofMonth, DayOfWeek, DepTime, CRSDepTime, ArrTime, CRSArrTime, UniqueCarrier, FlightNum, TailNum, ActualElapsedTime, CRSElapsedTime, AirTime, ArrDelay, DepDelay, Origin, Dest, Distance, TaxiIn, TaxiOut, Cancelled, CancellationCode, Diverted, CarrierDelay, WeatherDelay, NASDelay, SecurityDelay, LateAircraftDelay, Year, Month FROM stg_airline.onTimePerf;
