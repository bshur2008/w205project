#!/usr/bin/env bash
folders_d=`ls -d /data/2000/census_2000/datasets/demographic_profile/[A-Z]*`
folders_s=`ls -d /data/2000/census_2000/datasets/State_Legislative_Districts/SLD_Block_Supplement/[A-Z]*`

#make local directory
mkdir /data/demographic_profile &> /dev/null
mkdir /data/sld &> /dev/null
chown -R w205:hadoop /data/demographic_profile
chown -R w205:hadoop /data/sld

#setup hadoop directory
hadoop fs -mkdir /user/w205/demographic_profile &> /dev/null
hadoop fs -mkdir /user/w205/sld &> /dev/null

#setup hive database
hive -e 'create database if not exists staging;'

#load data into HDFS
for f in ${folders_d[@]}
do
	#create demographic profile datasets
	IFS='/' read -a fl <<< "$f"
	unzip -p $f/*.zip | gzip > /data/demographic_profile/${fl[@]:(-1)}.gz
done
for f in ${folders_s[@]}
do
	#create sld datasets
	IFS='/' read -a fl <<< "$f"
	unzip -p $f/*.zip | gzip > /data/sld/${fl[@]:(-1)}.gz
done

#combine datasets and load to HDFS
rm /data/demographic_profile/allstates.gz &> /dev/null
rm /data/sld/allstates.gz &> /dev/null
cat /data/demographic_profile/*.gz >> /data/demographic_profile/allstates.gz
cat /data/sld/*.gz >> /data/sld/allstates.gz
hadoop fs -rm /user/w205/demographic_profile/allstates.gz
hadoop fs -rm /user/w205/sld/allstates.gz
hadoop fs -copyFromLocal /data/demographic_profile/allstates.gz /user/w205/demographic_profile/allstates.gz
hadoop fs -copyFromLocal /data/sld/allstates.gz /user/w205/sld/allstates.gz
rm /data/demographic_profile/*.gz
rm /data/sld/*.gz
