
DELETE FROM prd.tweet_log
WHERE dt_event >= current_date-1
;

INSERT INTO prd.tweet_log
SELECT 
    md5(text) tweet_id
    , md5(user_screen_name) user_id
    , dttm_event 
    , language 
    , cnt_retweets 
    , cnt_favorites 
    , cnt_tweets
FROM stg.tweets
WHERE dt_event >= current_date-1
;
