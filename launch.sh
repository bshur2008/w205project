#!/usr/bin/env bash
cnt="$(ps aux | grep lein | wc -l)"
if [ $cnt -eq 1 ]
then
cd ./lang_analysis
lein run -m streamparse.commands.run/-main topologies/spanish_tweets.clj -t 0 --option 'topology.workers=2' --option 'topology.acker.executors=2' --option 'streamparse.log.path="/data/tmp/logs"' --option 'streamparse.log.level="error"'
fi
