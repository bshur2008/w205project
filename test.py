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
	print tweet
     
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
