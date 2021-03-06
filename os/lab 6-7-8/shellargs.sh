#!/bin/bash

ARGS=$@
echo First method:

for a in $@
do
	echo $a
done


echo Second method:
for i in $(seq 1 $#)
do
	echo ${!i} # this performs indirect expansion. For example i to value of 1 then to value of the $1 which is the first cmd line argument
done

echo Third method:
while [ $# -le 0 ]
do
	echo $1 $2   #or echo $ 1 and $ 2 then shift 2
	shift 2 
done


