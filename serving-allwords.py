#!/usr/bin/env python
from __future__ import print_function
import redis, sys

if __name__=='__main__':
	r = redis.StrictRedis(host='localhost', port=6379, db=0)
	k = r.keys()
	z = {x:r.get(x) for x in k}
	for c in z: print(c,z[c])
