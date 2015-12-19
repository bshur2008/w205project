#!/usr/bin/env bash
lasthr=$(date -d'-1 hour' +%Y%m%d%H)
segments=(0 1 2 3 4 5)
segments2=(0 1 2 3 4 5 6 7 8 9)

rm /data/tmp/$lasthr.txt.gz
hdfs dfs -copyToLocal /user/w205/tweets/es/$lasthr\.txt.gz /data/tmp/$lasthr\.txt.gz
sudo chmod 777 /data/tmp/$lasthr.txt.gz

for s in ${segments[@]}
do

for ss in ${segments2[@]}
do

cat /data/tmp/raw/tweets/$lasthr$s$ss*.js | gzip >> /data/tmp/$lasthr.txt.gz
rm /data/tmp/raw/tweets/$lasthr$s$ss*.js

done
done

hdfs dfs -moveFromLocal -f /data/tmp/$lasthr.txt.gz /user/w205/tweets/es/$lasthr.txt.gz
