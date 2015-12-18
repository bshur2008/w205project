#!/usr/bin/env bash
PROJECT_HOME=/project

# DDL statements
hive -f $PROJECT_HOME/DDLs/tweet_ddl.sql

# Streaming job
: << 'END'
sudo -u hdfs hadoop \
jar /usr/lib/hadoop-mapreduce/hadoop-streaming-2.6.0-cdh5.4.7.jar \
-input /user/w205/tweets/es/2015121511.txt.gz \
-output /user/w205/test \
-mapper ETLs/tweets_raw_mapper.py \
-file ETLs/tweets_raw_mapper.py
END

# ETL flow
hive -f $PROJECT_HOME/ETLs/tweets_load_from_raw.sql 
hive -f $PROJECT_HOME/ETLs/tweets_load_tweet_log.sql
hive -f $PROJECT_HOME/ETLs/tweets_load_tweet_users.sql
hive -f $PROJECT_HOME/ETLs/tweets_load_tweet_words.sql
hive -f $PROJECT_HOME/ETLs/combined_table.sql
