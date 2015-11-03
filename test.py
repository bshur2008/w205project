#!/usr/bin/env python
from tweepy.streaming import StreamListener
from tweepy import Stream, TweepError
from tweepy import OAuthHandler, API
from sys import argv,exit
from credentials import CREDENTIALS

class StdOutListener(StreamListener):
    def on_status(self, status):
        print status.text
     
    def on_error(self, status):
        print status

if __name__=='__main__':
    auth = OAuthHandler(CREDENTIALS['KEY'],CREDENTIALS['SECRET'])
    auth.set_access_token(CREDENTIALS['OAUTH_TOKEN'], \
	CREDENTIALS['OAUTH_SECRET'])
    api = API(auth)
    stream = Stream(auth=api.auth, listener=StdOutListener())
    stream.filter( track=['hasta'] )

