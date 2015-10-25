#!/usr/env bash
folders=`ls -d /data/2000/census_2000/datasets/demographic_profile/[A-Z]*`

mkdir /data/demographic_profile
chown -R w205:hadoop /data/demographic_profile
for f in ${folders[@]}
do
	echo "unzip -p /data/2000/census_2000/datasets/demographic_profile/$f/*.zip | gzip > /data/demographic_profile/${f%/}.gz"
done

