#!/usr/bin/env python
from tweepy import TweepError
from tweepy import OAuthHandler, API
from sys import argv,exit
import requests
from requests_oauthlib import OAuth1

def authorize(consumer_token, consumer_secret):
    auth = OAuthHandler(consumer_token, consumer_secret)
    try:
        redirect_url = auth.get_authorization_url()
        print 'URL: %s' % redirect_url
    except TweepError:
        print 'Error! Failed to get request token.'
    return auth

if __name__=='__main__':
    if len(argv)!=3:
        print "usage: authorize_link.py [key] [secret]"
        exit(1)
    token, secret = argv[1:]
    auth = authorize(token,secret)
    verifier = raw_input('Verifier:')
    auth.get_access_token(verifier)
    
    f = open('credentials','w')   
    print >>f, "{'KEY':'%s' \
	,'SECRET':'%s' \
	,'OAUTH_TOKEN':'%s' \
	,'ACCESS_SECRET':'%s'}" % ( \
		token \
		, secret \
		, auth.access_token \
		, auth.access_token_secret \
	)
    f.close()
