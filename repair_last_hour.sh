#!/usr/bin/env bash
lasthr=$(date -d'-1 hour' +%Y%m%d%H)
lastday=$(date -d'-1 day' +%Y%m%d)

sudo -u hdfs hdfs dfs -cat /user/w205/tweets/$lasthr*.js | gzip >> /project/$lasthr\.txt.gz
sudo -u hdfs hdfs dfs -rm /user/w205/tweets/$lasthr*.js
sudo -u hdfs hdfs dfs -moveFromLocal /project/$lasthr\.txt.gz /user/w205/tweets/$lasthr\.txt.gz

sudo rm /project/$lastday*.txt.gz
