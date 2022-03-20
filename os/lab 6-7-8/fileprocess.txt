#!/bin/bash

for f in `find $1 -type f -name "*.txt" `
do
	echo $f
	no=`grep -c "hello" $f`
	total=`expr $no + $total:`
done
