#!/usr/bin/env bash
lasthr=$(date -d'-1 hour' +%Y%m%d%H)

rm /data/tmp/$lasthr.txt.gz
hdfs dfs -copyToLocal /user/w205/tweets/$lasthr\.txt.gz /data/tmp/$lasthr\.txt.gz
sudo chmod 777 /data/tmp/$lasthr.txt.gz

cat /data/tmp/raw/tweets/$lasthr.txt | gzip >> /data/tmp/$lasthr.txt.gz

hdfs dfs -moveFromLocal -f /data/tmp/$lasthr.txt.gz /user/w205/tweets/$lasthr.txt.gz

gzip /data/tmp/raw/tweets/$lasthr.txt
#rm /data/tmp/raw/tweets/$lasthr.txt
