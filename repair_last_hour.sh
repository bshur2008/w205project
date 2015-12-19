#!/usr/bin/env bash
PROJECT_HOME=/project
lasthr=$(date -d'-1 hour' +%Y%m%d%H)
segments=(0 1 2 3 4 5)
segments2=(0 1 2 3 4 5 6 7 8 9)

# Load files into HDFS
rm /data/tmp/$lasthr.txt.gz
hdfs dfs -moveToLocal /user/w205/tweets/es/$lasthr/$lasthr\.txt.gz /data/tmp/$lasthr\.txt.gz
sudo chmod 777 /data/tmp/$lasthr.txt.gz

for s in ${segments[@]}
do

for ss in ${segments2[@]}
do

cat /data/tmp/raw/tweets/$lasthr$s$ss*.js | gzip >> /data/tmp/$lasthr.txt.gz
rm /data/tmp/raw/tweets/$lasthr$s$ss*.js

done
done

hdfs dfs -mkdir /user/w205/tweets/es/$lasthr
hdfs dfs -moveFromLocal -f /data/tmp/$lasthr.txt.gz /user/w205/tweets/es/$lasthr/$lasthr.txt.gz

# Run ETL
hive --hiveconf lasthr=$lasthr -f $PROJECT_HOME/ETLs/tweets_load_from_raw.sql 
: << 'END'
sudo -u hdfs hdfs dfs -rm -r -f /user/w205/tweets/mapped
sudo -u hdfs hadoop \
jar /usr/lib/hadoop-mapreduce/hadoop-streaming-2.6.0-cdh5.4.7.jar \
-input /user/w205/tweets/es/$lasthr.txt.gz \
-output /user/w205/tweets/mapped \
-mapper ETLs/tweets_raw_mapper.py \
-file ETLs/tweets_raw_mapper.py
hive -e "LOAD DATA INPATH '/user/w205/tweets/mapped' INTO TABLE stg.tweets;"
END
