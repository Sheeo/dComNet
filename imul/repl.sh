#!/bin/sh
while read x y; do
	sh runwith.sh $x $y
	make
done
