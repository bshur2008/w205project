CREATE DATABASE IF NOT EXISTS raw ;

--DROP TABLE IF EXISTS raw.tweets ;

CREATE EXTERNAL TABLE IF NOT EXISTS raw.es_tweets
(
    json string 
)
LOCATION  '/user/w205/tweets/es';

CREATE DATABASE IF NOT EXISTS stg ;

--DROP TABLE IF EXISTS stg.tweets ;

CREATE TABLE IF NOT EXISTS stg.tweets 
(
    language string
    , dt_event date
    , dttm_event timestamp
    , cnt_retweets bigint
    , cnt_favorites bigint
    , user_screen_name string
    , user_name string
    , user_location string
    , text string
)
PARTITIONED BY (day string)
STORED AS ORC 
;

CREATE DATABASE IF NOT EXISTS prd;

--DROP TABLE IF EXISTS prd.tweet_log ;
CREATE TABLE IF NOT EXISTS prd.tweet_log 
(
    tweet_id string
    , user_id string 
    , dttm_event timestamp
    , language string
    , cnt_retweets bigint
    , cnt_favorites bigint
    , cnt_tweets bigint 
)
STORED AS ORC
;

--DROP TABLE IF EXISTS prd.tweet_users ;
CREATE TABLE IF NOT EXISTS prd.tweet_users
(
    user_id string
    , user_screen_name string
    , user_name string
    , user_location string
)
STORED AS ORC
;

--DROP TABLE IF EXISTS prd.tweet_words ;
CREATE TABLE IF NOT EXISTS prd.tweet_words  
(
    tweet_id string
    , language string
    , dt_event date
    , words array<string>
)
STORED AS ORC
;

