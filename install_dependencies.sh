#!/usr/bin/env bash
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
while read -r line || [[ -n "$line" ]]; do
	pip install $line
done < "dependencies.txt"
