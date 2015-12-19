#!/usr/bin/env bash
cnt="$(ls /data/tmp/raw/tweets | wc -l)"
if [ $cnt -eq 0 ]
then
for p in `ps aux | grep parse | awk '{print $2}'`;do sudo kill -9 $p; done
cd /project/lang_analysis
#lein run -m streamparse.commands.run/-main topologies/spanish_tweets.clj -t 0 --option 'topology.workers=2' --option 'topology.acker.executors=2' --option 'streamparse.log.path="/data/tmp/logs"' --option 'streamparse.log.level="error"'
sparse run > /dev/null
fi
