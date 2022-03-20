#!/bin/sh

if gcc -o myprog -Wall $1
then
	shift
	./myprog $*
else
	echo "Compile errors:"
fi
