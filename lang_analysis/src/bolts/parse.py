from __future__ import absolute_import, print_function, unicode_literals

import re
#import hdfs
from streamparse.bolt import Bolt
from datetime import datetime as DT
from json import loads, dumps
getdt = lambda: DT.now().strftime('%Y%m%d%H%M%S%f')
################################################################################
# Function to check if the string contains only ascii chars
################################################################################
def ascii_string(s):
  return all(ord(c) < 128 for c in s)

class ParseTweet(Bolt):

    def process(self, tup):
	filename = '/data/tmp/raw/tweets/'+getdt()+'.js'
        tweet = tup.values[0]  # extract the tweet
	#client = hdfs.client.Client('http://localhost:50070')
        #client.write(filename,data=tweet+'\n')
	with open(filename,'w') as w:
	    print(tweet,file=w)
	
        # Split the tweet into words
	tweet = loads(tweet)
        words = tweet.get('text','').split()
        # Filter out the hash tags, RT, @ and urls
        valid_words = []
        for word in words:
            # Filter the hash tags
            if word.startswith("#"): continue		
            # Filter the user mentions
            if word.startswith("@"): continue
            # Filter out retweet tags
            if word.startswith("RT"): continue
            # Filter out the urls
            if word.startswith("http"): continue
            # Filter out numbers
            if re.search(ur'[0-9]',word,flags=re.UNICODE): continue
            # Strip leading and lagging punctuations
            aword = word.strip("\"?><,'.:;)")
	    bword = re.sub('[^\w+]','',aword,flags=re.UNICODE)
            # now check if the word contains only ascii
            if len(bword) > 0:# and ascii_string(bword):
                valid_words.append([bword])
        if not valid_words: return
        # Emit all the words
        self.emit_many(valid_words)
	# self.log('{}'.format(str(valid_words)))
        # tuple acknowledgement is handled automatically

