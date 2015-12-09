#!/usr/bin/env python
import sys, re

for title, text in sys.stdin:
	new_words = []
	words = re.sub(r'[\r\n\t]','',text).split()
	for word in words:
		if "[" in word: continue
		if "{" in word: continue
		if word.startswith("http://"): continue
		if "@" in word: continue
		if "-" in word: continue
		if "=" in word: continue
		if "&" in word: continue
		if "|" in word: continue
		word = re.sub('[^\w+]','',word,flags=re.UNICODE)
		new_words.append(word)
	new_text = ' '.join(new_words)
	print '\t'.join([title,new_text])

