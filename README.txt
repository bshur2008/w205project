Steps to install:
1) load code into /project folder (NOTE: this folder is required)
2) install python dependencies with install_dependencies.sh script
3) install redis and run in daemon mode locally
4) add twitter credentials to ~/.bash_profile 
5) ensure that Hadoop and Hive are installed properly 
6) create /data/tmp/raw/tweets folder(s) on local file system
7) create /user/w205/tweets/es folder on HDFS
8) use crontab.txt example file to schedule processes to run automatically
