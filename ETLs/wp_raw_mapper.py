#!/usr/bin/env python
from __future__ import print_function #, unicode_literals
import sys, re, json 

for line in sys.stdin:
	try:
		line = line.strip()
		title, text = line.split('\t')
		text = text.decode('utf-8')
		title_words = title.split()
		for title_word in title_words:
			if re.search(ur'[^\w+]',title_word,flags=re.UNICODE): raise Exception('Bad title')
		new_words = []
		words = re.sub(ur'[\|]',' ',text,flags=re.UNICODE).split()
		words = re.sub(ur'[\]\[*`~-]','',text,flags=re.UNICODE).split()
		for word in words:
			if word.startswith('http'): continue
			if re.search(ur'[^\w+.?]',word,flags=re.UNICODE): continue
			if re.search(ur'[0-9\_]',word,flags=re.UNICODE): continue
			new_words.append(word)
		new_text = ' '.join(new_words).encode('utf-8')
		print('\t'.join([title,new_text]))
	except Exception as e:
		# print('\t'.join([title,str(e)]))
		pass

