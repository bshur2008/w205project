#!/usr/bin/env python
from __future__ import print_function
import redis, sys

if __name__=='__main__':
	r = redis.StrictRedis(host='localhost', port=6379, db=0)
	if len(sys.argv)==2:
		print('{}: {}'.format(sys.argv[1],r.get(sys.argv[1])))

