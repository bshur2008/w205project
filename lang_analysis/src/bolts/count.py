from __future__ import absolute_import, print_function, unicode_literals
from collections import Counter
from streamparse.bolt import Bolt
import psycopg2
import datetime as DT
TBL='tweet_word_count'

class TweetCounter(Bolt):
	def initialize(self, conf, ctx):
		self.counts = Counter()
		
	def process(self, tup):
		word = tup.values[0]
		word = word.lower()
		
		conn = psycopg2.connect("user=postgres")
		cur = conn.cursor()
		cur.execute('''SELECT * from public.{}
			WHERE word='{}' and language='{}';'''.format(
				TBL, word, 'es'))
		if cur.fetchone():
			SQL = '''UPDATE public.{} 
				SET cnt=cnt+{}
				WHERE word='{}'
				AND language='{}';
			'''.format(TBL,1,word,
				'es')
		else:
			SQL = '''INSERT INTO public.{}
				(language, word, cnt)
				VALUES ('{}','{}',{});
				'''.format(TBL,'es',
						word, 1)
		cur.execute(SQL+'COMMIT;')
		conn.commit()
		cur.close()
		conn.close()
		
		# emit
		# Increment the local count
		self.counts[word] += 1
		self.emit([word, self.counts[word]])
		#self.log('{}: {}'.format(word, self.counts[word]))

