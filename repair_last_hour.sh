#!/usr/bin/env bash
lasthr=$(date -d'-1 hour' +%Y%m%d%H)
lastday=$(date -d'-1 day' +%Y%m%d)

#sudo rm /data/tmp/$lasthr\.txt.gz
sudo -u hdfs hdfs dfs -copyToLocal /user/w205/tweets/$lasthr\.txt.gz /data/tmp/$lasthr\.txt.gz
sudo chmod 777 /data/tmp/$lasthr\.txt.gz
sudo -u hdfs hdfs dfs -cat /data/tmp/raw/tweets/$lasthr*.js | gzip >> /data/tmp/$lasthr\.txt.gz

fsize=$(wc -c <"$lasthr\.txt.gz")
if [[ $fsize -gt 20 ]]
then
 #sudo -u hdfs hdfs dfs -rm /user/w205/raw/tweets/$lasthr*.js
 sudo -u hdfs hdfs dfs -moveFromLocal -f /data/tmp/$lasthr\.txt.gz /user/w205/tweets/$lasthr\.txt.gz
fi

