#!/usr/bin/env bash
cnt="$(ps aux | grep lein | wc -l)"
if [ $cnt -eq 1 ]
then
cd /project/lang_analysis
sparse run
fi
