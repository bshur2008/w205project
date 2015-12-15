
INSERT OVERWRITE TABLE prd.tweet_words
SELECT 
    hash(concat(text,user_screen_name)) tweet_id
    , language
    , dt_event
    , split(regexp_replace(lower(text),'[,.]',''),' ')
    , sentences(lower(text))
FROM stg.tweets
;
