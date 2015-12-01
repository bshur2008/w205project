DROP DATABASE IF EXISTS raw ;
CREATE DATABASE raw ;

DROP TABLE IF EXISTS raw.tweets ;

CREATE EXTERNAL TABLE raw.tweets
(
    filter_used string
    , language string
    , json string 
)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '~'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION  '/user/w205/tweets';
