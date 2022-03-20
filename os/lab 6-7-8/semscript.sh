#!/bin/sh

D=$1

if [ -z "$D" ]; then
	echo "ERROR: No dir provided for monitoring" >&2
	exit 1
fi

if [ ! -d "$D" ]; then
	echo "ERROR:Dir $D does not exits" >&2
	exit 1
fi

STATE=""
while true; do
	S=""
	for P in `find $D`; do
		if [ -f $P ]; then
			LS=`ls -l $P | sha1sum`
			CONTENT=`sha1sum $P`
		elif [ -d $P ]; then
			LS=`ls -l -d $P | sha1sum`
			CONTENT=`ls -l $P | sha1sum`
		fi
		S="$S\n$LS $CONTENT"
		
	done
#	echo $S
	if [ -n "$STATE" ] && [ "$S" != "$STATE" ]; then
		echo "Directory state changed"
	fi
	STATE=$S;
	sleep 1
done
