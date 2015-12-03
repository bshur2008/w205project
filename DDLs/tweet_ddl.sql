CREATE DATABASE IF NOT EXISTS raw ;

DROP TABLE IF EXISTS raw.tweets ;

CREATE EXTERNAL TABLE raw.tweets
(
    json string 
)
LOCATION  '/user/w205/tweets';

CREATE DATABASE IF NOT EXISTS stg ;

DROP TABLE IF EXISTS stg.tweets ;

CREATE TABLE stg.tweets 
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
STORED AS ORC 
;

CREATE DATABASE IF NOT EXISTS prd;

DROP TABLE IF EXISTS prd.tweet_log ;
CREATE TABLE prd.tweet_log 
(
    tweet_id bigint
    , user_id bigint 
    , words_id bigint
    , dttm_event timestamp
    , language string
    , cnt_retweets bigint
    , cnt_favorites bigint
    , cnt_tweets bigint 
)
STORED AS ORC
;

DROP TABLE IF EXISTS prd.tweet_users ;
CREATE TABLE prd.tweet_users
(
    user_id bigint
    , user_screen_name string
    , user_name string
    , user_location string
)
STORED AS ORC
;

DROP TABLE IF EXISTS prd.tweet_words ;
CREATE TABLE prd.tweet_words  
(
    words_id bigint
    , language string
    , dt_event date
    , word string
)
STORED AS ORC
;

