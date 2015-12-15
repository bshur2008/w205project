#!/usr/bin/env python
from __future__ import print_function #, unicode_literals
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
	    valid_words = []
	    for word in o['text'].split():
		if word.startswith("#"): continue		
		if word.startswith("@"): continue
		if word.startswith("RT"): continue
		if word.startswith("http"): continue
		#word = word.strip("\"?><,'.:;)")
		word = re.sub(ur'[^\w+.?]','',word,flags=re.UNICODE)
		if len(word) > 0:
		    valid_words.append(word)
	    o['text'] = re.sub(ur'[\n\r]','',' '.join(valid_words),flags=re.UNICODE).encode('utf-8')
	    o['language'] = o['language'].encode('utf-8') if o['language'] else ''
	    o['user_location'] = o['user_location'].encode('utf-8') if o['user_location'] else ''
	    o['user_name'] = o['user_name'].encode('utf-8') if o['user_name'] else ''
	    o['user_screen_name'] = o['user_screen_name'].encode('utf-8') if o['user_screen_name'] else ''
	    print('\t'.join([ str(x) for x in [
	     parse(o['created_at']).strftime('%Y-%m-%d %H:%M:%S')
	     , o['favorite_count']
	     , o['retweet_count']
	     , o['language']
	     , o['user_location']
	     , o['user_name']
	     , o['user_screen_name']
	     , o['text']
	    ]]))
	except Exception as e:
	    # print(e)
	    pass
