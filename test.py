#!/usr/bin/env python
import tweepy
from sys import argv,exit

def authorize(consumer_token, consumer_secret):
    auth = tweepy.OAuthHandler(consumer_token, consumer_secret)
    try:
        redirect_url = auth.get_authorization_url()
        print 'Successful OAuth'
    except tweepy.TweepError:
        print 'Error! Failed to get request token.'

if __name__=='__main__':
    if len(argv)!=3:
        print "usage: test.py [key] [secret]"
	exit(1)
    token, secret = argv[1:]
    authorize(token,secret)

