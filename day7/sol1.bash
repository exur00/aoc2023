#!/bin/bash

i=1
while read line; do
	bid=$(echo "$line" | awk '{print $2}')
	bid=$(( i * $bid ))
	echo "$bid"
	(( i += 1 ))
done < <(./sol1_sub1.bash $1 | sort)

#run with: ./sol1.bash input | awk '{s+=$1}  END {print s}'
