#!/usr/bin/env bash
lasthr=$(date -d'-1 hour' +%Y%m%d%H)
lastday=$(date -d'-1 day' +%Y%m%d)
segments=(0 1 2 3 4 5)

rm /data/tmp/$lasthr.txt.gz
hdfs dfs -copyToLocal /user/w205/tweets/$lasthr\.txt.gz /data/tmp/$lasthr\.txt.gz
sudo chmod 777 /data/tmp/$lasthr.txt.gz

for s in ${segments[@]}
do
cat /data/tmp/raw/tweets/$lasthr$s*.js | gzip >> /data/tmp/$lasthr.txt.gz
rm /data/tmp/raw/tweets/$lasthr$s*.js
done

#fsize=$(wc -c <"/data/tmp/$lasthr.txt.gz")
#if [[ $fsize -gt 20 ]]; then
hdfs dfs -moveFromLocal -f /data/tmp/$lasthr.txt.gz /user/w205/tweets/$lasthr.txt.gz
#fi

