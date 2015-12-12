#!/usr/bin/env bash

# DDL statements
hive -f ./DDLs/tweet_ddl.sql

# ETL flow
hive -f ./ETLs/tweets_load_from_raw.sql 
hive -f ./ETLs/tweets_load_tweet_log.sql
hive -f ./ETLs/tweets_load_tweet_users.sql
hive -f ./ETLs/tweets_load_tweet_words.sql
hive -f ./ETLs/combined_table.sql

# POSTGRES
sudo -u postgres psql -f DDLs/postgres_wc.sql
