#!/usr/bin/env python
from tweepy.streaming import StreamListener
from tweepy import Stream, TweepError
from tweepy import OAuthHandler, API
from sys import argv,exit
from credentials import CREDENTIALS
from json import dumps

t = ['un','una','yo','tu','su','y','en','para','por','a','i','u']
language = 'es'

class StdOutListener(StreamListener):
    def on_status(self, status):
	tweet = dumps(status._json,sort_keys=True,indent=4)
	o = {
	    'created_at':status._json.get('created_at')
	    ,'favorite_count':status._json.get('favorite_count')
	    ,'retweet_count':status._json.get('retweet_count')
	    ,'language':status._json.get('lang')
	    ,'user_location':status._json.get('user').get('location') 
	    ,'user_name':status._json.get('user').get('name') 
	    ,'user_screen_name':status._json.get('user').get('screen_name') 
	    ,'text':status._json.get('text')
	}
	print o
     
    def on_error(self, status):
        print status

if __name__=='__main__':
    # t = argv[1] if len(argv)>1 else 'boom'
    auth = OAuthHandler(CREDENTIALS['KEY'],CREDENTIALS['SECRET'])
    auth.set_access_token(CREDENTIALS['OAUTH_TOKEN'], \
	CREDENTIALS['OAUTH_SECRET'])
    api = API(auth)
    stream = Stream(auth=api.auth, listener=StdOutListener())
    stream.filter( track=t ,languages=[language])
