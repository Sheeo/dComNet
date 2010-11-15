#!/bin/sh
sh imul.j.sh $1 $2 > gen/trace
wc -l gen/trace
tail -1 gen/trace
