#!/usr/bin/env bash
hive -f /project/ETLs/tweets_load_from_raw.sql 
hive -f /project/ETLs/tweets_load_tweet_log.sql

