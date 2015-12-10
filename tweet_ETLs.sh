#!/usr/bin/env bash

# DDL statements
hive -f /project/DDLs/tweet_ddl.sql

# ETL flow
hive -f /project/ETLs/tweets_load_from_raw.sql 
hive -f /project/ETLs/tweets_load_tweet_log.sql
hive -f /project/ETLs/tweets_load_tweet_users.sql
hive -f /project/ETLs/tweets_load_tweet_words.sql

# POSTGRES
sudo -u postgres psql -f DDLs/postgres_wc.sql
