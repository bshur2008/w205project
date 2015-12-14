Steps to install:
1) load code into /project folder (NOTE: this folder is required) 
	git clone https://github.com/bshur2008/w205project.git
	mv w205project /project
2) ensure that python 2.7 is installed and install python dependencies with install_dependencies.sh script
3) install redis and run in daemon mode locally (http://redis.io/ -- example redis.conf file included)
4) add twitter credentials to ~/.bash_profile or run the below in bash CLI
	export TWITTER_KEY=[key]
	export TWITTER_SECRET=[secret]
	export TWITTER_OAUTH_TOKEN=[oauth token]
	export TWITTER_OAUTH_SECRET=[oauth secret]
5) ensure that Hadoop and Hive are installed properly 
6) create /data/tmp/raw/tweets folder(s) on local file system
7) create /user/w205/tweets/es folder(s) within HDFS and 
	open up access to all linux users with hdfs dfs -chmod 777 -r /user/w205/tweets/es 
	(this allows cron job to move files from local file system to HDFS)
8) install lein if not installed (http://leiningen.org/)
9) for wikipedia data, attach EBS volume snapshot snap-8041f2e9 
	and load eswiki-20090812-pages-meta-current.xml.bz2 data file
	into HDFS folder /user/w205/wp/es
10) use crontab.txt example file to schedule processes to run automatically
	OR run manually:
		./launch.sh # run Storm topology
		./repair_last_hour.sh # run each hour to load tweets from local files to HDFS
		./tweet_ETLs.sh # run ETLs for twitter data
		./wp_ETLs.sh # run Wikipedia ETLs
	(NOTE: may need to execute sparse run from the /project/lang_analysis folder to 
		compile job and ensure streamparse works before it will run correctly)
11) to view real-time tweets use the serving scripts provided:
	python serving-allwords.py # dump all words from Redis (NOTE: use sparingly)
	python serving-allwords.py | sort -k2,2nr | head -n20 # display the top 20 words
	python serving-getword.py [word] # display counts for an individual word

NOTE: use test_scripts/authorize.py script to authenticate with OAuth for the first time
	and test_scripts/test.py to test your twitter stream
