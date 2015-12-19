--SET hive.exec.dynamic.partition = true;
--SET hive.exec.dynamic.partition.mode=nonstrict;
ADD FILE /project/ETLs/tweets_raw_mapper.py;

FROM (
FROM raw.es_tweets
SELECT TRANSFORM(es_tweets.json)
USING 'python tweets_raw_mapper.py'
AS (
dttm_event timestamp
, cnt_favorites bigint
, cnt_retweets bigint
, language string
, user_location string
, user_name string
, user_screen_name string
, text string
)
) raw_tweets
INSERT OVERWRITE TABLE stg.tweets
SELECT 
    language 
    , to_date(dttm_event) 
    , dttm_event 
    , cnt_retweets 
    , cnt_favorites
    , user_screen_name 
    , user_name 
    , user_location 
    , text 
;
