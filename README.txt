Steps to install:
1) load code into /project folder (NOTE: this folder is required) 
	git clone https://github.com/bshur2008/w205project.git
	mv w205project /project
2) ensure that python 2.7 is installed and install python dependencies with install_dependencies.sh script
3) install redis and run in daemon mode locally (http://redis.io/ -- example conf file included)
4) add twitter credentials to ~/.bash_profile 
	export TWITTER_KEY=[key]
	export TWITTER_SECRET=[secret]
	export TWITTER_OAUTH_TOKEN=[oauth token]
	export TWITTER_OAUTH_SECRET=[oauth secret]
5) ensure that Hadoop and Hive are installed properly 
6) create /data/tmp/raw/tweets folder(s) on local file system
7) create /user/w205/tweets/es folder on HDFS
8) install lein if not installed (http://leiningen.org/)
9) use crontab.txt example file to schedule processes to run automatically
	(NOTE: may need to execute sparse run from the /project/lang_analysis folder to 
		compile job and ensure streamparse works before it will run correctly)
10) for wikipedia data, attach snapshot snap-8041f2e9 and load eswiki-* data into HDFS folder /user/w205/wp/es
