#!/bin/bash

while read line; do

	card=$(echo "$line" | cut -d ":" -f 2)
	winning=$(echo "$card" | cut -d "|" -f 1)
	numbers=$(echo "$card" | cut -d "|" -f 2)
	#echo "$winning\n$numbers\n\n"
	winning=$(echo "$winning" | tr " " "\n")
	echo "$winning" > tmp.txt
	#echo "$winning\n$numbers\n\n"
	overlap=$(echo "$numbers" | grep -o -w -f tmp.txt) #-o only matching part, -w whole word, -f for wordlist
	#echo "$overlap"
	amt=$(echo "$overlap" | wc --words)
	#echo "    $amt"
	if [ "$amt" != "0" ]; then
		echo "$((2**($amt - 1)))"
	fi
done

# run cat input | ./sol1.bash | awk '{s+=$1} END {print s}'

