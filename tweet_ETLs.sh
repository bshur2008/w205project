#!/usr/bin/env bash
PROJECT_HOME=/project

# DDL statements
hive -f $PROJECT_HOME/DDLs/tweet_ddl.sql

# ETL flow
hive -f $PROJECT_HOME/ETLs/tweets_load_from_raw.sql 
hive -f $PROJECT_HOME/ETLs/tweets_load_tweet_log.sql
hive -f $PROJECT_HOME/ETLs/tweets_load_tweet_users.sql
hive -f $PROJECT_HOME/ETLs/tweets_load_tweet_words.sql
hive -f $PROJECT_HOME/ETLs/combined_table.sql

# POSTGRES
sudo -u postgres psql -f $PROJECT_HOME/DDLs/postgres_wc.sql
