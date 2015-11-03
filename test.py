#!/usr/bin/env python
from tweepy.streaming import StreamListener
from tweepy import Stream, TweepError
from tweepy import OAuthHandler, API
from sys import argv,exit
import requests
from requests_oauthlib import OAuth1

def authorize(consumer_token, consumer_secret):
    auth = OAuthHandler(consumer_token, consumer_secret)
    try:
        redirect_url = auth.get_authorization_url()
        print 'Successful OAuth'
    except TweepError:
        print 'Error! Failed to get request token.'
    return auth

class StdOutListener(StreamListener):
    def on_status(self, status):
        print status.text
     
    def on_error(self, status):
        print status

if __name__=='__main__':
    if len(argv)!=3:
        print "usage: test.py [key] [secret]"
	exit(1)
    token, secret = argv[1:]
    auth = authorize(token,secret)
    print auth.access_token
    api = API(auth)
    stream = Stream(auth=api.auth, listener=StdOutListener())
    stream.filter( track=['hasta'] )

