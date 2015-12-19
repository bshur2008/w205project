#!/usr/bin/env bash
PROJECT_HOME=/project

# Copy code to HDFS
hdfs dfs -copyFromLocal -f $PROJECT_HOME/ETLs/tweets_raw_mapper.py /user/w205/tweets_raw_mapper.py
hdfs dfs -copyFromLocal -f $PROJECT_HOME/ETLs/wp_raw_mapper.py /user/w205/wp_raw_mapper.py

# DDL statements
hive -f $PROJECT_HOME/DDLs/tweet_ddl.sql
hive -f $PROJECT_HOME/DDLs/combined_table.sql

# ETL flow
# hive -f $PROJECT_HOME/ETLs/tweets_load_from_raw.sql 
hive -f $PROJECT_HOME/ETLs/tweets_load_tweet_log.sql
hive -f $PROJECT_HOME/ETLs/tweets_load_tweet_users.sql
hive -f $PROJECT_HOME/ETLs/tweets_load_tweet_words.sql
hive -f $PROJECT_HOME/ETLs/combined_table.sql
