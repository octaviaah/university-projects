#!/bin/bash

IFS=""
while read line
do
	echo $line
	#word by word
	IFS=" "
	for w in $line
	do
		echo "[$w]  "
	done
	#back to lien by line to kep spaces
	IFS=""
done < $1
