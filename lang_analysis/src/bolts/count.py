from __future__ import absolute_import, print_function, unicode_literals
from collections import Counter
from streamparse.bolt import Bolt
import redis
import datetime as DT
TBL='tweet_word_count'

class TweetCounter(Bolt):
	def initialize(self, conf, ctx):
		self.counts = Counter()
		
	def process(self, tup):
		word = tup.values[0]
		word = word.lower()
		
		# increment word in redis
		r = redis.StrictRedis(host='localhost', port=6379, db=0)
		r.incr(word)
		
		# emit
		# Increment the local count
		self.counts[word] += 1
		self.emit([word, self.counts[word]])
		#self.log('{}: {}'.format(word, self.counts[word]))

