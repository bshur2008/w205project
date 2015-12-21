

INSERT OVERWRITE TABLE prd.tweet_log
SELECT DISTINCT
    hash(concat(text,user_screen_name)) tweet_id
    , hash(user_screen_name) user_id
    , dttm_event 
    , language 
    , cnt_retweets 
    , cnt_favorites
    , 1 
FROM stg.tweets
;
