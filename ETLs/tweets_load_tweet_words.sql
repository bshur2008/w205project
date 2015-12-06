
INSERT OVERWRITE TABLE prd.tweet_words
SELECT 
    hash(concat(text,user_screen_name)) tweet_id
    , language
    , dt_event
    , split(text,' ')
FROM stg.tweets
;
