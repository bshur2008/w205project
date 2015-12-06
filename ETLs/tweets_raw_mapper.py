#!/usr/bin/env python
from __future__ import print_function
import sys, json, re
from dateutil.parser import parse

for line in sys.stdin:
	try:
	    line = line.strip()
	    tweet = json.loads(line)
	    o = {
	     'created_at':tweet.get('created_at')
	     ,'favorite_count':tweet.get('favorite_count')
	     ,'retweet_count':tweet.get('retweet_count')
	     ,'language':tweet.get('lang')
	     ,'user_location':tweet.get('user').get('location') 
	     ,'user_name':tweet.get('user').get('name') 
	     ,'user_screen_name':tweet.get('user').get('screen_name') 
	     ,'text':tweet.get('text')
	    }
	    print('\t'.join([ re.sub(r'[\n\r]','',unicode(x)) for x in [
	     parse(o['created_at']).strftime('%Y-%m-%d %H:%M:%S')
	     , o['favorite_count']
	     , o['retweet_count']
	     , o['language']
	     , o['user_location']
	     , o['user_name']
	     , o['user_screen_name']
	     , o['text']
	    ]]))
	except:
	    pass
