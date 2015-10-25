#!/usr/bin/env bash
folders=`ls -d /data/2000/census_2000/datasets/demographic_profile/[A-Z]*`

#make local directory
mkdir /data/demographic_profile &> /dev/null
chown -R w205:hadoop /data/demographic_profile

#setup hadoop directory
hadoop fs -mkdir /user/w205/demographic_profile &> /dev/null

#setup hive database
hive -e 'create database if not exists staging;'

#load data into HDFS
for f in ${folders[@]}
do
	#create demographic profile datasets
	IFS='/' read -a fl <<< "$f"
	unzip -p $f/*.zip | gzip > /data/demographic_profile/${fl[@]:(-1)}.gz
done

#combine datasets and load to HDFS
rm /data/demographic_profile/allstates.gz &> /dev/null
cat /data/demographic_profile/*.gz >> /data/demographic_profile/allstates.gz
hadoop fs -rm /user/w205/demographic_profile/allstates.gz
hadoop fs -copyFromLocal /data/demographic_profile/allstates.gz /user/w205/demographic_profile/allstates.gz
rm /data/demographic_profile/*.gz
