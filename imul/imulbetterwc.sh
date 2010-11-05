#!/bin/sh
sh imulbetter.j.sh $1 $2 > gen/tracebetter
wc -l gen/tracebetter
tail -1 gen/tracebetter
