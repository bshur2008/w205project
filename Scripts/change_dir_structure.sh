#!/usr/bin/env bash
files=$(hdfs dfs -ls /user/w205/tweets/es | awk '{print $8}')
for f in ${files[@]}
do
	filename=${f##*/}
	hrname=${filename%%.*}
	newfilename=/user/w205/tweets/es/$hrname/$filename
	newfolder=/user/w205/tweets/es/$hrname
	if [ ${f#*.} = 'txt.gz' ]
	then
	  hdfs dfs -mkdir $newfolder
	  hdfs dfs -mv $f $newfilename
	  hive -e "ALTER TABLE raw.es_tweets ADD PARTITION (hr = '$hrname') LOCATION '$newfolder';"
	fi 	
done

