#!/bin/bash

file=$1

grep -o "the" $file

while read string
do
	echo Line is: $string
	echo Word by word:
	for w in $string
	do
		if [ $w = "the" ]
		then 
			echo $w
		fi
	done
done < $file
