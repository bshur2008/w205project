CREATE DATABASE raw ;

DROP TABLE IF EXISTS raw.tweets ;

CREATE EXTERNAL TABLE raw.tweets
(
    filter_used string
    , language string
    , json string 
)
FIELDS TERMINATED BY '~'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE
LOCATION  '/home/w205/tweets';
