#!/bin/bash
amtCards=0

while read line; do
	
	searchCard=$(echo "$line" | sed -r 's/^([^.]+).*$/\1/; s/^[^0-9]*([0-9]+).*$/\1/' ) # awk -F'[^0-9]+' '{ print $2 }')
	#echo "zoek: $searchCard"
	card=$(grep "Card $searchCard" input | cut -d ":" -f 2)
	#echo "$card"
	if [ "$card" = "" ]; then
		break
	fi
	amtCards=$(($amtCards + 1)) # after grep so it doesn't add if card is nonexistant	
	
	winning=$(echo "$card" | cut -d "|" -f 1)
	numbers=$(echo "$card" | cut -d "|" -f 2)
	#echo "$winning\n$numbers\n\n"
	winning=$(echo "$winning" | tr " " "\n")
	echo "$winning" > tmp.txt
	#echo "$winning\n$numbers\n\n"
	overlap=$(echo "$numbers" | grep -o -w -f tmp.txt) #-o only matching part, -w whole word, -f for wordlist
	#echo "$overlap"
	overlap=$(echo "$overlap" | tr " " "\n")
	amt=$(echo "$overlap" | wc --words)
	#echo "er zijn $amt"
	for i in $(seq $(($searchCard + 1)) $(($searchCard + $amt))); do
		#echo "nummer : $i aan de beurt"
		amtCards=$(( $amtCards + $(echo "$i" | ./sol2.bash) ))
		#echo "Game $i test" | ./sol2.bash
	done
done
echo $amtCards

