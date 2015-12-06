
INSERT OVERWRITE TABLE prd.tweet_users
SELECT 
    hash(user_screen_name) user_id
    , user_screen_name
    , user_name 
    , user_location
FROM stg.tweets
;
