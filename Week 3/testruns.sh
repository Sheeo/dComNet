#!/bin/sh
FILE=geq.j
if [ x != "x$1" ]
then
	FILE=$1
	shift
fi
cat testruns.txt|\
while read a b
do
	echo -n "$a & $b & "
	ijvm-asm geq.j|ijvm -s - $a $b
done
