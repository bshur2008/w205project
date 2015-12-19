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
                        w = re.compile(ur'[^\w+]',flags=re.UNICODE)
			if w.search(title_word): raise Exception('Bad title')
		new_words = []
                w1 = re.compile(ur'[\|]',flags=re.UNICODE)
                w2 = re.compile(ur'[\]\[*`~-]',flags=re.UNICODE)
		words = w1.sub(' ',text).split()
		words = w2.sub('',text).split()
		for word in words:
			if word.startswith('http'): continue
                        w3 = re.compile(ur'[^\w+.?!]',flags=re.UNICODE)
                        w4 = re.compile(ur'[0-9\_]',flags=re.UNICODE)
			if w3.search(word): continue
			if w4.search(word): continue
			new_words.append(word)
		new_text = ' '.join(new_words).encode('utf-8')
		print('\t'.join([title,new_text]))
	except Exception as e:
		print('\t'.join([title,str(e)]))
		pass

