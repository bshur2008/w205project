#!/usr/bin/env bash
lasthr=$(date -d'-1 hour' +%Y%m%d%H)
lastday=$(date -d'-1 day' +%Y%m%d)

sudo -u hdfs hdfs dfs -cat /user/w205/tweets/$lasthr*.js | gzip >> /data/tmp/$lasthr\.txt.gz

fsize=$(wc -c <"$lasthr\.txt.gz")
if [ $fsize -gt 20 ]
then
 sudo -u hdfs hdfs dfs -rm /user/w205/tweets/$lasthr*.js
 sudo -u hdfs hdfs dfs -moveFromLocal /data/tmp/$lasthr\.txt.gz /user/w205/tweets/$lasthr\.txt.gz
fi

