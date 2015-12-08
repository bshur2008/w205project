CREATE DATABASE IF NOT EXISTS raw ;

DROP TABLE IF EXISTS raw.wikipedia ;

CREATE EXTERNAL TABLE IF NOT EXISTS raw.wikipedia
(
    xml string 
)
LOCATION  '/user/w205/wp';

CREATE DATABASE IF NOT EXISTS stg ;

--DROP TABLE IF EXISTS stg.wikipedia ;

CREATE TABLE IF NOT EXISTS stg.wikipedia
(
    language string
    , text string
)
STORED AS ORC 
;

