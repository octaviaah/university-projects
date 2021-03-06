#!/bin/sh

# ARGS

if [ $# -lt 3 ]
then
	echo Please provide at least 3 arguments
	exit 1
fi


for f in $@; do
	if [ -f $f ]; then
		echo $f is a filename
	elif [ -d $f ]; then
		echo $f is a directory
	elif echo $f | grep -q -E "\-?[0-9]*\.?[0-9]+"; then
		echo $f is an integer
	elif echo $f | grep -i -q -E "[a-z]{3,}@[a-z]+\.[a-z]{2,3}"; then
		echo $f is an email address 
	else
		echo $f is a random string.
	fi
done



